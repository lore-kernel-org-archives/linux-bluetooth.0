Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jan 2012 23:31:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org, Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] net: bluetooth: Fix 'enable_hs' type
Message-ID: <20120110213134.GA8679@x220.ger.corp.intel.com>
References: <1326227630-2556-1-git-send-email-festevam@gmail.com>
 <20120110210042.GA7954@x220.ger.corp.intel.com>
 <CAOMZO5BLGwvJEJCrv9hooj5PTMuOQire2nz=Bc6S3i+VjUEEjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5BLGwvJEJCrv9hooj5PTMuOQire2nz=Bc6S3i+VjUEEjw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabio,

On Tue, Jan 10, 2012, Fabio Estevam wrote:
> > The patch has been applied to my bluetooth-next tree. Don't you get the
> > same warning for enable_mgmt and enable_le as well? Those seem to be
> > declared in a similar manner.
> 
> No, because enable_mgmt and enable_le are already declared as 'bool'.

I don't know what tree you're looking at but at least in mine they're
both "static int".

Johan
