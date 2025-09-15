Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372622EA175
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943066; cv=none; b=UHjMzicefus13CBw+3d1QqbXxWFwd/A6IorEsRnHCFCvIlVRERl+UIXQeWzGtQNGhLbKVKA8/UbAWkas2wehwUDCuSAjPyxvaOkAv/AZkI9gHmHOG+Dqv+kBSSKgjrfVQgShuGq4suzutA/GCWrhL10/V7mlK9d4BPOMTeUzgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943066; c=relaxed/simple;
	bh=5kpZSypQn3yJGnCu2EhMISWD9fQ1DeGcGvBeW6SUSBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI7g1GtvxfjTIeRS3mDUBrXKLH5lthDrPV5o8pmbXl0U5JxgHrRXwJgvzFbjVZaSPE9D9mnEJ+1rVHj/Wr5mOiogxvC4OZJGT0w+TmeHZMdXYsojssv5XHSmVVrPRe6epzPXzFPwqL47IeS/wn1NQv9kX34kj38YkF1Icyv+fvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jszi9ngD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jszi9ngD"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3515a0bca13so29945011fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943062; x=1758547862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp8A5C8ZwD1S7bxRc0JPCCqN+sI3LSkwavzYnPXeI+M=;
        b=jszi9ngD60gcOzhM5aG4kfwPc8JuRIKcPacdZ9ZAJe6jzW5+HPNx1W0ODwAv8bSpFo
         Y8hovKDHRRybWoeqpwFxWJ4YXCwyDC8Dhyi6XcdPzeS69IBrV3s9I3QJ8RvOqib7+XCi
         sfl1hFyRNMpxbA23iP5RRDy2zNHckuzFMej7cqB+bLOCM6c6SNy73YUwuAst6gICXjnI
         vbwQmyeW75BtQX52finKkvQy6uLOO+JtLDi4057aS0HKGAvNYGlZtMuniI68/7JJ+OQe
         wvG7K56bK3VXS5w6q/pSwBLOIyWI0yhz2uGIOYO/LqYjx1TwDVXfDjGJNevIgPpvMiyo
         09Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943062; x=1758547862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp8A5C8ZwD1S7bxRc0JPCCqN+sI3LSkwavzYnPXeI+M=;
        b=Gk0swXPSAfZh4hOVp+dg1xEdFYEx+CXxkgSTlBOMAefaZrra23whRgLMniBRLGAHQG
         Ar0LgTQc08P5qNIxDszcc0xZUZC7QclxNwRrg+ZWrzGX0BzuajWpliLR9FMNyKntv7Cs
         uJBoYzjo+r+QPaRwpcfJwdwwCenznLa7YQxTjU73C1GyLuNWtQmsri/PlWShaGnoq95R
         AfT62idha7HSs3Lk9fxhmCKmq+BuPduSk9gA2cSnIdRbA6R92tDCdZBZN+f6JvdWsn4a
         VN/FvjG3T1L0zp7yIWLLjTmTrlbw4ggPswJGhIuT9r6boU7krly7Fd64yciGoyEI2MCS
         7HQQ==
X-Gm-Message-State: AOJu0YzC84i5IT9KdlPEJ/BeLHxPBKkmoyr/64/zdZOSU6KoaYoABz39
	TTS8lshCEcqCcPqDhb+ghwKtVweX1X+LP+NGAvvLFhI8S1xt2kgvagelYXlXCugsUwR3CMtq6vE
	+4vIt5puyT6XrKtpt+ErQusnZ3CnRDzMm7w==
X-Gm-Gg: ASbGncuNL44mn3G4pCiKwjSbbd7PUnCkr5CHk6ApQ5NQhjdoUsv5X6cKAjXqIAyaOTK
	huQ3tUm+60ZSJrrfdKLoEl9/pRxN1FtSZ3RkVFNPbGEt3cghrBePBjnvdXLoUa38wv3h7aSsSo4
	3IMOzl3Vw66HVvIrPKdfACNgvu8ZKrCUDzs+ZthxTKAKp6q1I1pTE86pKHl+MprLFPxx1gyGidv
	0qQrWsocqbRXUrN
X-Google-Smtp-Source: AGHT+IHBCWN5kjWfuohxXeVYsSo1f6edhqJYVCLEMbUaa/+L2TD6vcsxRMfVi+C3I7j3xE2NJFnllsj/oilrq8KAvb0=
X-Received: by 2002:a2e:be08:0:b0:337:e0d9:69a0 with SMTP id
 38308e7fff4ca-3511a747db6mr38089601fa.20.1757943061830; Mon, 15 Sep 2025
 06:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911102840.2090361-1-frederic.danis@collabora.com>
 <20250911102840.2090361-2-frederic.danis@collabora.com> <CABBYNZ+fnsntwwbZY=u0_5J6O5oxCQhBq8Y-HcnaXXsDtTE-9A@mail.gmail.com>
 <b4e36f0d-130e-49f8-b2b3-dde10a5ef3cb@collabora.com>
In-Reply-To: <b4e36f0d-130e-49f8-b2b3-dde10a5ef3cb@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Sep 2025 09:30:49 -0400
X-Gm-Features: AS18NWASwUNjp4bRGm77F5hyUuwoBpoEx8y-NXz9rGXx2U7OIhiK25jNh33sovY
Message-ID: <CABBYNZJ3ECWsSjR0E6PiiAS6KPAZmnf_D+-WyyN-Kwz6=_AYmw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] unit/test-hfp: Add Operator name test for HF
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Sep 11, 2025 at 1:33=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 11/09/2025 19:28, Luiz Augusto von Dentz wrote:
> > Hi Fr=C3=A9d=C3=A9ric,
> >
> > On Thu, Sep 11, 2025 at 6:37=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
> > <frederic.danis@collabora.com> wrote:
> >> This add the following test:
> >> - HFP/HF/PSI/BV-04-C
> >>    Verify that the HF can query the currently selected operator name.
> >>
> >> Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
> >> callsetup and callheld indicators at connection time.
> >> ---
> >>   unit/test-hfp.c | 50 +++++++++++++++++++++++++++++++++++++++--------=
--
> >>   1 file changed, 40 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
> >> index 371415a68..8ab6c7bf5 100644
> >> --- a/unit/test-hfp.c
> >> +++ b/unit/test-hfp.c
> >> @@ -699,7 +699,7 @@ static void test_hf_robustness(gconstpointer data)
> >>          context_quit(context);
> >>   }
> >>
> >> -#define MINIMAL_SLC_SESSION \
> >> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
> > WARNING:MACRO_ARG_UNUSED: Argument 'service' is not used in function-li=
ke macro
> > #10: FILE: unit/test-hfp.c:702:
> > +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
> >       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
> >           ' ', '0', '\r', '\n'), \
> >       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >
> > WARNING:MACRO_ARG_UNUSED: Argument 'call' is not used in function-like =
macro
> > #10: FILE: unit/test-hfp.c:702:
> > +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
> >       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
> >           ' ', '0', '\r', '\n'), \
> >       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >
> > WARNING:MACRO_ARG_UNUSED: Argument 'callsetup' is not used in
> > function-like macro
> > #10: FILE: unit/test-hfp.c:702:
> > +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
> >       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
> >           ' ', '0', '\r', '\n'), \
> >       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >
> > WARNING:MACRO_ARG_UNUSED: Argument 'callheld' is not used in function-l=
ike macro
> > #10: FILE: unit/test-hfp.c:702:
> > +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
> >       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
> >           ' ', '0', '\r', '\n'), \
> >       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >
> > - total: 0 errors, 4 warnings, 108 lines checked
>
> Yes, I saw this, it is due to argument usage is done in the next hunk,
> and checkpatch failsto parse it.

I'd recommend introducing them in the next change then, otherwise this
may break things like bisect.

> >>          raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
> >>                  ' ', '0', '\r', '\n'), \
> >>          frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >> @@ -722,10 +722,15 @@ static void test_hf_robustness(gconstpointer dat=
a)
> >>          frg_pdu('\r', '\n'), \
> >>          frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >>          raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
> >> -       frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
> >> -       frg_pdu(',', '0', ',', '5', '\r', '\n'), \
> >> +       frg_pdu(service, ',', call, ',', callsetup, ',', callheld, ','=
), \
> >> +       frg_pdu('5', ',', '0', ',', '5', '\r', '\n'), \
> >>          frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >> -       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
> >> +       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >> +       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
> >> +       raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' '), \
> >> +       frg_pdu('0', ',', '0', ',', '\"', 'T', 'E', 'S', 'T'), \
> >> +       frg_pdu('\"', '\r', '\n'), \
> >> +       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n')
> >>
> >>   static void hf_session_ready_cb(enum hfp_result res, enum hfp_error =
cme_err,
> >>                                                          void *user_da=
ta)
> >> @@ -745,7 +750,13 @@ static void hf_update_indicator(enum hfp_indicato=
r indicator, uint32_t val,
> >>          if (!context->session.completed) {
> >>                  switch (indicator) {
> >>                  case HFP_INDICATOR_SERVICE:
> >> -                       g_assert_cmpint(val, =3D=3D, 0);
> >> +                       if (g_str_equal(test_name, "/HFP/HF/PSI/BV-03-=
C") ||
> >> +                               g_str_equal(test_name, "/HFP/HF/TRS/BV=
-01-C") ||
> >> +                               g_str_equal(test_name,
> >> +                                               "/hfp_hf/test_session_=
minimal"))
> >> +                               g_assert_cmpint(val, =3D=3D, 0);
> >> +                       else
> >> +                               g_assert_cmpint(val, =3D=3D, 1);
> >>                          break;
> >>                  case HFP_INDICATOR_CALL:
> >>                          g_assert_cmpint(val, =3D=3D, 0);
> >> @@ -789,9 +800,22 @@ static void hf_update_indicator(enum hfp_indicato=
r indicator, uint32_t val,
> >>          }
> >>   }
> >>
> >> +static void hf_update_operator(const char *operator_name, void *user_=
data)
> >> +{
> >> +       struct context *context =3D user_data;
> >> +       const char *test_name =3D context->data->test_name;
> >> +
> >> +       if (tester_use_debug())
> >> +               tester_debug("operator updated: %s", operator_name);
> >> +
> >> +       if (g_str_equal(test_name, "/HFP/HF/PSI/BV-04-C"))
> >> +               g_assert_cmpstr(operator_name, =3D=3D, "TEST");
> >> +}
> >> +
> >>   static struct hfp_hf_callbacks hf_session_callbacks =3D {
> >>          .session_ready =3D hf_session_ready_cb,
> >>          .update_indicator =3D hf_update_indicator,
> >> +       .update_operator =3D hf_update_operator,
> >>   };
> >>
> >>   static void test_hf_session_done(enum hfp_result res, enum hfp_error=
 cme_err,
> >> @@ -996,13 +1020,13 @@ int main(int argc, char *argv[])
> >>
> >>          define_hf_test("/hfp_hf/test_session_minimal", test_hf_sessio=
n,
> >>                          NULL, test_hf_session_done,
> >> -                       MINIMAL_SLC_SESSION,
> >> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
> >>                          data_end());
> >>
> >>          /* Transfer Signal Strength Indication - HF */
> >>          define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
> >>                          NULL, test_hf_session_done,
> >> -                       MINIMAL_SLC_SESSION,
> >> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
> >>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', =
':'),
> >>                          frg_pdu(' ', '5', ',', '3', '\r', '\n'),
> >>                          data_end());
> >> @@ -1010,7 +1034,7 @@ int main(int argc, char *argv[])
> >>          /* Transfer Roaming Status Indication - HF */
> >>          define_hf_test("/HFP/HF/PSI/BV-02-C", test_hf_session,
> >>                          NULL, test_hf_session_done,
> >> -                       MINIMAL_SLC_SESSION,
> >> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
> >>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', =
':'),
> >>                          frg_pdu(' ', '6', ',', '1', '\r', '\n'),
> >>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', =
':'),
> >> @@ -1020,15 +1044,21 @@ int main(int argc, char *argv[])
> >>          /* Transfer Battery Level Indication - HF */
> >>          define_hf_test("/HFP/HF/PSI/BV-03-C", test_hf_session,
> >>                          NULL, test_hf_session_done,
> >> -                       MINIMAL_SLC_SESSION,
> >> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
> >>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', =
':'),
> >>                          frg_pdu(' ', '7', ',', '3', '\r', '\n'),
> >>                          data_end());
> >>
> >> +       /* Transfer Operator name - HF */
> >> +       define_hf_test("/HFP/HF/PSI/BV-04-C", test_hf_session,
> >> +                       NULL, test_hf_session_done,
> >> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
> >> +                       data_end());
> >> +
> >>          /* Transfer Registration Status - HF */
> >>          define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
> >>                          NULL, test_hf_session_done,
> >> -                       MINIMAL_SLC_SESSION,
> >> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
> >>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', =
':'),
> >>                          frg_pdu(' ', '1', ',', '1', '\r', '\n'),
> >>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', =
':'),
> >> --
> >> 2.43.0
> >>
> >>
> >
> Regards,
>
> Fred
>
> --
> Fr=C3=A9d=C3=A9ric Danis
> Senior Software Engineer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United K=
ingdom
> Registered in England & Wales, no. 5513718
>


--=20
Luiz Augusto von Dentz
