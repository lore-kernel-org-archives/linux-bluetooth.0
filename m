Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 00:38:02 -0600
From: Jonathan Nieder <jrnieder@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andres Cimmarusti <acimmarusti@gmail.com>, linux-kernel@vger.kernel.org,
	info@linuxcertified.com, Paul Fertser <fercerpav@gmail.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: firmware loading failure for AR3011 (0cf3:3000 or 0cf3:3005 ?)
Message-ID: <20120124063802.GD30210@burratino>
References: <CAH=dYrHhttmRjkVuo9QvJ5_Uqd+BJGCJJkaMw8153RW1SFv9dA@mail.gmail.com>
 <20120124061430.GB30210@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120124061430.GB30210@burratino>
List-ID: <linux-bluetooth.vger.kernel.org>

Jonathan Nieder wrote:
> Andres Cimmarusti wrote:

>> [    9.335184] ath3k_load_firmware: Can't change to loading configuration err
>> [    9.335413] ath3k: probe of 1-1.3:1.0 failed with error -110
>
> Further investigation revealed that the problem seems to be in
> userspace: various kernels including a 2.6.32.y-based and 3.1.8-based
> one reproducibly exhibit this behavior with a Debian wheezy userspace
> and do _not_ exhibit the problem in Debian squeeze, Ubuntu 11.10, or
> Fedora 16.  More results:

Erm, I can't read.  Let's try that again:

 working userspace:	Debian squeeze, Ubuntu 11.04, Fedora 15
 broken userspace:	Debian wheezy, Ubuntu 11.10, Fedora 16

Sorry for the confusion.
