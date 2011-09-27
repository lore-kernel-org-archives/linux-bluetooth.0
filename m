Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:34:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Fixes and refactor avrcp
Message-ID: <20110927083422.GL3952@dell>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 15, 2011, Lucas De Marchi wrote:
> Here are some fixes for avrcp. 0001 fixes a bug due to the recent code move,
> 0002 fixes the response of one command and the other 3 were already sent
> previously.
> 
> 
> David Stockwell (3):
>   avrcp: use LAST element on media_info_id enum
>   avrcp: fix handling of metadata item 0x7
>   avrcp: get/set three-byte company-id
> 
> Lucas De Marchi (2):
>   avrcp: fix missing error code
>   avrcp: fix overwrite of number of attributes
> 
>  audio/avrcp.c |   72 +++++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 42 insertions(+), 30 deletions(-)

All five patches applied. Thanks.

Johan
