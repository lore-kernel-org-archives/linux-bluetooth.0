Return-Path: <cyrus@holtmann.org>
Message-ID: <4f436aae0807290745i74ac09b6xee4f4e01037e3cbd@mail.gmail.com>
Date: Tue, 29 Jul 2008 17:45:36 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: pavan_savoy@indiatimes.com
Subject: Re: HCI_Reset and Notification to User-Space
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <723119697.28261217339091256.JavaMail.root@mbv7.indiatimes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1399758677.27391217338854603.JavaMail.root@mbv7.indiatimes.com>
	 <723119697.28261217339091256.JavaMail.root@mbv7.indiatimes.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 29, 2008 at 4:44 PM,  <pavan_savoy@indiatimes.com> wrote:
> Also I couldnt trace the hci_init_req, which does the HCI_RESET, read_BD addr, local name..etc..
>
> Who calls it ?

hci_dev_open. indirectly, using __hci_request.
