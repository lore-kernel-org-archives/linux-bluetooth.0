Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] monitor: Format URI hash using 8 hex digits
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170726054040.17970-3-frederic.dalleau@collabora.com>
Date: Wed, 26 Jul 2017 09:45:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <74268B4F-AF41-49D7-9296-A2FA0E665E24@holtmann.org>
References: <20170726054040.17970-1-frederic.dalleau@collabora.com>
 <20170726054040.17970-3-frederic.dalleau@collabora.com>
To: =?utf-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
        <frederic.dalleau@collabora.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> URI hash is a 32 bits value.
> ---
> monitor/packet.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index f72fcab6a..994f5b259 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -3551,7 +3551,7 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
> 			break;
> 		}
> 
> -		print_field("  URI Hash: 0x%4.4x", get_be32(data + 19));
> +		print_field("  URI Hash: 0x%08x", get_be32(data + 19));

in btmon we use the 0x%8.8x notation then.

Regards

Marcel

