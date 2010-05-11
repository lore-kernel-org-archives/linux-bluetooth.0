Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 May 2010 15:47:02 +0100 (BST)
To: Serhiy Kachaniuk <serzholino@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bugreport]
In-Reply-To: <u2z793f89501005060256g3eb32a09ncff16e8e454bdcc@mail.gmail.com>
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>  <4BE270EE.5080306@greffrath.com> <u2z793f89501005060256g3eb32a09ncff16e8e454bdcc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1273589222.840882.854.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Serhiy, from your message on the ubuntu bug report

> Maybe the reason is that this dongle doesn't support reading/writing of
> 'Default Link Policy Settings' ?

and this command was introduced in spec version 1.2, and your device
reports

>        HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver: 0x800

so yes, that is likely the problem as it is too old.

That bluez has no handling for the possibility that the command may not be
supported is possibly a bug or possibly an indication that older devices
are no longer to be supported, I can't really say which.

regards,
iain


