Return-Path: <cyrus@holtmann.org>
Message-ID: <1327971117.1955.205.camel@aeonflux>
Subject: Re: [PATCH v3 3/6] Bluetooth: Add hci_do_le_scan()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 16:51:57 -0800
In-Reply-To: <CACJA=fW0_fdMq9CHVzMPNtp=HrG=RpraLiRjp-L9f1ES8dUsMw@mail.gmail.com>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	 <1327531949-29463-4-git-send-email-andre.guedes@openbossa.org>
	 <1327959526.1955.167.camel@aeonflux>
	 <CACJA=fW0_fdMq9CHVzMPNtp=HrG=RpraLiRjp-L9f1ES8dUsMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> This patch adds to hci_core the hci_do_le_scan function which
> >> should be used to scan LE devices.
> >>
> >> In order to enable LE scan, hci_do_le_scan() sends commands (Set
> >> LE Scan Parameters and Set LE Scan Enable) to the controller and
> >> waits for its results. If commands were executed successfully a
> >> delayed work is scheduled to disable the ongoing scanning after
> >> some amount of time. This function blocks.
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >>  include/net/bluetooth/hci_core.h |    5 +++
> >>  net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++++++++++++++++
> >>  net/bluetooth/hci_event.c        |   15 ++++++++--
> >>  3 files changed, 74 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index 4e569d8..d157762 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -263,6 +263,11 @@ struct hci_dev {
> >>
> >>       unsigned long           dev_flags;
> >>
> >> +     struct delayed_work     le_scan_disable;
> >> +
> >> +     wait_queue_head_t       le_scan_wait_q;
> >> +     u8                      le_scan_result;
> >> +
> >>       int (*open)(struct hci_dev *hdev);
> >>       int (*close)(struct hci_dev *hdev);
> >>       int (*flush)(struct hci_dev *hdev);
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 4830995..22abc37 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -779,6 +779,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> >>       if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
> >>               cancel_delayed_work(&hdev->service_cache);
> >>
> >> +     cancel_delayed_work_sync(&hdev->le_scan_disable);
> >> +
> >>       hci_dev_lock(hdev);
> >>       inquiry_cache_flush(hdev);
> >>       hci_conn_hash_flush(hdev);
> >> @@ -1593,6 +1595,57 @@ int hci_add_adv_entry(struct hci_dev *hdev,
> >>       return 0;
> >>  }
> >>
> >> +static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
> >> +                                             u16 window, int timeout)
> >> +{
> >> +     long timeo = msecs_to_jiffies(3000);
> >> +     DECLARE_WAITQUEUE(wait, current);
> >> +
> >> +     BT_DBG("%s", hdev->name);
> >> +
> >> +     if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> >> +             return -EINPROGRESS;
> >> +
> >> +     add_wait_queue(&hdev->le_scan_wait_q, &wait);
> >> +
> >> +     /* Send LE Set Scan Parameter command and wait for the result */
> >> +     hdev->le_scan_result = -ETIMEDOUT;
> >> +     send_le_scan_param_cmd(hdev, type, interval, window);
> >> +
> >> +     schedule_timeout_uninterruptible(timeo);
> >> +     if (hdev->le_scan_result)
> >> +             goto failed;
> >> +
> >> +     /* Send LE Set Scan Enable command and wait for the result */
> >> +     hdev->le_scan_result = -ETIMEDOUT;
> >> +     send_le_scan_enable_cmd(hdev, 1);
> >> +
> >> +     schedule_timeout_uninterruptible(timeo);
> >> +     if (hdev->le_scan_result)
> >> +             goto failed;
> >> +
> >> +     remove_wait_queue(&hdev->le_scan_wait_q, &wait);
> >> +
> >> +     schedule_delayed_work(&hdev->le_scan_disable,
> >> +                                             msecs_to_jiffies(timeout));
> >
> > we need to make this generic. I know that Andrei will need the same for
> > A2MP and we already do a similar thing with hci_request. If we start
> > spreading the hand-coded versions, this gets messy really quick.
> 
> Yes, I do agree with you about getting messy. So, are you fine with
> we use hci_request here too?

so hci_request is one command at a time. We have a lock for it that
ensures this. Is this good enough?

Also the core idea of hci_request is fine, but we might wanna make this
a bit better. Currently hci_request is spreading hci_req_complete around
like crazy. I think we need to figure out something smarter if we start
using it more and more.

Regards

Marcel


