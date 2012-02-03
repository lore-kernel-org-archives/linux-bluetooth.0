Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 13:37:48 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org,
	anderson.lizardo@openbossa.org
Subject: Re: [PATCH v3] proximity: make reporter work per-adapter
Message-ID: <20120203213748.GA32352@x220.globalsuite.net>
References: <1328304844-21149-1-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328304844-21149-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Fri, Feb 03, 2012, Arik Nemtsov wrote:
> Register an adapter driver for reporter and add the adapter argument in
> appropriate places.
> ---
> v2->3: rebased, removed signed-off-by
> 
>  proximity/manager.c  |   28 +++++++++++++++++++-----
>  proximity/reporter.c |   57 +++++++++++++++++++------------------------------
>  proximity/reporter.h |    4 +-
>  3 files changed, 46 insertions(+), 43 deletions(-)

Applied. Thanks.

Johan
