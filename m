Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH]btusb:Prevent illtimed autosuspend
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20091216182600.GA20031@srcf.ucam.org>
References: <200912161923.43127.oliver@neukum.org>
	 <20091216182600.GA20031@srcf.ucam.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Dec 2009 15:37:57 -0800
Message-Id: <1261006677.4041.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver and Matthew,

> > commit 0b72b0a05c1d950e4f35520926cc36bc01fb998a
> > Author: Oliver Neukum <oliver@neukum.org>
> > Date:   Mon Dec 14 22:09:49 2009 +0100
> > 
> >     btusb:Prevent illtimed autosuspend
> >     
> >     The device must be marked busy as it recieves data.
> >     
> >     Signed-off-by: Oliver Neukum <oliver@neukum.org>
> 
> Tested-by: Matthew Garrett <mjg@redhat.com>

thanks for figuring this out. I will queue this patch up along with the
other changes and send them to Dave this week.

Regards

Marcel


