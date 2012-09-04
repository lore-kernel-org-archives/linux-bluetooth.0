Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Sep 2012 15:51:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0 1/3] audio: Remove unused function
Message-ID: <20120904125136.GA3350@x220.ger.corp.intel.com>
References: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Sep 04, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> gateway_config_stream() is now unnecessary after the removal of the unix
> socket support in commit 1d9d0527cfb6d96a976ede56bd43a2bc16bb5f21.
> ---
>  audio/gateway.c |   16 ----------------
>  audio/gateway.h |    2 --
>  2 files changed, 0 insertions(+), 18 deletions(-)

All three patches have been applied. Thanks.

Johan
