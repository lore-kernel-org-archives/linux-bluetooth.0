Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 07/14] Bluetooth: Handle race condition in Discovery
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316522234.1937.81.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:13:50 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2CF28A50-3159-4B3F-AAC4-0E12E2B24D54@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-8-git-send-email-andre.guedes@openbossa.org> <1316522234.1937.81.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 9:37 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> If MGMT_OP_STOP_DISCOVERY command is issued before the kernel
>> receives the HCI Inquiry Command Status Event from the controller
>> then that command will fail and the discovery procedure won't be
>> stopped. This situation may occur if a MGMT_OP_STOP_DISCOVERY
>> command is issued just after a MGMT_OP_START_DISCOVERY.
>>=20
>> This race condition can be handled by checking for pending
>> MGMT_OP_STOP_DISCOVERY command in inquiry command status event
>> handler. If we have a pending MGMT_OP_STOP_DISCOVERY command we
>> cancel the ongoing discovery.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/hci_event.c        |    3 +++
>> net/bluetooth/mgmt.c             |   14 +++++++++++++-
>> 3 files changed, 17 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>> index 4a79a50..36e15cc 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -876,6 +876,7 @@ int mgmt_discovering(u16 index, u8 discovering);
>> int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
>> int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
>> int mgmt_discovery_complete(u16 index, u8 status);
>> +int mgmt_has_pending_stop_discov(u16 index);
>>=20
>> /* HCI info for socket */
>> #define hci_pi(sk) ((struct hci_pinfo *) sk)
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index b44f362..c9d641b 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -962,6 +962,9 @@ static inline void hci_cs_inquiry(struct hci_dev =
*hdev, __u8 status)
>> 	set_bit(HCI_INQUIRY, &hdev->flags);
>>=20
>> 	mgmt_discovering(hdev->id, 1);
>> +
>> +	if (mgmt_has_pending_stop_discov(hdev->id))
>> +		hci_cancel_inquiry(hdev);
>> }
>>=20
>> static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 =
status)
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index d84f242..58cf33a 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1674,7 +1674,11 @@ static int stop_discovery(struct sock *sk, u16 =
index)
>> 		goto failed;
>> 	}
>>=20
>> -	err =3D hci_cancel_inquiry(hdev);
>> +	if (test_bit(HCI_INQUIRY, &hdev->flags))
>> +		err =3D hci_cancel_inquiry(hdev);
>> +	else
>> +		err =3D 0;
>> +
>=20
> do we really just wanna always return success here? Even if
> stop_discovery is called for a none existing discovery.

If stop_discovery() is called for a none existing discovery
this code isn't even reached since stop_discovery() will
return in MGMT_OP_START_DISCOVERY pending command check at=20
the beginning of stop_discovery().

If we have an ongoing discovery but the HCI_INQUIRY flag isn't
set, then we are in the race condition window. Only in that case,
we return 0 and postpone the discovery cancel operation.

> And btw. since you just changed the hci_cancel_inquiry() to return
> -EPERM if the HCI_INQUIRY flag is not set you could do this simpler by
> just checking the return value directly. No double check of the
> HCI_INQUIRY flag.

Yes, I could have done like this, but since in a further patch I'll
add the HCI_LE_SCAN flag check I've done his way here (please see
patch 13/14).

The HCI_INQUIRY check in hci_cancel_inquiry() is to make sure no
HCI_OP_CANCEL_INQUIRY command is issued unless the controller is
in inquiry mode (spec recommendations).

The HCI_INQUIRY (and HCI_LE_SCAN) check in stop_discovery() stands
for sending the right command to cancel the ongoing discovery.

Andre=
