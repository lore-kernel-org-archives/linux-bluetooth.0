Received: from sonic.asd.mail.yahoo.com (sonic322-27.consmr.mail.bf2.yahoo.com [74.6.132.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E615746F
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358653; cv=none; b=VHDRDrhAmnvpJVzeS3clm4UEPX92uW31aSPU1Wj1zTBaYGt+GLw+y58MslHfSKjSP9yo+VL8qe2XUwLpvUXqzun/CWrr5YTy2D/zSiV+a9p6VWag372wgc2uUDKPiB7xRlpe7FgSNmvaSRZLu06YTjJ/kDqXp2ijhMOCjUDhRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358653; c=relaxed/simple;
	bh=p3dq/6LECgBPtW4YSuBsxTQ5pXSA/K/t+jhXwC7zITo=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hYaqIL4ZpQFr2xP8Dw5OLAPwMesSAus8KbAwK9Ugg4cLaZK803YgynopxJRFMPUkPphofdJSWPXBr8XGQzxnjkxr07tg93zVIfK7cJnv7xFqEFMBcc1wgKFXBPQ8KB9yuUZn1+mOVGJyMFqzDNRAkhmil7/TTBq5niEkYrPRGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gcnzqZay; arc=none smtp.client-ip=74.6.132.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gcnzqZay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754358650; bh=p3dq/6LECgBPtW4YSuBsxTQ5pXSA/K/t+jhXwC7zITo=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=gcnzqZay+hp7olT/8ORgv4yPv0oEt9EIKNilE6fvCAncnYTqFZbaNaDd2LxrY5JtESMCnWShQIzmZ6t4aHk5ZdMeQOmpiDZS9j7IyK8KiIcQZk+0to56Pj3Ya+RBlqVTMfep+Sbnit9vDTe6jvBb7TlnOAp1FYcqG9YlPJXVz2KnQ1+YcLjUPeDCvYv2Wh0EtaldtAxQRZVhO0MzHvaM5TO9uQV4k8HsybNu44jrcUS5X1xqZMPfAuEymIqQwQt4YSbsC2h49wuf7HaOjXDkYqR8CO3Z3/VvXZHknZfXwuwatx8COyqBVBdEG/JASJzg9HcnzyeYTedrNUr0ulmW0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754358650; bh=Ww6rrTWIXOILkTwSEpW5hzbCm3D228a3Z9k7F6sIbd4=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=jM+1rkVoQB4lCtmxj2ptKKkLkVrhnOgk2NDevch2UgAd4kA8GXTTFmjDMgrgcPVizZy8vbilxkGCz/IukJcQBi9qT3g16dGXnlzaUzPpxNliivdS3DNMQgSIus2nWCo8qTMVMgE//jLSB7WVkx5rCZ4gkZFhu3HTv4Y2dqkwhIjPCG8luFrc8Ptxyz0MxbM7yiFUIKFmVbB2xT33K8vRMtz4BV4yKB+2Ld/JEm/fDBxZ+jhBRoKfBedTxKig5vOcDm4xTzWOEVV5JYAERhqDb5jftTIpl+i365oHgykISyyqyQTHWsEQEhncWeCp68rnSVxcERM9JLsY8H4K9tK2Sw==
X-YMail-OSG: UCPwa84VM1kWCxswkHr_AKIQcFzCmrhZoyEpvxLKMgUulQxmAYu8A6ivRIyD8l6
 Psoy7x6DAsnJxBZsRg6OEWyo71.jIl7SzTigzXZyf_eRIm5Z4ziOjEurJkdKovjX60S3gXPnpBua
 De7RogNfe.XNt_6ImNMrwN0ULUiydNajOlN45Yjf5tfcwvyUp_30.q4i2xgzah1TXyS0HIwiIFVZ
 s.vi6BlLZ.zIPXmh.45I55SgPCrXUo78vzoZ_pQAA0oeqA2k0mV8zwSwj88YyOrQi01uZ.0djD08
 LjAeJnJbzeKq1R6t4H_ingJMOBD6x9ypWnzOEU_PXQItwYSEYUMWosiA7cTs4ZwMfKp365DZN1Nm
 sOIW7S9.HGGrmUHheKs67Nc2I49vdDZ39vZjpw.zJQEc23STt1uQkQEB7EqGLCB07bKTIhZ1PuYg
 1VRixtzQHECJ92G9DrOfntZlaViUut2wo7.k7Naiwhje.coTmtE9YfPN7H5yRLANPZ1qRORwmlja
 8beh2Ox6ie3FTtvHtcxPrYsh_nn2dBgjg1BXtfU7Remk1yBuzTdPCsfLzdiykG.PgsUm9J2f1QpP
 UJWxk_LDBbO8j4atTxfrhhlAX2.It1wslO_bavl35LMRYLWSP2yoUPFp_7XOHkB8SYPWLT77jpNA
 fQ089gtuHuidVI3d0.6CsCtxpfOdsJw0I9ED1COolNxuudB0daWe1Z3SbzKLgl_ECnhNDwyRZIL.
 Gw.gWmqEYABIMVKHqgxQEYSb98CUYhUnWRJz8Zq6Nnqcon1cDK8.rJejopfVnOWR4c.Q6erGOJ7R
 gsmGBnHpfUR9JJRcn9npHkj9rR3YUnjhAHAI9nLebV9DEduf1KLJ7S1kMAqZqtZzQQgIwrOZlIIK
 9by9E39QvXXkkgL.KB9cukvtDySX7xwHk617TulX9QU_IaUZ1.c9OpAV3.eAfqw7Z763Rd2xbIS8
 ecPlxgeqX3bA5U8MDmnIsPrOJ77PDC5MqKW.s1SeRdGA00Mo5UGUbrPwjtB3CzarGcNJjfnWO8um
 yINtxEzCYbNBGzECbF7aiJzN_L111_ec8NuPtnqkmA1SpjJZTodSG.N9sGAC7i_IrhJFjSYv91eJ
 uF5HZvR17HiFKAayumiiue_5CgFkoBbSiOgHFjw3QtKMobk2bPug8SRd5iYWUVk4ZHLcvvPB5UxW
 Q4fb2WxRvXlIku5dZSvku5d1AFtBzGE4nsffdf7Vd5pL2hFavpHpNjLD.7WULD8zYeSRjtyLK74x
 amuF04wDHDYKZtgt9fLchmAoXj9vl79Djd6sn2kt4tGNVgUKb.0eosIZHpwEKcNT.eDudkG4NytO
 NaU37y1fGkpngwsZ6mVSJEfvgCv51qTBfpvTeTqaNOxz4T8x.JnVTXCL6EflgOFUKWB2WreB0y_Q
 KTam1DNQi6nBSbPyQRrtlCiBGoLdiPXatDLj5Ykuf8ceTdzfjjbOUL4tkotrzfHfHtSsPFPVMxkq
 y.xpZze1IvQR2TfjH.Gmfmh.NswqFIAYU4ezJUzEJP43rqN.UkBjES8mVABOcvf0Z_9mwk_O3QTw
 tHnFsOI6Fk7Lw97CYl6IRMiTp4gwtRXtUKms3.L0H0ElUfx9rDJIjziM29Wx4sux3wObq8kFAUiZ
 n0vQqv.fMGoBgCTyAq0oIb4OdxtqWvuzxMM13IOfIyKqYZNGK1xjqKpj2_dJHUJff6D9CzV3BUo9
 eY1aWi2LkEr1MDZZ4flvAXLzrBvVhkabmyZyEYCv_Cjux00z88kBoOfgdqZ14EOZk_Uv3AlQmhwp
 gZK6zxGHVRR8lpXc._X63VPRJyr995OZu5Bjrl5yPuBEF7JGLhnvdE35DTOS5fg42hKV3dITV.Jh
 6LbOlYGNQ1y4NkNlIQMn1JX00xBYF0DMNZyGCUDziW1gBxmLaltKafjO0A4j70rix_CZlbI0ZC4L
 cvc6Eoqxznl9k2T30yaf54RomdJC59G83AzoL8SIRieokLJSRgJy6jxcfSJR7AfWDS_rQBz96TTC
 QSD_V1jlnFsKFi2ItGuCq8u9CcH9GAa792EVkVSUluxsjtxZiL9yqxXpUJK1ag73W8IJCNNZA0bj
 8ZzrJX4WYVCJ6Wb30OuBHrfQsoUA_H0GLZiZ.0Sy77Nj.t21Y4S4G8dBiowLxsYQ33ec9GQ7Ay3H
 FKTtYRZl8sx2AJDQibhg_5O9e3Nd0BSuwj5WN47RxGi_TTau4Axf.jMXmq5DDd7RajJJ2hTcEZvA
 hQ_M25EQ30vmTtUNeyc4y_6BYPSh_nFCD_dBoQvnUK4MkrCniqSlQH72wKFMP6mhHaFd94io7gCu
 pyZ71AUzcu_FQRU4EnlELPyePgiz5D0Sdow--
X-Sonic-MF: <sunstechlive@yahoo.com>
X-Sonic-ID: 2861e57d-30b9-4d72-be3b-0ae8539ba312
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Tue, 5 Aug 2025 01:50:50 +0000
Date: Tue, 5 Aug 2025 01:40:39 +0000 (UTC)
From: suns <sunstechlive@yahoo.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <742340634.1050712.1754358039006@mail.yahoo.com>
In-Reply-To: <1929589719.1039587.1754353192826@mail.yahoo.com>
References: <1929589719.1039587.1754353192826.ref@mail.yahoo.com> <1929589719.1039587.1754353192826@mail.yahoo.com>
Subject: Re: Pull request #801 for MIDI bluetooth more than one event in a
 frame.
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 YMailNovation

Im not the developer of the solution, but the solution works really well.

https://github.com/bluez/bluez/pull/801/commits/64f48d1f45424ab6be05c7b686804ebaab0bc4e6

It points out to issue #471:
https://github.com/bluez/bluez/issues/471

I was trying to fix the issue and found a solution already done but not on main release.

Not sure how to proceed as this is not my code.

Regards,
Suns
