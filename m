Return-Path: <cyrus@holtmann.org>
Subject: Re: omnibook module loads but still can't use bluetooth device
From: Renato Budinich <rennabh@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <200906190033.15149.aklists@mixdown.ca>
References: <1245274194.3925.13.camel@renato-laptop>
	 <200906190033.15149.aklists@mixdown.ca>
Content-Type: text/plain
Date: Sat, 20 Jun 2009 00:44:19 +0200
Message-Id: <1245451459.5266.1.camel@renato-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Now the 'btusb' module gets loaded, and that is what seems to bring up the HCI 
> device for me.  Perhaps that's what is missing on your system?

Yepee! Recompiling the kernel with btusb as module did the trick. Thank
you for the insight

Renat

