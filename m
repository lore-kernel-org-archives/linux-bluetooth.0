Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC v2 4/4] Bluetooth: Introduce "New Connection Parameter" Event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACJA=fWJ4o7LqrdOnvz4vBPYmNEdtprwLGMsnEAe8K+TsSV7-Q@mail.gmail.com>
Date: Tue, 1 Jul 2014 11:08:41 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BD2C2824-BD34-4252-8BE6-BF75A5F3881A@holtmann.org>
References: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org> <1403743975-31114-4-git-send-email-andre.guedes@openbossa.org> <B71B6CE6-3764-4AA9-8A19-006CB7A57D1D@holtmann.org> <CACJA=fWJ4o7LqrdOnvz4vBPYmNEdtprwLGMsnEAe8K+TsSV7-Q@mail.gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

>>> This patch introduces a new Mgmt event called "New Connection Parameter".
>>> This event indicates to userspace the connection parameters values the
>>> remote device requested.
>>> 
>>> The user may store these values and load them into kernel (an upcoming
>>> patch will introduce a Mgmt command to do that). This way, next time a
>>> connection is established to that device, the kernel will use those
>>> parameters values instead of the default ones.
>>> 
>>> This event is sent when the remote device requests new connection
>>> parameters through Link Layer or L2CAP connection parameter update
>>> procedures.
>>> 
>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>>> ---
>>> include/net/bluetooth/hci_core.h |  3 +++
>>> include/net/bluetooth/mgmt.h     | 10 ++++++++++
>>> net/bluetooth/hci_event.c        |  3 +++
>>> net/bluetooth/l2cap_core.c       |  6 +++++-
>>> net/bluetooth/mgmt.c             | 19 +++++++++++++++++++
>>> 5 files changed, 40 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 016d262..f318efe 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -1322,6 +1322,9 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
>>> void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
>>> void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
>>>                 bool persistent);
>>> +void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>> +                      u8 bdaddr_type, u16 min_interval, u16 max_interval,
>>> +                      u16 latency, u16 timeout);
>>> void mgmt_reenable_advertising(struct hci_dev *hdev);
>>> void mgmt_smp_complete(struct hci_conn *conn, bool complete);
>>> 
>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>>> index bcffc9a..de22982 100644
>>> --- a/include/net/bluetooth/mgmt.h
>>> +++ b/include/net/bluetooth/mgmt.h
>>> @@ -578,3 +578,13 @@ struct mgmt_ev_new_csrk {
>>>      __u8 store_hint;
>>>      struct mgmt_csrk_info key;
>>> } __packed;
>>> +
>>> +#define MGMT_EV_NEW_CONN_PARAM               0x001a
>>> +struct mgmt_ev_new_conn_param {
>>> +     struct mgmt_addr_info addr;
>>> +     __u8 store_hint;
>>> +     __le16 min_interval;
>>> +     __le16 max_interval;
>>> +     __le16 latency;
>>> +     __le16 timeout;
>>> +} __packed;
>> 
>> the only open question I still have is if we want to add a __u8 master variable here. The connection parameters are no longer strictly speaking slave to master only. With link layer topology, there are a bit more flexible.
> 
> If we are the slave side and the master requests a parameters update,
> I don't see why we should store the new parameters. The connection is
> always initiated by the master side and, in this case, it is
> responsible for choosing the connection parameters.

good point. And if we say that when we are slave, the connection parameter update is triggered via socket option, then there is really nothing to do here.

> We may send the "New Connection Parameter" event just to let the
> user-space knows the parameters have changed, but it would always be
> store_hint = 0x00.

Lets not send them then. When we are slave, we can check them for ourselves from the socket option that we are using to set them. So no need to send them around.

Also it would be confusing when you switch between master and slave roles. Then you do not know which ones are which. So not sending them is better here.

>> In addition it could be possible that we also act as slave and in that case we request the parameters. I wonder if that should be done via this event as well or if we just use socket option for that. Thoughts?
> 
> I'm not sure about this, but it seems a socket option is a good way to
> request new connection parameters.

I think socket option is best solution here.

Regards

Marcel

