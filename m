Return-Path: <cyrus@holtmann.org>
Message-ID: <1334654814.16897.189.camel@aeonflux>
Subject: Re: [PATCH v0 5/6] Bluetooth: btusb: Dynamic alternate setting
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Tue, 17 Apr 2012 11:26:54 +0200
In-Reply-To: <20120416214602.GA2796@joana>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	 <1334126932-27327-6-git-send-email-mikel.astiz.oss@gmail.com>
	 <20120416214602.GA2796@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > The alternate setting must be dynamically set according to the number of
> > active SCO links, and the bit depth of the audio. The possible values
> > for the alternate setting are described in the Bluetooth Core
> > Specification, Volume 4, Part B, section 2.1.1.
> > 
> > Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> > ---
> >  drivers/bluetooth/btusb.c |   13 +++++++++++--
> >  1 files changed, 11 insertions(+), 2 deletions(-)
> 
> Applied, thanks.

applied to what? It is not part of the share bluetooth-next tree. You
are confusing me here.

Regards

Marcel


