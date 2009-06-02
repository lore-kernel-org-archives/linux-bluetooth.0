Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 1/4 v2] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E90677EA@SC-VEXCH1.marvell.com>
References: <1243640590-31666-1-git-send-email-bzhao@marvell.com>
	 <1243667360.3523.28.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E90677EA@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 22:21:07 +0200
Message-Id: <1243974067.15087.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> > > This driver provides basic definitions and library functions to
> > > support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> > > combo chip.
> > 
> > we still have to talk about the handling of vendor commands. Handling
> > these inside the driver is a bad idea. We can just let the core forward
> > them to you if you are interested. I have to think about it a little
> > bit.
> 
> I don't know how the vendor specific commands can be handled outside of btmrvl.ko driver.
> Please share with me once you have any idea on the handling of the vendor commands.

the Bluetooth core parses the commands and events anyway. So we just
need a hook in the hci_dev structure to allow to be called when a vendor
command arrives. And there needs to be an easy way to send such vendor
specific commands from within the driver. Handling it inside the driver
is wrong since you are messing with the flow control handling and that
should be done by the Bluetooth core.
 
> > > +struct btm_thread {
> > > +	struct task_struct *task;
> > > +	wait_queue_head_t wait_q;
> > > +	void *priv;
> > > +};
> > 
> > Please prefix everything with btmrvl_* for cleaner namespace. Especially
> > for the exported symbol it is important that you have a clean namespace.
> 
> I've made this change. Do you want me to resend the new patch now, or wait a while for more feedbacks?

Please re-send them. Then I can add them to bluetooth-testing to see how
far we get. The vendor command handling should not stop us from merging
the driver, but it will be todo item that needs fixing from your side.

I also wanna coordinate with John on how we get the rmmod thing done in
a better way. What you are doing right now is messy and ugly.

Regards

Marcel


