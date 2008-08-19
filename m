Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch]race condition in btusb disconnect() handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808191714.50309.oliver@neukum.org>
References: <200808191423.52657.oliver@neukum.org>
	 <200808191605.40987.oliver@neukum.org>
	 <1219156278.7591.145.camel@violet.holtmann.net>
	 <200808191714.50309.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 17:27:23 +0200
Message-Id: <1219159643.7591.161.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > > > First you release the interface, then you unregister the hci.
> > > > 
> > > > Putting it after hci_unregister_dev is an issue. The unregister will
> > > > call __hci_dev_put and then in return will call the destruct callback
> > > > which will free the data pointer.
> > > > 
> > > > So either we use hci_dev_hold or make sure that disconnect can only
> > > > disable the SCO interface. That comes directly with the first comment
> > > > from you.
> > > 
> > > Here is a new version. I am afraid normal hci_dev_hold would fail if
> > > the disconnect happens because the btusb module is being unloaded.
> > 
> > the btusb_stop_traffic change is bogus. You don't need that. The flush
> > callback will be called to ensure that all TX traffic is released.
> 
> OK.
> 
> > I am not sure about hci_dev_hold. We ensure that a reference count to
> > the module is hold when the HCI device is brought up.
> 
> But won't the module be marked as going away and make try_module_get()
> fail?

when calling "hciconfig hci0 up" then it is impossible to unload the
btusb module since we keep a module reference.

I am thinking that just __set_isoc_interface(..., 0) when disconnect
gets called for the isoc interface and the releasing the interface is
the more cleaner way. I have to think about this.

Regards

Marcel


