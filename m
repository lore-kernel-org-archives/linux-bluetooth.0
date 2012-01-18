Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326890884-16678-2-git-send-email-ulisses@profusion.mobi>
References: <1326890884-16678-1-git-send-email-ulisses@profusion.mobi>
	<1326890884-16678-2-git-send-email-ulisses@profusion.mobi>
Date: Wed, 18 Jan 2012 16:34:23 -0300
Message-ID: <CACJA=fX_TTf+1ecuY_31xRRHsBQFOMhX=zaDi1=4cQcYYmJCpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Remove wait for delayed work to finish
From: Andre Guedes <andre.guedes@openbossa.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Wed, Jan 18, 2012 at 9:48 AM, Ulisses Furquim <ulisses@profusion.mobi> wrote:
> Do not wait for delayed work to finish where it's not needed. In the
> case of adv_work the handler is already protected by the hdev lock
> and removing the wait we also avoid introducing deadlocks involving
> the delayed work lock.
>
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  net/bluetooth/hci_core.c  |    2 +-
>  net/bluetooth/hci_event.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a7b7200..b4041be 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1731,7 +1731,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>
>        hci_del_sysfs(hdev);
>
> -       cancel_delayed_work_sync(&hdev->adv_work);
> +       cancel_delayed_work(&hdev->adv_work);

I'm afraid we'll introduce a race condition if we don't use the
_sync variant at hci_unregister_dev.

If we don't wait adv_work finish it may be running after hdev
object is freed.

>
>        destroy_workqueue(hdev->workqueue);
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c2fe964..f28cbae 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1045,7 +1045,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>        case LE_SCANNING_ENABLED:
>                set_bit(HCI_LE_SCAN, &hdev->dev_flags);
>
> -               cancel_delayed_work_sync(&hdev->adv_work);
> +               cancel_delayed_work(&hdev->adv_work);
>
>                hci_dev_lock(hdev);
>                hci_adv_entries_clear(hdev);

BR,

Andre
