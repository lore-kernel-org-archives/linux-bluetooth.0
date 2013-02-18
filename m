Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 18:13:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: Fix compilation error with GINT_TO_POINTER
Message-ID: <20130218161331.GA5539@x220.P-661HNU-F1>
References: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Feb 18, 2013, Syam Sidhardhan wrote:
> Fixes the following error:
> tools/btmgmt.c: In function ‘index_rsp’:
> tools/btmgmt.c:756:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> tools/btmgmt.c: In function ‘cmd_info’:
> tools/btmgmt.c:791:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> cc1: all warnings being treated as errors
> make[1]: *** [tools/btmgmt.o] Error 1
> make: *** [all] Error 2
> ---
>  tools/btmgmt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This patch has been applied. For whatever reason I did not get this
warning/error in my environment. Which gcc version and architecture are
you using?

Johan
