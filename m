Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400A2882C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638039; cv=none; b=U+2KxlZX3ZRGo3LUCE9wMGmtojDstPME7N2uN0U5oHcQe/xUEfU7o/XgavC9vnXV4XL46/OtALshuvDe8RkI0B704WJiRJ1MFMANB5q7VmvVCcyQvn8HDYTxS2QrKh9xPmbSpLLdA72tPRWfsNWr0b52wTl7t+yH9xP3pXGVNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638039; c=relaxed/simple;
	bh=QCnYG3N2e2NceAp0PF5Pma5enMa7X7yp9aLyrYRI51s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVXISDDQyRe6LVfwoJvd1e4GJcovabXT9ZmuR+55lkpj+TMh9tMGWpZl3uKtCtVPaARwb/iLsZhPf49PokBxWYCO6RKXpxw3vmroJe2TgGdmBz9ja7SxU578x6JoVCS529Gp9cMNyXRnDfE0ERNqc8agSsWtZ6t/q8mOrKGlqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7cMW2Oh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7cMW2Oh"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f8d3be05so40216961fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755638035; x=1756242835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXnUCfN53fBRdf4dByye1NGE5bbJqK9L0OA/8mzuNzM=;
        b=k7cMW2OhvRA77zyoL3hHAq4xjYvGdGl+Xo+SxnFkmYhBPf8XbVJXEW+msjx8qRh2ys
         IQdrzPJVca++LDQ58Zmft2RBTos3M+lX5d1DGqdxcpl4QDIv44/Lf/2S99p0KBA5JZfJ
         RwS+5z9858TVVvfHsZRJt5DJAdHpDUf1rtXXmO70HzY4nQzh/NaDaUEL7cGnEqfcwuCS
         fu4u9j/VZISUOQn6EXsU6ETxLW9FFxx+1b29gdS3YFqah6S84kGIO1HjxzQCePF0NqaV
         SbdQr6hvCWcHFL0k46sI/kelOEUExSNga99A2z+OCr1Yb8ga0qqfn/7GGlZTqKDx7HeO
         YF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755638035; x=1756242835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXnUCfN53fBRdf4dByye1NGE5bbJqK9L0OA/8mzuNzM=;
        b=sFQrvRjUTlQj+/XN+uTVdYsmQObvFVStJba6tr/eyzzCpPdJyc3phrozbcWxZZlMOJ
         hxUJD8r/W+Qzk+WEMZdJTCtkSWEZ5lJNJS52GpSS66YKNOhxFJbNV2hT3/Ph09Lmurlw
         wGBikEy+0nB9vdgUOgSI4WozjNLU3Uf60iZjk7qgYHWxshAY/v4ehkNAriX2Bkrz1kAe
         Ry8HCgYfGis26OQQ28PAIjS+vF7CUEJIPIXK/6nAkUsAXkvdmUh3PewQlg4sE8ryvw8j
         R5SzYz5esq0OcF+jDkkRw/p8SK1UaUWiSvzLAmTtNix9IgOIiTj1WNo215RNQkguPMI2
         Aw6w==
X-Gm-Message-State: AOJu0Yyx1HylFti6FoC0as7XpP/dVE6m2alxnDuwMg6EL4yiLwJZvIwI
	JzViErFWOfHJlS+52JHI/oJYoqrQ3orGWCkhz2kth8/LzrjZ8PysEaPzRoKTp9gKEnkj4h4sCtQ
	W/edjhDWUv5r9wFsgu8w2Hnf4+5Z8R5TH6y5SB+s=
X-Gm-Gg: ASbGncv3xRJi/K+23/Ly6Q6OVSsyP81pOc09G8rQmErvckClR6WHBGbTFXaKXXSH1Fd
	yjmxgKtOXdzjCjpsWJk+Au5mk2RAI2XmnXxVuzLLfZ/f+dVsgGoQFJlt5aI037s5JACoR1fetwz
	Ta0V0cVa+VffQxS+Uv+6WGe+FZRivgGEV0Y9AFVqYYHDGURoh029FtD0Ir1ubRFopixMkmLYw8/
	TOk4Q==
X-Google-Smtp-Source: AGHT+IFPfVcmL/0K+6c/dbp/SbUTuh5XokVZAD0n9arIxa0NbrvwDJhpIA0s65KIygQSGh28fWxoh134g5nH0x3VwDU=
X-Received: by 2002:a05:651c:31c5:b0:333:f1e5:7847 with SMTP id
 38308e7fff4ca-3353bd3479fmr1148551fa.34.1755638034584; Tue, 19 Aug 2025
 14:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819133321.382279-1-frederic.danis@collabora.com>
In-Reply-To: <20250819133321.382279-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Aug 2025 17:13:42 -0400
X-Gm-Features: Ac12FXxBt9Y1prRE8ThRu-3QEtAqVy4JLmbEVm5_7cwAxhO5Eh2Uf10Zhu8zxtg
Message-ID: <CABBYNZ+9ti9jv1u6WyhQqFUn9Yh_0M3a6Ri4Drf7BTMLAsnPgQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ RESEND 1/4] shared/hfp: Add HF SLC connection function
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Aug 19, 2025 at 9:39=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This implements the minimal SLC connection exchange, i.e. AT+BRSF,
> AT+CIND=3D?, AT+CIND? and AT+CMER=3D3,0,0,1 requested to complete the
> Service Level Connection Establishment.
> ---
>  src/shared/hfp.c | 508 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/hfp.h |  69 +++++++
>  2 files changed, 577 insertions(+)
>
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index df6eab35d..c1bcb61cf 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -25,6 +25,12 @@
>  #include "src/shared/io.h"
>  #include "src/shared/hfp.h"
>
> +#define DBG(_hfp, fmt, arg...) \
> +       hfp_debug(_hfp->debug_callback, _hfp->debug_data, "%s:%s() " fmt,=
 \
> +                                               __FILE__, __func__, ## ar=
g)
> +
> +#define HFP_HF_FEATURES        (HFP_HF_FEAT_ESCO_S4_T2)
> +
>  struct hfp_gw {
>         int ref_count;
>         int fd;
> @@ -50,6 +56,16 @@ struct hfp_gw {
>         bool destroyed;
>  };
>
> +typedef void (*ciev_func_t)(uint8_t val, void *user_data);
> +
> +struct indicator {
> +       uint8_t index;
> +       uint32_t min;
> +       uint32_t max;
> +       uint32_t val;
> +       ciev_func_t cb;
> +};
> +
>  struct hfp_hf {
>         int ref_count;
>         int fd;
> @@ -73,6 +89,17 @@ struct hfp_hf {
>
>         bool in_disconnect;
>         bool destroyed;
> +
> +       struct hfp_hf_callbacks *callbacks;
> +       void *callbacks_data;
> +
> +       uint32_t features;
> +       struct indicator ag_ind[HFP_INDICATOR_LAST];
> +       bool service;
> +       uint8_t signal;
> +       bool roaming;
> +       uint8_t battchg;
> +
>  };
>
>  struct cmd_handler {
> @@ -101,6 +128,19 @@ struct event_handler {
>         hfp_hf_result_func_t callback;
>  };
>
> +static void hfp_debug(hfp_debug_func_t debug_func, void *debug_data,
> +                                               const char *format, ...)
> +{
> +       va_list ap;
> +
> +       if (!debug_func || !format)
> +               return;
> +
> +       va_start(ap, format);
> +       util_debug_va(debug_func, debug_data, format, ap);
> +       va_end(ap);
> +}
> +
>  static void destroy_cmd_handler(void *data)
>  {
>         struct cmd_handler *handler =3D data;
> @@ -1527,3 +1567,471 @@ bool hfp_hf_disconnect(struct hfp_hf *hfp)
>
>         return io_shutdown(hfp->io);
>  }
> +
> +static void ciev_service_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_SERVICE].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_SERVICE].max) {
> +               DBG(hfp, "hf: Incorrect state %u:", val);
> +               return;
> +       }
> +
> +       hfp->service =3D val;
> +       if (hfp->callbacks && hfp->callbacks->update_indicator)
> +               hfp->callbacks->update_indicator(HFP_INDICATOR_SERVICE, v=
al,
> +                                                       hfp->callbacks_da=
ta);
> +}
> +
> +static void ciev_call_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_CALL].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_CALL].max) {
> +               DBG(hfp, "hf: Incorrect call state %u:", val);
> +               return;
> +       }
> +}
> +
> +static void ciev_callsetup_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_CALLSETUP].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_CALLSETUP].max) {
> +               DBG(hfp, "hf: Incorrect call setup state %u:", val);
> +               return;
> +       }
> +}
> +
> +static void ciev_callheld_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_CALLHELD].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_CALLHELD].max) {
> +               DBG(hfp, "hf: Incorrect call held state %u:", val);
> +               return;
> +       }
> +}
> +
> +static void ciev_signal_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_SIGNAL].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_SIGNAL].max) {
> +               DBG(hfp, "hf: Incorrect signal value %u:", val);
> +               return;
> +       }
> +
> +       hfp->signal =3D val;
> +       if (hfp->callbacks && hfp->callbacks->update_indicator)
> +               hfp->callbacks->update_indicator(HFP_INDICATOR_SIGNAL, va=
l,
> +                                                       hfp->callbacks_da=
ta);
> +}
> +
> +static void ciev_roam_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_ROAM].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_ROAM].max) {
> +               DBG(hfp, "hf: Incorrect roaming state %u:", val);
> +               return;
> +       }
> +
> +       hfp->roaming =3D val;
> +       if (hfp->callbacks && hfp->callbacks->update_indicator)
> +               hfp->callbacks->update_indicator(HFP_INDICATOR_ROAM, val,
> +                                                       hfp->callbacks_da=
ta);
> +}
> +
> +static void ciev_battchg_cb(uint8_t val, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "%u", val);
> +
> +       if (val < hfp->ag_ind[HFP_INDICATOR_BATTCHG].min ||
> +                       val > hfp->ag_ind[HFP_INDICATOR_BATTCHG].max) {
> +               DBG(hfp, "hf: Incorrect battery charge value %u:", val);
> +               return;
> +       }
> +
> +       hfp->battchg =3D val;
> +       if (hfp->callbacks && hfp->callbacks->update_indicator)
> +               hfp->callbacks->update_indicator(HFP_INDICATOR_BATTCHG, v=
al,
> +                                                       hfp->callbacks_da=
ta);
> +}
> +
> +static void set_indicator_value(uint8_t index, unsigned int val,
> +       struct indicator *ag_ind, struct hfp_hf *hfp)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < HFP_INDICATOR_LAST; i++) {
> +               if (index !=3D ag_ind[i].index)
> +                       continue;
> +
> +               ag_ind[i].val =3D val;
> +               ag_ind[i].cb(val, hfp);
> +               return;
> +       }
> +}
> +
> +static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err=
,
> +       void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "");
> +
> +       if (result !=3D HFP_RESULT_OK) {
> +               DBG(hfp, "hf: CMER error: %d", result);
> +               goto failed;
> +       }
> +
> +       if (hfp->callbacks->session_ready)
> +               hfp->callbacks->session_ready(HFP_RESULT_OK, 0,
> +                                               hfp->callbacks_data);
> +       return;
> +
> +failed:
> +       if (hfp->callbacks->session_ready)
> +               hfp->callbacks->session_ready(result, cme_err,
> +                                               hfp->callbacks_data);
> +}
> +
> +static void slc_cind_status_cb(struct hfp_context *context,
> +       void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +       uint8_t index =3D 1;
> +
> +       while (hfp_context_has_next(context)) {
> +               uint32_t val;
> +
> +               if (!hfp_context_get_number(context, &val)) {
> +                       DBG(hfp, "hf: Error on CIND status response");
> +                       return;
> +               }
> +
> +               set_indicator_value(index++, val, hfp->ag_ind, hfp);
> +       }
> +}
> +
> +static void slc_cind_status_resp(enum hfp_result result,
> +       enum hfp_error cme_err,
> +       void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "");
> +
> +       hfp_hf_unregister(hfp, "+CIND");
> +
> +       if (result !=3D HFP_RESULT_OK) {
> +               DBG(hfp, "hf: CIND error: %d", result);
> +               goto failed;
> +       }
> +
> +       /* Continue with SLC creation */
> +       if (!hfp_hf_send_command(hfp, slc_cmer_resp, hfp,
> +               "AT+CMER=3D3,0,0,1")) {
> +               DBG(hfp, "hf: Could not send AT+CMER");
> +               result =3D HFP_RESULT_ERROR;
> +               goto failed;
> +       }
> +
> +       return;
> +
> +failed:
> +       if (hfp->callbacks->session_ready)
> +               hfp->callbacks->session_ready(result, cme_err,
> +                                               hfp->callbacks_data);
> +}
> +
> +static void set_indicator_parameters(struct hfp_hf *hfp, uint8_t index,
> +       const char *indicator,
> +       unsigned int min,
> +       unsigned int max)
> +{
> +       struct indicator *ag_ind =3D hfp->ag_ind;
> +
> +       DBG(hfp, "%s, %i", indicator, index);
> +
> +       if (strcmp("service", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 1) {
> +                       DBG(hfp, "hf: Invalid min/max values for service,=
"
> +                               " expected (0,1) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_SERVICE].index =3D index;
> +               ag_ind[HFP_INDICATOR_SERVICE].min =3D min;
> +               ag_ind[HFP_INDICATOR_SERVICE].max =3D max;
> +               ag_ind[HFP_INDICATOR_SERVICE].cb =3D ciev_service_cb;
> +               return;
> +       }
> +
> +       if (strcmp("call", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 1) {
> +                       DBG(hfp, "hf: Invalid min/max values for call,"
> +                               " expected (0,1) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_CALL].index =3D index;
> +               ag_ind[HFP_INDICATOR_CALL].min =3D min;
> +               ag_ind[HFP_INDICATOR_CALL].max =3D max;
> +               ag_ind[HFP_INDICATOR_CALL].cb =3D ciev_call_cb;
> +               return;
> +       }
> +
> +       if (strcmp("callsetup", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 3) {
> +                       DBG(hfp, "hf: Invalid min/max values for callsetu=
p,"
> +                               " expected (0,3) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_CALLSETUP].index =3D index;
> +               ag_ind[HFP_INDICATOR_CALLSETUP].min =3D min;
> +               ag_ind[HFP_INDICATOR_CALLSETUP].max =3D max;
> +               ag_ind[HFP_INDICATOR_CALLSETUP].cb =3D ciev_callsetup_cb;
> +               return;
> +       }
> +
> +       if (strcmp("callheld", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 2) {
> +                       DBG(hfp, "hf: Invalid min/max values for callheld=
,"
> +                               " expected (0,2) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_CALLHELD].index =3D index;
> +               ag_ind[HFP_INDICATOR_CALLHELD].min =3D min;
> +               ag_ind[HFP_INDICATOR_CALLHELD].max =3D max;
> +               ag_ind[HFP_INDICATOR_CALLHELD].cb =3D ciev_callheld_cb;
> +               return;
> +       }
> +
> +       if (strcmp("signal", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 5) {
> +                       DBG(hfp, "hf: Invalid min/max values for signal,"
> +                               " expected (0,5) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_SIGNAL].index =3D index;
> +               ag_ind[HFP_INDICATOR_SIGNAL].min =3D min;
> +               ag_ind[HFP_INDICATOR_SIGNAL].max =3D max;
> +               ag_ind[HFP_INDICATOR_SIGNAL].cb =3D ciev_signal_cb;
> +               return;
> +       }
> +
> +       if (strcmp("roam", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 1) {
> +                       DBG(hfp, "hf: Invalid min/max values for roam,"
> +                               " expected (0,1) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_ROAM].index =3D index;
> +               ag_ind[HFP_INDICATOR_ROAM].min =3D min;
> +               ag_ind[HFP_INDICATOR_ROAM].max =3D max;
> +               ag_ind[HFP_INDICATOR_ROAM].cb =3D ciev_roam_cb;
> +               return;
> +       }
> +
> +       if (strcmp("battchg", indicator) =3D=3D 0) {
> +               if (min !=3D 0 || max !=3D 5) {
> +                       DBG(hfp, "hf: Invalid min/max values for battchg,=
"
> +                               " expected (0,5) got (%u,%u)", min, max);
> +                       return;
> +               }
> +               ag_ind[HFP_INDICATOR_BATTCHG].index =3D index;
> +               ag_ind[HFP_INDICATOR_BATTCHG].min =3D min;
> +               ag_ind[HFP_INDICATOR_BATTCHG].max =3D max;
> +               ag_ind[HFP_INDICATOR_BATTCHG].cb =3D ciev_battchg_cb;
> +               return;
> +       }
> +
> +       DBG(hfp, "hf: Unknown indicator: %s", indicator);
> +}
> +
> +static void slc_cind_cb(struct hfp_context *context, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +       int index =3D 1;
> +
> +       DBG(hfp, "");
> +
> +       while (hfp_context_has_next(context)) {
> +               char name[255];
> +               unsigned int min, max;
> +
> +               /* e.g ("callsetup",(0-3)) */
> +               if (!hfp_context_open_container(context))
> +                       break;
> +
> +               if (!hfp_context_get_string(context, name, sizeof(name)))=
 {
> +                       DBG(hfp, "hf: Could not get string");
> +                       goto failed;
> +               }
> +
> +               if (!hfp_context_open_container(context)) {
> +                       DBG(hfp, "hf: Could not open container");
> +                       goto failed;
> +               }
> +
> +               if (!hfp_context_get_range(context, &min, &max)) {
> +                       if (!hfp_context_get_number(context, &min)) {
> +                               DBG(hfp, "hf: Could not get number");
> +                               goto failed;
> +                       }
> +
> +                       if (!hfp_context_get_number(context, &max)) {
> +                               DBG(hfp, "hf: Could not get number");
> +                               goto failed;
> +                       }
> +               }
> +
> +               if (!hfp_context_close_container(context)) {
> +                       DBG(hfp, "hf: Could not close container");
> +                       goto failed;
> +               }
> +
> +               if (!hfp_context_close_container(context)) {
> +                       DBG(hfp, "hf: Could not close container");
> +                       goto failed;
> +               }
> +
> +               set_indicator_parameters(hfp, index, name, min, max);
> +               index++;
> +       }
> +
> +       return;
> +
> +failed:
> +       DBG(hfp, "hf: Error on CIND response");
> +}
> +
> +static void slc_cind_resp(enum hfp_result result, enum hfp_error cme_err=
,
> +       void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "");
> +
> +       hfp_hf_unregister(hfp, "+CIND");
> +
> +       if (result !=3D HFP_RESULT_OK) {
> +               DBG(hfp, "hf: CIND error: %d", result);
> +               goto failed;
> +       }
> +
> +       /* Continue with SLC creation */
> +       if (!hfp_hf_register(hfp, slc_cind_status_cb, "+CIND", hfp,
> +                       NULL)) {
> +               DBG(hfp, "hf: Could not register +CIND");
> +               result =3D HFP_RESULT_ERROR;
> +               goto failed;
> +       }
> +
> +       if (!hfp_hf_send_command(hfp, slc_cind_status_resp, hfp,
> +                       "AT+CIND?")) {
> +               DBG(hfp, "hf: Could not send AT+CIND?");
> +               result =3D HFP_RESULT_ERROR;
> +               goto failed;
> +       }
> +
> +       return;
> +
> +failed:
> +       if (hfp->callbacks->session_ready)
> +               hfp->callbacks->session_ready(result, cme_err,
> +                                               hfp->callbacks_data);
> +}
> +
> +static void slc_brsf_cb(struct hfp_context *context, void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +       unsigned int feat;
> +
> +       DBG(hfp, "");
> +
> +       if (hfp_context_get_number(context, &feat))
> +               hfp->features =3D feat;
> +}
> +
> +static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err=
,
> +       void *user_data)
> +{
> +       struct hfp_hf *hfp =3D user_data;
> +
> +       DBG(hfp, "");
> +
> +       hfp_hf_unregister(hfp, "+BRSF");
> +
> +       if (result !=3D HFP_RESULT_OK) {
> +               DBG(hfp, "BRSF error: %d", result);
> +               goto failed;
> +       }
> +
> +       /* Continue with SLC creation */
> +       if (!hfp_hf_register(hfp, slc_cind_cb, "+CIND", hfp, NULL)) {
> +               DBG(hfp, "hf: Could not register for +CIND");
> +               result =3D HFP_RESULT_ERROR;
> +               goto failed;
> +       }
> +
> +       if (!hfp_hf_send_command(hfp, slc_cind_resp, hfp, "AT+CIND=3D?"))=
 {
> +               DBG(hfp, "hf: Could not send AT+CIND command");
> +               result =3D HFP_RESULT_ERROR;
> +               goto failed;
> +       }
> +
> +       return;
> +
> +failed:
> +       if (hfp->callbacks->session_ready)
> +               hfp->callbacks->session_ready(result, cme_err,
> +                                               hfp->callbacks_data);
> +}
> +
> +bool hfp_hf_session_register(struct hfp_hf *hfp,
> +                               struct hfp_hf_callbacks *callbacks,
> +                               void *callbacks_data)
> +{
> +       if (!hfp)
> +               return false;
> +
> +       hfp->callbacks =3D callbacks;
> +       hfp->callbacks_data =3D callbacks_data;
> +
> +       return true;
> +}
> +
> +bool hfp_hf_session(struct hfp_hf *hfp)
> +{
> +       DBG(hfp, "");
> +
> +       if (!hfp)
> +               return false;
> +
> +       if (!hfp_hf_register(hfp, slc_brsf_cb, "+BRSF", hfp, NULL))
> +               return false;
> +
> +       return hfp_hf_send_command(hfp, slc_brsf_resp, hfp,
> +                                       "AT+BRSF=3D%u", HFP_HF_FEATURES);
> +}
> diff --git a/src/shared/hfp.h b/src/shared/hfp.h
> index 600d084a7..f54b86a92 100644
> --- a/src/shared/hfp.h
> +++ b/src/shared/hfp.h
> @@ -10,6 +10,34 @@
>
>  #include <stdbool.h>
>
> +#define HFP_HF_FEAT_ECNR                               0x00000001
> +#define HFP_HF_FEAT_3WAY                               0x00000002
> +#define HFP_HF_FEAT_CLIP                               0x00000004
> +#define HFP_HF_FEAT_VOICE_RECOGNITION                  0x00000008
> +#define HFP_HF_FEAT_REMOTE_VOLUME_CONTROL              0x00000010
> +#define HFP_HF_FEAT_ENHANCED_CALL_STATUS               0x00000020
> +#define HFP_HF_FEAT_ENHANCED_CALL_CONTROL              0x00000040
> +#define HFP_HF_FEAT_CODEC_NEGOTIATION                  0x00000080
> +#define HFP_HF_FEAT_HF_INDICATORS                      0x00000100
> +#define HFP_HF_FEAT_ESCO_S4_T2                         0x00000200
> +#define HFP_HF_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS  0x00000400
> +#define HFP_HF_FEAT_VOICE_RECOGNITION_TEXT             0x00000800
> +
> +#define HFP_AG_FEAT_3WAY                               0x00000001
> +#define HFP_AG_FEAT_ECNR                               0x00000002
> +#define HFP_AG_FEAT_VOICE_RECOGNITION                  0x00000004
> +#define HFP_AG_FEAT_IN_BAND_RING_TONE                  0x00000008
> +#define HFP_AG_FEAT_ATTACH_VOICE_TAG                   0x00000010
> +#define HFP_AG_FEAT_REJECT_CALL                                0x0000002=
0
> +#define HFP_AG_FEAT_ENHANCED_CALL_STATUS               0x00000040
> +#define HFP_AG_FEAT_ENHANCED_CALL_CONTROL              0x00000080
> +#define HFP_AG_FEAT_EXTENDED_RES_CODE                  0x00000100
> +#define HFP_AG_FEAT_CODEC_NEGOTIATION                  0x00000200
> +#define HFP_AG_FEAT_HF_INDICATORS                      0x00000400
> +#define HFP_AG_FEAT_ESCO_S4_T2                         0x00000800
> +#define HFP_AG_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS  0x00001000
> +#define HFP_AG_FEAT_VOICE_RECOGNITION_TEXT             0x00001000
> +
>  enum hfp_result {
>         HFP_RESULT_OK           =3D 0,
>         HFP_RESULT_CONNECT      =3D 1,
> @@ -57,6 +85,35 @@ enum hfp_gw_cmd_type {
>         HFP_GW_CMD_TYPE_COMMAND
>  };
>
> +enum hfp_indicator {
> +       HFP_INDICATOR_SERVICE =3D 0,
> +       HFP_INDICATOR_CALL,
> +       HFP_INDICATOR_CALLSETUP,
> +       HFP_INDICATOR_CALLHELD,
> +       HFP_INDICATOR_SIGNAL,
> +       HFP_INDICATOR_ROAM,
> +       HFP_INDICATOR_BATTCHG,
> +       HFP_INDICATOR_LAST
> +};
> +
> +enum hfp_call {
> +       CIND_CALL_NONE =3D 0,
> +       CIND_CALL_IN_PROGRESS
> +};
> +
> +enum hfp_call_setup {
> +       CIND_CALLSETUP_NONE =3D 0,
> +       CIND_CALLSETUP_INCOMING,
> +       CIND_CALLSETUP_DIALING,
> +       CIND_CALLSETUP_ALERTING
> +};
> +
> +enum hfp_call_held {
> +       CIND_CALLHELD_NONE =3D 0,
> +       CIND_CALLHELD_HOLD_AND_ACTIVE,
> +       CIND_CALLHELD_HOLD
> +};
> +
>  struct hfp_context;
>
>  typedef void (*hfp_result_func_t)(struct hfp_context *context,
> @@ -128,6 +185,13 @@ typedef void (*hfp_response_func_t)(enum hfp_result =
result,
>
>  struct hfp_hf;
>
> +struct hfp_hf_callbacks {
> +       void (*session_ready)(enum hfp_result result, enum hfp_error cme_=
err,
> +                                                       void *user_data);
> +       void (*update_indicator)(enum hfp_indicator indicator, uint32_t v=
al,
> +                                                       void *user_data);
> +};
> +
>  struct hfp_hf *hfp_hf_new(int fd);
>
>  struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp);
> @@ -146,3 +210,8 @@ bool hfp_hf_register(struct hfp_hf *hfp, hfp_hf_resul=
t_func_t callback,
>  bool hfp_hf_unregister(struct hfp_hf *hfp, const char *prefix);
>  bool hfp_hf_send_command(struct hfp_hf *hfp, hfp_response_func_t resp_cb=
,
>                                 void *user_data, const char *format, ...)=
;
> +
> +bool hfp_hf_session_register(struct hfp_hf *hfp,
> +                               struct hfp_hf_callbacks *callbacks,
> +                               void *callbacks_data);
> +bool hfp_hf_session(struct hfp_hf *hfp);
> --
> 2.43.0

Incremental build seem to be broken:

git rebase -i origin/master --exec=3D"make -j check"

FAIL: unit/test-hfp

>


--=20
Luiz Augusto von Dentz
