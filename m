Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 14:46:52 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Nikolay Kachanov <nikolay.kachanov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BCM2035 problem
Message-ID: <20110803174652.GB28119@joana>
References: <CA+16OfjbEJmKrog5aMXCNLyBrqW7sMCoqV4QvkYgn765LWsvsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+16OfjbEJmKrog5aMXCNLyBrqW7sMCoqV4QvkYgn765LWsvsg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nikolay,

* Nikolay Kachanov <nikolay.kachanov@gmail.com> [2011-08-03 09:15:40 +0400]:

> Hello,
> 
> With all versions of bluez above 4.84, including 4.96, my cellular
> phone and PC can pair via Broadcom BCM2035 USB dongle, but every
> attempt of file exchange ends with a complain about other side is not
> responding.
> Is that a bug or BCM2035 is not supported any more?
> My OS is Arch Linux, both i686 and x86_64. I can provide more
> information if necessary.

An hcidump output would be good. Also send the log of obexd -nd.

	Gustavo
