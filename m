Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361227855.1583.40.camel@aeonflux>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
	<1360970828-24004-4-git-send-email-andre.guedes@openbossa.org>
	<1361053940.1583.14.camel@aeonflux>
	<CACJA=fVRr3NSdRD9rx5DN8dW6n6w=UdWADGVOdQOp2TLvRFTZQ@mail.gmail.com>
	<1361227855.1583.40.camel@aeonflux>
Date: Tue, 19 Feb 2013 15:15:52 -0300
Message-ID: <CACJA=fUSwNxSQsV9AnwoEHFgapky3v4MCgz+n+btvYT3DcMrLA@mail.gmail.com>
Subject: Re: [RFC v2 3/8] Bluetooth: LE connection state machine
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 18, 2013 at 7:50 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> >> This patch implements a state machine for carrying out the general
>> >> connection establishment procedure described in Core spec.
>> >>
>> >> The state machine should be used as follows: when the kernel
>> >> receives a new LE connection attempt, it should go to HCI_CONN_LE_
>> >> SCAN state, starting the passive LE scanning. Once the target remote
>> >> device is in-range, it should go to HCI_CONN_LE_FOUND, stopping the
>> >> ongoing LE scanning. After the LE scanning is disabled, it should go
>> >> to HCI_CONN_LE_INITIATE state where the LE connection is created.
>> >>
>> >> This state machine will be used by the LE connection routine in
>> >> order to establish LE connections.
>> >>
>> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> >> ---
>> >>  include/net/bluetooth/hci_core.h | 13 +++++++++++++
>> >>  net/bluetooth/hci_conn.c         | 26 ++++++++++++++++++++++++++
>> >>  2 files changed, 39 insertions(+)
>> >>
>> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> >> index 48c28ca..c704737 100644
>> >> --- a/include/net/bluetooth/hci_core.h
>> >> +++ b/include/net/bluetooth/hci_core.h
>> >> @@ -300,6 +300,16 @@ struct hci_dev {
>> >>
>> >>  #define HCI_PHY_HANDLE(handle)       (handle & 0xff)
>> >>
>> >> +/*
>> >> + * States from LE connection establishment state machine.
>> >> + * State 0 is reserved and indicates the state machine is not running.
>> >> + */
>> >> +enum {
>> >> +     HCI_CONN_LE_SCAN = 1,
>> >> +     HCI_CONN_LE_FOUND,
>> >> +     HCI_CONN_LE_INITIATE,
>> >> +};
>> >> +
>> >
>> > and why don't we have HCI_CONN_LE_IDLE = 0 then. I do not get this magic
>> > number handling when you introduce an enum anyway. You spent more time
>> > explaining it with a comment instead of just using an extra enum entry.
>>
>> Ok, I'll introduce the HCI_CONN_LE_IDLE state.
>>
>> >>  struct hci_conn {
>> >>       struct list_head list;
>> >>
>> >> @@ -356,6 +366,8 @@ struct hci_conn {
>> >>
>> >>       struct hci_conn *link;
>> >>
>> >> +     atomic_t        le_state;
>> >> +
>> >
>> > Why is this atomic_t. I am lost on what you are trying to solve here.
>> > This requires a detailed explanation or you just get rid of it and use
>> > the enum.
>>
>> le_state was defined as atomic_t so read and write are atomic
>> operations, avoiding to acquire hdev->lock every time we want to read
>> or write this variable.
>
> that seems pretty much short sighted. Use a proper look and try not to
> mix an atomic in here.

Ok, I'll use lock instead.

>> >>       void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
>> >>       void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
>> >>       void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
>> >> @@ -599,6 +611,7 @@ int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
>> >>  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
>> >>  int hci_conn_change_link_key(struct hci_conn *conn);
>> >>  int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
>> >> +void hci_conn_set_le_state(struct hci_conn *conn, int state);
>> >
>> > External state setting. That does not look like a good idea in the first
>> > place. Why do you want to do it like this. Shouldn't be this self
>> > contained.
>>
>> We need to set le_state variable in hci_event.c (see patch 5/8). That
>> is why this function was added to hci_core.h.
>
> That is not a good enough explanation. Doing it like this opens a can of
> worms. I do not not get why we can not just trigger the next operation
> from within the event callbacks.
>
> You need to explain the point of all these indirection. Who is going to
> read or even understand that in 12 month. I have a hard time to follow
> by just reviewing these patches. That does not sound like a good
> approach for re-designing the LE connection handling.

Fair enough, I'll change this and use callbacks to trigger the next state.

>> >>  void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
>> >>
>> >> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> >> index 25bfce0..d54c2a0 100644
>> >> --- a/net/bluetooth/hci_conn.c
>> >> +++ b/net/bluetooth/hci_conn.c
>> >> @@ -391,6 +391,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>> >>                   (unsigned long) conn);
>> >>
>> >>       atomic_set(&conn->refcnt, 0);
>> >> +     atomic_set(&conn->le_state, 0);
>> >>
>> >>       hci_dev_hold(hdev);
>> >>
>> >> @@ -1027,3 +1028,28 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
>> >>
>> >>       return hchan;
>> >>  }
>> >> +
>> >> +void hci_conn_set_le_state(struct hci_conn *conn, int state)
>> >> +{
>> >> +     struct hci_dev *hdev = conn->hdev;
>> >> +
>> >> +     BT_DBG("conn %p state %d -> %d", conn, atomic_read(&conn->le_state),
>> >> +            state);
>> >> +
>> >> +     if (state == atomic_read(&conn->le_state))
>> >> +             return;
>> >> +
>> >> +     switch (state) {
>> >> +     case HCI_CONN_LE_SCAN:
>> >> +             hci_le_scan(hdev, LE_SCAN_PASSIVE, 0x60, 0x30, 0);
>> >> +             break;
>> >> +     case HCI_CONN_LE_FOUND:
>> >> +             hci_cancel_le_scan(hdev);
>> >> +             break;
>> >> +     case HCI_CONN_LE_INITIATE:
>> >> +             hci_le_create_connection(conn);
>> >> +             break;
>> >> +     }
>> >> +
>> >> +     atomic_set(&conn->le_state, state);
>> >> +}
>> >
>> > The more I read this, the more I think this is the wrong approach to
>> > this. The kernel should have a list of device it wants to connect to. If
>> > that list is non-empty, start scanning, if one device is found, try to
>> > connect it, once done, keep scanning if other devices are not connected.
>> >
>> > You need to build a foundation for LE devices that the kernel wants to
>> > connect to. And not hack in some state machinery.
>>
>> As commented in the cover letter, this RFC series is an initial work,
>> it supports only one LE connection attempt at a time. It doesn't
>> support multiple LE connection attempts and doesn't handle concurrent
>> device discovery properly yet.
>>
>> Let me try to give you the big picture:
>> LE connection attempts come from user-space through the connect()
>> call. Each connect() call adds a hci_conn object into a connection
>> list (hdev->conn_hash) and start the LE passive scan if not already
>> running. So the kernel has a list of devices it wants to connect to
>> (hci_conn objects in HCI_CONN_LE_SCAN le_state). When the target
>> device is found, we stop the scanning and initiate the connection.
>> Once the connection is done (successfully or not), we start passive
>> scanning again if we still have devices we want to connect to.
>>
>> I think this is pretty much the approach you described. Are we on the
>> same page about this approach?
>
> I got what you are trying to achieve, but that is just for connection
> handling of connect().
>
> What I really care is about a bigger picture for handling auto-connect
> and background scanning.

Ok, let me try an even bigger picture about the whole LE connection:
At kernel-space, as already said, the connect() call implements the
passive scanning + the connection attempt.
At user-space, we will simply call connect() to establish LE
connections. The whole code to add devices to the connect_list and
trigger the fake passive scanning can be removed (since this is now
handled by the kernel). If auto-connect is enabled and a disconnection
occurs, all we have to do is calling connect() in
attrib_disconnect_cb.

> Same as I care about being able to use the white list as much as
> possible. As long as we do not require IRK and the white list is large
> enough, lets use it. If it is possible to use a white list, the power
> impact will be large. If we can not use the white list, we have to
> consider down periods for the passive scanning to allow the host to
> sleep for certain amount of time.

Using white list requires some changes in hci_connect_le so it adds
the address into the white list instead of starting the passive
scanning and removes it if the connection is established successfully.
As soon as we have LE connection stable enough, we can work on the
white list support too.

We may achieve these down periods you mentioned by choosing
power-saving scanning parameters values (window and interval).
However, they will impact directly on the connection latency.

>> > And of course, can we please do proper error handling here. This whole
>> > thing is broken. If any of the HCI commands fail, your state machine is
>> > screwed up.
>>
>> Sure, as I said in the cover letter, the next step is to handle corner
>> cases like that.
>
> Error cases are not corner cases. Can we please stop such a thinking. At
> random times the controller will have resource limits and thus HCI
> commands will fail. Either you handle that right away or this is a
> pretty much useless attempt.
>
> The reason I pointed you to Johan's work for transaction is actually the
> case of being able to handle error conditions. With LE is has become
> obvious that in a lot of cases you have more than just one HCI command
> to trigger some actions. The handling gets a lot more complicated. We
> will have many small state machines to keep track. This needs clean code
> that can be understood by more than just 2 people.

Sure. I'll rebase on top of transactions patches and all error cases
will be handled in the next series.

Regards,

Andre
