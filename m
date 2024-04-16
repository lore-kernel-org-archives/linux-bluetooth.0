Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503B130A43
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280594; cv=none; b=bKPk5+uXXQFCtT5bN24AWdbWb3sC1hmQhqYvgVpDs4wWk5sUqTsNdJg7N7yUeOismGrUdksBX72OirV17JVGcLNSPGuXznFm3KdMUaINbzsC8oe2xPr2jZuUakG7NSXefrBUW8JdLu/gFAnUJbTB+iLtnFWyjbZovnqdaoh04SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280594; c=relaxed/simple;
	bh=5whnXbFtyACQo8hyIdodxdvFjfiSbyGsJMqSv8FVSf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+r/wsIY9mAzDn+EPVC6l4nl5RqtLTXpXdnxiaWhie2pPMLEVF71Jm8PloB9xQysjZxgLZDX6EI01OzyvC0cCsDvVWL7+lbk6IPDHM1gFHFIB67kso1Jll1uP80r57AWyZF/o38sXmvjPGYBgAYdZUvOyN6hzbHdyS2JupSDZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN2D7036; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN2D7036"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so16557481fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280590; x=1713885390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCRblIzbp9DopdoCO3x5DzIKWFiVzaiLpSF4dFmHWSQ=;
        b=dN2D7036m76FA27RPiJ1KVDpICxx9v+M3YvFsa2lZaY1ifGMsNwXhNeHskzTGTBu7l
         L/6/L0l9ufdGDNSbBacmPQkEJ9lZN+kDMY4NOgcPvrXyzl84FveFxuzjKs53Q2ukFTZb
         Tt9NgLVf6elNPILoCwVwx5s+QXcrculnTCGtYgcyCvk6DLTKmbLgJuL/HQvKhZf/Ejv3
         rBnKYIqUlP1pTmOffwQPcqSbfSfmIvtj9v6etBBteMIOueT0PmlxLQ3RCUPoZvtyOgOC
         HMFkHYJx5Ev2eWm18qtmnPo5w2GAT0/RO+8EJmJ2xMcHLdk72ViEEn1A2RuWptatUT/R
         S/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280590; x=1713885390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCRblIzbp9DopdoCO3x5DzIKWFiVzaiLpSF4dFmHWSQ=;
        b=g+SYzmKITt+7cUdeMjWh2LEXDvpTmyaaVvW8AuvmNK//MEGTLHii5uZ0xSvQVU+PFz
         ebmXPh9nXGrdB+q6TJr5Z9wTjLYbCo3b+xP/vfVlPCzWQgYCeJasCub+qp1Gw1VhUh3B
         PNfzTXe4GpbjN9CeGrabX3+KsqNsmkW0AIqrDV7ElMmptGdcof1S3uuf04uOKsEklTP2
         1J/Y8JCxmZvZUAXeZnWR1jjFYn2jmyeOyPsOp6xht8qO0n0X4/6cV11jzaUolxC1zW4p
         ibtLwZfiffRtLdrWyI7fUb6d0hQFugNer1dz9yxYYegBzYlkj6wKXImKMxqZq1pwow3m
         ZKdQ==
X-Gm-Message-State: AOJu0YyitHa8+REP3gPtx2+W+GQN2y8LNq7J5MjRxugHEbtYQy6wUPoi
	6X29O0yANcF3oKGLhYyqrNq6HRd6V3SreF7uQWzWR16DfEOXySf0pXbUrK95x2Oi1xU4tefeJRF
	/AJokDvxM7mWQ47MwaBe2rmnfDum5IA==
X-Google-Smtp-Source: AGHT+IF/cdyNSA5er7eaHNDwfhEGdI7bVHloWiTnC6FrsVyI70lG2klvHpZ7ZAWScLEz8M3stisMoppGkJ6UutR50w0=
X-Received: by 2002:a05:651c:1027:b0:2da:b35b:eafb with SMTP id
 w7-20020a05651c102700b002dab35beafbmr2841098ljm.29.1713280589952; Tue, 16 Apr
 2024 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
In-Reply-To: <d52ddf4759720a2879677fca0129d3fd1a32dda0.1712951445.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Apr 2024 11:16:17 -0400
Message-ID: <CABBYNZLHfS95O=0QWbitCpQRhcn8smez0wEAXzouonPFsra5nw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: clean up requests for a stream
 before freeing it
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Apr 12, 2024 at 3:58=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Cancel stream's queued requests before freeing the stream.
>
> As the callbacks may do some cleanup on error, be sure to call them
> before removing the requests.
>
> Fixes:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000013430
> READ of size 8 at 0x60d000013430 thread T0
>     #0 0x89cb9f in stream_stop_complete src/shared/bap.c:1211
>     #1 0x89c997 in bap_req_complete src/shared/bap.c:1192
>     #2 0x8a105f in bap_process_queue src/shared/bap.c:1474
>     #3 0x93c93f in timeout_callback src/shared/timeout-glib.c:25
> ...
> freed by thread T0 here:
>     #1 0x89b744 in bap_stream_free src/shared/bap.c:1105
>     #2 0x89bac8 in bap_stream_detach src/shared/bap.c:1122
>     #3 0x89dbfc in bap_stream_state_changed src/shared/bap.c:1261
>     #4 0x8a2169 in bap_ucast_set_state src/shared/bap.c:1554
>     #5 0x89e0d5 in stream_set_state src/shared/bap.c:1291
>     #6 0x8a78b6 in bap_ucast_release src/shared/bap.c:1927
>     #7 0x8d45bb in bt_bap_stream_release src/shared/bap.c:5516
>     #8 0x8ba63f in remove_streams src/shared/bap.c:3538
>     #9 0x7f23d0 in queue_foreach src/shared/queue.c:207
>     #10 0x8bb875 in bt_bap_remove_pac src/shared/bap.c:3593
>     #11 0x47416c in media_endpoint_destroy profiles/audio/media.c:185
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ---
>  src/shared/bap.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 5fee7b4c5..ccde26431 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1105,6 +1105,9 @@ static void bap_stream_free(void *data)
>         free(stream);
>  }
>
> +static void bap_abort_stream_req(struct bt_bap *bap,
> +                                               struct bt_bap_stream *str=
eam);

Normally we suggest just to move up the function definitions to avoid
forward declarations like the above.

>  static void bap_stream_detach(struct bt_bap_stream *stream)
>  {
>         struct bt_bap_endpoint *ep =3D stream->ep;
> @@ -1114,6 +1117,8 @@ static void bap_stream_detach(struct bt_bap_stream =
*stream)
>
>         DBG(stream->bap, "stream %p ep %p", stream, ep);
>
> +       bap_abort_stream_req(stream->bap, stream);
> +
>         queue_remove(stream->bap->streams, stream);
>         bap_stream_clear_cfm(stream);
>
> @@ -1477,6 +1482,28 @@ static bool bap_process_queue(void *data)
>         return false;
>  }
>
> +static bool match_req_stream(const void *data, const void *match_data)
> +{
> +       const struct bt_bap_req *pend =3D data;
> +
> +       return pend->stream =3D=3D match_data;
> +}
> +
> +static void bap_req_abort(void *data)
> +{
> +       struct bt_bap_req *req =3D data;
> +       struct bt_bap *bap =3D req->stream->bap;
> +
> +       DBG(bap, "req %p", req);
> +       bap_req_complete(req, NULL);
> +}
> +
> +static void bap_abort_stream_req(struct bt_bap *bap,
> +                                               struct bt_bap_stream *str=
eam)
> +{
> +       queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abo=
rt);
> +}
> +
>  static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
>  {
>         struct bt_bap_req *pend;
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
