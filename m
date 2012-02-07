Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328588997-25029-4-git-send-email-aguedespe@gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
	<1328588997-25029-4-git-send-email-aguedespe@gmail.com>
Date: Tue, 7 Feb 2012 06:48:37 -0400
Message-ID: <CAJdJm_OdPCzJaBSkPx8E0ZS+TqVJV943+t8Npj+x=U8B4XRZ5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Use advertising cache thread-safe functions
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Feb 7, 2012 at 12:29 AM, Andre Guedes <aguedespe@gmail.com> wrote:
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6808069..3933ccd 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3255,12 +3255,10 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
>        void *ptr = &skb->data[1];
>        s8 rssi;
>
> -       hci_dev_lock(hdev);
> -

So there is no need to lock hdev between the hci_add_adv_entry() and
mgmt_device_found() calls? This looks different from what is done for
BR/EDR for the inquiry cache.

>        while (num_reports--) {
>                struct hci_ev_le_advertising_info *ev = ptr;
>
> -               __hci_add_adv_entry(hdev, ev);
> +               hci_add_adv_entry(hdev, ev);
>
>                rssi = ev->data[ev->length];
>                mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
> @@ -3268,8 +3266,6 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
>
>                ptr += sizeof(*ev) + ev->length + 1;
>        }
> -
> -       hci_dev_unlock(hdev);
>  }
>
>  static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
> --
> 1.7.9


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
