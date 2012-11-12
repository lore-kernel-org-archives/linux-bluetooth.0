Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Nov 2012 19:23:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 0/7] Manager/Adapter transition to ObjectManager
Message-ID: <20121112172346.GA6267@x220.P-661HNU-F1>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 08, 2012, Mikel Astiz wrote:
> (This is sent as RFC since I haven't done proper testing, and
> furthermore the test scripts haven't been updated)
> 
> While thinking about how profile and their states should be exposed in
> D-Bus (see previous RFC), I found several potential improvements in
> the current version of the Manager and Adapter APIs.
> 
> Basically, this patchset removes some properties and methods that seem
> duplicated.
> 
> There are other similar methods/properties that could be simplified as
> well, but for practical reasons I started with the most obvious ones.
> 
> Mikel Astiz (7):
>   manager: Expose default adapter using property
>   manager: Remove redundant D-Bus signals
>   manager: Remove redundant Adapters property
>   adapter: Remove redundant D-Bus signals
>   adapter: Remove DevicesFound signal
>   adapter: Remove redundant Devices property
>   adapter: Remove FindDevice method from D-Bus API
> 
>  doc/adapter-api.txt |  32 +--------
>  doc/manager-api.txt |  28 +-------
>  src/adapter.c       | 187 +---------------------------------------------------
>  src/manager.c       | 103 +++++++----------------------
>  4 files changed, 29 insertions(+), 321 deletions(-)

All patches except 5/7 (which needs a bit more discussion) have been
applied. Thanks.

Johan
