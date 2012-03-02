Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 15:11:11 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH] SAP: Make PADDING4 macro a bit more robust
Message-ID: <20120302231111.GA27253@x220.ice.intel.com>
References: <1330700316-5810-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330700316-5810-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Mar 02, 2012, Szymon Janc wrote:
> Bitwise operations are done before arithmetic operations and this might
> cause undesired results if macro is called with parameter of form x+y.
> ---
>  sap/server.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
