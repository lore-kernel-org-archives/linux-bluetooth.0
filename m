Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 15:18:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 1/2] lib: add start and stop discovery
Message-ID: <20141102131850.GA4544@t440s.P-661HNU-F1>
References: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Oct 29, 2014, Jakub Pawlowski wrote:
> This patch adds start and stop discovery definitions for new kernel
> method.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  lib/mgmt.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

I'd first like to see a patch to properly update doc/mgmt-api.txt with
this new API and only then start making any code changes. Did you reach
a consensus on the version Marcel sent on Oct 10th? To me that thread
looked unfinished (looking at Marcel's email on Oct 20th).

A couple of minor cosmetic change suggestions:

> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 46766a9..8f37937 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -445,6 +445,32 @@ struct mgmt_cp_set_public_address {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A

It seems you could use one tab less to align the value here which should
make it line up with the other (at least nearby) opcode values.

> +#define MGMT_RANGE_NONE     0X00
> +#define MGMT_RANGE_RSSI     0X01
> +#define MGMT_RANGE_PATHLOSS 0X02

Please use lower-case 'x' for consistency here. You can also align these
(with tabs and not spaces like you now use) with nearby define values.

Johan
