Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Fix alignment
Date: Fri, 22 Aug 2014 10:20:32 +0200
Message-ID: <1600595.PUnPVAOPMQ@uw000953>
In-Reply-To: <1408539959-5545-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1408539959-5545-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 20 of August 2014 16:05:59 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/handsfree.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index bad7086..c06f65c 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -360,7 +360,7 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -390,7 +390,7 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val, i, def;
>  	bool tmp[IND_COUNT];
> @@ -435,7 +435,7 @@ failed:
>  }
>  
>  static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -460,7 +460,7 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	char buf[IPC_MTU];
>  	struct hal_ev_handsfree_dial *ev = (void *) buf;
> @@ -503,7 +503,7 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -531,7 +531,7 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -556,7 +556,7 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -578,7 +578,7 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -606,7 +606,7 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -634,7 +634,7 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	struct hal_ev_handsfree_dtmf ev;
>  	char str[2];
> @@ -672,7 +672,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -694,7 +694,7 @@ static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -704,7 +704,7 @@ static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	struct hal_ev_handsfree_dial ev;
>  
> @@ -728,7 +728,7 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	struct hal_ev_handsfree_vr_state ev;
>  	unsigned int val;
> @@ -761,7 +761,7 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	struct hal_ev_handsfree_nrec ev;
>  	unsigned int val;
> @@ -799,7 +799,7 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -809,7 +809,7 @@ static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -928,7 +928,7 @@ static bool connect_sco(void)
>  }
>  
>  static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	DBG("");
>  
> @@ -965,7 +965,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -1003,7 +1003,7 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -1064,7 +1064,7 @@ static void register_post_slc_at(void)
>  }
>  
>  static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> @@ -1109,7 +1109,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	char *buf, *ptr;
>  	int len;
> @@ -1166,7 +1166,7 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int feat;
>  
> @@ -1194,7 +1194,7 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
>  }
>  
>  static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	struct hal_ev_handsfree_chld ev;
>  	unsigned int val;
> @@ -1243,7 +1243,7 @@ static struct hfp_codec *find_codec_by_type(uint8_t type)
>  }
>  
>  static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
> -							void *user_data)
> +								void *user_data)
>  {
>  	unsigned int val;
>  
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
