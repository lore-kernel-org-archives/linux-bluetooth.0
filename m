Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C30474246
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404103; cv=pass; b=NrPKtj5l6Ge5p42HPc9pe6u6z2VXcADYdHNax5JfxmiFoFy5KBcGOmphH42h8r4ndRS6euaE75MDWsJnH06WW0hjmkKxMnEVvZ4Ihgg0/xgxhx6SQowOr9JdC7J8xcmnircw+4ptnM+/d9zkm6Qm31ovUQnMII8RirJQM9iEsUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404103; c=relaxed/simple;
	bh=/q5dIhtpofhSE1m4oAHrTuiE9UJu/GiikLx6MGqPrkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELudxWB7U9w523FjAyVg6JqSPrzM2W8kYqv2K2ETJMnRJ/IaaVvyV44E1AgKzRuZH+8kMitRv4a00J+23mq5EPhw9f+RK0AFNsD5uWxo9ZsOx57FvZvYiCWNgeutx5ay3SngPnZyllDiw4Vxg8Z0auVtrMHyVWmHL8/1Q/nw2c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdG2lcsg; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdG2lcsg"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b89a0e69dfso2369244e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 09:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789404099; cv=none;
        d=google.com; s=arc-20260327;
        b=IJrt5nr2wzJ6vRw1/BW3oRwcp6X4RYWpfA6qL1Z2yW55nOpa4api711LCm/NpBy4kA
         GBtyD5/eqa6ROAoTBWYvyneifdWMHa/CIRF83weKR2f4k/fuvhDAxUpW8iHgc5/FO3EW
         mjPZcLmKRVQCjALSNq2znm3+BqbQm+LWS41fWfVpWD3Ahc8ilUc54osR8ck6dsyuZpHs
         jEaL1rE0R+3LrdkdspEmpyiqUi8J7S1vjCasZbKidZ1wlA3fl4EXCdqrJ6dDZ+A+4Uwi
         nbUu7fkrGMSuyGABLVTxvbfqSHmNJSvTLD/dTFvTPZTi4jR3kIQjNuUPFPk+EQX1S59s
         swIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5QBi1hlywv0v1qX0CmTELQD8b5TmnWXgJFp53lp3gw=;
        fh=FJbprF4ssQ31Afert8jlihG4yTX4LL61FUDd0A14lb4=;
        b=BlpROKR2uNJbhYTquROjpF2jqnKeOJp8w73OQ+HhNjqL9V37Ha6v4z4kxpayEfMgZK
         p090A1LB0ZuRwCV8s734PYPJvgu8A8QWAnxdqKbfV7CImhv0PLDiCP3ZYQw6ZCAA9iIV
         aT5lFLcGbuGmmx6i1oQSVwCtEdH5WRWc0aYHkH5rQTyvNVDfkvhk0Kvnx6dlPswS44ka
         znPRStFEcmd4gHXygkMVkFnupQxjnOn1tQE6NO0xH5nF6AKsBKAY0gi8ZgXo6faDwLs8
         gazyAAhEwsXe+GKdH0aRsJ+YbcLOwmpIsxarNKdmLpW/htwA+keN3T5KNIvPDNFpDs5d
         Khqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789404099; x=1790008899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5QBi1hlywv0v1qX0CmTELQD8b5TmnWXgJFp53lp3gw=;
        b=cdG2lcsgrLq8z3j5qKnh2oNQ1wncHd5/Nuw4dYW4Zm/4uAvLOzdu7cFINBnytL7BPm
         I1ZuI9+5OUmC3F1ttPDJAd464JVXcglkkaQBjsDB7EL0OE8sBCbcrOmHn5NOmNzbAC/N
         zWNxIIW+UWsgMpFkKHH2Q76iBv84oZww9l2w6cy9HnuVUYyUQ1YIf0JjpZweKcJ8Oad7
         nCOJDAT7LXtmggmJZu0bc9xGcQcJhEkNkfXrTAOaOTmnJChtDIUV8DKLp97iK9noamJq
         l+Egw+CWdISJnjECmPFs1c2kWkiRcv18WbMX55FP3Ks31urQGXsWp+sXQfaXpKD/ZJKV
         FoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789404099; x=1790008899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5QBi1hlywv0v1qX0CmTELQD8b5TmnWXgJFp53lp3gw=;
        b=De9qcEAyhCVMB5jUFa1suGUrhLExAPiVcN9KxqesgKOQS7XxKUeVTwS0A5BVB+kita
         A2y372Edjw4bADtwh6mxk/8XMR87MXqSLmakQ1wCSTqghoKLnaEDzgJHI5/o46g1aVRI
         KgWF0rr3pHi4C7l5r6hMaNT36+prME+4jiA18JrVX7VlqzS+/uhKwm4bLjTJbP6DmSHR
         STgNC/ajAv4wOzmByJ3NiP4qW3AuxAvd42vXcPucm8RwtrGZUil/ykPKaEDJxTECEZHU
         34/sx3GLJSNqmnlR1Xw6vk71Keevn1GlsiYucguSlhTHY8Ov5KoxwVidBNyFko3hTe2B
         NK6w==
X-Forwarded-Encrypted: i=1; AKwUvByMe17ca65p6U1TY3VJECXqNEF5WBdJ9QP+jMGX6DsxDmPlY/HIPvFk77FNR83mfSpZ+22R8Lgmp6K5orfpOtQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ngVak1gsDyY4aCktn9Dehl+n9EvNnlS0dZL/FgI6ETtneq3jTe
	8XVAVarPaIIfYm5e5vFdRPDlc4vZ3ZrculvEEpShH4TMSBQ5VbSKG6R0KDlpLkGcyc7rJ5oHEY+
	CT9LeBDvcrmOIVI6cGRN6xhO4x8gQ1NxD356IsFE=
X-Gm-Gg: AYBFou0OJCtz0t62LPUAKAKoBWJ97bMS3nTPU+J/mtSIQ6Js87Mvwl8ZDdKfXuoZ73v
	8miytSASnTtLRNosXTpFSY3o8y4aPIkJANj5Soo9YJinTmpVAs//jULEARdh15+XBfTPaPAi6aO
	DllQtG3lDBUwDUx0lEvEWTtK8p5qmTyn+WqCqKHNpNIWptHThD5Gxnja2IeuJveYoxY5IkY6hOA
	KKm4xJfne6j42vUglVIDD2eyA6oG06+Fg613ZX4BW+tPNMcs9YhHoq97ivfAclj8mQqnIHjfODL
	42+dzBivkHey7QTsOSciWEQCnc5tRwnoYbfwuPVcZ0E9FtBBpGUyjD4QkDYjz5F0QWgYfR6psPu
	clf1SXqMlkdT5I2hEdJa9kKUvNdKYeizKA7oflDUrrtM=
X-Received: by 2002:ac2:51c3:0:b0:5b5:e2e2:5f2e with SMTP id
 2adb3069b0e04-5b8ae66be2bmr1075835e87.18.1789404098900; Mon, 14 Sep 2026
 09:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com> <CABBYNZ+553teDOW-43qkf_TCyNr31LP8gS1vQ7YfKvAZ9UnzLw@mail.gmail.com>
In-Reply-To: <CABBYNZ+553teDOW-43qkf_TCyNr31LP8gS1vQ7YfKvAZ9UnzLw@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 14 Sep 2026 11:41:27 -0500
X-Gm-Features: AcwNN1VcyFZN_ANvu-LDP0KF6xMSQkAjdjBmvwmWiacirlX_7whxioI6fOHD5FI
Message-ID: <CALHNRZ9FeNaT65WTEJAe8H9ux2CtGVkdoL1-nDVMrdGi5mTxvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 9:13=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Mon, Sep 14, 2026 at 5:38=E2=80=AFAM Aaron Kling via B4 Relay
> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This patch adds the device ID for the bluetooth chip used in the
> > Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/bluetooth/btbcm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > index 463d59890befe..14acea7325478 100644
> > --- a/drivers/bluetooth/btbcm.c
> > +++ b/drivers/bluetooth/btbcm.c
> > @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_subve=
r_table[] =3D {
> >         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
> >         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
> >         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> > +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
> >         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
> >         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
> >         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
> >
> > ---
> > base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> > change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8
>
> We need some more information, such as:
>
>     Test log:
>
>       Bluetooth: hci0: BCM: chip id 206
>       Bluetooth: hci0: BCM: features 0x0f
>       Bluetooth: hci0: BCM4384B0
>       Bluetooth: hci0: BCM4384B0 (002.001.025) build 0000
>       Bluetooth: hci0: BCM4384B0 'brcm/BCM4384B0.hcd' Patch
>       Bluetooth: hci0: BCM: features 0x0f
>       Bluetooth: hci0: BCM4384B0 AP6684P CN iPA [Version: 1030.1021]
>       Bluetooth: hci0: BCM4384B0 (002.001.025) build 1021
>       Bluetooth: hci0: BCM: Using default device address (43:84:b0:00:76:=
93)

Sure. This is from a Nvidia SHIELD TV 2019 Pro:

[    9.802656] Bluetooth: hci0: BCM: chip id 122
[    9.808481] Bluetooth: hci0: BCM: features 0x0f
[    9.835172] Bluetooth: hci0: BCM4356A3
[    9.837341] Bluetooth: hci0: BCM4356A3 (001.004.009) build 0000
[    9.844428] Bluetooth: hci0: BCM4356A3
'brcm/BCM4356A3.nvidia,p2894-2551-b00.hcd' Patch
[   12.171393] Bluetooth: hci0: BCM: features 0x0f
[   12.198153] Bluetooth: hci0: BCM4356A3 37.4MHz Class 1.5 Nvidia mDarcy-0=
108
[   12.203520] Bluetooth: hci0: BCM4356A3 (001.004.009) build 0109

Aaron
