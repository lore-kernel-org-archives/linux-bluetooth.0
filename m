Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jul 2011 10:55:19 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Zheng Wu <wu.zheng@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fixing crash in irmc.c when vcard=0
Message-ID: <20110727075519.GA26718@dell>
References: <1311735947-4835-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311735947-4835-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 27, 2011, Zheng Wu wrote:
> If getting the number of vcard is 0 in sync server, obexd will crash.
> The reason is that null point is used in query_result of irmc.c.
> ---
>  plugins/irmc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied after a couple of minor cosmetic fixes. Thanks.

Johan
