Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 15:01:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd 4/6] client: fix pbap select when same path given
 twice
Message-ID: <20120214130134.GF19427@x220.ger.corp.intel.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329143945-4934-4-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329143945-4934-4-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 13, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> If the same path is selected twice, the operation can be skipped but the
> D-Bus response should still be sent.
> ---
>  client/pbap.c |   57 ++++++++++++++++-----------------------------------------
>  1 files changed, 16 insertions(+), 41 deletions(-)

I can't apply this one because of the fixes needed to the previous one.

Johan
