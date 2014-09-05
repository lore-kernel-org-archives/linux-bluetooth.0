Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Sep 2014 11:44:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH ] GATT: Add support for Gatt multiple char write request
Message-ID: <20140905084453.GA9598@t440s>
References: <1408619604-26201-1-git-send-email-bharat.panda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408619604-26201-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Aug 21, 2014, Bharat Panda wrote:
> Changes made to handle gatt char multiple write request
> 1. Changes made to handle gatt long char write request
> 2. Cache/prepare and execute long char write request.
> 3. Updates gatt attribute db using offset value.
> 4. Proper offset and char length handling to fix below PTS test cases,
> 
> TP/GAW/SR/BV-06-C
> TP/GAW/SR/BV-10-C
> TP/GAW/SR/BV-09-C
> TP/GAW/SR/BI-09-C
> TP/GAW/SR/BI-14-C
> TP/GAW/SR/BI-15-C
> TP/GAW/SR/BV-05-C
> TP/GAW/SR/BI-07-C
> TP/GAW/SR/BV-07-C
> TP/GAW/SR/BI-08-C
> TP/GAW/SR/BI-25-C
> TP/GAW/SR/BI-26-C
> TP/GAW/SR/BI-27-C
> ---
>  src/attrib-server.c | 323 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/attrib-server.h |   3 +
>  2 files changed, 324 insertions(+), 2 deletions(-)

First of all sorry for the delay in replying to this - you sent it just
when I had started a two week vacation.

> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index e65fff2..10a7923 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -85,6 +85,25 @@ struct group_elem {
>  	uint16_t len;
>  };
>  
> +struct local_db {
> +	uint16_t handle;
> +	uint8_t offset;
> +	size_t len;
> +	uint8_t *data;
> +	struct local_db *next;
> +};
> +
> +struct char_handle_len {
> +	uint16_t handle;
> +	size_t org_len;
> +	struct char_handle_len *next;
> +};
> +
> +struct char_handle_len *local_char_handle_len = NULL;
> +struct char_handle_len *local_char_handle_len_head = NULL;
> +struct local_db *local_prep_db = NULL;
> +struct local_db *local_prep_db_head = NULL;

Shouldn't these variables be part of gatt_channel instead of them being
global like this? Otherwise we may have conflicts between multiple
connections to different devices.

Btw, what are your plans regarding our new ATT/GATT APIs in src/shared?
Are you planning to provide patches to update these features to use the
new API once we have the rest of the ATT server infrastructure in place?
I'd like to avoid introducing too much new code for the old API since it
will eventually need to be converted to the new one.

In general, could you please read through the kernel CodingStyle
document which is what we mostly follow. There are quite many violations
in this patch. You'll also want to read the coding-style.txt and HACKING
documents from Luiz that were just recently pushed to upstream bluez.git.

Johan
