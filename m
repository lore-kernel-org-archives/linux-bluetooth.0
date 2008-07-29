Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jul 2008 19:10:54 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: Ohad Ben-Cohen <ohad@bencohen.org>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <1399758677.27391217338854603.JavaMail.root@mbv7.indiatimes.com>
In-Reply-To: <bd5b16740807290603r4cdc6fbbg1e19ffcda836c70e@mail.gmail.com>
Subject: Re: HCI_Reset and Notification to User-Space
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you,

Also hci_notify notifies a HCI_DEV_REG event thru' the notifier chain, what I couldnt get was, how does HCI-daemon wait on it.
(related to g_io_add_watch or something was my guess, but not sure..., or is it using the Stack-Internal Socket Events? which would require hci_dev_open to be called.)

I until now had thought notifier chains are used only for inter-kernel notifications. I guess I was wrong.

Please clarify.


----- Original Message -----
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: pavan savoy <pavan_savoy@indiatimes.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Tue, 29 Jul 2008 18:33:20 +0530 (IST)
Subject: Re: HCI_Reset and Notification to User-Space

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

