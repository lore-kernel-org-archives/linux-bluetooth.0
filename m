Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 12:02:56 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Re: Work-around for broken MS device
Message-ID: <20110505190256.GA15545@jh-x301>
References: <1236278908.3602.1896.camel@cookie.hadess.net>
 <1237397279.15346.1157.camel@cookie.hadess.net>
 <1237011673.24751.10.camel@localhost.localdomain>
 <1237816742.19118.1234.camel@cookie.hadess.net>
 <7B1632C9-FE1A-43EA-A0B6-F26A46F9929F@holtmann.org>
 <1304618532.16101.14.camel@novo.hadess.net>
 <1304620681.16101.15.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304620681.16101.15.camel@novo.hadess.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, May 05, 2011, Bastien Nocera wrote:
> > Patch to do that attached.
> 
> And one that compiles (sigh).

> From 2b4524b060d980a7899c03359cd4943c9ad9cfe4 Mon Sep 17 00:00:00 2001
> From: Bastien Nocera <hadess@hadess.net>
> Date: Mon, 8 Nov 2010 16:43:42 +0000
> Subject: [PATCH] Handle non-UTF-8 device names
> 
> http://thread.gmane.org/gmane.linux.bluez.kernel/1687
> https://bugzilla.redhat.com/show_bug.cgi?id=450081
> ---
>  src/event.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)

Pushed upstream. Thanks.

Johan
