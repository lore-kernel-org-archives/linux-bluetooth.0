Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 May 2011 10:57:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-bluetooth@vger.kernel.org,
	Nobuhiro Iwamatsu <iwamatsu@debian.org>
Subject: Re: [PATCH] Fix install path for udevdir
Message-ID: <20110531075749.GA18878@dell.ger.corp.intel.com>
References: <1306828085-30834-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306828085-30834-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 31, 2011, Nobuhiro Iwamatsu wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@debian.org>
> 
> If PCMCIA enabled, udevdir value override from /lib/udev to
> $(libexecdir)/udev.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@debian.org>
> ---
>  Makefile.am |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

Thanks. The patch has been pushed upstream (with the signed-off-by line
removed since we don't use that).

Johan
