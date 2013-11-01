Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Nov 2013 09:57:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, s.syam@samsung.com
Subject: Re: [BUG] Crash during disconnecting and removing bond from remote
 device
Message-ID: <20131101075718.GA13221@x220.p-661hnu-f1>
References: <526E5C98.8020407@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <526E5C98.8020407@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seung-Woo Kim,

On Mon, Oct 28, 2013, Seung-Woo Kim wrote:
> I used 3.10.14 with RFCOMM tty patches in 3.12-rc, and I tested
> disconnecting and removing a bond from remote device. and I got
> following crash.

This looks like a potentially valid issue, but you'd need to dress up
the fix as a proper patch (i.e. git format-patch + git send-email). It'd
also be good if you could confirm that the issue is reproducable with
the latest bluetooth-next kernel.

Johan
