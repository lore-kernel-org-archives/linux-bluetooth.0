Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859934EF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620670; cv=none; b=LQrGebBN6UEIv+8NoMkb32uxlqYolTqTGh66o1mCphnjU80DWfRVpxN4k8XIu/mgbamWZxeSrLDSuquAiKSTDTFR+FxP7w1DLzRtjo8d05WZWmq0/wFen8712YXMuSODca+mOsxw50bpm19Sy9iEUTDBF/j1JhsLpO+vGgxbNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620670; c=relaxed/simple;
	bh=MIgBcgeCPCt0/E7baL45B3avIfqJSNWzzGyn+2JKIT4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaNu9nvAW2PAe8mg+cReg28LV3qy5hadrERyuS0AkYn0MG7q/d6s3HYpklEGyeLra3MRxkVtiNEJ3iAPtxueMGki4JJz1Wz+jiysoCrkOd4NpLbKUccbjr4nVvqe1ac04o5wpqG+34IURbSRVft+oEzkMfRTx/nJjifCXxrIPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N170bCAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N170bCAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCF41F00A3D
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786620668;
	bh=MIgBcgeCPCt0/E7baL45B3avIfqJSNWzzGyn+2JKIT4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=N170bCAEoPmKVRCqVi7p43hphL+5Lc+pTZdSOukLcmObH62k3XD8Jh45etky31Yt5
	 1OqCWZjfiFmbhA03SOHGxIFRYEMzROh9fXTgbQGxwKLFrTrawcmvHSQ/FhwOduc+zg
	 i/isVWt7CFRHeAldEoNitfw24OIEkAr6uxIB23iWTWWZRDkRwEyM778Uyr2LgWUewb
	 XUTEy7NFZP91ePkvRqQfntFdCMBXsomvdd1bV+oqaMmVFAUQJMyCBxHhvEKGjq6H6/
	 Z36VZmSDI9LTTixpNWp/uqx2LeNQP24h0qP+k7AwGdtf574UIYfztPNuaX6PXhSwfk
	 BeNuP4wMBsTLQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39db07589caso5209171fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 04:31:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YySwZ2+mrYXK/f0rN9LMRZezePdSNWKiTc+rSeiAWOpvzEJA4Ms
	iRXp0VNdTSUKP78ZM8UB98z0xyGZJByCudYRagYS9sQ1NHxwUGhgVFu+TfS6uz18MU2HjKcC0jj
	C1/vxKMvxCv3xcK8rMTnB/0WJB7qcktNivyWnJQJLfw==
X-Received: by 2002:a05:651c:1986:b0:39a:da70:2c83 with SMTP id
 38308e7fff4ca-3a11a52c79emr6890461fa.7.1786620667629; Thu, 13 Aug 2026
 04:31:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 06:31:05 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 06:31:05 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <389052ce-6468-4968-98b0-c76ebc940db8@posteo.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28554782-1f3b-4537-b891-1c483a29e8c3@posteo.de>
 <CABBYNZ+3dd4qea4LZAXiEwD3MHkiK82y5S7RFE2EQzQx5jS+Rw@mail.gmail.com> <389052ce-6468-4968-98b0-c76ebc940db8@posteo.de>
Date: Thu, 13 Aug 2026 06:31:05 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mfpo1JNEpwvVg2OOAb73oEuoXLo-FL94khfYLJjxN11mg@mail.gmail.com>
X-Gm-Features: AUfX_myP8roE36N65xY_-xAdCGvsbBZY-c_c6lzZY-gtwnXHrc5TjhuYHc4JnNY
Message-ID: <CAMRc=Mfpo1JNEpwvVg2OOAb73oEuoXLo-FL94khfYLJjxN11mg@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: WCN6855 10ab:9309 stops reporting ISO TX
 completions during BAP LC3
To: Jonas Zunker <jonas-zunker@posteo.de>
Cc: linux-bluetooth@vger.kernel.org, brgl@kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 09:39:53 +0200, Jonas Zunker <jonas-zunker@posteo.de> said:
> Thanks, that makes sense.
>
> CC'ing Bartosz since this looks like it may be related to the Qualcomm
> Bluetooth driver or firmware.
>
>

Hi!

Thanks, Unfortunately I'll look at it in September at the earliest, as I'm OoO
starting tomorrow.

Bartosz
