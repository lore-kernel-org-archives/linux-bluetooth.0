Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACD246BA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890752; cv=pass; b=FfA4dAEVjX9MvFtodbRjqHUGZGkHZB9qoawjVkufjjUjsw0yODa3NaL1b6u7ZbhJwuURj4rKcRRtjl1HLcaW3xJJGF+G3QQyKwtfFXwgIww3EQ9IxPYHaYZos65TP8V1hzwfg7FxdQP7B1ppjxmItMonSf8QJ7ksk0t6m/C2B98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890752; c=relaxed/simple;
	bh=EDjnF1u9l3vAHBZvIHYz9qzZcFN4ugQNdHGN7OSSrgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyXZ7jpa8MCIc3i31oeLmYR/0uruAqx5IdyvRmZm0XQUc/WoZMyKL7qhs/+jl7/VJ2BitABy0vSZiOG9WCtFCo+FioNR70OGtidjgUIWpSd6/LGidOmtCh10CqvDClkmIwG47Eh+YZPsxfX0pyo+Alts9krsmclXjpWAgwN9euw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b=sWfx/88O; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b="sWfx/88O"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so2868951a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 02:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770890749; cv=none;
        d=google.com; s=arc-20240605;
        b=lKmo2JRZk0O9DiB/QGC9prS0/75cdYqXHnjLQZ4CrkKSqaIa1A42uRYLK6MyHOL+7T
         D/nhtd4LlRnbEYN6at12l27RD7cmL49dQbZjzRbCfB91jXB87VLvSUInaGj3+Ljtgzts
         Gj/D+yHsWqHq00FA+LMdj5H7u6RadABqM71JBzxCByfxZL2eNl3uQMXFWMM0xYUFRBTL
         acI3dB07srTA0MiDFFgTyVTqani1iQ2X/+JQptHYv8IqPL6PO5Qry4ORp1UAUVM1yvoW
         cJ5JfzJ8o6EzNMbXoK5NB45bX/4cfKlLZ3JxbFxhKXeWo+nnhNUIFzGkBvSVJi4+K2Vg
         +guA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EYzoWAptSrn0hzEAdTb6C3SqrnjOlSOCeo1GjNhOqjM=;
        fh=zVS+1flyQdn8NMu/zMaB35VmmYPlKiumV2GeuCFM+wQ=;
        b=QJ1uNYr5CT8KFzVLdSLJBxnBbuldsVGrYzlAX686umADYKXG0BQyujPrB/QVU4bSBy
         RFpx/3py5lxN6iEbxShB4IzUT9mndosTh7PfnVmB/v9u+JV9rAVdzTGEQ2J2riHtQouV
         on3eqcrBGZXa4AXdfXmtBpF0sx9IVyRoFIDP1HymMElQImdijj9C9KrYeF2976wvtXW4
         19M1XzU/P6LmHdXTECVTiKyt1nQrujOJreAcLRq9NhN52QSEYoDIrzuBB8WJX+8bq2pb
         7QACUjKFnVybIfPIPYxEwzGG76lHP0WVI90eQXXtKSo+EF45RyKYJ425UxBBpniWHwcp
         0Fow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup.pl; s=google; t=1770890749; x=1771495549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYzoWAptSrn0hzEAdTb6C3SqrnjOlSOCeo1GjNhOqjM=;
        b=sWfx/88OIvH3OoMAO9QcomJ7Se/TuKTxHvmMovxnsEuvzJwRa45qJlls9LYZ1PohQC
         VZkTomLBSlyrj2+8PD1tnfNG8l2p29T1EfkpLlcqZ5/SgGqYiwZtNXlyccfj+haGJVu3
         d0fAuNSy6R9MXohl7eA+/WKAL6hQ02fSeMJtdr8d17i+Y5+cVoEHBI1xrhNzOmUulDLu
         +AWsy0/PAUCBMZJeeHILYf9OFRFziMBxTF/A05DI4PmUgr79jCw8gmC8eniHeAKy62pj
         dGb3Tei1oP4zMcdyceZo1tjK1tXTfro+WZvAJ2PQThesg4A3y0PkOm/v1a1Q6STQwCWb
         oygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890749; x=1771495549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYzoWAptSrn0hzEAdTb6C3SqrnjOlSOCeo1GjNhOqjM=;
        b=kgVU7t3I2eThN1xmmFoDeroypNkYq8M4+ypNqW7uJeh9opqfDte+SPjZzuIapZSnbB
         D/ToCVdwBD16JUYe0HCFY8Barrlz0J2EjexD+GOEc5vDNyhWRylVRu3Cr7H8QCAnxh25
         VsBHMJE1g4qkJbVQBGMUnrozWBdXvRpHKnNPHWdz2ffEFnv5sHbyNbJpRUV3u5ogh3TW
         XxiPe/LXuSFAJ0TuTuETxg4pVNig3rxINGWizITCTZY0FrnqHNbInh9XAAr5hQBy8Jnj
         VOwjZyhV697S146Rtbekdmijj7h9y19KEJgTwGlgR+DF9MCl7WGix5izl1gDtjWLXFvu
         hBsA==
X-Gm-Message-State: AOJu0YyYln/7Lho8emNx/WbFE852wBJCwHzDMt22/h/l0i973YKUD9k7
	uzVm3MRxwDcEM93zYCq28jsyHFDGLYNH7RgMG5k0U6tt33OIrMsqpqds0CFIhAgZXSnXhYQY4BD
	ATuUcjMKmf3CtB+qzbbwt0CiFLAU5wzzpSwkgmiKQnA==
X-Gm-Gg: AZuq6aKscRg0AFSLoxffj/rf0FHjGW9CIqChIO1rrD7F9HuuopwYR+iQLdzbu+vC3nk
	iXXIVZTXfWW04fUm2/gzPI9et2qf+98+cw0rpjcFNOUfUh/VD1dCQMkZGYrgNYEPY3sE4WxTuGA
	VvXAeWFxAHwa1CE9f8B3phHMngF0RSYzUOzx/Kc4lBSua12mCXsHsioUQcI3RGG+dRKuAkpl5l2
	Bmv1SfPUTbZdNHh9+9ZXMBeUmnXf/GE7EcVuZtxO391TQ0tRaQ4ypsePV2tw6L0ytalvN3PSUy0
	7MXAGTY=
X-Received: by 2002:aa7:d1cc:0:b0:65a:23e6:ae60 with SMTP id
 4fb4d7f45d1cf-65b9bb4b294mr818559a12.12.1770890749569; Thu, 12 Feb 2026
 02:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212074111.316980-1-mariusz.skamra@codecoup.pl> <18fca2c1-c35f-4624-9520-7425f99e7781@molgen.mpg.de>
In-Reply-To: <18fca2c1-c35f-4624-9520-7425f99e7781@molgen.mpg.de>
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Date: Thu, 12 Feb 2026 11:05:38 +0100
X-Gm-Features: AZwV_QhnQjBNflRqHyyHaTK4iq73pbNThK5NnLH59XbFzchYhQTzg0VVXg1xg1Q
Message-ID: <CAJq99ad7YJ2zNZFZnDHbUpghbrOGz0r66Y492z=UTFqdjE1e5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix CIS host feature condition
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, 
	Naga Bhavani Akella <naga.akella@oss.qualcomm.com>, "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Cc: +Luiz]

Thank you for your advice.

czw., 12 lut 2026 o 09:16 Paul Menzel <pmenzel@molgen.mpg.de> napisa=C5=82(=
a):
>
> [Cc: +Naga]
>
> Dear Mariusz,
>
>
> Thank you for your patch.
>
> Am 12.02.26 um 08:41 schrieb Mariusz Skamra:
> > This fixes the condition for sending the LE Set Host Feature command.
> > The command is sent to indicate host support for Connected Isochronous
> > Streams in this case. It has been observed that the system could not
> > initialize BIS-only capable controllers because the controllers do not
> > support the command.
> >
> > As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
> > supported if CIS Central or CIS Peripheral is supported; otherwise,
> > the command is optional.
>
> It=E2=80=99d be great if you documented the BIS-only controller you teste=
d with.

The controller I am using is open-source Apache MyNewt Nimble.

>
> Also to easier find your patch in the history, I=E2=80=99d find it useful=
 to add
> the log messages of the failure.
>
> I think you are missing the Fixes: tag.

Should it refer to mainline or bluetooth-next SHA?

>
> Fixes: fe05e3c0593f ("Bluetooth: hci_sync: Add LE Channel Sounding HCI
> Command/event structures")
>
> Though this was just merged in this 7.0 merge window.
>
> (This seems to be a common mistake, and was fixed at another place in
> commit 5af69ab9bc62 (Bluetooth: ISO: Set CIS bit only for devices with
> CIS support).
>
> > Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
> > ---
> >   net/bluetooth/hci_sync.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index f04a90bce4a9..0b0dc0965f5a 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct h=
ci_dev *hdev)
> >   {
> >       int err;
> >
> > -     if (iso_capable(hdev)) {
> > +     if (cis_capable(hdev)) {
> >               /* Connected Isochronous Channels (Host Support) */
> >               err =3D hci_le_set_host_feature_sync(hdev, 32,
> >                                                  (iso_enabled(hdev) ? 0=
x01 :
>

Looks like the regression was introduced in 709788b154ca
(Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings),
while fe05e3c0593f ("Bluetooth: hci_sync: Add LE Channel Sounding HCI
Command/event structures") only moved the code.

Should I mention about 709788b154ca or fe05e3c0593f or maybe both?

> Feel free to add
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Sure

>
>
> Kind regards,
>
> Paul


--=20
Regards,
Mariusz


Mariusz Skamra
Senior Software Engineer

Codecoup Sp. z o. o.
Strzegomska 138
54-429 Wroclaw
POLAND
www.codecoup.pl
