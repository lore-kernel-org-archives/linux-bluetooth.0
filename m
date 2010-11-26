Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290784965-4508-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1290784965-4508-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 26 Nov 2010 12:22:37 -0400
Message-ID: <AANLkTi=6N-D+mGgpQ6P9YM+Cvk0F87MDAq14rDLdAYYw@mail.gmail.com>
Subject: Re: [RFC 4/4] Bluetooth: clean up hci code
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 26, 2010 at 11:22 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> @@ -430,7 +433,8 @@ int hci_inquiry(void __user *arg)
>        hci_dev_unlock_bh(hdev);
>
>        timeo = ir.length * msecs_to_jiffies(2000);
> -       if (do_inquiry && (err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo)) < 0)
> +       err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo);
> +       if (do_inquiry && err < 0)
>                goto done;

I think there is a problem here. the "do_inquiry" flag will be checked
*after* the inquiry request is done. Maybe you should do something
like:

if (do_inquiry) {
    err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo);
    if (err < 0)
        goto done;
}

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
