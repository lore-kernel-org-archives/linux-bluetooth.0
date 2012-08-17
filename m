Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Aug 2012 12:27:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v3] mgmt-api: Add reason to device disconnect event
Message-ID: <20120817092702.GA7224@x220>
References: <1345194655-8453-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345194655-8453-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Aug 17, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> Extend the management API with the disconnect reason, as now reported
> by the Kernel in MGMT_EV_DEVICE_DISCONNECTED.
> ---
> v3 integrates the changes suggested by Johan with the exception of the type change between uint16_t and size_t in mgmt_device_disconnected().
> 
>  doc/mgmt-api.txt  |   16 ++++++++++++++++
>  lib/mgmt.h        |    6 ++++++
>  monitor/control.c |   19 +++++++++++++++----
>  src/mgmt.c        |   16 +++++++++++-----
>  tools/btmgmt.c    |   18 +++++++++++++-----
>  5 files changed, 61 insertions(+), 14 deletions(-)

Applied. Thanks.

Johan
