Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187446;
	b=YOc2RAACOMqUp23p1b7xhTOLaApJIUoKzwgEBOx5CUicpbW7nDK9YMuqtqnHsVdqTaHU
	 YB1Zu1mYtmEaVVzUSxdNn/4a4dZDrF6bivX550CdGWlWrvdll0e4A91J1rlk3XmG+Ni6A
	 HjQDuVp1Fbp5NntNbxG36+XRFpAs+2RNAaY71WsN09fE8S7qKOEDGu5+xqOu3UbXIkkpK
	 qfu9T9wyDo1X5sa9iQrmlaoMxrO73nCSC3bAnGXLTcrRzoVv/Nd3h3lvAKdnv1ZNZi+eS
	 MU62X1dtoRb3ZQC2oPSEZpAQb/IjcEzmnnYWnD9FUn1Pkx9aV+KFjhqc8P/xVxYqBRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BKXAMnhEL10C6cWQXNXkQhHfm/U1VTZ5wJ7WB1ooFUA=;
	b=SwZ2DqbcLcMZeYh7+nrZRGLz+5HmhXxI1auYBC3cSxg700BDLED4rT+nzviH6KonNIjo
	 P6YKL/WJqutl6Ujwvj1IxtAFTtLhfnKKUZpRvUG3V+ZBDEpkQhhCqtE+6ryP9+l5h2Wju
	 /C4e69F4CutgfRWZxxM7Og/B1EEwe7UfJsecxiLLoPyQ962/Eruv5rX+ht9qSeUAoWQHH
	 UBfaZWK4bXkKz+Efde5YxUIc4DYLxf9xgmV2Ib1NKW0NBnMZlRa7YhZT7TK1v1SaXHZP/
	 FjTTJhqgpPC772D1FrYSXPOX86bQqtx2tPxZRbIX/L+Kye0edvzWw4ALBvII35bJOIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imm74dXh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99683606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99683606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imm74dXh
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67921b515a7so1177736d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:10:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795187444; cv=none;
        d=google.com; s=arc-20260327;
        b=JYyZEd55beP4rHIdn/S/3YyNp+Xnb+diWURQczyRnQErRqB+fEjoPTd5dD2RF9/yPY
         5Q07KZrAcVNLAxEFxSuOXzrbQlZ7IUKQKF0bWFgNN12/LMELUfyqnZyuOdgrr19KBwjk
         U6ZFNT6YEafVGz9X4RJhRWH1jzvqwabsoDUNvdmAeMuDDvIdRS9Y9Z6uWQT0jqQvZ2LS
         mYBEypsrZS9jJz6HcQidqWLy8rl1psJXh9sifIKVcx8cmc+y+09MtAeum+9TMs89n/Xs
         llCbYi04HZ6QPxaz66XthFR6AffuFRCdBnRTWeaH6jRioohf7Z67saFpm46xiTD/jjJN
         Y7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKXAMnhEL10C6cWQXNXkQhHfm/U1VTZ5wJ7WB1ooFUA=;
        fh=nlii0G744JXlRuEh7wckNQuXrox0qAIxXfDm6MVj26c=;
        b=cXjRwT8NPQsR6UumjUyg0T+uJR4xHUmHEO1jb9UCJlPlKzznYEk/5SuLCHcMaNl3yV
         tQk0zKCNo40qa5qdVz9MyCyc646SaiJ0ceijCf0HMI1ej6duCeFXSc8cftN6kDhOSPc3
         FuP7Mnxr00B+yM3xXPiMOoMDxRLc4josvo/3WqkCP3EHr0dKyOixUZscZjavZ1BXtc2t
         qlMu8nHlrdtV9QT64R8h+yEu8ti70JGiV6Oo3ySdBu/+0ba6QFQphDzXcHIVx+qpx6+d
         f97wHyduQ9gv0DMEeX9sVaJJenf/eQ2JjTSJA80ilKoueYNrbN5Yt8gNYFhaRUy1n3El
         QMvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187444; x=1795792244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKXAMnhEL10C6cWQXNXkQhHfm/U1VTZ5wJ7WB1ooFUA=;
        b=imm74dXhMjm6PN6N7kPR7xXWccvFxIIn81HCeZGGmsxHr0FZbMP9SQeGMFXGk+5Ddg
         bAEdWvg26NC0/JiqWXy6lt76+F8egKw9KUpqjluz8PQWInzCetKpWYkKxF7Tsyk2cUem
         9h1UxGkRJHIiYr9vBSE4ooWvbUC062iCVPoQMsdULlxabNg2C0RkYgXlMjlefi0VZqXo
         eEXj9ZNC+FWJoZ5kCqa/rXWY0ovUcnge1RJ/4ugq4tS191dKwJu81QmA56eBI7fJcvUL
         05cwvv92l2+p4QfrheHOtoYmUcvU8kYK91rl9SFqYE0lqchkU9UK7ntEEJRPfmA+eQOD
         chHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187444; x=1795792244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKXAMnhEL10C6cWQXNXkQhHfm/U1VTZ5wJ7WB1ooFUA=;
        b=i9USvs9Ckvsl7P46/Hpy/+82eQdgFHfO8jSygf4fKuaMudDQrS+ld+Sn+ltz2kvogt
         KifgOOM1w0OXYowj/w7sMivCb7hYaJjx08OGGU2zrBGaauZ+BPCTdjTEdlpj2WO2BxIM
         dY2QlJCtHCHXjKQhCJehNHZZGHw0459hMcpx2pdM6nMBXllSKsFl31R5QycZcCu0v1PL
         c8GlbrPBjDTR/ykbDlhYJ4mzfiAth6nKgMx2NFRML5LoeSgL/tR/aPJmzEl5i3OHBjsO
         3dXJDqA9BtLpnmEN8zAIaiI54M/b8xDk2vfNNgHvINGQgQDH6zLIYRTTWKyeOK1gfYsO
         JQXg==
X-Gm-Message-State: APuU4Z9sVKMFQBHISce+2Vy/bzEnZddQyEpTB96U7R3/J+N8uzDqmQf4
	86W8W/XvHBxh2l4NhSBx71Gs0So6Rf2haqVk5YoJLNXq2EXlQ7RCDWWQ32gHCOTNr5tM/wekbbc
	m5/x5BRjuMj63MiKFutgHK4Osoyvc7NM=
X-Gm-Gg: AZFdTZfe4Kwdcbho6u+i/TC16nJTZy6USdhUVXO0YrD/PfwMNaGGE/+Wbn2LlMuUZoq
	p3pp01YsHsMqrJ0BJiJd6yZTyax3Rh0MNpSikgvfPoF1o32b3ovkAbZJajM4V3f0ekRoivEgG3p
	KwKWX0O8Yi1+q9a1xslDkd/L0nKToeXDiyno6dbOejpvs/dFoVQCtFe5aO02Qoq0HSatJyndIf4
	4oLZfs7YbtdajnMyDEOk7ML3kphB9nM8R/sULTZ1whvzX5wHe6e0K+2GgZce/cHvtfENx45DdgA
	zUh4GH7dqTkRWX8eEaNGGjvriiZlCbfhQtpH5iOVSzPMPyL1TilvTDHFGAxjPN5/YluLvd6ZrKa
	oOd5et3USft5mLDJYBdhzxhVNxq0q6Umvo7/mJTwb4ghkRqtPfRPwqZDN14X/Ff9xtVWWx8riW1
	segYejMSoD/n1uWM5C4TNcBnRIY4ibmPFqoBGPA1iST91VxtVLI4ZQbweGb+g=
X-Received: by 2002:a05:690e:11cf:b0:67d:ab84:3bd5 with SMTP id
 956f58d0204a3-67df42bce89mr1524173d50.2.1795187444551; Fri, 20 Nov 2026
 07:10:44 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115191908.3646-enderaoelyther@gmail.com> <tencent_5C090D89F54B3F9DA10CEFA2CA9E8AD8EC05@qq.com>
In-Reply-To: <tencent_5C090D89F54B3F9DA10CEFA2CA9E8AD8EC05@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Nov 2026 10:10:33 -0500
X-Gm-Features: AclHuK-HAPbcLL60QLxVKWLoZwxh3iknbBMC0SdpELwqNb_F3kZf_LlC5hVaslY
Message-ID: <CABBYNZJWXoTxVYKEhQfZ82-P=8ogS-yBrMPR1sNxo3C6yQG-2g@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: hold the listener across child teardown
To: Hang Nan <2122295973@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	luiz.von.dentz@intel.com, pav@iki.fi, zzzccc427@gmail.com, 
	enderaoelyther@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hang,

On Fri, Nov 20, 2026 at 7:18=E2=80=AFAM Hang Nan <2122295973@qq.com> wrote:

I need a proper explanation for why these changes are needed, what you
are trying to fix with backtraces, etc. Also, your Signed-off-by and
Fixes tags are needed here.

> ---
>  net/bluetooth/rfcomm/sock.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 3fb8b5474948..94a495e86057 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -66,6 +66,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d=
, int err)
>         __must_hold(&d->lock)
>  {
>         struct sock *sk =3D d->owner, *parent;
> +       bool held =3D false;
>
>         if (!sk)
>                 return;
> @@ -83,6 +84,12 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *=
d, int err)
>         if (parent) {
>                 if (d->state =3D=3D BT_CLOSED) {
>                         sock_set_flag(sk, SOCK_ZAPPED);
> +                       /* close() may already have dropped its reference=
 and the
> +                        * queue holds none, so keep the listener alive a=
cross the
> +                        * unlink and the notification.
> +                        */
> +                       sock_hold(parent);
> +                       held =3D true;
>                         bt_accept_unlink(sk);
>                 }
>                 parent->sk_data_ready(parent);
> @@ -100,6 +107,12 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc=
 *d, int err)
>                  * rfcomm_sock_destruct() will dead lock. */
>                 rfcomm_dlc_unlock(d);
>                 rfcomm_sock_kill(sk);
> +               /* Drop the listener reference with neither the child's s=
ocket
> +                * lock nor its DLC lock held: this put can be the final =
one and
> +                * rfcomm_sock_destruct() takes the listener's own DLC mu=
tex.
> +                */
> +               if (held)
> +                       sock_put(parent);
>                 rfcomm_dlc_lock(d);
>         }
>  }
> --
> 2.47.3
>


--=20
Luiz Augusto von Dentz
