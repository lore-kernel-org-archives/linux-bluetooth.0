Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 May 2014 17:54:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] gatt: Fix not freeing GError on failure
Message-ID: <20140521145431.GA30054@t440s>
References: <1400682882-11341-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1400682882-11341-3-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400682882-11341-3-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, May 21, 2014, Jakub Tyszkowski wrote:
> +	if (gerr) {
> +		error("Could not acquire att imtu and cid: %s", gerr->message);
> +		free(gerr);
> +	}

Good catch, but GErrors are freed with g_error_free()

Johan
