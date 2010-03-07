Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Mar 2010 07:56:58 -0800
From: Greg KH <gregkh@suse.de>
To: t.a.c.henriques@googlemail.com
Cc: t.a.c.henriques@gmail.com, marcel@holtmann.org,
	adobriyan@gmail.com, tglx@linutronix.de,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: fix coding style issue in hci_vhci.c This
	patch affects hci_vhci.c it fixes some warnings detected by the
	checkpath.pl tool Signed-off-by: Tiago Henriques
	<t.a.c.henriques@gmail.com>
Message-ID: <20100307155658.GB1805@suse.de>
References: <1267934631-3531-1-git-send-email-t.a.c.henriques@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267934631-3531-1-git-send-email-t.a.c.henriques@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Your Subject line is a bit messed up :)

You need to put extra lines in your git commit so that git-send-email
doesn't barf on it.

On Sun, Mar 07, 2010 at 04:03:51AM +0000, t.a.c.henriques@googlemail.com wrote:
> From: root <root@balganUbuntuVM.(none)>

And this is incorrect.

thanks,

greg k-h
