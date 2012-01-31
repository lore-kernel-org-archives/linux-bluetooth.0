Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327971117.1955.205.camel@aeonflux>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	<1327531949-29463-4-git-send-email-andre.guedes@openbossa.org>
	<1327959526.1955.167.camel@aeonflux>
	<CACJA=fW0_fdMq9CHVzMPNtp=HrG=RpraLiRjp-L9f1ES8dUsMw@mail.gmail.com>
	<1327971117.1955.205.camel@aeonflux>
Date: Tue, 31 Jan 2012 10:42:09 -0300
Message-ID: <CACJA=fXB45+sBirPL7yk43otCd5bHmdRbzDti91h=DDSKnvc1A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] Bluetooth: Add hci_do_le_scan()
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 30, 2012 at 9:51 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> >> This patch adds to hci_core the hci_do_le_scan function which
>> >> should be used to scan LE devices.
>> >>
>> >> In order to enable LE scan, hci_do_le_scan() sends commands (Set
>> >> LE Scan Parameters and Set LE Scan Enable) to the controller and
>> >> waits for its results. If commands were executed successfully a
>> >> delayed work is scheduled to disable the ongoing scanning after
>> >> some amount of time. This function blocks.
>> >>
>> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> >> ---
>> >> =A0include/net/bluetooth/hci_core.h | =A0 =A05 +++
>> >> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 57 ++++++++++++++++=
++++++++++++++++++++++
>> >> =A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| =A0 15 ++++++++--
>> >> =A03 files changed, 74 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
>> >> index 4e569d8..d157762 100644
>> >> --- a/include/net/bluetooth/hci_core.h
>> >> +++ b/include/net/bluetooth/hci_core.h
>> >> @@ -263,6 +263,11 @@ struct hci_dev {
>> >>
>> >> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 dev_flags;
>> >>
>> >> + =A0 =A0 struct delayed_work =A0 =A0 le_scan_disable;
>> >> +
>> >> + =A0 =A0 wait_queue_head_t =A0 =A0 =A0 le_scan_wait_q;
>> >> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0le_scan_resul=
t;
>> >> +
>> >> =A0 =A0 =A0 int (*open)(struct hci_dev *hdev);
>> >> =A0 =A0 =A0 int (*close)(struct hci_dev *hdev);
>> >> =A0 =A0 =A0 int (*flush)(struct hci_dev *hdev);
>> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> index 4830995..22abc37 100644
>> >> --- a/net/bluetooth/hci_core.c
>> >> +++ b/net/bluetooth/hci_core.c
>> >> @@ -779,6 +779,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>> >> =A0 =A0 =A0 if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flag=
s))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&hdev->service_cache)=
;
>> >>
>> >> + =A0 =A0 cancel_delayed_work_sync(&hdev->le_scan_disable);
>> >> +
>> >> =A0 =A0 =A0 hci_dev_lock(hdev);
>> >> =A0 =A0 =A0 inquiry_cache_flush(hdev);
>> >> =A0 =A0 =A0 hci_conn_hash_flush(hdev);
>> >> @@ -1593,6 +1595,57 @@ int hci_add_adv_entry(struct hci_dev *hdev,
>> >> =A0 =A0 =A0 return 0;
>> >> =A0}
>> >>
>> >> +static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interva=
l,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u16 window, int timeout)
>> >> +{
>> >> + =A0 =A0 long timeo =3D msecs_to_jiffies(3000);
>> >> + =A0 =A0 DECLARE_WAITQUEUE(wait, current);
>> >> +
>> >> + =A0 =A0 BT_DBG("%s", hdev->name);
>> >> +
>> >> + =A0 =A0 if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINPROGRESS;
>> >> +
>> >> + =A0 =A0 add_wait_queue(&hdev->le_scan_wait_q, &wait);
>> >> +
>> >> + =A0 =A0 /* Send LE Set Scan Parameter command and wait for the resu=
lt */
>> >> + =A0 =A0 hdev->le_scan_result =3D -ETIMEDOUT;
>> >> + =A0 =A0 send_le_scan_param_cmd(hdev, type, interval, window);
>> >> +
>> >> + =A0 =A0 schedule_timeout_uninterruptible(timeo);
>> >> + =A0 =A0 if (hdev->le_scan_result)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>> >> +
>> >> + =A0 =A0 /* Send LE Set Scan Enable command and wait for the result =
*/
>> >> + =A0 =A0 hdev->le_scan_result =3D -ETIMEDOUT;
>> >> + =A0 =A0 send_le_scan_enable_cmd(hdev, 1);
>> >> +
>> >> + =A0 =A0 schedule_timeout_uninterruptible(timeo);
>> >> + =A0 =A0 if (hdev->le_scan_result)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>> >> +
>> >> + =A0 =A0 remove_wait_queue(&hdev->le_scan_wait_q, &wait);
>> >> +
>> >> + =A0 =A0 schedule_delayed_work(&hdev->le_scan_disable,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(timeout));
>> >
>> > we need to make this generic. I know that Andrei will need the same fo=
r
>> > A2MP and we already do a similar thing with hci_request. If we start
>> > spreading the hand-coded versions, this gets messy really quick.
>>
>> Yes, I do agree with you about getting messy. So, are you fine with
>> we use hci_request here too?
>
> so hci_request is one command at a time. We have a lock for it that
> ensures this. Is this good enough?

Yes, for this case, hci_request is just fine.

BR,

Andre
