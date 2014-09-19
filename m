Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH 7/7] android/hal-utils.c : Fix null pointer dereference
Date: Fri, 19 Sep 2014 09:08:21 +0200
Message-ID: <5931585.p2k8yBDPcD@leonov>
In-Reply-To: <1410441607-9687-7-git-send-email-gowtham.ab@samsung.com>
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com> <1410441607-9687-7-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thursday 11 of September 2014 18:50:07 Gowtham Anandha Babu wrote:

Commit header should be like:
android/hal-utils: Fix null pointer dereference

> Handles the possible null pointer dereference: bd_addr by checking it
> against null. ---

Commit body should be limited to 72 characters. 

>  android/hal-utils.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal-utils.c b/android/hal-utils.c
> index ceefefc..64ab5a1 100644
> --- a/android/hal-utils.c
> +++ b/android/hal-utils.c
> @@ -166,11 +166,13 @@ int int2str_findstr(const char *str, const struct
> int2str m[]) */
>  const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
>  {
> -	const uint8_t *p = bd_addr->address;
> +	const uint8_t *p;
> 
>  	if (!bd_addr)
>  		return strcpy(buf, "NULL");
> 
> +	p = bd_addr->address;
> +
>  	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
>  					p[0], p[1], p[2], p[3], p[4], p[5]);

I've fixed those minors myself and pushed the patch, but please keep it in 
mind for any future submissions. Thanks.


-- 
BR
Szymon Janc
