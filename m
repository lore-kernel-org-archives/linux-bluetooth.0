Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Aug 2011 10:22:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] Fix response for GetCurrentPlayerApplicationSettingValue
Message-ID: <20110809072212.GA14581@dell>
References: <1312814927-2371-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312814927-2371-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Aug 08, 2011, Lucas De Marchi wrote:
> According to AVRCP spec there's no player id in response.
> ---
>  parser/avrcp.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)

Applied. Thanks.

Feel free to tag hcidump patches with [PATCH hcidump] in the future.

Johan
