Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Feb 2010 14:06:31 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Always use "nice abort" in osso-gwobex
Message-ID: <20100218170631.GA15653@jh-x301>
References: <1266455391.678.1742.camel@localhost.localdomain>
 <1266490576.678.2975.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1266490576.678.2975.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Feb 18, 2010, Bastien Nocera wrote:
> On Thu, 2010-02-18 at 01:09 +0000, Bastien Nocera wrote:
> > Heya,
> > 
> > As discussed on IRC, we should always use the "nice abort" of openobex,
> > rather than disconnecting from device when cancelling transfers.
> 
> Updated patch for that, forgot to remove some bits in configure.ac

Both patches have been pushed upstream. Thanks.

Johan
