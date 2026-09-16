Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5D3C3F51
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579811; cv=pass; b=HRd+O3NV3Dlmp9lbJu3IV7BWhhhS0SFKluk1EWnaLSTORL6yXcCdu9Tb6k0vBINce03X2vURKhrQduB6WHH/MMBSNBmJLEHN5kBgWZGnpMtHdInOWKgg1ncfbbWmBhzlTIywM31umpa1/PqUKa8mwlLGG9Vz8r2E/gXFe5Qw6ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579811; c=relaxed/simple;
	bh=PgMWZRvbgKR3vXFso3Q5tfw8DNe/0J/rTGL65vEk2sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozcRtT+Rj/rl25aFI0pNvzY8XD4wY8KF7LJBrjbQdjJx/BzLqiGPrQNoBIR5gqRtq3qlYnYoUCUJsuNfhpQZli/1xAskjvak/Ww8IZoFNfXX5N+3MzVZu3EaPgRNpIIEDDSoF1Qql+aiB+Bf0+PTNJF1x3VQL8GY7vLzLTJZKUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvp8g1Yd; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvp8g1Yd"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d45ae011cso12364927b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789579806; cv=none;
        d=google.com; s=arc-20260327;
        b=Xu5MLL8mvrEDG6sqywucfnp/Jn2T9WnXPpeR/s8BGLRU7LppHozWdhnVArjj7L1Bsy
         ofF89xX/6llQYhGWZC4wmnqMCXVtqiyzQq7OL1mNtmFTn3hGH+MW5dL5NaYrzuaZRFmY
         TayBvL+HDLla+y6qP2kkNuQTYduUF5sqzww3DDuCwrU1c29FKGE3tmnvHU/LvtdeZ218
         ahNM8/+kRudZsBtJkwA0I3uAiw7xfJt+mirFwJiu1zWWdEt0kJ22Cb7igVW5lkyG4FF3
         j3XWpWwecrVEN1Ux+UW+hhDea6qM1CY21rR3lux1efbW9eW+c2rsLKRMJJig9rzyON0i
         5pWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aqcULkXZQ0/YrrN9LAC3cYrOts+XJkym17Lk5crrPTQ=;
        fh=rhg0Gle/4xL7toZLvPTXiQYaR5XkHzpydvfLlubNvfM=;
        b=bDjfAW/0yTdMTMb0nAtI4hBxc6dr4bKf0yuDw3HNbORkAeRdU4fKpWPr0LlpWnZwNH
         xG8YX71Y2AAy6sTFo04kjiTawv30yf9oacAYNABZXR1rdbkmKBhJzcHVBy5eBwG54/vr
         a6MQVdQnIgKFcysgtwc5CgVSiwLsTYM1zbvHoiRgKDlETSwp5MRxtczxto/Gm+0MXY9F
         t1gjFKA+KW8TOazG1fyLiJ5LYqyYSgQ+xY3wGtrN6Q3odiQh4LsygScRZqLPA24eA2TE
         QnQpA+BHIT0Cb17CoV6HPqJB43oPuN1HQJvh0RQe2B3GXqw369EiAxiYdIBkzXXQ2b9+
         WpDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789579806; x=1790184606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aqcULkXZQ0/YrrN9LAC3cYrOts+XJkym17Lk5crrPTQ=;
        b=Vvp8g1YdZ+OHsHKmIEROPDfa3sG3AgEFnYU1qAOUbKdxAFCjPinejy50ZbRwxxcZUC
         LfLnDKrexjQTF/n5N1vTU94LuPmX25SYOA7Ohp5RrQAHWqp0BVAgMaias70YCoQQU/2a
         pH7JOx5EFYhaOnToWl/n5D4BPAUyaXvmJYj5m0pRcMZqP9iu+/IlBhJbxSGj7CsiXM03
         bq92Ue23eQP48yunBKQSPHBOEpGc+18yGmxTpTNjNsPfnqjQ+NoB8ZSVPWN/FiWmTRme
         RxlozAl0cqEdjlxc9IKQLMkk0UgYSUUuS2CbGLUneQyM63SGUGmA2X1xVxeEaYzetFZ2
         k/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579806; x=1790184606;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aqcULkXZQ0/YrrN9LAC3cYrOts+XJkym17Lk5crrPTQ=;
        b=xLth4wpLBo6ZB7f8sZktq3QWj1PxYxqR/4CPZY6CyoAq555KLflHT6hX36zv2SuguK
         ZFT2nUAnkMIl+Y2u8xJWHOyRcfWKjEV7VeKbDrBNqNfj4+9IiNoB5ap4TwapkRjBsnBN
         jE/QITYPGDlhcWYTrm6TfyKCmSOd/W14TepMBfUqpMFplKXi1ODFdsfIL1ketbhyfPhQ
         kVSK3/A08TimO6Qfpy/Gz7gXJxTvy5wU9FiGvLXbJxbA8sjTF/Tu+TuzomLcbercIntk
         1cDNggYpKtC4YAd7ckYff5OIhLMG3cxq6XkOUAJHPGumtYvyyygnnqSoEa7vGntn0GI6
         e1cg==
X-Gm-Message-State: AFuF++mbIRD4KbJsgYirgAeZ8tbgS7hxnuS/psd4jLVzvLT271PhaaEu
	wj+J/pSuvS0ofMeKro/CuIbTfbQMwQBovAyeoy8Mu2ZfQFjMAbplyLYi0ZWaA57QIMdiWUdLjyX
	HAdMsa303K3KzFv9tQKm/9vpMi8W6K6PkUPYaev4=
X-Gm-Gg: AYBFou0Ok37Pi8NOBRKO993aWOPNK2w7UnCVjoSKWSF2aq3ZYJu2woq5nily9PtG5+I
	EnW8pVTkdpJX+dU7mVmAlT217kHXzmeEhjDw7CudFHAD/+hkiCkHVvxxd+3MLq1ckDv2Ni7m6ff
	4D3lMomaXFv4aYZa8sJnZn3fMxM/8Vd8faq825g8NC/CxtlYommn7fVXs269FIhZorPgaLJ0rcA
	5KXN1wqov9oa0sdbBxfVFBx4+Xi2vY5eEg14jskiWL/fKylt8kE1+LoDBG/66DTVGXKDCr0HK+1
	Ng80GThQIjr2sXQCaN1G/H169h0OgHuv9SEulFjAkCwEiS1an8n3tTLAtdV+PZ5co+sIyHR6/kS
	kXwqUYxGV7szme4rAP+N7bGvVPR/NPW2/Vu+EbRah+iGjXLQjTxXg
X-Received: by 2002:a05:690e:bc3:b0:66e:57d8:6a52 with SMTP id
 956f58d0204a3-671631a7766mr1235345d50.7.1789579805999; Wed, 16 Sep 2026
 10:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me>
 <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
In-Reply-To: <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 13:29:55 -0400
X-Gm-Features: AcwNN1XkRocOJYZ6KHnVBKDPysIK8BEOWvGaRcRQLUqEXJ-g0PfoUE3QvOXtw8M
Message-ID: <CABBYNZ+tf1SZb3ONdaySGEk=n27XofWepzfg2y_VTujTUc4eCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Skip local metadata Config callbacks
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2026 at 6:33=E2=80=AFAM dt <derektern@proton.me> wrote:
>
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
>
> When reconfiguring a client stream that is already Codec Configured,
> setup_config() queues Codec Configuration and then caches metadata.
> stream_metadata() emits a same-state CONFIG notification for that local
> update. The profile callback treats it as the peer's configuration
> completion and clears config_pending before the peer has responded.
>
> If the control point response precedes the ASE state notification, QoS
> setup can run while need_reconfig is still set and fail locally.
>
> Cache client metadata in CONFIG without emitting a state notification.
> Keep genuine peer CONFIG notifications and server metadata handling
> unchanged.
> ---
>  src/shared/bap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 891a2f4fd..44cfd1ab4 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2278,6 +2278,11 @@ static uint8_t stream_metadata(struct bt_bap_strea=
m *stream, struct iovec *meta,
>         util_iov_free(stream->meta, 1);
>         stream->meta =3D util_iov_dup(meta, 1);
>
> +       /* Local client metadata does not confirm the peer codec config. =
*/
> +       if (stream->client &&
> +               bt_bap_stream_get_state(stream) =3D=3D BT_BAP_STREAM_STAT=
E_CONFIG)
> +               return 0;

I'm not sure why this is not handled in the switch statement below.

>         switch (bt_bap_stream_get_state(stream)) {
>         case BT_BAP_STREAM_STATE_IDLE:
>                 /* Initial metadata */

Also after this there is:

default:
/* Force state change to the same state to update metadata */
stream_set_state(stream, bt_bap_stream_get_state(stream));

So according to your findings the above doesn't apply to
BT_BAP_STREAM_STATE_CONFIG? Afaik this is done so that
profiles/audio/transport.c:bap_state_changed to update the Metadata
property, but only takes effect on enabling and streaming, so it
probably fine to skip during config, or perhaps we limit to
BT_BAP_STREAM_STATE_ENABLING/BT_BAP_STREAM_STATE_STREAMING which is
where the metadata does apply.

> --
> 2.55.0
>
>
>


--=20
Luiz Augusto von Dentz
