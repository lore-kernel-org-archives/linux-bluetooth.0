Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005F17C7B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175860; cv=none; b=tjNhSNQhcxHbd1DNa0XVlnRP6Cq6SsgsScHcy1nTR5JlrLKYfuym0Ko07ZSH5jO8IQH17z7LJjO0cCpSUpCHAz2Cg0VM66y2lshQu3KCJasCA12TGEFwlqt+yYFt5SdkmQh6d94zX3I71N5MIlTkk5obriDL5Y5t44LLnVfE6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175860; c=relaxed/simple;
	bh=vxm+D4Vma6+LOr5JUg9gt71NcFnX4tLUX5AKFnsK1xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtQ5B/Vt6nrq9ECJBOD5pAHpK5k/On3xyc6YlQDM9qh01HfBVfaZSakWvMqIFAcSN6ZcM/29RCzNxAacxsS0pdeyQmf84xvUgIJTtTfXwdYZsY2oDPYqyJBevENbVlQqFIHt2Cxe+mGG5nxw/U8pcTusED8tTAK7puY+5TDFkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT7nDasn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT7nDasn"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ea8fff1486so13160351fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717175857; x=1717780657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOaxlcqnUpYqcx26j++GDsSKWj68SWxWl1UMC+K+AXU=;
        b=XT7nDasn11dm2Tbw8xjLyQTCdqBmRxPXrWDgpSP5U5IXRtelNZisNvctamktintfmS
         G1/uEhK2K01OFsNt/DbqrEznORyb5Y8S8Ot5eLvi30jBZ6gdAkUSoRpCFSgduEOTICNt
         XkbCuslwb4fL3/1OMUXHNUW0or+dR2bIhjpFhhTT8Ma1p2iWi5adJN7gjEkfUnrxWOyO
         20mcGc2+z/4nBAbDNN2NbL54q5quFAPvaQBy4j5rnUUe770+V6DPPEqtr3kGyn5Xvahq
         YfaRJTz72yZu6PiYCHac0G4X5d20Jg7g43JcuhxAPKsx41yUB40sN/gYN4Hc0WLwzsw7
         ZZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175857; x=1717780657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOaxlcqnUpYqcx26j++GDsSKWj68SWxWl1UMC+K+AXU=;
        b=aBw/xXg4wz5LAeDeB1W4tn0f+Kri3Y7vmu2n3NqpFnJHlxYRWRNwF73qzOYNIXOm7j
         /bnIU9XDY15fGxgoK24CuzB652vf6YI69TW/S+oovTVoJAOHSmpxuGds09YbcBsobwNZ
         iP7c/EJer7LB4RV4Ef5feicrOdOnqXEAlCyYSLORVXDDPWj3fTkIq066KRw2sdRvPKAO
         9XwWErNfZ55WCeA0YvmPjmMMDmKuSWZluygsXgEhHLrAUzi0ZHOHUHlRih8w1GfRFM2N
         7L3JvfuA2glARqltU96HgLwwPzSaG6ynDi/YfkMMrsPI40Vl4MEG92BqpV+qb0fIgTRU
         kc8A==
X-Gm-Message-State: AOJu0Yx5WkWupuuJJWlqq0lq5bs3klZ+gSyT4oquLgV2ZtRkwPuooRut
	wla4DGWg3mQnIVc0i9k6q3ZaQCUd6kN9JPUOtLldI9nXOsjIDn6LqDm2xIaBec1ClzbSvtXS5gr
	UoLvgS1/gMbGD+w0NBQzVgIzWBogZIA==
X-Google-Smtp-Source: AGHT+IGEI8QGPM4WfR0IE34608F1p8t0OvO4YxFPCfahXay3StiPb+8Ain3Ne5XE4zi9VFgxIV8pvvjuV71ez64vTzo=
X-Received: by 2002:a2e:9042:0:b0:2ea:9bf3:d139 with SMTP id
 38308e7fff4ca-2ea9bf3ea1amr3215471fa.19.1717175856496; Fri, 31 May 2024
 10:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 May 2024 13:17:24 -0400
Message-ID: <CABBYNZLUKCdrHd7tH8ro8AD1ERAph0JPm2FxeUdPcsKSrR-cdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/6] Add new BAP BSRC/SCC tests
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Mon, May 27, 2024 at 3:54=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This patch adds BAP unit tests for Broadcast Source stream
> establishment (BAP/BSRC/SCC/BV-35-C [Establishes Broadcast] - page 175),
> stream disable (BAP/BSRC/SCC/BV-36-C [Disables Broadcast] - page 176) and
> stream release (BAP/BSRC/SCC/BV-37-C [Releases Broadcast] - page 176).
>
> This patch also adds shared/bap fixes regarding broadcast stream
> management, required for successful test implementation.
>
> Iulia Tanasescu (6):
>   shared/bap: Remove DISABLING case from bcast state cb
>   shared/bap: Fix potential stream access after free
>   test-bap: Update bsrc_state to just handle CONFIG state
>   test-bap: Add Broadcast Source Establish test
>   test-bap: Add Broadcast Source Disable test
>   test-bap: Add Broadcast Source Release test
>
>  src/shared/bap.c |  26 ++++--
>  unit/test-bap.c  | 210 ++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 186 insertions(+), 50 deletions(-)
>
>
> base-commit: 75893035705da57efd6f8a84bba77d596c463d34
> --
> 2.39.2

I'm off this week, will review this set next week.


--=20
Luiz Augusto von Dentz
