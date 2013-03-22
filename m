Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Mar 2013 14:32:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 01/11] core: Add btd_service to represent device services
Message-ID: <20130322123205.GA14158@x220.ger.corp.intel.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1363678855-12765-2-git-send-email-mikel.astiz.oss@gmail.com>
 <20130322105336.GA10769@x220.ger.corp.intel.com>
 <CANT-zCUUTZLZUEZwkFS4nRLWCbYHuUBrYBK1ioLciQ4V=4NsWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCUUTZLZUEZwkFS4nRLWCbYHuUBrYBK1ioLciQ4V=4NsWQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Mar 22, 2013, Mikel Astiz wrote:
> >> +void service_unavailable(struct btd_service *service)
> >> +{
> >> +     service->profile = NULL;
> >> +     service->err = 0;
> >> +     service_set_state(service, SERVICE_STATE_UNAVAILABLE);
> >> +}
> >
> > Why aren't these function names prefixed with btd_?
> 
> I had a look at some other existing headers such as device.h and
> didn't understand the criteria to add or not the prefix.
> 
> I'll add to it to all functions in the next revision.

In principle any symbols that should be accessible from plugins
should be prefixed with btd_. There are many cases which do not follow
this in the old code, but we're trying to gradually fix it.

Johan
