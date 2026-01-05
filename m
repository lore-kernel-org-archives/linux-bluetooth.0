Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483113FEE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638771; cv=none; b=bWPHO1pLwFw5xSW334VhKM+9MHMh2apgp4BYM4SuTbyfV6bfP84FjD/K//cbw0kKMPVe10CaQHGaV5PX99kUHLGhU7MvDKFP5LnD8HlFusZxb14GtzexIxvKGDRIIWerB1xlETApaO06xpJVStGn9uYpNQM9Gxm4T/U7mRleWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638771; c=relaxed/simple;
	bh=YPWS/xAXW2SdVlCVr4eqkgeG8sMWJDClMxcm3iC0cfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4vwY48JOclqf7OlyokL7qcea6xeGaz59D3UsbIsmACfkdsT63dpGP4BfZ4+SKYzhIP3jFVrR3OTJLc+vKnnqT0oGhfH8r9fTSmmZ+pBVahuduDMbkZXH6lM6uW9dwtgzAAvCuZGEppgFAeAQblc7CNMztDYtlmXrvWGMedJMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcyRSK4I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcyRSK4I"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fba1a1b1eso4024807b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638767; x=1768243567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/tB54UyDO/ngccdejo0UkDDeRn+XXiyoA1jSiHWGR0=;
        b=QcyRSK4ItRaU9WAKABze6j9BUGNV/VC5NVks/2yenCXp2HnxukeVhOfCHiyKZinqPr
         ETaxopJWUbrdUUA+cW4QfEVeVnT/Wsy7VD2VC3R+HsuUH0oDC7gV3VpVXbIWk2DxsRtY
         vDytDW7vkek3Bw/lAFcBkrT4MJFQGI1epUntqOSo0KoWMxk50s4M2rHdD8pSipyLDWPn
         YTsnh8Go0M0FJwonEckzdDdfORrLHEZ+MWmGAZs6T8UFZhT3P+6rYuDNGKS6/avTTho1
         53GgbG6d95k8jhReOQoG1zuxWLeAiVSQ2BdvjCf5jCNNOdlR96Xor1VfeCHYXgsEy8jG
         Lyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638767; x=1768243567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/tB54UyDO/ngccdejo0UkDDeRn+XXiyoA1jSiHWGR0=;
        b=lqP8cWwomQkdU0RHwLpVwBcGh5egM0hGubVpiZyYTjMf+S93ZksT8mS9XcCTIDSkC6
         MhEl5iqmgsEZvpENvWtq6rtpSvD4LtqvBpQpulF2d1tac77C3x+2ufb+Z0Gwns36k/AW
         owiQe0CbbWukCuAeIVLY6wL2NVJ7mAkfD7u7BCDWvFxAczS4b2cUgqMOyWEnOKXUKrh5
         BKiI7AFQz7E5RlSs4IpwGsqn4SriL3g0UtcBxY17Y6A7tuKWvJag3hz9BvFlP6V7l+J6
         tpeFKGBM2kVR07p00yM0FlarhQk0P8Hlu9ESxz13GrHiOdzBd77kAfJdEIRy6iG9NLn+
         kROQ==
X-Gm-Message-State: AOJu0Yz2Thx015zJEQch3f6xD+IMU2fIl04foYOf8HsCz1Nr8TvFmCGa
	1K/79F3Nt9MgURCQke+71bwZjyKaD5hEQhWVKILEHQ56ekyVC+eGQ/z+PNPLQ3yuqd9V38KfZdc
	mE9q03/Z/Aax/LPYSJWcv/4VRDG6N4N2gqNfU
X-Gm-Gg: AY/fxX4oKIIRAz64C+BlYfh9dn8UNRfceOkxPE/f3gmhuS4afeQq2LmA3/XTgSy50Dg
	AXRg75RgUD+P3NgLLzTXeesFG/Ri2MMmNYrLJ1+FtrL8P7lfg3hNwWRKIhU+zKUeMyRHCXNaitS
	YvzA0oHqs7gnIW19ntKw6EfC2iN96tYgX2iYJl3KfO3tT1iUuVBVdD1USrz9A/idnINhu7rJ6mY
	xzzKOk6kY9YNPE/9dTkhOCWFkjzY27vhq88MBi+RfOSMrTrLozXxUQaClf51gO1hIJqsVUirzKh
	xOcmrAFN63oQmGJF9VTNaChURpGRVA6Og65vgX3IXX9tyGq//M66giPqKw==
X-Google-Smtp-Source: AGHT+IFRAkEjgVGUL956NdtDgmPrE+csntXpRGDOSYhe0hdE8uZoTzlyLOihpb6YUYBtdwLFK4GV4DGue3jr8IkJrIg=
X-Received: by 2002:a05:690e:1c19:b0:645:5433:8581 with SMTP id
 956f58d0204a3-6470d2e96cbmr106137d50.31.1767638767579; Mon, 05 Jan 2026
 10:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767559459.git.pav@iki.fi> <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
In-Reply-To: <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Jan 2026 13:45:54 -0500
X-Gm-Features: AQt7F2qErq4Ht86nVAzmJdP_LesflhLdvCW_aW7U_CoUMS7beme7Q128wTcYrCM
Message-ID: <CABBYNZJ5gFe1N-NGU-ni7TybTraCh3yFDjwSEzYUzeC84_Kqyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/bap: add bt_bap_stream_is_server
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Jan 4, 2026 at 3:51=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add function for determining whether a given stream is a BAP Server
> stream or not.
> ---
>  src/shared/bap.c | 6 ++++++
>  src/shared/bap.h | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 6a35e4e1d..d0425318c 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -4270,6 +4270,12 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_strea=
m *stream)
>         return 0x00;
>  }
>
> +bool bt_bap_stream_is_server(struct bt_bap_stream *stream)
> +{

It is probably a good idea to check if the stream is valid first
before attempting to check if the client field is valid.

> +       /* Stream is a BAP Server stream (not Broadcast or BAP Client) */
> +       return !stream->client;

Hmm, so the assumption here is that stream->client is set for
broadcast as well? Perhaps the terminology is misleading here, perhaps
initiator would have been better, otherwise this may be confused with
BAP client/server role which only applies to unicast, anyway Im fine
rewording it later but I think it would be clearer to have something
like bt_bap_stream_is_initiator.

> +}
> +
>  static void notify_pac_removed(void *data, void *user_data)
>  {
>         struct bt_bap_pac_changed *changed =3D data;
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 80e91f10a..983b9d9a6 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -113,6 +113,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap_p=
ac *pac);
>
>  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
>
> +bool bt_bap_stream_is_server(struct bt_bap_stream *stream);
> +
>  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
>
>  /* Session related function */
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
