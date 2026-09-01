Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509244A2A49
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290329; cv=pass; b=GzJEKTgTm0cErd3L62eQd/yY7OtoFMj4tYMy9+4NyQNSbhCn/EakcE3cqrXVgDpHyYdtADhxwji268V3VAR5PdLNKEY6RuSUZGLpKuIOkTECeOEpRF96aszRlu5OOzPJjAl/WD/FyYn0GXyywBagJkospaSfp0W4ZgsOA3CDRek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290329; c=relaxed/simple;
	bh=I8Dm4yX2gtsxJTxiWNlFfRe+oMAWwzuJWHtXcKqXvi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxU+oscpYCTF4P4XijNkeyBBieOKhhUk22IdQ3pnt8wU3iBn63kXLvMPCxyPK1mLqa59XVaxOQqCzRi9dEUmucjKbH60xvFJCa3dfR4eOeY6xEm/esoz+d7N0lOcU5Evk7tdssmS9/SUbU1Vu3N3+6BnRlLSWKv6pfuAWu0lMUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTf7yEYN; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTf7yEYN"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c744a00edso269704d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 12:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788290326; cv=none;
        d=google.com; s=arc-20260327;
        b=LR38Z5BeY9BAMjzBTMNZQF9r7Chf2t+dhqCZJkmsP9eD91aBHjdUir9Ad8qo53FfHJ
         /ONpCpNxcKK3p+VaYBj9ip9dXvXd+8MCFhWKkN17U4vOiJDUeqZadH/bRpuNKjhkq6lW
         1WP/7VFqAXAHAuW3muq6AggIo0U103e8kU0Y9Sp8JEXRmwHF+tUAsyA1zjcRpef+x1Jp
         W/YhDBxmgltkghjds2owfDgNIN9+5alCAl27oJqoSmhs0dyepxKEzf9eCvo30JaM1RLQ
         dylz2NeIwfHc+J5/9ljORrYj3AVotp74su2lNrOJM/I5ibMGkbTNa1Kl1fmRVr/CLlFf
         1dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9xG0BUEQHuWF0hT+4x7XmwAs29VVhaqa3D7W1fhcmAo=;
        fh=Gd2d+Rw6g6ZGoe4UdkN+1yH9Rb4ADc2FgS40BpFfxHQ=;
        b=ikUKiUfbYBQ/H0Q5lU9HxsJNmG93cvjDrq/FwY9mc0REd68WvEJHS8qpTqkDSXXtnF
         wJS+Bui+BcVmax22m2IV/kHNZFwAstAeVCZW3d9ekK68dav/pJ90bYv9D0eeWHuldOQp
         CHd6Qprva636NKER8eNJaP6SQXOTstROqYedokFk8laS/XrBEeV7U8Z9dhzFdhOpYf1A
         FG/JarTkf4V4F7GThulptA6tGGW/Z0wI52UP8kiiGkkwIyNo/6WseLzhldldCSyd3SnG
         MmMznmXb9VDDwhoiEbweZZ6V5NIbFCMZp3dYq6FIk7dWZEwdNdMxtUJ1HBAswWTkatqb
         uD/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788290326; x=1788895126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9xG0BUEQHuWF0hT+4x7XmwAs29VVhaqa3D7W1fhcmAo=;
        b=fTf7yEYNC31hRNtoW/OqFn/WVZWN3ry9Kxdwm8sz8BxZ4DemrUnF5AXHoQkJWGNcRu
         FbucZhBPMKP2aS9yXlHjeh0yPZ+icFVPdNlQuSbcTwDk7uDgUs47/gtMF3VYrgN8cNBZ
         jl/T2zRn1Diydh4koPOP97pmLLdFQxYi7DsCFIPQo8VYbR+HvnE+l7dVeEPdGOrf+wA2
         5GV1S2EuqKm6ZRkZEBlnAgBqnP0/0Sr0d8KhWTQTJt31L7jvCWL/XwihqAU7Rs72QlUt
         xQ7U/ebg8dwv2IfLGSB+pVi1yp+S9c5xIOAOMr2Zh9DsSofbNLGcZkwqlq89usXAh4Lu
         ImpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290326; x=1788895126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xG0BUEQHuWF0hT+4x7XmwAs29VVhaqa3D7W1fhcmAo=;
        b=JphbN3iDxj8PSTlkxDWfFkAr3inH9ekjAUS/4/HLVVFQPwAKKUlgw0pzXo1q2IC87G
         q7oCK82SyJ0jWhAIg+4RSfFmSxoXdl/VLG4BFOcxtnyFCFIXh+YXYI4gdzMLwM88MI85
         973kptb431kOgnaW0y/BLT+UfMXGLGCmD6+QrzyK7O+v2mkFC38RF3104iqhWqHMe7S6
         yiaWsI6FzvRatlJifSELtDqzUBjSD1QnQZqR1THmJmhmCG0hfkECwo2VaiRaDqbY/kpF
         DW5u5JZ/wsHvPWWwxL+Kvd1gSGDVsoxaiV0ty1ngEg38npnxKQDVMdthc65SCQZ/Qp/g
         C6HQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/h7HDAyTAt4NijOqSK8vbv31aSHLfpTlbSWsT+Y+wZR8oOLx6aW4OGUdA9howXO7U2bchLm9au7uqdZfENS0=@vger.kernel.org
X-Gm-Message-State: AFuF++lZnxOzhwXXRfRvCws0OT9srAFoJEJZGt0qSIg1XmudNH6QUbkF
	gZBbLgTMCoOlQiuV4DxbVt/rjeKLk6l3dkSLmts29ADhBWOlSq6EnX7T3defe0y1n1j3Ca9TDE1
	UaZPreclqI8cF1iGLdx3Qpf04bER42qo=
X-Gm-Gg: AYBFou3jYUkN5a7UickPrAOndli8rCL44316HT0d8LMdiE0tgEx8zrjIHbJZU2pKTDT
	WRCXDbKSGOILDeCYs/UUK8KUUwnwBZSdXkkt+Wq6PJJwrLz6S4aRAAAGgkf0AfayFNzervwjPZD
	FvG+kWvH0peDfCFNp5vvj3zyWE0xqmv88sJd/rXC4dD4ptf3ZuyCmJhXusBcCCYIGQJ376DKba9
	TrDol8AnglnSAydpWAL+deRBaosAVmM/WPjbZ91N5XYenwEZhebzNKRGluJenuLOzdmidAfarlr
	e8pcuH+qem0klspUDBPPjNgG3bmf94JqzRdrb9VMEEiPTCo1AZc07+JNyUMY3aHs7vorRAg68H/
	ZzpHdazioDDUOPSW/ywUvsCK+5AjyngI=
X-Received: by 2002:a53:c9cb:0:b0:66d:bc2:8067 with SMTP id
 956f58d0204a3-66e4c747eb2mr8123066d50.42.1788290325948; Tue, 01 Sep 2026
 12:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788013041.git.pav@iki.fi> <178828980914.1804078.16309494402667039315.git-patchwork-notify@kernel.org>
In-Reply-To: <178828980914.1804078.16309494402667039315.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 15:18:34 -0400
X-Gm-Features: AcwNN1WFztdhSMMJqbHrXqV7ILVNhKI0HKkimevPHSu9KjLGWy9b396Ug8qfmXw
Message-ID: <CABBYNZJVZXd=JUqRyiS4mG9xRq0somG6pYHqrTbd0D=B6KKe+g@mail.gmail.com>
Subject: Re: [PATCH 00/16] Bluetooth: L2CAP: fix and annotate
 l2cap_conn::chan_l locking
To: patchwork-bot+bluetooth@kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	oss@fourdim.xyz, error27@gmail.com, elver@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Sep 1, 2026 at 3:11=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Sat, 29 Aug 2026 17:19:55 +0300 you wrote:
> > The intent in current code is that:
> >
> > - l2cap_conn::chan_l read/write is guarded by l2cap_conn::lock
> >
> > - l2cap_chan_del called with held l2cap_chan::lock (l2cap_sock.c uses
> >   this)
> >
> > [...]
>
> Here is the summary with links:
>   - [01/16] Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/de=
l
>     https://git.kernel.org/bluetooth/bluetooth-next/c/ca52f4764c87
>   - [02/16] Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking=
 helpers
>     https://git.kernel.org/bluetooth/bluetooth-next/c/368dc7fcaced
>   - [03/16] Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
>     https://git.kernel.org/bluetooth/bluetooth-next/c/86b377359826
>   - [04/16] Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
>     https://git.kernel.org/bluetooth/bluetooth-next/c/4e64bd587b64
>   - [05/16] Bluetooth: L2CAP: remove unused l2cap_chan_close()
>     https://git.kernel.org/bluetooth/bluetooth-next/c/c5123fddfef1
>   - [06/16] Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan=
_disconnect
>     https://git.kernel.org/bluetooth/bluetooth-next/c/02122fd80029
>   - [07/16] Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_=
defer
>     https://git.kernel.org/bluetooth/bluetooth-next/c/62df59925278
>   - [08/16] Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm(=
)
>     https://git.kernel.org/bluetooth/bluetooth-next/c/604e2f6d1e95
>   - [09/16] Bluetooth: L2CAP: add annotations for l2cap_chan list locking
>     https://git.kernel.org/bluetooth/bluetooth-next/c/886931f0c7e6
>   - [10/16] Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred=
_rsp_defer
>     (no matching commit)
>   - [11/16] Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
>     https://git.kernel.org/bluetooth/bluetooth-next/c/26836086682a
>   - [12/16] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
>     (no matching commit)
>   - [13/16] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
>     (no matching commit)
>   - [14/16] Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounti=
ng safe
>     https://git.kernel.org/bluetooth/bluetooth-next/c/761224d13f8a
>   - [15/16] Bluetooth: L2CAP: remove conditional locking from l2cap_conne=
ct()
>     https://git.kernel.org/bluetooth/bluetooth-next/c/2c127ee79a0b
>   - [16/16] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has=
 conn
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>

I've run into some conflicts; this is why some changes were not
applied. Could you please look into it and rebase them?

--=20
Luiz Augusto von Dentz
