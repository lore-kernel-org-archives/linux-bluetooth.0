Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch]race condition in btusb disconnect() handling
Date: Tue, 19 Aug 2008 17:34:08 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808191423.52657.oliver@neukum.org> <200808191714.50309.oliver@neukum.org> <1219159643.7591.161.camel@violet.holtmann.net>
In-Reply-To: <1219159643.7591.161.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808191734.08795.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 19 August 2008 17:27:23 schrieb Marcel Holtmann:
> > > I am not sure about hci_dev_hold. We ensure that a reference count to
> > > the module is hold when the HCI device is brought up.
> > 
> > But won't the module be marked as going away and make try_module_get()
> > fail?
> 
> when calling "hciconfig hci0 up" then it is impossible to unload the
> btusb module since we keep a module reference.

There's no guarantee the hci is up when disconnect() is called.

	Regards
		Oliver
