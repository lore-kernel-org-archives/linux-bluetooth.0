Return-Path: <john@metanate.com>
Date: Tue, 24 Nov 2015 12:28:42 +0000
From: John Keeping <john@metanate.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hciattach: Add support for BCM line discipline
Message-ID: <20151124122842.12ca2fba.john@metanate.com>
In-Reply-To: <BECBB818-C6C6-4A55-A8ED-804820D0337E@holtmann.org>
References: <1448366171-14264-1-git-send-email-john@metanate.com>
	<BECBB818-C6C6-4A55-A8ED-804820D0337E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 24 Nov 2015 13:21:05 +0100, Marcel Holtmann wrote:

> > This is similar to the "bcm43xx" option but using the kernel driver
> > has the advantage that the wakeup and shutdown pins on the device
> > can be used.  
> 
> what is wrong with just using btattach?

It's marked as experimental and not installed by "make install", so I
assumed that it was only supposed to be used for testing.


Regards,
John
