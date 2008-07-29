Return-Path: <cyrus@holtmann.org>
Message-ID: <4f436aae0807290745j3a636acfode2598b9b4229999@mail.gmail.com>
Date: Tue, 29 Jul 2008 17:45:25 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: pavan_savoy@indiatimes.com
Subject: Re: HCI_Reset and Notification to User-Space
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1399758677.27391217338854603.JavaMail.root@mbv7.indiatimes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bd5b16740807290603r4cdc6fbbg1e19ffcda836c70e@mail.gmail.com>
	 <1399758677.27391217338854603.JavaMail.root@mbv7.indiatimes.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pavan,

Please don't top-post.

On Tue, Jul 29, 2008 at 4:40 PM,  <pavan_savoy@indiatimes.com> wrote:
> Also hci_notify notifies a HCI_DEV_REG event thru' the notifier chain, what I couldnt get was, how does HCI-daemon wait on it.
> (related to g_io_add_watch or something was my guess, but not sure..., or is it using the Stack-Internal Socket Events? which would require hci_dev_open to be called.)
>
> I until now had thought notifier chains are used only for inter-kernel notifications. I guess I was wrong.

The notification IS sent to a kernel client - the hci_sock_dev_event
function. That function in turn sends the event to a user space via a
socket which was created and watched by hcid beforehand. Check out
hcid's main function for more details.

Regards,
Ohad.
