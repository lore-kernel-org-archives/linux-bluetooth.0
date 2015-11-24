Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] tools/hciattach: Add support for BCM line discipline
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151124122842.12ca2fba.john@metanate.com>
Date: Tue, 24 Nov 2015 13:37:22 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <00194B0F-4F62-445C-B8C8-1877ED61C4B7@holtmann.org>
References: <1448366171-14264-1-git-send-email-john@metanate.com> <BECBB818-C6C6-4A55-A8ED-804820D0337E@holtmann.org> <20151124122842.12ca2fba.john@metanate.com>
To: John Keeping <john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

>>> This is similar to the "bcm43xx" option but using the kernel driver
>>> has the advantage that the wakeup and shutdown pins on the device
>>> can be used.  
>> 
>> what is wrong with just using btattach?
> 
> It's marked as experimental and not installed by "make install", so I
> assumed that it was only supposed to be used for testing.

hmm, not installed by default. I do not remember the reason for that, but I am sure I had one. However btattach is so dead simple that it should be used. Seems like we should look into making sure the command line options are stable and we install it by default.

The hciattach code is the most horrific code we have in our tree. I really dislike it and there is almost zero chance to clean it up. I am not sure that I want to pile on top of it.

Regards

Marcel

