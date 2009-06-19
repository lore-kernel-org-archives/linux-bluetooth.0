Return-Path: <cyrus@holtmann.org>
Subject: Re: omnibook module loads but still can't use bluetooth device
From: Renato Budinich <rennabh@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <200906190033.15149.aklists@mixdown.ca>
References: <1245274194.3925.13.camel@renato-laptop>
	 <200906190033.15149.aklists@mixdown.ca>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 14:46:56 +0200
Message-Id: <1245415616.3788.4.camel@renato-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-19 at 00:33 -0400, Andrew Kohlsmith (Mailing List
Account) wrote:
> On my Toshiba U300, I had to specify ectype=14 when I load the omnibook module 
> or I don't find any BT device at all.  I don't think that's your problem, 
> though.

yes i tried with different ectypes and 12 seems to give best results for
me

> Now the 'btusb' module gets loaded, and that is what seems to bring up the HCI 
> device for me.  Perhaps that's what is missing on your system?
> 
Yes definitely it's missing! Do you know which option does it correspond
to in the kernel configuration? I'll search for it and compile it in
these days and then report back

Renato

