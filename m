Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 22:15:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 hcidump 3/3] decode fixed channel list info rsp
Message-ID: <20111014191554.GA8723@fusion.localdomain>
References: <1318408296-28840-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318408296-28840-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318408296-28840-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 12, 2011, Emeltchenko Andrei wrote:
> @@ -241,6 +250,8 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
>  		return btohs(bt_get_unaligned((uint16_t *) ptr));
>  	case 4:
>  		return btohl(bt_get_unaligned((uint32_t *) ptr));
> +	case 8:
> +		return btohll(bt_get_unaligned((uint64_t *) ptr));
>  	}
>  	return 0;
>  }

Looks to me like you've forgotten to update the return type of get_val()
from uint32_t to uint64_t. Other than that I haven't spotted any major
issues with this patch series.

Johan
