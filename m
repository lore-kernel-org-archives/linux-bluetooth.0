Return-Path: <cyrus@holtmann.org>
Subject: RE: [bluetooth-next] bluetooth: hci_sysfs: use strict_strtoul
 instead of simple_strtoul
From: Marcel Holtmann <marcel@holtmann.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Cohen, Guy" <guy.cohen@intel.com>,
	"Rindjunsky, Ron" <ron.rindjunsky@intel.com>
In-Reply-To: <6F5C1D715B2DA5498A628E6B9C124F04016C0E8D6B@hasmsx504.ger.corp.intel.com>
References: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
	 <1266843933-28802-2-git-send-email-tomas.winkler@intel.com>
	 <1268096639.3712.37.camel@localhost.localdomain>
	 <6F5C1D715B2DA5498A628E6B9C124F04016C0E8D6B@hasmsx504.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 18:16:35 -0800
Message-ID: <1268100995.3712.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > >  net/bluetooth/hci_sysfs.c |   24 ++++++++++++------------
> > >  1 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > can you please explain the rational behind this change. What is the
> > benefit? I just fail to see it right away.
> 
> The real reason using strict instead of simple strtoul is explained here thttp://www.kernel.org/doc/htmldocs/kernel-api/re42.html
> In the bottom line it just something a chackpatch is complain about. I've touched the file to insert some test hook for the HCI reset so I fixed that on the way. 

I am fine with that. However please use the following constructs:

	if (strict_strtoul(...) < 0)
		return -EINVAL;

There is no point in having ret variable if you don't use it.

Also I like to have a commit body and not only a subject line. It
doesn't have to be a novel, but only the subject is not good enough for
me.

Regards

Marcel


