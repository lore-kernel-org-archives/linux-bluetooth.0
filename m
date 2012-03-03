Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 16:12:20 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2 v2] core: Make adapter_ops->set_discoverable to
 take discoverable timeout
Message-ID: <20120303001220.GB32181@x220.ice.intel.com>
References: <1330593304-7309-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330593304-7309-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 01, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables the driver to implements its own handling of the timeout
> ---
> v2: Merge changes on hciops and mgmtops
> 
>  plugins/hciops.c  |   92 +++++++++++++++++++++++++++++++++++++++++--------
>  plugins/mgmtops.c |   13 ++++---
>  src/adapter.c     |   98 ++++++-----------------------------------------------
>  src/adapter.h     |    7 +++-
>  4 files changed, 101 insertions(+), 109 deletions(-)

Both patches have been applied. Thanks.

Johan
