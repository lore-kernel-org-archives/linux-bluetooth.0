Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Aug 2010 08:55:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj <suraj@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH v2 2/2] Bluetooth: host level Support for Atheros
 AR300x device
Message-ID: <20100818055555.GA28115@jh-x301>
References: <1281681408-27376-1-git-send-email-suraj@atheros.com>
 <1281681408-27376-2-git-send-email-suraj@atheros.com>
 <20100817143236.GB19862@jh-x301>
 <4C6B6E03.7080600@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C6B6E03.7080600@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Wed, Aug 18, 2010, Suraj wrote:
> Sorry about that,
> 
> I did do a fresh
> 
> ./bootstrap-configure
> ./configure
> make
> 
> and strangely my compiler did not catch anyone of these and it
> compiled without any warning.
> 
> Is there any flag I have to enable for this?
> 
> My gcc version says,
> 
> gcc 4.4.3

bootstrap-configure already runs configure for you (hence the name) with
the appropriate parameters (such as --enable-maintainer-mode). When you
run configure a second time it will overwrite these. So running
"./bootstrap-configure && make" should be enough.

Johan
