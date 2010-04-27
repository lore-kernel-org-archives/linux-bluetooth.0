Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Apr 2010 12:30:43 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: ofono@ofono.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DUN client for oFono and BlueZ
Message-ID: <20100427153043.GA3374@vigoh>
References: <20100427012059.GG12813@vigoh>
 <1272356128.17421.6781.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272356128.17421.6781.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,


* Bastien Nocera <hadess@hadess.net> [2010-04-27 09:15:28 +0100]:

> On Mon, 2010-04-26 at 22:20 -0300, Gustavo F. Padovan wrote:
> > Hi all,
> > 
> > I'm starting the DUN Client implementation for the Linux Stack. DUN is
> > the Bluetooth dial-up network profile. It makes possible share internet
> > connection between two Bluetooth devices. That is my Google Summer of Code
> > project for this year.
> 
> Does this project include anything that will be reusable by non-oFono
> based projects? Native BT PPP line discipline would have been nice.
> 

Yes, oFono will be only the Agent, you can implement a new one if you
want. Also oFono already does the PPP line discipline, so we don't need
to duplicate such feature in BlueZ.

-- 
Gustavo F. Padovan
http://padovan.org
