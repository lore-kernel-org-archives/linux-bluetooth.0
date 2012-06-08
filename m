Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 19:01:31 +0300
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Fix multiple channels detaching mix-up
Message-ID: <20120608160131.GA11275@NoteStation>
References: <1338322808-15503-1-git-send-email-ido@wizery.com>
 <20120530073701.GB6539@x220>
 <20120530183227.GA16709@WorkStation.localnet>
 <20120606091758.GA12782@WorkStation.localnet>
 <20120607154417.GC25119@x220.docomointertouch.net>
 <20120608153944.GA28852@x220.docomointertouch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120608153944.GA28852@x220.docomointertouch.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Jun 08, 2012 at 11:39:44PM +0800, Johan Hedberg wrote:
> Hi Ido,
> 
> On Thu, Jun 07, 2012, Johan Hedberg wrote:
> > Hi Ido,
> > 
> > On Wed, Jun 06, 2012, Ido Yariv wrote:
> > > On Wed, May 30, 2012 at 09:32:27PM +0300, Ido Yariv wrote:
> > > > From 78254bb099f80ad38e10075fbb73a4d990217630 Mon Sep 17 00:00:00 2001
> > > > From: Ido Yariv <ido@wizery.com>
> > > > Date: Tue, 29 May 2012 21:11:16 +0300
> > > > Subject: [PATCH v2] attrib-server: Fix multiple channels detaching mix-up
> > > > 
> > > > The identifier returned by g_attrib_register is not unique across
> > > > different channels. Since attrib_channel_detach assumes this identifier
> > > > to be unique, it may end up detaching the wrong channel when a device
> > > > disconnects.
> > > > 
> > > > Fix this by using the channel's pointer as a unique identifier for
> > > > detaching the channel. The identifier returned from g_attrib_register
> > > > will still be used to find the relevant event structure.
> > > 
> > > Any thoughts about this one?
> > 
> > I don't really like the idea of returning a pointer (even though an
> > opaque one) to code that shouldn't have access to data behind that
> > pointer. Could we instead just make this really simple by removing
> > attrib->next_evt_id and adding a static guint variable into the
> > g_attrib_register function?
> 
> Since I haven't heard back from you and we're way overdue with the 4.100
> release I went ahead and pushed this simplified solution.

Sorry for the delayed response - I was on a trans-atlantic flight.

This was actually the first revision of this patch. I submitted this
version, to avoid static variables. In terms of functionality, I'm OK
with both solutions.

Thanks,
Ido.
