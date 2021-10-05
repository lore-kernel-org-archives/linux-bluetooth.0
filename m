Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A0E61354
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 16:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhJEQPl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEQPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 12:15:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE2C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 09:13:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mXn4e-0007Bu-No; Tue, 05 Oct 2021 18:13:48 +0200
Subject: Re: [PATCH v2 2/2] shared/util: Update UUID database with LE Audio
 services
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20210913201341.3515285-1-luiz.dentz@gmail.com>
 <20210913201341.3515285-2-luiz.dentz@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <82910b87-fd40-14a5-26fa-6cd9415b3e74@pengutronix.de>
Date:   Tue, 5 Oct 2021 18:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913201341.3515285-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On 13.09.21 22:13, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This updates UUID database with the values from assigned numbers for LE
> Audio services.

Do you know if there is work underway to add LE Audio support to the
BlueZ stack?

Thanks,
Ahmad

> ---
>  src/shared/util.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 2887a3efa..81b20d86f 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -289,7 +289,21 @@ static const struct {
>  	{ 0x1826, "Fitness Machine"				},
>  	{ 0x1827, "Mesh Provisioning"				},
>  	{ 0x1828, "Mesh Proxy"					},
> -	/* 0x1829 to 0x27ff undefined */
> +	{ 0x1843, "Audio Input Control"				},
> +	{ 0x1844, "Volume Control"				},
> +	{ 0x1845, "Volume Offset Control"			},
> +	{ 0x1846, "Coordinated Set Identification"		},
> +	{ 0x1848, "Media Control"				},
> +	{ 0x1849, "Generic Media Control"			},
> +	{ 0x184b, "Telephony Bearer"				},
> +	{ 0x184c, "Generic Telephony Bearer"			},
> +	{ 0x184c, "Microphone Control"				},
> +	{ 0x184e, "Audio Stream Control"			},
> +	{ 0x184f, "Broadcast Audio Scan"			},
> +	{ 0x1850, "Published Audio Capabilities"		},
> +	{ 0x1851, "Basic Audio Announcement"			},
> +	{ 0x1852, "Broadcast Audio Announcement"		},
> +	/* 0x1853 to 0x27ff undefined */
>  	{ 0x2800, "Primary Service"				},
>  	{ 0x2801, "Secondary Service"				},
>  	{ 0x2802, "Include"					},
> @@ -522,6 +536,74 @@ static const struct {
>  	{ 0x2ade, "Mesh Proxy Data Out"				},
>  	{ 0x2b29, "Client Supported Features"			},
>  	{ 0x2b2A, "Database Hash"				},
> +	{ 0x2b3a, "Server Supported Features"			},
> +	{ 0x2b77, "Audio Input State"				},
> +	{ 0x2b78, "Gain Settings Attribute"			},
> +	{ 0x2b79, "Audio Input Type"				},
> +	{ 0x2b7a, "Audio Input Status"				},
> +	{ 0x2b7b, "Audio Input Control Point"			},
> +	{ 0x2b7c, "Audio Input Description"			},
> +	{ 0x2b7d, "Volume State"				},
> +	{ 0x2b7e, "Volume Control Point"			},
> +	{ 0x2b7f, "Volume Flags"				},
> +	{ 0x2b80, "Offset State"				},
> +	{ 0x2b81, "Audio Location"				},
> +	{ 0x2b82, "Volume Offset Control Point"			},
> +	{ 0x2b83, "Audio Output Description"			},
> +	{ 0x2b84, "Set Identity Resolving Key"			},
> +	{ 0x2b93, "Media Player Name"				},
> +	{ 0x2b94, "Media Player Icon Object ID"			},
> +	{ 0x2b95, "Media Player Icon URL"			},
> +	{ 0x2b96, "Track Changed"				},
> +	{ 0x2b97, "Track Title"					},
> +	{ 0x2b98, "Track Duration"				},
> +	{ 0x2b99, "Track Position"				},
> +	{ 0x2b9a, "Playback Speed"				},
> +	{ 0x2b9b, "Seeking Speed"				},
> +	{ 0x2b9c, "Current Track Segments Object ID"		},
> +	{ 0x2b9d, "Current Track Object ID"			},
> +	{ 0x2b9e, "Next Track Object ID"			},
> +	{ 0x2b9f, "Parent Group Object ID"			},
> +	{ 0x2ba0, "Current Group Object ID"			},
> +	{ 0x2ba1, "Playing Order"				},
> +	{ 0x2ba2, "Playing Orders Supported"			},
> +	{ 0x2ba3, "Media State"					},
> +	{ 0x2ba4, "Media Control Point"				},
> +	{ 0x2ba5, "Media Control Point Opcodes Supported"	},
> +	{ 0x2ba6, "Search Results Object ID"			},
> +	{ 0x2ba7, "Search Control Point"			},
> +	{ 0x2ba9, "Media Player Icon Object Type"		},
> +	{ 0x2baa, "Track Segments Object Type"			},
> +	{ 0x2bab, "Track Object Type"				},
> +	{ 0x2bac, "Group Object Type"				},
> +	{ 0x2bb3, "Bearer Provider Name"			},
> +	{ 0x2bb4, "Bearer UCI"					},
> +	{ 0x2bb5, "Bearer Technology"				},
> +	{ 0x2bb6, "Bearer URI Schemes Supported List"		},
> +	{ 0x2bb7, "Bearer Signal Strength"			},
> +	{ 0x2bb8, "Bearer Signal Strength Reporting Interval"	},
> +	{ 0x2bb9, "Bearer List Current Calls"			},
> +	{ 0x2bba, "Content Control ID"				},
> +	{ 0x2bbb, "Status Flags"				},
> +	{ 0x2bbc, "Incoming Call Target Bearer URI"		},
> +	{ 0x2bbd, "Call State"					},
> +	{ 0x2bbe, "Call Control Point"				},
> +	{ 0x2bbf, "Call Control Point Optional Opcodes"		},
> +	{ 0x2bc0, "Termination Reason"				},
> +	{ 0x2bc1, "Incoming Call"				},
> +	{ 0x2bc2, "Call Friendly Name"				},
> +	{ 0x2bc3, "Mute"					},
> +	{ 0x2bc4, "Sink ASE"					},
> +	{ 0x2bc5, "Source ASE"					},
> +	{ 0x2bc6, "ASE Control Point"				},
> +	{ 0x2bc7, "Broadcast Audio Scan Control Point"		},
> +	{ 0x2bc8, "Broadcast Receive State"			},
> +	{ 0x2bc9, "Sink PAC"					},
> +	{ 0x2bca, "Sink Audio Locations"			},
> +	{ 0x2bcb, "Source PAC"					},
> +	{ 0x2bcc, "Source Audio Locations"			},
> +	{ 0x2bcd, "Available Audio Contexts"			},
> +	{ 0x2bce, "Supported Audio Contexts"			},
>  	/* vendor defined */
>  	{ 0xfeff, "GN Netcom"					},
>  	{ 0xfefe, "GN ReSound A/S"				},
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
