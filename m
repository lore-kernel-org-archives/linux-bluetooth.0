Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 May 2011 12:12:48 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Warning fixes for GCC 4.6
Message-ID: <20110506151248.GA2221@joana>
References: <1304620983.16101.16.camel@novo.hadess.net>
 <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
 <1304693789.16101.35.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304693789.16101.35.camel@novo.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

* Bastien Nocera <hadess@hadess.net> [2011-05-06 15:56:28 +0100]:

> On Fri, 2011-05-06 at 10:52 +0300, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> > 
> > On Thu, May 5, 2011 at 9:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > > So that bluez compiles with -Werror.
> > >
> > > Cheers
> > >
> 
> Updated patch attached. Only comment left is the "unused" attribute.

> From 1816c686e1e411ec574c6f168dac43e0ff4d6bd1 Mon Sep 17 00:00:00 2001
> From: Bastien Nocera <hadess@hadess.net>
> Date: Thu, 5 May 2011 19:41:38 +0100
> Subject: [PATCH] Fix "set but not unused variable" GCC 4.6 warnings
> 
> ---
>  attrib/gatt.c         |    4 ----
>  audio/a2dp.c          |    3 ---
>  audio/manager.c       |    2 --
>  audio/pcm_bluetooth.c |    4 ++--
>  btio/btio.c           |    5 +++++
>  compat/fakehid.c      |    6 ++++--
>  cups/hcrp.c           |   12 ++++++++++++
>  gdbus/object.c        |    3 +--

The gdbus changes need a new patch. It also needs to be applied to Obexd
ConnMan and oFono.

-- 
Gustavo F. Padovan
http://profusion.mobi
