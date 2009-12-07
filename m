Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Dec 2009 20:05:37 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Gunn <bgunn@solekai.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND #2] [PATCH] Bluetooth: implement raw output for hidp
In-Reply-To: <1260210432.2987.59.camel@violet>
Message-ID: <alpine.LNX.2.00.0912072004530.3755@pobox.suse.cz>
References: <alpine.LNX.2.00.0912031450400.3755@pobox.suse.cz>  <alpine.LNX.2.00.0912071853230.3755@pobox.suse.cz> <1260210432.2987.59.camel@violet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 7 Dec 2009, Marcel Holtmann wrote:

> > Implment raw output callback which is used by hidraw to send raw data to 
> > the underlying device.
> > 
> > Without this patch, the userspace hidraw-based applications can't send 
> > output reports to HID bluetooth devices.
> 
> that is in the bluetooth-next and net-next tree already. Linus should be
> pulling it any time soon.

Hi Marcel,

ah, I have been looking into wrong tree (bluetooth-2.6 instead of 
bluetooth-next-2.6).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
