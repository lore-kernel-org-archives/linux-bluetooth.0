Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120110210042.GA7954@x220.ger.corp.intel.com>
References: <1326227630-2556-1-git-send-email-festevam@gmail.com>
	<20120110210042.GA7954@x220.ger.corp.intel.com>
Date: Tue, 10 Jan 2012 19:08:45 -0200
Message-ID: <CAOMZO5BLGwvJEJCrv9hooj5PTMuOQire2nz=Bc6S3i+VjUEEjw@mail.gmail.com>
Subject: Re: [PATCH] net: bluetooth: Fix 'enable_hs' type
From: Fabio Estevam <festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>, linux-bluetooth@vger.kernel.org,
	padovan@profusion.mobi, marcel@holtmann.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 10, 2012 at 7:00 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> The patch has been applied to my bluetooth-next tree. Don't you get the
> same warning for enable_mgmt and enable_le as well? Those seem to be
> declared in a similar manner.

No, because enable_mgmt and enable_le are already declared as 'bool'.

Regards,

Fabio Estevam
