Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2E1EB9E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259496; cv=none; b=VvXdbhbcmP2MV8B3e03ZrXASpV0IzEHdgLfezHcOu/2mz0iyJPIfypksxD5+b7SVAyWPq3yqStWo7Q2r0H82u8atRcfEIZcQB1Od8UpNfgeE8Sg0sAyztjD5UF/ziwDSzZztqy/avVzqmBc0rxZvnVvV8dtPzmOYdovlMHPp24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259496; c=relaxed/simple;
	bh=rf6qBCFx84nRSiTwB8P1w4vSydz5AXBEEAlIc/cZfxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvMopSXwDMEYJCyz+30VjfxTpKVIuUje/o0U6tmiJ/oE/i4Ka8H+DDX6Ua3WAKQc/AgiemKqtO5Fw7g5NN32OJWjvqLGc+SHyV2KehmQvUVOw3gtG2o/4vK03MWvRHLumWzEfBl0v0Xu8Iuq5ntWqzG1M2CmVd/0d7nilUjwohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCZX/JZ5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCZX/JZ5"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3022484d4e4so12994891fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738259492; x=1738864292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiteQLsp2T/DspkN6bz5fxZwcClJcuKzIw5KqQawDSM=;
        b=eCZX/JZ5qNJnhBr+ScvZ9sdM8g7LKV8YCbRfP2q393kRAKo4DGNynw2zpFPvY1HTh7
         /aOmI/CxEbW5BC9WdFVvHGBiE6Y/1Y051afoMqA9CYfnoxPiFFWTXEP1T0hArjhO7Bgg
         LFZJskYhHF/L94lxmmDNNwGRpvEgZocYpr03AEqcNIiXbSudTEOYDBIoguIEWC4b3OEH
         UVhgG/3T60IfHCR7nXH+xejWeqEaafxE/AST/H6cjcOEjnxcvMVgDk6/mB1l3ayjqWHV
         SKXG26IvpdSSRwbl+pU1ENn03SbEFHWRlbFkfExSWiPAw3fjGMLvT7l8kXYW5jOOrdpp
         x1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738259492; x=1738864292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiteQLsp2T/DspkN6bz5fxZwcClJcuKzIw5KqQawDSM=;
        b=tHDGUS5q1icGP9I7qvGF/BxNdyw3zhoss9aCu7dOSuRFZDTkrQpJPbC3EqxPbbh45R
         GPCwK+trjV+IlfwZhkMvUyLK8WQ17dc0iWyCrjf77jUs9YuGJs1cpomFp1BpUkHC6F5a
         UYT4L/g6YEBAo4ydVUkWjzqN2v6n02Q86uWIq1RwF+NsOMj6Y8MoKXh7rVumC0dEItrf
         u1eq70/k4lqZl5S2GpFW4vYnPdu40hbM0Vnpl+r0FxTK83JqcKadKAwj4hHEWfCBajXD
         pSSD72Q4/lKBSz568eyCePcIy3psOHxzpRXeOe/zhJah++vLwemAnk6rrYyZaCHkJvcX
         BBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW09jQIDzlDWsT+SHgYCtea3NURW6GRKapY1RPPHz52dmcWmJmr8T56c3wpE8yBWsQwDZvCZ6N+FWG4xzeLrAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCp7iWZzXDiDz/8CwcCmHqJ6yhZJxkJSz/k4ZHPln5en4DkPs
	potcRpdnj2trCStl/CU4j6dh7qXDVretGx8iOUpa2bbEwHluYfrtK1RXsu5Uj0DlpK1l5utzHgE
	SiuIXUOD5ITH8UY+Vd6e8+xhccgFdcRA9
X-Gm-Gg: ASbGncvedbKu2P4o5/3g8mmDrUGycWL8Ox02wRVNdshwpNnD7BPD9/M5BLBXilQXV1P
	RSAC4cuPHz336zt+3BrQVkC7IPQbsC6pihXQSp7VbLXUBowSkdC4irrg2k2puU3/Ysq7PRSY=
X-Google-Smtp-Source: AGHT+IEQN/gwoI2EyLiLIRV81LmMDXc5wN4lRBrfhsUfArzb7Nxg+b5ybsJ9s2bczNUVjd3uJqRZ2MKoCAqtIb5p4ts=
X-Received: by 2002:a2e:a909:0:b0:300:3bcd:8d05 with SMTP id
 38308e7fff4ca-307968da703mr34683861fa.15.1738259490987; Thu, 30 Jan 2025
 09:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129084950.41987-1-pchelkin@ispras.ru> <173825823449.1027237.5797702882442522177.git-patchwork-notify@kernel.org>
In-Reply-To: <173825823449.1027237.5797702882442522177.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jan 2025 12:51:17 -0500
X-Gm-Features: AWEUYZniCAxmLPQxUgJMAhkXb72T1Kor3u0_eGXlS4QeWfbZ0R562Uy337VZkFg
Message-ID: <CABBYNZKm+xj4wmuzBgCjJq4genR73a6Gj-C1uvGHW3MiNdHNSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] audio: actually try to enable MTU auto-tuning
To: patchwork-bot+bluetooth@kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, linux-bluetooth@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fedor,

On Thu, Jan 30, 2025 at 12:30=E2=80=AFPM <patchwork-bot+bluetooth@kernel.or=
g> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Wed, 29 Jan 2025 11:49:49 +0300 you wrote:
> > A "0" for the input MTU passed to the underlying socket is supposed to
> > indicate that its value should be determined by the L2CAP layer.
> > However, the current code treats a zero imtu just as if there is
> > nothing to change.
> >
> > Introduce an additional flag to indicate that the zero imtu is
> > explicitly requested by the caller for the purpose of auto-tuning.
> > Otherwise, the similar behavior remains.
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v2,1/2] audio: actually try to enable MTU auto-tuning
>     (no matching commit)

Ive done quite a few modifications to the above change, so instead of
using a auto_mtu it now checks if -1 for not set, Ive checked with a
couple headsets I have and it seem to work fine but perhaps you want
to check as well just to make sure I didn't screw something up.

>   - [BlueZ,v2,2/2] a2dp: enable input MTU auto-tuning for the server
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D252a32ac0b3f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
