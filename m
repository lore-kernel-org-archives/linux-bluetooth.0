Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABUK1agL-wTZE1cTmO3=eBcApt0_emHcFMg9kQJ19pbo-dH5sA@mail.gmail.com>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
	<20120709140005.GA3293@x220>
	<CABUK1agL-wTZE1cTmO3=eBcApt0_emHcFMg9kQJ19pbo-dH5sA@mail.gmail.com>
Date: Tue, 10 Jul 2012 07:57:30 +0200
Message-ID: <CANq1E4RS3SzmSVF10u-+D0XXRU4jKC62fMAYcR91tPTk345M+g@mail.gmail.com>
Subject: Re: [PATCH 00/21] HID over GATT plugin
From: David Herrmann <dh.herrmann@googlemail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan

On Tue, Jul 10, 2012 at 12:08 AM, Pavan Savoy <pavan_savoy@sify.com> wrote:
> Johan, Joao,
>
> Why wasn't uinput sub-system used ?
> May be there was a discussion regarding this on list & I missed it ?

Yes, there was a discussion on linux-bluetooth and linux-input. If we
use uinput then we need a user-space HID parser. That would mean
duplicating a lot of kernel HID code.

> why invent uHID ? or the project previously existed ?

What project do you mean here? I don't know any predecessor of uHID.
Btw. uhid is already in Jiri's tree and scheduled for 3.6.

Regards
David
