Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jun 2010 15:49:11 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Andrei Moraru <andrei.moraru.n@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: hci_scodata_packet: hci1 SCO packet for unknown connection
 handle 42
Message-ID: <20100618184911.GA14514@vigoh>
References: <AANLkTin25xCMcVDCzbeXO-ZZfxhS4O0foXU8wl4h3tds@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTin25xCMcVDCzbeXO-ZZfxhS4O0foXU8wl4h3tds@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Moraru <andrei.moraru.n@gmail.com> [2010-06-18 15:29:41 +0300]:

> Hello,
> 
> the machine is running CentOS and Asterisk 1.4.32
> 
> there are installed bluez-4.66 and asterisk module chan_mobile
> 
> The Asterisk crashes sometimes when is using FXO over the bluetooth
> connection via chan_mobile
> 
> uname -a:
> 2.6.18-164.el5 #1 SMP Thu Sep 3 03:33:56 EDT 2009 i686 athlon i386 GNU/Linux

Update your kernel to a 2.6.34 at least and see if you still have this
issue.

-- 
Gustavo F. Padovan
http://padovan.org
