Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FB4C226E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578714; cv=pass; b=mkaDzkUKb84JY7F9+xUBVC2KTZUYpyRLWXfFtdmwVZkI0IYpPqalqRekbdpUr2LW7q8A2VPo4m/Xy0zHpLxpd0IHJfkUQkBshhMuGpLJOUlkXf9TGuXhWGUOd7LO6pcsMtvGllcRG9Rx0FG8xsm/rdQ0JNk7SFQmjRJdBzWbjh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578714; c=relaxed/simple;
	bh=SqJQqlzxmfihyeHnarom0K3YLg4Hf9vNPio3i25JlkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0FnYwKNcvT29weeGZoV1Zic0gVKX0DPke+ZUUMxYe2/bf35E0gjWAJOxXhyKBXvvIeoNN+cey+YdoZEItpWJj8eDMqmswC78rWE41hv5ALA09wkjD3Vbc/yT35lU755KEbAj7KLOOoIaXgvcQH/2s8Vej3ELlM1dD7rhTaw3bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHo/3sJz; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHo/3sJz"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66fabb1a601so1227756d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789578699; cv=none;
        d=google.com; s=arc-20260327;
        b=N7TcatPNL+Oa5PDeODPb4ft8QMKiStSlAH3BIOpvX+NBhZBiYqh/wK//YFRLihOf/X
         AKwbzLDsGQqYzzrlWZy2spW/72m1/qeAPT2SyFwJCiVcvCO1Im3DfeZ0bC5ssShb4/MY
         tnAqttXg3QsNQTMHlinZWM9fxZaihhGB9YmopfatmBl1x0bim/lUUbzqcDlLakSTWt1H
         OC9CZbwvYCDD3GzeVFfCUKBvN8tITB4uAEnT2otYgG6m292x6JP/E3lF+Y/reh5U/UBU
         ZUBnUVAP4wybqI+D1lxFAzl++zq4AjHIcql3BHXDeMotjZ0w+TZ2AZ+YHVMMmfxoF8CJ
         GhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hw/qoNG7M2fryz+mfzCrh7JGX6ontqEugpuhKgwx+RM=;
        fh=rhg0Gle/4xL7toZLvPTXiQYaR5XkHzpydvfLlubNvfM=;
        b=EvFI0Lb1BsMBILAo0HIYFFeDPAzbpHpbZR3HYILMlk6iGIdJgWJUsF9ydGb3Xh/ejJ
         /LZ75KHFUODBESMDc4mktNf9xKGRbdrrPU15fW5kDXVWYDRKJdQzgCCh+VhozTRxzWcE
         ORnZ/w6Ghu8C8QfU9BKkkwv51xQ5q5NXKjrlM/ogHlvOMUkJsna/Fu6j1X1+SZuGPVQL
         HGMVmYJ2YTkT1/snPB1Os1dhX7kss7T+rAMUUwcviIyduFraZye93+haCb53ukjh+xtC
         GDa7Ytp3hA3RVGcvZM3ycovmWdYg1DwK4x+bYKIMBZeXTc49tn6bqTF+XvsOo3LsguMb
         Ckpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578699; x=1790183499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hw/qoNG7M2fryz+mfzCrh7JGX6ontqEugpuhKgwx+RM=;
        b=fHo/3sJz836ELXydr+1eZcy0puG602rAZgfrFUUTqt5qlhg55bgHGQ6dM06Eyu5Trs
         D9Nlje+wx+cLsJYPBuRA8dZTmACcigFfY8uD6T/rULC06p7s33A7kq8MzLc2PoFLzUt3
         0fv7WbTNolII5Ik+i37Sw0Y1xbeNev1Ku80PNviozmDYleL2Qj+Ls1PF+3HbiodUaQbE
         67ISROkgFKYBu8GmXIr5/+vbGIoN1B/pmBb8rLtFfS4GoEUoG1WOm5TZx584Yi3Xa3WD
         GOjuTrGWKeOUFY2Mzb3y1oAFBaRT55zbuzsjg5iKY796lZob/2VLbQVNV5WmIEkNgj+r
         U4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578699; x=1790183499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hw/qoNG7M2fryz+mfzCrh7JGX6ontqEugpuhKgwx+RM=;
        b=Eed++oQNVz5SHRe/vY5tjYWPe5cVmg3e9ZTfdRbUYfnbWCKrBs7idQse7JaVoNBm1h
         Z0CpUifhvPd7o3PgSb64BVdEWfYNzeeQeOB74gNdRW02RY7o7iTNn83livzvdDyDHil5
         MWC1CaNzEs+9T+CNFANT/v4BxrbCLPWP+rq+sKmSaTcDvw02MpHbiZNLCmi0PSbFKDb2
         j7Ry1tWQrHmpr4h4COu3IDljItyk7PlsRj/Vdrqxq+JPGGfzc7Vs/dX5tMaQ9TLkjjn3
         F+ByasW4jR3mBLKNfeSzabJ9jHuac7zNgAXwnN1IDDJi4z1ye52Zxo2BGZ6shww0qfJ8
         2iRA==
X-Gm-Message-State: AFuF++nK0cLqNg6Ueco2PhemBhW3wXcBbQqQmv00S5Ue4J1lgyAvbPuJ
	K3h0ZopqZXtyhJM/D3lqMrYoUSJZF42LLNwEmmfqKvZYMTjj7Xmbtyzx4I5iwkSNUZEoTZLhhXr
	PSqHp7E7iOqy3gpgHtCkI1mDM4cVZwhI=
X-Gm-Gg: AYBFou2HKflD2BWYXLs4EYIriQLudWZFbJnmMn3GS2GmdTRodvnFmdVFWa5g6SPwGxE
	N7179cFHvWHHFkHL1vt07AskKMkaR8GP0vIG3pT07tabE6cAkBN0TtB9bRhYKZnsfJEDVvfkFof
	V9RAhvAoALc5+lQuKdBGoA7LrdTfhNRCoFHF4yStopOQGq+gAwfI9o/psSarECalAqont3QGJt+
	mSqjgYgJK0OjXnBULRFJYpEWK+k3PHjouTw6WOVbrpSAyPWR6VoUDZ1Pq4oBaZVqlMfTM47AdT1
	YrYXE97DYFhB7b8HoA9k+aeY0HWOg4o0kEBgkOLQJKxvhaZRbUsiM0GHQn4YvyOaXRAl0IOhZB5
	tVSajuy0JB7S6NNKaQzNIRcy3ngIZBJ9IyQHCpQU1fg==
X-Received: by 2002:a53:d058:0:20b0:66f:c1bc:c06e with SMTP id
 956f58d0204a3-67163272b7dmr1018284d50.54.1789578699383; Wed, 16 Sep 2026
 10:11:39 -0700 (PDT)
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
Date: Wed, 16 Sep 2026 13:11:27 -0400
X-Gm-Features: AcwNN1Uowl4cXw4dAOTjdbe4uvQ_w1XgQ8GyGahQdqUtswy8MvLW8N9cHsgJCoQ
Message-ID: <CABBYNZ+9w-Uv0PNjTkUzCSU2-zN7oaFneOL+RJgaqdctqmc9eA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Skip local metadata Config callbacks
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Derek,

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

Do you have a btmon trace that captures this scenario?

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
> +
>         switch (bt_bap_stream_get_state(stream)) {
>         case BT_BAP_STREAM_STATE_IDLE:
>                 /* Initial metadata */
> --
> 2.55.0
>
>
>


--=20
Luiz Augusto von Dentz
