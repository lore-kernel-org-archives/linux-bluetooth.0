Return-Path: <cyrus@holtmann.org>
Message-ID: <53FEF078.3060304@tieto.com>
Date: Thu, 28 Aug 2014 11:03:52 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] emulator/btdev: Fix not disabling le advertising on connection
References: <1408964932-9690-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408964932-9690-1-git-send-email-jakub.tyszkowski@tieto.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/25/2014 01:08 PM, Jakub Tyszkowski wrote:
> Le Advertising should be disabled after the le connection is
> established (Core Spec. 4.1 - Part E, Sec. 7.8.9). Not doing so
> results in errors while switching advertisement multiple times during
> different connection states.
> ---
>   emulator/btdev.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index b09f8cb..86fd3d9 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -1023,6 +1023,7 @@ static void le_conn_complete(struct btdev *btdev,
>
>   		btdev->conn = remote;
>   		remote->conn = btdev;
> +		remote->le_adv_enable = 0;
>
>   		cc->status = status;
>   		cc->peer_addr_type = btdev->le_scan_own_addr_type;
>
  ping
