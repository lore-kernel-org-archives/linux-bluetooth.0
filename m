Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2014 20:11:09 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.orgg, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv7] tools: add bcm43xx specific init in hciattach
Message-ID: <20140404171109.GA25219@t440s.P-661HNU-F1>
References: <1396628768-13868-1-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396628768-13868-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Fri, Apr 04, 2014, Loic Poulain wrote:
> Add a bcm43xx specific init sequence in hciattach
> in order to initialize bcm43xx controllers.
> ---
>  v7: Fix missing include
> 
>  Makefile.tools            |   3 +-
>  tools/hciattach.c         |  11 +-
>  tools/hciattach.h         |   2 +
>  tools/hciattach_bcm43xx.c | 378 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 392 insertions(+), 2 deletions(-)
>  create mode 100644 tools/hciattach_bcm43xx.c

Applied. Thanks!

Johan
