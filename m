Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39E258CFB
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054943; cv=none; b=B+0ddnkFc/3pMsNHVrY4VV0hJ2uYduQzlmtMXgIz6cd3rj7s/kIhYA0REXIyITsoDwicACsl2VB5hRrRas4VtiZHPofn6gBdfzPt0YzTxslgvNF+YMr/XF+yr1PQ58VhbyJVepufVHWa+2dsQNrUdkx8XZYEwZMViedpTC5ynPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054943; c=relaxed/simple;
	bh=m39WKoVMU2NvLP6shlCQZczliOP9zNnyaauj8ljWILQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StqfWjhBYqUHExAK5yyn22/XIp+w30f5tQBZrynbakcVoRj8QEmVSxEAx+Rte1VUQOqabgCFZPRymZec78Q2Fg4/Nchyp1w2yQmx9mQKRzT5MrT5Yqzsrcu3d8LrqqcpxOLguUEUXuwbBt/EXF5rsG8uj43jR/KPFpEensDbTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=YW336OWt; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="YW336OWt"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-400fa6eafa9so3051571b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747054940; x=1747659740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K8QpXpD7fMc4fdEjgc+zdFi2o3syEGdunhiguCF/b3U=;
        b=YW336OWtpBog3s8Bj1gnL5d1sTpOUoKilCKkhxvNoF1UfyChZNx+YUk+8ys0zLm6ae
         xPHYg0zfvcAkFxsdHJZguyQwPx9zMT1jWfgoaCQ2l74wijHT1YCINN5vJfdJo7saov9p
         sobPmqR9EJd/4ZG6j9Bir2377BGy146b6KkSelCEaUF5yw3pkhn1ZZLgOJKjEgCKCGGB
         FK5r72hs9mWUpnUNsTdeBafwD4ivVIUQCL00LZIQQPuYUpVIPQlnhVC8SFJ1X/PoS4nW
         rMk4A6IZuYJM/TfHv8TFuqsZbdukd0ZjmBhcK/Vcv5ehR3QviDZtD4zCRHo4g5w7wxfF
         tmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747054940; x=1747659740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8QpXpD7fMc4fdEjgc+zdFi2o3syEGdunhiguCF/b3U=;
        b=rtW1tTov1qNCkfJ+DXEFv14JomCEh1vjjgQaQO5Dhcssd0eYc9OtaDJ3V1yYyGvox2
         khD8XZdPl1BoF0o2CJuZGOcyKgigUR8GabOabRe/hjdvumzdPje502cxJvu6xU6FA8o8
         Qv84fTMW/gy/BKerEMi1apA9k9gB4eDnMTJQXGup3m5qf1UL3xHA6nOLRMVlKsjJQ/kU
         IR0KI7ZQ5vLszpPKOo7lu6BlveQxdxaiZI90PrDocfhtYwWzt9LWkENebDl9eALdk2CM
         a2MlQc3qmCq/NazU5t9lIqJFVYcjSoed5R65apTB5rFW7EeaNmyz5rPNn35sDPlUj95z
         sT4g==
X-Gm-Message-State: AOJu0YxB5CgDm9l+NnRRBwKLnroW2gbWYVRV6ET9Bn9TIzBonoCKSYHr
	WhZkAts6mil4jBBDlm4/LV3MOXr9VAe/dqmk2BNWs7eRQJpdsFpDtj0uLk1rLQi16fo1g9/tjkb
	dtoaPt73QmwKv5yY32QBx/FRJBzJOz/Z0MzFrYO39EjXA/rmV
X-Gm-Gg: ASbGncttOEiiGeAZmPhvMXQz7hWbbxWwtRaFpezndHxT2LVVZrVDGN0aY+P5R0D15oS
	lVUSDURHC636HRkGnopF4Bz/XsnOCi67AbCP/HzNUWWLLB5GBMgDBmjtip3R9lw/fhJiifvgujI
	QIkr0NQ+2f1OjT+3n+jv/I0ehoHSbQ8TGrLsoGoGAOExChS6WFnEUv02Upq/6GkNRn0g==
X-Google-Smtp-Source: AGHT+IFP8zG6nZLyLpz1h49yLoPF3x1FTw9IOQR+R2rrKbcNjOiu0SS3PyRNVhnbb8to+5peGTb6Kh1gs0xEVYtzPdg=
X-Received: by 2002:a05:6808:23d4:b0:3f7:8f77:2a9e with SMTP id
 5614622812f47-4037fe51ddamr6514367b6e.20.1747054935122; Mon, 12 May 2025
 06:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512101952.70203-1-sanchayan@asymptotic.io> <20250512101952.70203-3-sanchayan@asymptotic.io>
In-Reply-To: <20250512101952.70203-3-sanchayan@asymptotic.io>
From: Sanchayan Maity <sanchayan@asymptotic.io>
Date: Mon, 12 May 2025 18:32:04 +0530
X-Gm-Features: AX0GCFvqd0sk9hApElrtTNLe95zJjmX6fxmdN6gYltVBRGkkJVddo9hTkVXpcWc
Message-ID: <CAGd0QtvSiFrrfGLjyZ5Y8p+tX3YLvMPCR9DuGJiZAy-YA617NQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] transport: Create media request before calling suspend
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Content-Type: text/plain; charset="UTF-8"

This patch is very much incorrect. Will send a v2 later.

On Mon, 12 May 2025 at 15:50, Sanchayan Maity <sanchayan@asymptotic.io> wrote:
>
> Creating the media request before suspend can result in
> a situation where media_request_reply is not called as
> the suspend action for a profile may not depend on the
> callback of the stop operation.
>
> This is the case for ASHA profile as devices are not
> expected to acknowledge the receipt of a stop command.
>
> Moving media_request_create before media_transport_suspend
> should not change the behaviour of release.
> ---
>  profiles/audio/transport.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index c5ae3a71b..dc4f8fea0 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -917,29 +917,29 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
>                 if (g_str_equal(member, "Acquire")) {
>                         media_request_reply(owner->pending, ECANCELED);
>                         media_owner_remove(owner);
>                 } else {
>                         return btd_error_in_progress(msg);
>                 }
>         }
>
>         transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
>
> +       req = media_request_create(msg, id);
> +       media_owner_add(owner, req);
> +
>         id = media_transport_suspend(transport, owner);
>         if (id == 0) {
>                 media_transport_remove_owner(transport);
>                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>         }
>
> -       req = media_request_create(msg, id);
> -       media_owner_add(owner, req);
> -
>         return NULL;
>  }
>
>  static gboolean get_device(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
>         struct media_transport *transport = data;
>         const char *path;
>
>         if (transport->device)
> --
> 2.49.0
>
