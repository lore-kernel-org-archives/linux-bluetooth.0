Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B930FF36
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446937; cv=pass; b=Dp4e+xA9FFRvmdsI0dzkwzfcHymLcYnPf3RgdVmw2KODzm4ZKEvn7TR7mi9XjS/vzzOlNSZoXIkmMmOLdRGmDVlvszCtYJxzMqGbGr7uepBbf4wO4Bb9Erpokn373LUOUFCDeXkAI9UGh3hl+ffznBHCbtgPz0yB8QmAYpBShvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446937; c=relaxed/simple;
	bh=El+6zEQwLOSa+TgE2+LLKllay5j27lfEOkXOvO+rCVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JATL+JwY9OZ/nvIcymN5XOF84z8G0eRC0vtpJH6yXfkiW5nPSnHlZqRNjPBLRg2bPKfLNefbxprrQyNnTX30qeV/pma+WSTbl2ewvmmvIKbv6bZ3TLF+TczaQrWUqnziSu9UXo9KPyQsBXWRHxmRvCCdYuwJ7PrhOhZ9Z3ZfFqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=KFcSsDkW; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="KFcSsDkW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2757975a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 10:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783446934; cv=none;
        d=google.com; s=arc-20260327;
        b=BImjmaN9Px4cik0BwWi8vLdLKYTMIqf3uiIqGkDJIMmKSYqpPlDfvDFXVuYGrSp1p2
         SCMbeH0R5ZYMVeboqwE6xZLZ+dj086MryO4Piqe5B3iFi6flnfxP5eLbH3ataPXTpF4l
         r5FS6v+m5tRPEND4oo/kLDm5JKyp7nK9B9fJDtvcCYMtK3QO5ayUN3si1REa+spND4C6
         9kmASgLFweeMCTn4x7rQRRiSCvdOeLiJMON4FhJB5AtvLA2PvVCLt/uzf7S93e+TFynG
         NexPc1qpbjWNovUXL6I1FU+zL9xmaAihMf8FmjbsJ/qbPTK8o4V1VgSYrLLdtBq4/Dee
         yWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hHKfP8oj1BZ9z0oh3w87XvE4No9eddk/rLmkeC/eOak=;
        fh=bapvQ3JkMica6lw9lXqG9l8FqqLj3/3T0NWVufznYGU=;
        b=i2J0fSpPckjvHyFo35FImmjHk2bbcRKOkgPyQxfsingHSN2fM5cKkInV1GFoT0AiL3
         fAyRHd33DJQS+0yrEjc055bwKIwop+GCRJ07499+ImQo3D31H6P+2+I9ksR+F/SHPtwD
         3N77JaSY0LLTf79r4wW/IzUr0xQhpdml24vhqQ+m7zBn7O9ffntbTGL69M4PMGtyCRYw
         zRNr/paHeC1qOl3q9Pc/Bbdu401zsTPAbhvYf1JuqYFpfVbcO6tWUpGif+VBxYypOuRV
         PTfQfg3bJ+UhijtBLEgCGiKzFEiEQna2mvy1CmThX/DaiD4tVQHTWdk/owy7UsQdRAEP
         /9WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783446934; x=1784051734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHKfP8oj1BZ9z0oh3w87XvE4No9eddk/rLmkeC/eOak=;
        b=KFcSsDkWQu/v6KMB/ZmsZhiFenacBlRMOcNxCsTu9NwOdcT687lCVU47ryPUq4PI59
         k2alWEuVmUI6NQH35Kj/gYh+ONS/mGODIVu7dtvkMpqbewa1rg68KyzS6L3Hx2HwgaNM
         JrnNrxSb5/paos539MgSdnJOPfSxp54h42s4ubewtJK4enWHuZ+4T1dNrEs+NhBDkGd/
         XGogstbVdwgXiIsTgNHEv4jcqi2uHl4pLDgjfenGsUzYKCp7ESsxPhdYKqAZxSCmgtmd
         P9ZAnZr79nk2ZrAH7WiTYJ1TPA9plOtQsZrlzPmAK3cR8/pmx+4/JZkcQXSbbiZms3Zd
         u2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783446934; x=1784051734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHKfP8oj1BZ9z0oh3w87XvE4No9eddk/rLmkeC/eOak=;
        b=UUY/sc4mz/3ZgdHbmD5haGem0CX8ZCHcfo5E84vG6bJ04Eb9+WQ6nFmOQo9hX+YDwL
         90kCgOiCvDv7LKgogapmkoOkQoNQllfbktRsGtPSxqVfSrVGO7EZYEVQYzlx2mOPQ6tW
         M5ayGVHkPLA8A4KWdMRTv+Oa0ixTQjjtmWRhF3sCEYhO3gGOL7SMYDB8PmT+TU6xgBWV
         vNoup3N2LQMqeaAN2aQLkJ/xoyspsutptZaEyn2zPhddCnrbr2kkAaw9c4e505dm2Ay8
         tBSlqVC8r4OR896PwyjGwT49uzOae7krXfzawiFbjIt1DiRYgj5ja095mwrKBtETj4Fj
         l91A==
X-Forwarded-Encrypted: i=1; AHgh+RrcoeCiIysuJPnaIhgBC/dg+8TQBbfFoYh5R4ehJKMJq5jA/fAMR4VneMYfThxTAKMT2auSWmlFVbuCrDyJOiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqgPV0sGssMDveFQ2Yv+LBFezOIbzytuy6OMztZnwmwIqSVMn
	5SHOOPaceBvGMC4vnoiK0GruDi8JaD8IF+AYLjkYNZVML/bSw/TKXLWeNy+meFj51m7/tS6o0Mt
	Vf695WZAtK1plp3UgVIxqyfidLq5AgNrv9Z8POTZy
X-Gm-Gg: AfdE7cnhQqJtq8oB0M6/uR/qiIrvbdbvyFHSqeA1emqhkox1Rg16TbOlw9NrAUomNj1
	4oSlSpPsMFLZ29x91Eht44x9SnOPTbKtVhUAr72iXsyLxSVmHujt8zJwdZogGlFXalQnalRAwrL
	t715hggDCDI23i00sYW/YD/boA8zfnlmCNYpz8fnN2z6rwMpfBhNqeIiXXCVbVLGLS5nr+sWi0N
	OuB6kQmUBC6lCya9lYsaW24rGhnCuOqmdRHpTGJ76MXbrKn8JBAZ8N2LpeZxJ2arCNnXwvwAdf3
	AkBelFuChFolu08gAqsfPMr83DWB
X-Received: by 2002:a17:90b:5683:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-3875298135amr5775693a91.0.1783446934282; Tue, 07 Jul 2026
 10:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704231030.996390-1-xmei5@asu.edu> <akomrM-h521h6M0i@hovoldconsulting.com>
In-Reply-To: <akomrM-h521h6M0i@hovoldconsulting.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 10:55:23 -0700
X-Gm-Features: AVVi8CeyDOELnQLhYza0h8Ux8ZBnaqmsJuMa1WcfkwDqiuTGYvKnH3dWqGykmb0
Message-ID: <CAPpSM+Sph2Drdv_HxKTkfkHP-qDPqrRHYQ9eaOhJ5YGE-5cKYQ@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow in
 TLV parser
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Xiang

On Sun, Jul 5, 2026 at 2:41=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Sat, Jul 04, 2026 at 04:10:30PM -0700, Xiang Mei wrote:
> > In the TLV_TYPE_NVM branch of qca_tlv_check_data() the tag loop bound i=
s
> > "while (idx < length - sizeof(struct tlv_type_nvm))". "length" is a sig=
ned
> > int from the firmware TLV header and sizeof(struct tlv_type_nvm) is a
> > size_t (12), so "length" is converted to size_t and any firmware-suppli=
ed
> > "length" < 12 makes the subtraction wrap to a huge value.
>
> Yeah, there should have been a lower bound check on length before the
> loop.
>
> > The loop body
> > then reads a 12-byte struct tlv_type_nvm past the end of the short
> > vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past=
 it).
>
> No, only four bytes are read before the loop exits without any further
> consequences due to the following check:
>
>          if (length < idx + sizeof(struct tlv_type_nvm) + tag_len)
>                 return -EINVAL;
>
> which is false if length < 12.
>
Thanks Johan, and you're right. Only the 2-byte tag_id (and at most
the 4 bytes of tag_id/tag_len) is read out of bounds. This commit
message overstated the impact, and I should have caught that.

Unfortunately, the bot merged this patch when I was preparing the v2
this morning. If you think the inaccurate commit message is worth
fixing on record, I can send a follow-up to the maintainers to correct
the message

Xiang
> > Rewrite the bound as "idx + sizeof(struct tlv_type_nvm) <=3D length"; b=
oth
> > operands are non-negative, so it no longer underflows and a "length" to=
o
> > small for one record correctly skips the loop.
>
> This works too.
>
> >   BUG: KASAN: vmalloc-out-of-bounds in qca_download_firmware.isra.0 (dr=
ivers/bluetooth/btqca.c:421)
> >   Read of size 2 at addr ffffc900000e5004 by task kworker/u9:0/52
> >   Workqueue: hci0 hci_power_on
> >   Call Trace:
> >    ...
> >    kasan_report (mm/kasan/report.c:595)
> >    qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421 drivers/=
bluetooth/btqca.c:617)
> >    qca_uart_setup (drivers/bluetooth/btqca.c:948)
> >    qca_setup (drivers/bluetooth/hci_qca.c:2029)
> >    hci_uart_setup (drivers/bluetooth/hci_ldisc.c:438)
> >    hci_dev_open_sync (net/bluetooth/hci_sync.c:5227)
> >    hci_power_on (net/bluetooth/hci_core.c:920)
> >    process_one_work (kernel/workqueue.c:3322)
> >    worker_thread (kernel/workqueue.c:3486)
> >    kthread (kernel/kthread.c:436)
> >    ret_from_fork (arch/x86/kernel/process.c:158)
> >    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> >
> > Fixes: 2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity check=
s")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  drivers/bluetooth/btqca.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > index 04ebe290bc78..10c496eaea2c 100644
> > --- a/drivers/bluetooth/btqca.c
> > +++ b/drivers/bluetooth/btqca.c
> > @@ -415,7 +415,7 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
> >
> >               idx =3D 0;
> >               data =3D tlv->data;
> > -             while (idx < length - sizeof(struct tlv_type_nvm)) {
> > +             while (idx + sizeof(struct tlv_type_nvm) <=3D length) {
> >                       tlv_nvm =3D (struct tlv_type_nvm *)(data + idx);
> >
> >                       tag_id =3D le16_to_cpu(tlv_nvm->tag_id);
>
> With the commit message fixed you can add my:
>
> Reviewed-by: Johan Hovold <johan@kernel.org>
>
> Johan
