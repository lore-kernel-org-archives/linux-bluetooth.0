Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 18:20:45 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 5/8] Bluetooth: Remove GFP_ATOMIC usage from
 l2cap_core.c
Message-ID: <20121012102045.GD10739@joana>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
 <1349938311-25101-5-git-send-email-gustavo@padovan.org>
 <1349963436.27233.171.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349963436.27233.171.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-10-11 15:50:36 +0200]:

> Hi Gustavo,
> 
> > Since we change the Bluetooth core to run in process context we don't need
> > to use GFP_ATOMIC in many of places we were using it. The we just replace
> > by GFP_KERNEL.
> 
> I assume you double-checked that we nowhere hold a lock or the caller
> holds a lock.

Yes, I did double-check this. The code is running pretty fine as well.
I pushed this to bluetooth-next btw.

	Gustavo
> 
> 
