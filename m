Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Jul 2009 17:21:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com, linux-bluetooth@vger.kernel.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 1/3] Renaming found_device_req_name to
	adapter_resolve_names
Message-ID: <20090702142129.GA14614@jh-x301>
References: <1245768621-22895-1-git-send-email-alok.barsode@azingo.com> <20090630151158.GB636@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090630151158.GB636@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Tue, Jun 30, 2009, Johan Hedberg wrote:
> On Tue, Jun 23, 2009, alokbarsode@gmail.com wrote:
> > From: Alok Barsode <alok.barsode@azingo.com>
> > 
> > ---
> >  src/adapter.c  |   52 ++++++++++++++++++++++++++++++++++++++++
> >  src/adapter.h  |    2 +
> >  src/dbus-hci.c |   72 +------------------------------------------------------
> >  3 files changed, 56 insertions(+), 70 deletions(-)
> 
> This one doesn't apply anymore cleanly to upstream git. Could you please
> rebase it (and the other two patches in this set as well) against latest
> upstream git?

The updated patches have now been pulled from your tree and merged
upstream. Thanks!

Johan
