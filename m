Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Jun 2011 10:57:20 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Tomas Targownik <ttargownik@geicp.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Memory leak on failed connection attempt
Message-ID: <20110602135720.GB2790@joana>
References: <1306997293.1926.83.camel@rnd3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306997293.1926.83.camel@rnd3>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

* Tomas Targownik <ttargownik@geicp.com> [2011-06-02 16:48:13 +1000]:

> I am trying to track down a memory leak that is occurring in bluez4
> v4.87 running on Linux 2.6.32.21, on an ARMv5 device. Unfortunately with
> my somewhat limited bluetooth stack expertise, there is only so much I
> can understand in the debugging process, so I do hope that someone can
> offer their advice on this issue, or even just point me in the right
> direction. 

Can you try an upstream kernel and check if this still happens? 2.6.32 is
quite old.

-- 
Gustavo F. Padovan
http://profusion.mobi
