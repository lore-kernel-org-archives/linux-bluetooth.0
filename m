Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jun 2012 12:18:11 +0300
From: Ido Yariv <ido@wizery.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Fix multiple channels detaching mix-up
Message-ID: <20120606091758.GA12782@WorkStation.localnet>
References: <1338322808-15503-1-git-send-email-ido@wizery.com>
 <20120530073701.GB6539@x220>
 <20120530183227.GA16709@WorkStation.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120530183227.GA16709@WorkStation.localnet>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, May 30, 2012 at 09:32:27PM +0300, Ido Yariv wrote:
> From 78254bb099f80ad38e10075fbb73a4d990217630 Mon Sep 17 00:00:00 2001
> From: Ido Yariv <ido@wizery.com>
> Date: Tue, 29 May 2012 21:11:16 +0300
> Subject: [PATCH v2] attrib-server: Fix multiple channels detaching mix-up
> 
> The identifier returned by g_attrib_register is not unique across
> different channels. Since attrib_channel_detach assumes this identifier
> to be unique, it may end up detaching the wrong channel when a device
> disconnects.
> 
> Fix this by using the channel's pointer as a unique identifier for
> detaching the channel. The identifier returned from g_attrib_register
> will still be used to find the relevant event structure.

Any thoughts about this one?

Thanks,
Ido.
