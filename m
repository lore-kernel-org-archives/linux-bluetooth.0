Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D73FD14D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461641; cv=pass; b=L2qofY42HjwvnCsBmcZFyypTpGxGqogQvRWVZC67vSMJlGDy0zCkcqpFLkyZj8o1FtvNl7E6HtfLwNhIos4iPh7XFXhtFoienZbA+D9C9znWSID0W81tCk+phH0yDoN3PTyAtmzmbgTdOhG/EifHOqYxGaWMjSyjYEe6kQBIVuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461641; c=relaxed/simple;
	bh=iMGL0vF28UGweW2ATAPGYsuWdy4OzPlXsdblQV7xvv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b88g9o9wLa+IZUEChpltn1rEB294X1QV8zUmTKPUpPAOpUI4Z0J5W1+8AoCFYovca88q5F7Xev/g3zx/aDxZloX33gsz01pwwXDnqoSrOnjT7cF6y4KFdWIfHTqJXwKfaAxQB7sQl6F7yWEHitfCh4H3d29nUTqeDgFHJuXFGJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpLLRlDY; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpLLRlDY"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9a398bc7so4209778d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 06:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772461639; cv=none;
        d=google.com; s=arc-20240605;
        b=Bt93hsyRtfbr3cZQXziyJV7H1E3uuEl1fwqMx5QMpRoFPsJ1bJ3JviBdUnscbVTF/N
         7TRojHKKTdiMRKQXBQNlcJMTAQUUvVX67UPRoXixPBw+skdZzaPIRRC2OolysiqqIFOL
         LY2nFSh77F3P5cRotp0tjtjsVPLZGObNAUjtfMcI+qhr2aKITuuzFBa76FojtBw+ox/O
         1fYJy5i5sxVTS9EI7RoKAgElK/9fXiPIJbZtYR/RGlJHHNekBtV/xRicHaxuH3agEOZW
         eA8JVHZIk3qz7jDfJHn0+SMww2uz9Qw6Yu5/tHNFPG0mlf8Mo8RrnUyLP9DObpq4kTT2
         jKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iMGL0vF28UGweW2ATAPGYsuWdy4OzPlXsdblQV7xvv0=;
        fh=8s+Omh0KC8SSE1Tb/5y27cXk8TwuG9ekRyhRvgZ/MC0=;
        b=iabmsI/yJv6/GOM2+RI5XC3GuE7jTBkFv4aAsRLHmP9so7SVoMQTaTrzY0yolcXHX0
         XnKSAJc7I7fBYtH+d/7AwqkiY4Rss8lHvF/AnC3DGgydRp27ldCJS2itHB4r/mw+NFvV
         et8n01XvR+t5kNtLN3y3KkArYUwYpzd+09RjwBFH+OH4xFLqkndY/P2B1umGtZldOAAL
         XFuNuHSTgOJBKHecc0EZXcKD0eUia5k6/d1zlj7tqRvSuiwUuGZuTWQXp6hOScQCYCvV
         JcM+LxNN/xGcmCC5Wc9qIT5X+ZTufbNeqZuoG4dShYFR60MPF6hveuDs3P4e029yP/uC
         CN/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461639; x=1773066439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMGL0vF28UGweW2ATAPGYsuWdy4OzPlXsdblQV7xvv0=;
        b=SpLLRlDY9vcX/XM4RBxHCVxYjgVwnIurusF1Ww4+DoIoMggO7inNSoVxKSzArTUtCP
         iA23PEqT1bFq0Nv5UwO8+PzmIURpL6rAwTYOfOE9WVrwLFzLddj+nXETgJOI3MkTUQGt
         wrLTwKWyIR49GR09Uqt6cYSqwRQzqZIny6QaUCg+L2yqiLZiZHj8Il9qH3WsxnFFD4iF
         caePyIMF+eh8vByThDOkS4Cy3jTI+e/jtpLMfsoFfFADLu0rw/hdvMWBkr7HE0LMbO2Q
         G7ZeMunow9tlukZ51hjZK/l+QBd4y6SHGeAYcn5SVJptbiqakFBwvfdCTTBTitgKBx+l
         1W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461639; x=1773066439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMGL0vF28UGweW2ATAPGYsuWdy4OzPlXsdblQV7xvv0=;
        b=dMuJpEyTCJpCJaKEvevb4LzTiIg4/8OTdkgds6SJmGma/tQcxF1pq92Jfy/2p9fhoG
         fGF3QDxyfyfYcuCIym5XZijBxDqEl7R33mbhrWyD+yuu6PfdVwM2d8nsofjHkXc6VYG/
         TzqxA695X/jSdiwjzhc2T9Gc0HmNAaNqV9ykVILfOTlGjnE6Ht6EeHjbaAk667AmIlXX
         YiVXaDzbwJt0mJS/HPGqoNFxUeixLPHifQAnZBUc+TUMNtCPG7HeydtAC8LfFzP7sowU
         PFpdTFtU9VRY9JjUm8S6tMgAYW+x81erO2Q9Kv/DFsCS1Ahhc1RIo4/o16MmSYJgykXt
         wCIQ==
X-Gm-Message-State: AOJu0YxkLvNP0kLXvqlmTj53oZxnRFnv3JgZAyfumpDwYGKQKIWafvxJ
	lLcC7jUJE8fHVquhW+13+2Xc/Ab3eHcZoH/C1nFCgCEO/r5kDKmRSS4HPd80o5x3gRJSVSBpPms
	h68IK/OZQ4zd/g5CqPjVD8Yi9QLSugAI=
X-Gm-Gg: ATEYQzx1qpUt7SraOulp+LqXXbYsQITmHKWI8AlGHLy3KG7SNhzJSpzhAZ2OK8uawW+
	T0afkSZDCJoYc10lDnm+X8/JtjihxThNygyWLtceboqPs81R1srDTMBlkuMThIocTdnxgaVpttK
	WpWZVsdO2JabcmJxvReJLoZSBX/3vjmAtK/NFvhPKL3Xa6IPJOM1R8ivlSzNdwa5s/Waks/JHOP
	ZCsjM0QQftEIA+aCGgRDgQR5/tnMWmfC+fym2emh67uC5it2LHTstLt4sXeS7I1sthovewduvX3
	1rfKX2uAmJ6wI7Hv0CxrpOYRUamFii0Ihp2P1IkKlVlx4AIfa5wswZcNfhVp3/8lNEER0U8X8Z3
	9EYu8
X-Received: by 2002:a53:d203:0:b0:64a:d35e:d356 with SMTP id
 956f58d0204a3-64cc20ca96fmr8594057d50.30.1772461639014; Mon, 02 Mar 2026
 06:27:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126175340.3576865-1-luiz.dentz@gmail.com> <20260301233619.1807980-1-joanbrugueram@gmail.com>
In-Reply-To: <20260301233619.1807980-1-joanbrugueram@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Mar 2026 09:27:08 -0500
X-Gm-Features: AaiRm50yQ8F9BoCPndc8Z7MsSkPkQRb8rHTDRVlSPBgDjsQa9S5ZypQyJDrMa54
Message-ID: <CABBYNZL3W4+eF5ap7dS9ZSPmYkTLgmAEJ0H=OkC04x0LfXuqLA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
To: =?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joan,

On Sun, Mar 1, 2026 at 6:37=E2=80=AFPM Joan Bruguera Mic=C3=B3
<joanbrugueram@gmail.com> wrote:
>
> I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
> and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes it.
>
> The symptom is that when connecting the headphones via bluetoothctl,
> it either hangs or appears (in pavucontrol) as if it's using the AAC
> codec, but there's no output. Sometimes after some time, it disconnects
> and then re-connects successfully but using the MSBC/CVSD codecs.
>
> I haven't had time to troubleshoot this further so far, mainly posting
> if it can save someone a bisect.
>
> Bluetooth chip: Intel Corp. AX210 Bluetooth (ThinkPad T14 Gen 2)
> Device: Bose QuietComfort Ultra (bluetooth:v009Ep4066d0167)
> Bluez 5.86-4 (Arch Linux)
> Kconfig: That of the linux-mainline AUR package, plus UBSAN

Weird, there shouldn't be any logical difference but perhaps it's
device-specific. Can you collect the btmon traces? Actually it would
be great to have the before and after traces for comparison.

--=20
Luiz Augusto von Dentz
