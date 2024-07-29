Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FE8002E
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269928; cv=none; b=D6yO5cFxRbTkyy2+vnscG6UbW68BvDOW3d4xUvLywBRcQQQKJf/CcAVNWBccsv8VMvnzEk1H5mZIDFk+JNoCoOhqPuCto8xSm3tA+aP6f5uZtJSU1v6PrDPbkW8dW7lCk+wF4KG4O5sLi86y3Q0IIRRW14DVqhTiMEMXBIIJd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269928; c=relaxed/simple;
	bh=s8bEcS0ozK+7klzbUuiYWOTqErQZ1i19o8BpQT1ekdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBG/qqNUXloz6P1GdAslU0z3JfyIKhOCG6j0mb7nLOACLTnXA8ZGE8nrGiATLoDXzuE6zu+ioYIkKQuJwJT98A1L1G0I3D7W+QALinivoelPXlrtDAzFmRyPkE3cF1z8ErJx8YKR+nwC5rBQLhkWS9h6CgWajV3Ltc8kQny0y3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOHGC7il; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOHGC7il"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso57915941fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722269925; x=1722874725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AEXYmhh3nJshaznrQebnHPUzmXMqoED3ycKo+WCzdQ=;
        b=OOHGC7ilEjyYNgvwSTi12kMGCPBHEGAfTkGEacur06KEiJOuQEwKMLQBkJ2UzxdUFY
         2IXKm/MRhILDjkRqwv2fzi1MwKh1R0hmOpcCU4TspgqFUOdKHjV1hGLYoQnRbPR1fqst
         e5rZF2d9aAp2CB3dtXOQyK46CMQea1HeX+iltzEF5kQVgFyLSI1J01qlOdW74IfNxpSL
         tJE0SqgYODpaAXQaL4qeYQdM9R5xGFWI1+EMTwScfJtJSk9du9v4roEmPFgGsmYFv1NE
         Yy3q4bMDPWUxcWtQvc0PFmYFRnJxvSIjNXSphBlFhpYsWDv4jES9hnPFKsxSFyh98aVr
         fy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269925; x=1722874725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AEXYmhh3nJshaznrQebnHPUzmXMqoED3ycKo+WCzdQ=;
        b=ohHuPUZg9My8RkOHkyXEXLx4Azff3+I7+ermsuwiTL6MHJry3kbnvKtSzdZ0CBtnb+
         4SZHsnqWoXmFJsyseCYDgycKT2Ltw2UQMU7aBwTPRgXDaieoDrd1zfU/UU1ZpQx1BqYE
         nAgMCCOC/jV+RCF9JIsOLmwntoHQuaeaq7+eYFrn5NU4vTFiRqsnNsY3WFEPe036cA+/
         7AyC8PU+k05VlUjYEX5z384V1o32sklKCAGGM89OolwC8bnGcx64G2TnfUL3iT89YXaH
         H2fBxCRseixuqqzS1oVS/pAvyDxYGeAUbv8fMZ79yeK9mjLgIaeMWdKRp2DVw5ht5Edm
         nzkw==
X-Gm-Message-State: AOJu0Yzzn2jX4Gy5Sw7s2vFOFWDTX5eD365iVVTYSslj1C4HMfBrC6Kz
	+kV1IPhDYNl5N6r7nF5OUxWH1ry/GEE5P+t+8qc/3orMMqmxdO90kBgrlJCqaF/ssjcvUwa6pBb
	c3LNFG4+hqNAEAjkLQ0769cEDM0N+gzG77+8=
X-Google-Smtp-Source: AGHT+IFN5LFmudFmnYRRs1iGhE5J7AyoCATQ81lxCWWa3vp9bA0cLiOi9Zc3pUFodV+mlMPZU25WSFSNfr19FQzfLq4=
X-Received: by 2002:a2e:3311:0:b0:2ef:2677:7b74 with SMTP id
 38308e7fff4ca-2f12ee62638mr69580231fa.41.1722269924539; Mon, 29 Jul 2024
 09:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729155546.20932-1-anton@khirnov.net>
In-Reply-To: <20240729155546.20932-1-anton@khirnov.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jul 2024 17:18:31 +0100
Message-ID: <CABBYNZJvn73dWHqYCbWy614vCeUer7TQ6WD6koJFMMeWtpeWBQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: avoid dup filtering when passive
 scanning with adv monitor
To: Anton Khirnov <anton@khirnov.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Mon, Jul 29, 2024 at 5:06=E2=80=AFPM Anton Khirnov <anton@khirnov.net> w=
rote:
>
> This restores behaviour (including the comment) from now-removed
> hci_request.c, and also matches existing code for active scanning.

Make sure you add the Fixes tag with the commit hash that introduced
the problem, since we might want to backport this.

> Without this, the duplicates filter is always active when passive
> scanning, which makes it impossible to work with devices that send
> nontrivial dynamic data in their advertisement reports.
>
> Signed-off-by: Anton Khirnov <anton@khirnov.net>
> ---
>  net/bluetooth/hci_sync.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a31d39a821f4..e79cd40bd079 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3019,6 +3019,20 @@ static int hci_passive_scan_sync(struct hci_dev *h=
dev)
>         } else if (hci_is_adv_monitoring(hdev)) {
>                 window =3D hdev->le_scan_window_adv_monitor;
>                 interval =3D hdev->le_scan_int_adv_monitor;
> +
> +               /* Disable duplicates filter when scanning for advertisem=
ent
> +                * monitor for the following reasons.
> +                *
> +                * For HW pattern filtering (ex. MSFT), Realtek and Qualc=
omm
> +                * controllers ignore RSSI_Sampling_Period when the dupli=
cates
> +                * filter is enabled.
> +                *
> +                * For SW pattern filtering, when we're not doing interle=
aved
> +                * scanning, it is necessary to disable duplicates filter=
,
> +                * otherwise hosts can only receive one advertisement and=
 it's
> +                * impossible to know if a peer is still in range.
> +                */
> +               filter_dups =3D LE_SCAN_FILTER_DUP_DISABLE;
>         } else {
>                 window =3D hdev->le_scan_window;
>                 interval =3D hdev->le_scan_interval;
> --
> 2.39.2
>
>


--=20
Luiz Augusto von Dentz
