Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027594E36D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072080; cv=pass; b=A9SKWcOJsZaHyLQErBQSo9WWaXuAwUzfMOfi3vmOOV+0cLepvxbff5kOwHX9cJkbRUWUqAOzIxoPmr8dTbeN4l6XWuMuQaj1LEam5K6nPUYHfgJ3M/Nn/2arC9aITHXg6F/fUZCP/xRrdBnaMrpxlLodPMNeAr+z0+GPbIT6TKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072080; c=relaxed/simple;
	bh=aL+AafHZvOsGulzkqz3m9w2wFzipIqROE5U/Y/fmCXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIK1WSFYynxSCrRHGh/VxJmyzHY4cUoD2BOa4xEo8oEDVS6w+TpbekxhHkLBZQUccMdwwDPaOwthRyavhY4LP6GwgNmPpPu/q/dwLCk1MLGBl3wDFbZP73YRo27U6tI2wFQEPDLBrQK6zT2XOrzLLFrvsuGoWf3hvzrEAHztVws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K86JKnVc; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K86JKnVc"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ac8a2ac52bso56110377b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 06:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792072078; cv=none;
        d=google.com; s=arc-20260327;
        b=rrH8ISJaQ23SjYdgTTYc8pwHy3tujdpGsx75bSHKQS5ND2H3r2UTwK2Mg+mNN7lPwh
         rlk7jSoHV7a9CprwZ4LUcyk7nnnT+rsj+NH/XUmnaZrGiX+C4R4M//aRY5ijrjXja7zW
         i/5MIz4FVo1yXbdhQyNkMbyjghFdytphS63EH1Fxt+USjne8TZVO2T/qwhOwP0qwcToI
         aezHzsR9ZMnRYW9B27A9SsYTSkSDPJXeIs4oLDA7ytEXP9MjsvhOTmsCzLlAy2ucLs3j
         W7uzlC6Ev3VSCZlmpjSiPkPBgE3m8CKeRkSebG8It305hY8Hkl9g8HSeUKRlok7DshN3
         DICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zsThSPhIE6QGWwQEvDK4me/jRV2aNmYqF2LqA0tXlY=;
        fh=K4g8MVRvk1LSD/b+vcyA1+j3D60NYDVaQ55YSk1j0zE=;
        b=RBkch0CtuR6St8s/gvuSv+c+2+nmkqNyc2Up4hVRPplwNLhiINphHSwXOmHnCCXNk4
         XsFi31lT4XZK8fX1hg+uHZRP6Hx0OnQOS+dWiPtlgwFIJdI1hFqlB9So+oKnGYNmZRIf
         oicVZqxnIhbLq8k26VSC17sxHE6RQY2sx6c2+mw05j+yX5I/Dk8ySaV7IxAkuu6xZG3d
         /wEkA01bblgsmlV3BwEke3lw141kHdPUVgYywapnJR65fu9G3auBA9nozxJwMRzkvA58
         Vh8OyHWFprrGw11jMQW67bE55AZDAnXbtzBhGqR/OGGoV6ElA9fB9qH6mDu3KHDFCXj5
         9Z+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792072078; x=1792676878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0zsThSPhIE6QGWwQEvDK4me/jRV2aNmYqF2LqA0tXlY=;
        b=K86JKnVcKkvc0AUD+XGRgVBywteXrq+WYmAOxLAfDYXBdMW8wQCq7NKByeOHbyA59O
         +vm083tQFTT5+FYahRArW0TeWshzd7+9WRjhH93yjJY4YtorPu4KOOczTywWSZZk8xe9
         OdMOjR5/GucqTZSDi/I9sWNb6Kh67NPxWDu4qTyl3Life3n1PhpuYS0Ke9wWfBBXIvv7
         /P8NWQMsGlUliMrD8cVBpz5SVlvXaMS4wgRcSgogkdoG5byrDGV+TgNRQYvxCiSngIgF
         glp9oAxM0dGT2JjtRoq9Z/XjTQtuUejosiW7wI6sodPmzCLmf+Bh1kUZvS7S0/PTBWfd
         R5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792072078; x=1792676878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zsThSPhIE6QGWwQEvDK4me/jRV2aNmYqF2LqA0tXlY=;
        b=dAAVzluFD1HsUVxnw2vlTNbwAkWOaE59s1YihuSoazoF1Hp2z8IkkZHrQD3dM6yUeO
         59g9B0T7sunjCz1T4K/vhZ0z/6tNHPviPGBo65C0aUbvECJM1t31RVN+OQqTqFY4Ff+M
         8p7pD/K1Oz2NKL/EbuRd3pCB7X07TgD0Kl7bntCcAgiz5odAnxX8HHNfoMBi9y50fWPj
         qJPgKMLFRjRWQs/CrGPgc1jd+uisn7/FH8ANzdX/8rHvskAh4AxoNaJFlZd1KP/4GBKx
         q/5OSfKv4EVpqBuQZ0OFQIk+tYrRpE9wbGG9IME6bll+6DZJGxehOz52HDxILaCsPknY
         TPDg==
X-Forwarded-Encrypted: i=1; AKwUvBxIU40lJfXkfhBSYrXo4sdlHXJ88mqFbsXiU1PFNZjnqgTS3jBSUlqhgxuXn7W4irB61fFbnwtFwWQmCVbBrIg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1MZQx+kttCK1jktj6lAmRvFFQ/cNds6oKcBEJsqqChryddNZp
	BX+Gda8gTTi95+7bVaUSrZDpnd00OPJHGdXgOCyZPDbua0x3HcC2RkTedz7bq8o5LQrMN4IN0pv
	bianVMXe+BLT147EWDw/vWjhKKq2kEwk=
X-Gm-Gg: AYBFou0ZI74cDMTffVCX5bmRE4ztgw+dnpcOU4lWEGcTVj2qyhRz9dh/XEdyPYBotaB
	JhDMUSPmWGngRlHEOU9vRpvU3JEueN3PgfJ7hoILdN4G0VvP/hu+XzM5Kxxhe6a6KVUEKJuCMFe
	FClVHUdlpqrbv15JrJP5Hyia2+ayj9Ako49/NOPghm6mA4nv4TXxoJCyFo8D49TwxWdKwJm1eFs
	IA9RrJrxzPf5ZHZBNV7af/IXkrPPXuplnzNWpvUQLzwR3B0Oc6/Eu4yzw2JGsTefIIk+WFZn4Rq
	BFrypLNBL9ha61MOqZiPtNwnJFSEg2Sd/fmPAXfcv5f+u+x2+Km38eEPZZeAmvq808WTRocHptF
	akIiPe8+mxJQxe5ZkW2DPxSEsA0kuQmLtEUP0Ld8=
X-Received: by 2002:a05:690c:e694:10b0:8ae:b617:712d with SMTP id
 00721157ae682-8b0e2c154cemr221067b3.13.1792072077811; Thu, 15 Oct 2026
 06:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015081450.1241194-1-chris.lu@mediatek.com>
In-Reply-To: <20261015081450.1241194-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Oct 2026 09:47:44 -0400
X-Gm-Features: AclHuK-9IwK4gtIgFJ0IOoJ2ujxMQ8YcnWXIl-i3b10cUaiVlWQ4WrWnE6daL6c
Message-ID: <CABBYNZKaRo1SLa33mWwxE0Vp+3Wd=tJpvTFru-q8uraysdw4Qw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bluetooth: btmtk: fix ISO data reception
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Hao Qin <hao.qin@mediatek.com>, Wenlong Tian <ot_wenlong.tian@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Oct 15, 2026 at 4:15=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> Three fixes for ISO data handling in btmtk, found while debugging LE Audi=
o
> on MT7925. The code is shared by every MediaTek USB controller that
> supports ISO data, so none of this is specific to that part.
>
> Patch 1 drops the zero padding that the ISO interrupt IN endpoint appends
> to each transfer instead of parsing it as ISO packets. The driver turns
> that padding into handle 0 packets with a Data_Total_Length of zero and
> hands them to the stack, which is what fills the HCI log with malformed
> ISO frames, and a valid SDU is lost whenever handle 0 belongs to a live
> CIS/BIS.
>
> Patch 2 bounds Data_Total_Length by hdev->iso_mtu. The existing
> skb_tailroom() test enforces no protocol limit, because the skb head
> allocation is rounded up to a kmalloc bucket and skb_tailroom() reports
> the bucket size rather than what was requested.
>
> Patch 3 updates the mt79xx ISO data transmission setting.
>
> The three hunks do not overlap, so any prefix of the series applies on it=
s
> own.
>
> Changes in v2:
> - Patch 2 reworked and retitled. v1 only enlarged the receive skb, which
>   turned out to be a no-op, and added no bound at all. v2 bounds
>   Data_Total_Length by hdev->iso_mtu and sizes the skb from the same
>   value.
> - Patch 3 added.
> - Patch 1 unchanged.
>
> Based on bluetooth-next.
>
> Chris Lu (3):
>   Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
>   Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
>   Bluetooth: btmtk: derive the firmware ISO setting from
>     MTK_ISO_THRESHOLD
>
>  drivers/bluetooth/btmtk.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> --
> 2.45.2
>

In case you haven't seen it sashiko flagged a problem with this set:

https://sashiko.dev/#/patchset/20261015081450.1241194-1-chris.lu%40mediatek=
.com

Unsuccessful packets shall still be delivered to the host, this is
used, for example, to implement Packet Loss Concealment (PLC) logic.

--=20
Luiz Augusto von Dentz
