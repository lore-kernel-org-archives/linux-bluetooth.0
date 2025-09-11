Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369133EAFD
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611722; cv=none; b=etLqjkEFkVXFTx5foU1Zd8iK9YQy+iJrex7mMRAZyp1cnGmYzNR/bU1+U52Tg2v9dwqbb3I2XItFFkZxEN72hGe08w7VXllDmJDW+DeyazGqve3AFEKEy6/ynNTokMpp06iABQar7G8GWUiPrGw/lBQlRysUQFg58M9oMkfNfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611722; c=relaxed/simple;
	bh=nH2aLqhCK8ypdfninp40Tt7P/pZ089e/Oe7Sic31Ydo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpqlBgE5m1WU6ReQ/2jD3kRpkUruNCvdL5tibRPhA7RneIKub+aWs4yqtjja/y5ekujrR3tYR5IDTxmy0NYCT9JCDMWU/MIBKb7oHqSwjL/J6D/wg6FhR3MRk+4C3L/IErBDsWg8FI5vGjno9oyDTgv9BtEKpPMTMxnrgeB5ZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCJtF28z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCJtF28z"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33730e1cda7so9761291fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757611719; x=1758216519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUzroxIC6bLYOXw5ZA6YYmbGnvHhCSpz1G7yMKYYcsE=;
        b=CCJtF28zuKddiWR7Z4QcDHr/6eDQDd/CQKHzLa63HUESPPwrYpWOCk10nWRXHib17H
         GMd9+tFdLqlOmR1r7MJRM17q2rpkLz1IvSz4IFu3jKM5msSLK8HmFcUFZ2mPi8ygB91K
         mi4vpcUUYnVEOobScZcSgWOvys/4BTnh/fAbEroGRL9InzOYHYGkRhpsxfg/KAOMc/M1
         Xjt750LlOFU1YHHokXt4eNFgczw46T5f4CsC/p52D3gnt41X5UVM1k6occdTslZTES70
         hR2VumtwssyFxrhbmfoA3j9O3SxMMio12o8JA6NQ6yscVu/WEmJRUNybQgn3Ryv9BuKV
         YM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757611719; x=1758216519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUzroxIC6bLYOXw5ZA6YYmbGnvHhCSpz1G7yMKYYcsE=;
        b=xT2yaZfbQVJ0O3KFqeur3KOpOAWIUzSQZt7IUIzAgHQgRwK2bgvs69Hd1wIAVgGtdH
         orCmBqLt5InN0S8nThXZrmBX5+QtQ6UQWt9OHCkfbuHv8G8Ujk0ik8miakvZa1h6sFEy
         pAVsieIERoePbfNpzHy6Q5EhCWNuwq9yTrOxUgmjIPWbjluIeRGfsHn7tEUU7qPPyZBR
         P1wu+/jnRDDiRENMqvTB+Q6BAX/w9WU+R1RWlYE+YwK1WVSvLqFh/yWFtnHJltTZC7uh
         8IfrtB3M5rB7Ogm/R8NG/Xt7WUe3/8X1SyEJEOeBaIYFvDQWhL5jKBpAzq2DKiKNNVVK
         3xSw==
X-Gm-Message-State: AOJu0Yyu6RsyxebpubxAgUmfOeaBOtSbDiJKTBfG4HUj/FG+j9d6VZbU
	EWEriQ8UNC+28U8BA+vxbLlAV4kbznTYwY1DNuOkM7aYgUU8mMK06dfdokP3Kek5V7adVFTrq5o
	3MpQcoBzRCd+0Sr3ijmsBYAAgK3eD1MpJ8q9k
X-Gm-Gg: ASbGncuNmytUzwh4KpMhiWzWhCxL9HyefGW3dLyYwkh8trIZERaa2NhMaoLOulypwBa
	ItZf5rDRhlOdb6ug1vsdNI/fS6ALYI+uqI8ycCThhaJ5mUg7hFPk6dMzjrx6u8Yqj0ClrTj2YLU
	BZLgFqNW1CW13/8RfxfaX9GIe77XnejOd7olEdz59/Z1oYmdVErcdnqvJnQb+UU/K0DWWdQrJft
	FKryXMCJGJHcwiF1j+Z+IIyjjNT8aw2Aad3EzvEU0JG4Q==
X-Google-Smtp-Source: AGHT+IHfN+LkqTRdLXhPKiMUv+7+q88xPCIgE7YWfoElldiIFSzV7Wq1VYX80KjxHxIkSExSTZGq3B4wi8qJbPrHgDM=
X-Received: by 2002:a05:651c:f12:b0:336:de32:4a7e with SMTP id
 38308e7fff4ca-33b58cbe81bmr49237231fa.38.1757611718594; Thu, 11 Sep 2025
 10:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911102840.2090361-1-frederic.danis@collabora.com> <20250911102840.2090361-2-frederic.danis@collabora.com>
In-Reply-To: <20250911102840.2090361-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Sep 2025 13:28:26 -0400
X-Gm-Features: Ac12FXydCZjqHx7yjBJwanOM4UtyDpgNihlMvPnsITKE5C8E-RE6iWrMvmGW2Kc
Message-ID: <CABBYNZ+fnsntwwbZY=u0_5J6O5oxCQhBq8Y-HcnaXXsDtTE-9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] unit/test-hfp: Add Operator name test for HF
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Sep 11, 2025 at 6:37=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This add the following test:
> - HFP/HF/PSI/BV-04-C
>   Verify that the HF can query the currently selected operator name.
>
> Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
> callsetup and callheld indicators at connection time.
> ---
>  unit/test-hfp.c | 50 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
> index 371415a68..8ab6c7bf5 100644
> --- a/unit/test-hfp.c
> +++ b/unit/test-hfp.c
> @@ -699,7 +699,7 @@ static void test_hf_robustness(gconstpointer data)
>         context_quit(context);
>  }
>
> -#define MINIMAL_SLC_SESSION \
> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \

WARNING:MACRO_ARG_UNUSED: Argument 'service' is not used in function-like m=
acro
#10: FILE: unit/test-hfp.c:702:
+#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
     raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
         ' ', '0', '\r', '\n'), \
     frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \

WARNING:MACRO_ARG_UNUSED: Argument 'call' is not used in function-like macr=
o
#10: FILE: unit/test-hfp.c:702:
+#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
     raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
         ' ', '0', '\r', '\n'), \
     frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \

WARNING:MACRO_ARG_UNUSED: Argument 'callsetup' is not used in
function-like macro
#10: FILE: unit/test-hfp.c:702:
+#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
     raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
         ' ', '0', '\r', '\n'), \
     frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \

WARNING:MACRO_ARG_UNUSED: Argument 'callheld' is not used in function-like =
macro
#10: FILE: unit/test-hfp.c:702:
+#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
     raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
         ' ', '0', '\r', '\n'), \
     frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \

- total: 0 errors, 4 warnings, 108 lines checked


>         raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
>                 ' ', '0', '\r', '\n'), \
>         frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> @@ -722,10 +722,15 @@ static void test_hf_robustness(gconstpointer data)
>         frg_pdu('\r', '\n'), \
>         frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>         raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
> -       frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
> -       frg_pdu(',', '0', ',', '5', '\r', '\n'), \
> +       frg_pdu(service, ',', call, ',', callsetup, ',', callheld, ','), =
\
> +       frg_pdu('5', ',', '0', ',', '5', '\r', '\n'), \
>         frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> -       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
> +       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> +       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> +       raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' '), \
> +       frg_pdu('0', ',', '0', ',', '\"', 'T', 'E', 'S', 'T'), \
> +       frg_pdu('\"', '\r', '\n'), \
> +       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n')
>
>  static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_=
err,
>                                                         void *user_data)
> @@ -745,7 +750,13 @@ static void hf_update_indicator(enum hfp_indicator i=
ndicator, uint32_t val,
>         if (!context->session.completed) {
>                 switch (indicator) {
>                 case HFP_INDICATOR_SERVICE:
> -                       g_assert_cmpint(val, =3D=3D, 0);
> +                       if (g_str_equal(test_name, "/HFP/HF/PSI/BV-03-C")=
 ||
> +                               g_str_equal(test_name, "/HFP/HF/TRS/BV-01=
-C") ||
> +                               g_str_equal(test_name,
> +                                               "/hfp_hf/test_session_min=
imal"))
> +                               g_assert_cmpint(val, =3D=3D, 0);
> +                       else
> +                               g_assert_cmpint(val, =3D=3D, 1);
>                         break;
>                 case HFP_INDICATOR_CALL:
>                         g_assert_cmpint(val, =3D=3D, 0);
> @@ -789,9 +800,22 @@ static void hf_update_indicator(enum hfp_indicator i=
ndicator, uint32_t val,
>         }
>  }
>
> +static void hf_update_operator(const char *operator_name, void *user_dat=
a)
> +{
> +       struct context *context =3D user_data;
> +       const char *test_name =3D context->data->test_name;
> +
> +       if (tester_use_debug())
> +               tester_debug("operator updated: %s", operator_name);
> +
> +       if (g_str_equal(test_name, "/HFP/HF/PSI/BV-04-C"))
> +               g_assert_cmpstr(operator_name, =3D=3D, "TEST");
> +}
> +
>  static struct hfp_hf_callbacks hf_session_callbacks =3D {
>         .session_ready =3D hf_session_ready_cb,
>         .update_indicator =3D hf_update_indicator,
> +       .update_operator =3D hf_update_operator,
>  };
>
>  static void test_hf_session_done(enum hfp_result res, enum hfp_error cme=
_err,
> @@ -996,13 +1020,13 @@ int main(int argc, char *argv[])
>
>         define_hf_test("/hfp_hf/test_session_minimal", test_hf_session,
>                         NULL, test_hf_session_done,
> -                       MINIMAL_SLC_SESSION,
> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
>                         data_end());
>
>         /* Transfer Signal Strength Indication - HF */
>         define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
>                         NULL, test_hf_session_done,
> -                       MINIMAL_SLC_SESSION,
> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
>                         frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':')=
,
>                         frg_pdu(' ', '5', ',', '3', '\r', '\n'),
>                         data_end());
> @@ -1010,7 +1034,7 @@ int main(int argc, char *argv[])
>         /* Transfer Roaming Status Indication - HF */
>         define_hf_test("/HFP/HF/PSI/BV-02-C", test_hf_session,
>                         NULL, test_hf_session_done,
> -                       MINIMAL_SLC_SESSION,
> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
>                         frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':')=
,
>                         frg_pdu(' ', '6', ',', '1', '\r', '\n'),
>                         frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':')=
,
> @@ -1020,15 +1044,21 @@ int main(int argc, char *argv[])
>         /* Transfer Battery Level Indication - HF */
>         define_hf_test("/HFP/HF/PSI/BV-03-C", test_hf_session,
>                         NULL, test_hf_session_done,
> -                       MINIMAL_SLC_SESSION,
> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
>                         frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':')=
,
>                         frg_pdu(' ', '7', ',', '3', '\r', '\n'),
>                         data_end());
>
> +       /* Transfer Operator name - HF */
> +       define_hf_test("/HFP/HF/PSI/BV-04-C", test_hf_session,
> +                       NULL, test_hf_session_done,
> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
> +                       data_end());
> +
>         /* Transfer Registration Status - HF */
>         define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
>                         NULL, test_hf_session_done,
> -                       MINIMAL_SLC_SESSION,
> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
>                         frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':')=
,
>                         frg_pdu(' ', '1', ',', '1', '\r', '\n'),
>                         frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':')=
,
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
