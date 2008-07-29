Return-Path: <cyrus@holtmann.org>
Message-ID: <bd5b16740807290603r4cdc6fbbg1e19ffcda836c70e@mail.gmail.com>
Date: Tue, 29 Jul 2008 16:03:20 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: pavan_savoy@indiatimes.com
Subject: Re: HCI_Reset and Notification to User-Space
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1882591226.12271217333396980.JavaMail.root@mbv7.indiatimes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1882591226.12271217333396980.JavaMail.root@mbv7.indiatimes.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Tue, Jul 29, 2008 at 3:09 PM,  <pavan_savoy@indiatimes.com> wrote:
> What I am trying to understand is, in what place of hciattach does the whole system, [through dbus] get to know the existance of the bt device and what call [from which module] does that notification go to the user-space.

When hciattach calls the HCIUARTSETPROTO ioctl, you get the following
trace in the kernel:
hci_uart_set_proto -> hci_uart_register_dev -> hci_register_dev -> hci_notify.

The last function notifies user space (hcid) about the new device.
Hciattach does not use dbus and does not directly communicate with hcid.

Regards,
Ohad.

>
> Just a brief about the hciattach / notification to user-space and socket setup.
>
>
> Thanks in advance.
> Pavan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
