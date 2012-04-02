Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120402094633.GA26168@x220>
References: <1332879859-20268-1-git-send-email-arik@wizery.com>
 <CA+XVXfcJ=zGx9Qz6tEEEoBi9F4F6jN_bgnT5+axrN3p9zRNx-A@mail.gmail.com> <20120402094633.GA26168@x220>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 2 Apr 2012 14:12:56 +0300
Message-ID: <CA+XVXfex76H8AwCRnb2hYk_LZfORKOtPeoGn2POFZggqp=2ypQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Implement ProximityReporter profiles
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 2, 2012 at 12:46, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> On Tue, Mar 27, 2012 at 22:24, Arik Nemtsov <arik@wizery.com> wrote:
> Firstly the patches do not apply:
>
> Applying: att: add remote btd_device to ATT read/write callbacks
> /home/jh/src/bluez/.git/rebase-apply/patch:61: new blank line at EOF.
> +
> fatal: 1 line adds whitespace errors.
> Patch failed at 0001 att: add remote btd_device to ATT read/write callbacks

Ah there's an extra blank line at the end of the
"attrib/att-database.h" file I added. I'll remove it.

>
> And secondly you haven't replied anything to Lizardos mail yet.

Lizardo's only comment seems to be related to indentations of multiple
lines. I'll make some corrections and resubmit shortly.

Arik
