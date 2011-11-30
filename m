Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 6/9] Bluetooth: Add LE scan functions to hci_core
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1322497710.29909.40.camel@aeonflux>
Date: Wed, 30 Nov 2011 15:11:19 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D717F826-12B0-4441-91CD-D75CE7609D5C@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org> <1322265226-6404-7-git-send-email-andre.guedes@openbossa.org> <1322497710.29909.40.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 28, 2011, at 1:28 PM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> This patch adds to hci_core functions to init LE scan and cancel
>> an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |    3 +++
>> net/bluetooth/hci_core.c         |   32 =
++++++++++++++++++++++++++++++++
>> 2 files changed, 35 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>> index a48c699..db137ca 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -998,5 +998,8 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
>>=20
>> int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>> int hci_cancel_inquiry(struct hci_dev *hdev);
>> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 =
window,
>> +								int =
timeout);
>> +int hci_cancel_le_scan(struct hci_dev *hdev);
>>=20
>> #endif /* __HCI_CORE_H */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 8e96e3b..1e5d9db 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2678,5 +2678,37 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
>> 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
>> }
>>=20
>> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 =
window,
>> +								int =
timeout)
>> +{
>> +	struct le_scan_params *params =3D &hdev->le_scan_params;
>> +
>> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +		return -EINPROGRESS;
>> +
>> +	BT_DBG("%s", hdev->name);
>> +
>> +	params->type =3D type;
>> +	params->interval =3D interval;
>> +	params->window =3D window;
>> +	params->timeout =3D timeout;
>> +
>> +	queue_work(hdev->workqueue, &hdev->le_scan);
>=20
> so you are using the controller workqueue already. That is good. =
However
> if the send command are already processed in a workqueue, we could =
just
> sleep for their results. No need for hci_req_complete handling that we
> are using for ioctl based triggers. We could have a lot simpler
> hci_request handling from within the workqueue.

Ok, I'll replace hci_request by another simpler mechanism.

>> +
>> +	return 0;
>> +}
>> +
>> +int hci_cancel_le_scan(struct hci_dev *hdev)
>> +{
>> +	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +		return -EPERM;
>> +
>> +	BT_DBG("%s", hdev->name);
>> +
>> +	del_timer(&hdev->le_scan_timer);
>> +
>> +	return send_le_scan_enable_cmd(hdev, 0);
>> +}
>> +
>=20
> Don't you need to clear out the work struct as well? In case that one =
is
> still running? Meaning cancel gets called quickly after starting the
> scan. The window might be small, but this is a race condition.


If we want to be able to cancel le scan during this small window we
should cancel it (if it didn't start yet) or wait until "le scan" work
finishes. To achieve that we can use cancel_work_sync(), but it
blocks. So, we'll need another work to handle this.

This is a bit tricky actually. Since hdev->workqueue is single thread,
the "cancel le scan" work will always run after "le scan" work. So, if
we enqueue "cancel le scan" work in hdev->workqueue we won't be able
to cancel the "le scan" work if it is not started yet.

Do you think we should enqueue "cancel le scan" work in the system-wide
workqueue so we have the chance to cancel "le scan" work before it
starts?

BR,

Andre
