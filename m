Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] btmgmt: Fix endianess in cmd_scan_params()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404253518-24132-1-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 2 Jul 2014 00:43:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EA9B7C26-FBA3-4657-B077-24620C78765A@holtmann.org>
References: <1404253518-24132-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> The kernel expects Mgmt commands parameters in little-endian byte order
> so this patch fixes cp.interval and cp.window in cmd_scan_params().
> ---
> tools/btmgmt.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 066fde9..b0da592 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -2404,6 +2404,7 @@ static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
> 							int argc, char **argv)
> {
> 	struct mgmt_cp_set_scan_params cp;
> +	uint16_t interval, window;
> 
> 	if (argc < 3) {
> 		scan_params_usage();
> @@ -2413,8 +2414,11 @@ static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
> 	if (index == MGMT_INDEX_NONE)
> 		index = 0;
> 
> -	cp.interval = strtol(argv[1], NULL, 0);
> -	cp.window = strtol(argv[2], NULL, 0);
> +	interval = strtol(argv[1], NULL, 0);
> +	window = strtol(argv[2], NULL, 0);
> +
> +	put_le16(interval, &cp.interval);
> +	put_le16(window, &cp.window);

the struct is already packed. So not need for unaligned access. Just use the standard endian conversion functions.

Regards

Marcel

