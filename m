Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Sep 2012 13:30:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH] audio: Fix gateway probe always failing
Message-ID: <20120904103030.GA20746@x220>
References: <1346752527-8761-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346752527-8761-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Sep 04, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> Commit 813b674bce1aab009e7f2d14d1825f603330563d introduced this trivial
> bug which causes the failure of the gateway profile probe.
> ---
>  audio/manager.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Good catch. The patch has now been applied. Thanks!

Johan
