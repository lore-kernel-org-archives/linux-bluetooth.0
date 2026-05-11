Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D03A1A50
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508564; cv=pass; b=G8H8fZS8Jaw9nkSdnk2+AUnc+83rUlh0qMxPCleD24O+GKWOMkCr4PFEoRtpR6FjCqrnhmOZHfgtfCaD+2v4F7NYVa5vZVe8QCEPzxQvbCWreH6+zg89kOhR9d14GhMnmqfqv1NogqG3yG+UV4vvz065x3sX/YEKQKQIEsaLt2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508564; c=relaxed/simple;
	bh=T2OXXtawcqJJ2n9BV2w0UAoP9DxSZjvYPCt41NuzkaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsSxQCvasXRcjnUxTWfg+LlMXMIqAMy1kbPLUqfl0ckA94CbSVuOJBOkx2rB6Ags757ivUSMxQgUna9jQWCwgghuyOk1ID6DL5+Jq1hiTrcfarzW+L5FXHbQ4rVQfGYLuzIZVjm677BFIMVM3hkUNe9/x8NmubF1kbK5Pd9KsrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4uLNR4K; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4uLNR4K"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-694891f8f62so2301354eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778508558; cv=none;
        d=google.com; s=arc-20240605;
        b=E6n3+N8xkUKyGHfoRfZO9Sv1k3UjjdhvMB/UJoWpyKa0vnBfVG36OTFnNNxaXDLdAH
         UZ7IhQUW5YuLYOeZTHwzIb5jrMnKg+4IS//2AKPLNbtFTbd8+o/tj4ZBq14OdRDxJFDY
         q8BYi5LScAaskQxz/AEE6sSSjm3adMRjmGgJDtPHGGISQsCkWMLdJMbvv55XK+TVexjY
         1p8zwlPnF/JeRomyn4gyB7ugxwWsiWnx+pH/3SHpfCsiN5qD4x6JEclJamgBS5wAPXZf
         GZunnDi21gmQmjn6dPYikNUPv2WIsySP99vnXQy6DzHnuchbVR0XU+14uAO24wP3i466
         wibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75Uo3RNYmD/b+AQ2ZUq2KNxUAOcwH1+2v9uqI64SlTg=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=INklGRJTYhQyRNksL/uF0aqo5UEjHzrNI27WuLwgMBrPDpaktGwPD6bHDiHUyYpm3B
         PafFPXjgCcMx2I6/egsEkSfZH2QZuLVpCE5NzJTShIUjA5dqIoBgIZox0TnvNUu7jiQB
         doFcp2Xbzn150iC97PtZaxLmNvaO5obrHiQ1eB2OoLLNUQuwjdofQTx0ZqaRYsedbQxQ
         3WjdvLdS5VVtA58rPrtm8bATD9Pp+TPilAIIWfwr8+wh37s+DX5hDANgeADoq4/NtvhC
         OT7lD3Ele0BuvXf2rMpckdbDD1ma1Z1GDT94ZWVoVvTuqYR4xVd4EChkq49edyeimxmB
         YxbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508558; x=1779113358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75Uo3RNYmD/b+AQ2ZUq2KNxUAOcwH1+2v9uqI64SlTg=;
        b=J4uLNR4K6wbaP6G/5bxRIwlgmvE48a+01fJ1A/2oSuSx+WDRXKnNQxKe3bo7JZHLzi
         p/7dQQk+DDqSh+I+snsmP01ASqn/+VwHXFL3ErazpsmUsuX/tgyJXp9Ko6z/A5+qyb4x
         /4yuA6d8zyVgD2X87U8v8UtUcvck3Wef/fXK4gs/pQEbO4pWhu7t4cDUbShtyVGxNym6
         iShC06VBNhl6HlFELpEC3hme/JSs9E8qjzUExk5co3RdQ7KTsEhE7FvOcf3HS7gZhlQI
         XVGsS/9YGGDqu7y4dfdv3HnvAC0Ig5d7Fs712z1kuM0k+pyGE6GBy2bxRp2F3uFxgqEc
         w8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508558; x=1779113358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75Uo3RNYmD/b+AQ2ZUq2KNxUAOcwH1+2v9uqI64SlTg=;
        b=cAPu45xCYMjcmBD0NEndvxFY6XWR1p2EmXKq7JsErbXRVpdFe/F0MC/VGQANFc5Mhl
         aQspAC6Su7KlURNveNrNy30ETcmZ1ZPfYl+NbCpZhZbybUjnR5ueNvicNSO866Syx5ZW
         mMepS8HdUZf7A6czAJ6sz8VhZMsqS4v+J9tDrrcXjHv5mep68y40rjryuiG6fLoPTtGS
         73+I65B7QpGBmgTmbKNi7QUd1GIBaO8DfpgC5fH2Jq1RrsRJ2oNsRZbmmerlVXF7IOhl
         ibkkXSk9izf2ued/Sz7MoEah2PvDdxKEwVmLa+d6k25TWEV6Z4iF7u7mydEH3+9dY59s
         MiJg==
X-Gm-Message-State: AOJu0YzgvSWxwoWa5tha3mSicZ/aKkFBStJ0BfP4JLMsU4J+f66TTah8
	9dIeAa35ytpSH12Wn5tZvBRIr6uErYs+v1FyGNlF8hmqRaLXdv7yHe84xaqtxKzjsKLcmvn3IN/
	EI6HIhgprubRVBRphLMblhN7ZH7X5yr7PLlRB
X-Gm-Gg: Acq92OFjWn7RqtyK0Q4DFhcI6Rka4XRnLtNIpl8YHDgWXARn3tu4xuaZzQftxYHGYeD
	kePG5Fxm/bSkVtF79Zc2kyMLjtCbHTAggyhPL+/iHw1YByafSsk9dkl8+RX0WjEBEkhac4vnD30
	b+oHdqRP3BX+8Err7GPrDc3C4UTYKTpkiYLmLSvkQVry9Rrbg4v5etIQUENB3lJWpfsEc7EeM8y
	woF0T7UmZtEYJzU6Idog8XldQA1/ogegaVwQYbrhzK6dRj7UUri0qP+gCoXCTmgiQwny3pvvLOl
	qHV7hWjaIs6uaJm/P8+zZpgRWXuUBYUQvIPauVA7jAr3NR9g+X5ggaHWnTDm3Q1gXYJ/sA==
X-Received: by 2002:a05:6820:6303:b0:69b:544f:c16f with SMTP id
 006d021491bc7-69b544fd6a6mr1513463eaf.59.1778508557941; Mon, 11 May 2026
 07:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105845.8008-1-raghavendra.rao@collabora.com> <20260511105845.8008-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260511105845.8008-2-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 10:09:05 -0400
X-Gm-Features: AVHnY4ImLtQBafJlid7s96gOnI_FMOP_YgdZbqZW6fvlLcCMM4GYH0ey5vb1iV4
Message-ID: <CABBYNZLcvmErUXHUXnAJOMv+saSP7aodVtfRV0QnL2-yXg=z2w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] bap: set QOS state when CIS is lost while the
 state is streaming/enabling
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2026 at 6:59=E2=80=AFAM raghu447 <raghavendra.rao@collabora=
.com> wrote:
>
> This is used to Pass PTS tests BAP/USR/SCC/BV-167-C abd BV-168-C.
> ---
>  src/shared/bap.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 78ba22259..2edd4b249 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -6670,9 +6670,38 @@ bool bt_bap_match_bcast_sink_stream(const void *da=
ta, const void *user_data)
>         return stream->lpac->type =3D=3D BT_BAP_BCAST_SINK;
>  }
>
> +static void stream_io_qos_disconnect(struct bt_bap_stream *stream,
> +                                       struct bt_bap_stream_io *io)
> +{
> +       uint8_t state;
> +
> +       if (!stream || !stream->ep || stream->io !=3D io)
> +               return;
> +
> +       state =3D stream->ep->state;
> +
> +       DBG(stream->bap, "CIS disconnected for stream %p state %u", strea=
m,
> +                                                               state);
> +
> +       if (state !=3D BT_ASCS_ASE_STATE_ENABLING &&
> +                       state !=3D BT_ASCS_ASE_STATE_STREAMING)
> +               return;
> +
> +       DBG(stream->bap, "Moving ASE %u to QoS Configured after CIS loss"=
,
> +                                                       stream->ep->id);
> +
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> +}
> +
> +static void stream_link_io_qos_disconnect(void *data, void *user_data)
> +{
> +       stream_io_qos_disconnect(data, user_data);
> +}
> +
>  static bool stream_io_disconnected(struct io *io, void *user_data)
>  {
>         struct bt_bap_stream *stream =3D user_data;
> +       struct bt_bap_stream_io *sio;
>
>         DBG(stream->bap, "stream %p io disconnected", stream);
>
> @@ -6685,6 +6714,12 @@ static bool stream_io_disconnected(struct io *io, =
void *user_data)
>                 return false;
>         }
>
> +       sio =3D stream->io;
> +       if (sio) {
> +               stream_io_qos_disconnect(stream, sio);
> +               queue_foreach(stream->links, stream_link_io_qos_disconnec=
t, sio);
> +       }
> +

Hmm, this should already been doing by the likes of
bt_bap_stream_set_io(-1) -> bap_stream_set_io -> bap_stream_io_detach,
so perhaps there is something missing there, or perhaps
bap_stream_set_io is not handling all the states.

>         if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
