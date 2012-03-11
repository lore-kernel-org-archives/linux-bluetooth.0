Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120311130249.GA8525@x220.P-661HNU-F1>
References: <1331455196-26441-1-git-send-email-arik@wizery.com> <20120311130249.GA8525@x220.P-661HNU-F1>
From: Arik Nemtsov <arik@wizery.com>
Date: Sun, 11 Mar 2012 15:14:55 +0200
Message-ID: <CA+XVXfcqxdXRHYJCc2YToebasJk8xf6hH3_XhtOrd0n0fvR+tg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Implement Read Transmit Power Level command
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Johan,

On Sun, Mar 11, 2012 at 15:02, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> +
>> +unlock:
>> +     hci_dev_unlock(hdev);
>> +     hci_dev_put(hdev);
>
> The dev_put here looks like a bug (probably from before the rebase when
> this function was still calling hci_dev_get).

Thanks. That's indeed a bug I missed in the rebase. I'll fix it.

>
> Other than that I don't see anything obviously wrong with the patch,
> except that you might have maybe tried splitting it up a bit (not that
> it's very big now either).

Well the original was a single patch. And most of the code is pretty
boilerplate. I'm thinking a single patch might be ok?

Regards,
Arik
