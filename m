Return-Path: <cyrus@holtmann.org>
Subject: Re: Make bluetoothd start w/o SDP Server
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Susanne Goldammer <susanne.goldammer@gmx.de>,
	Bastien Nocera <hadess@hadess.net>,
	BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20091113113335.GA18325@jh-x301>
References: <4AF9721B.3010405@gmx.de>
	 <1257861916.10888.1372.camel@localhost.localdomain>
	 <4AF97659.2050807@gmx.de> <4AFBD3B6.6020706@gmx.de>
	 <20091112131357.1106213e@strolchi.home.s3e.de> <4AFC05BD.40508@gmx.de>
	 <20091112140840.1efa7475@strolchi.home.s3e.de> <4AFC1803.2080703@gmx.de>
	 <1258037845.2158.0.camel@localhost.localdomain> <4AFC26C3.50006@gmx.de>
	 <20091113113335.GA18325@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Nov 2009 12:58:41 +0100
Message-ID: <1258113521.3299.12.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Fixed. New patch attached.
> 
> The patch looks good except for two more white-space issues:

hold your horses.

Don't we create the SDP server with BDADDR_ANY. So if you wanna start
your own one on top of it, you just can bind() it to the local adapter
address and the kernel will use that one for that interface.

Regards

Marcel


