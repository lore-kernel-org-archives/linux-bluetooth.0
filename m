Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96E2BEFFF
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953692; cv=pass; b=PdAHm4wwDIHtoaDHUPVfr3b+LwrAdU1b7b61VFWxH9G3J67te5ltpPO0hkP7RKoOzzQx+/dYK0oxAPbahnm5es2Trs4PA8IxqUs6m0nuAub95ffYUY2LVvZ245sBWKOCvCkgZOO6e421nNxuP6ZGppYf5ot9f0MG/Q+KkBD3ExM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953692; c=relaxed/simple;
	bh=yS2/glhdhd/gdDBKE5UgSGKMLuswIRibTzoNlH5FNTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sodndL0AzXSQbs5yZ3Fa21bTvX45Ww6jurJJ8tsOnWReBLeGA5z+fowZT9Rk/xwdQLQIY91VVPITglNU2L5fpcliZyOOk4U157nE/D0kXYMNGculfkYlLba+vqdOEClc2Ki6i7TDEpYDCKKmKPZD25CwQklHAA1YbqM7pd+3Zqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ywbrHz; arc=pass smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ywbrHz"
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-393800f638bso93610651fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 00:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779953689; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3n/oHVxyHO42VJnPM69RcTzYxAZiwY+Vap9zA1q+wuXNu5nxfAXP55NYeHdhF1sax
         7UEQs9PK6F5KvARviLIFl9PnNn8yWTCDb9zq2eBw4Nd//oixRBsvmyq4UqE8/p28AFb0
         EhGH0hIz2qmPVVIF9EmAujjNjheQVwvXkGZFEASplk5wnvFS5HgXllbxYLTyrs7WCZe0
         GJlRJcBNCHQPoG//bs0T3RfCpNH6uAUjKqAnF6qUNtQKeOMNHJnkdxzG/cdK3GGVgCN5
         DJyjhj0nPnrzXclBWjrsVYd7gdTiA4LECGdVQUswZtIWsHwaGFSrfdOVqQqGbDxLfmJX
         crhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9H0vRKH8/H6W569Razk1c/3WxccIg5kDgZBhCKkCsIQ=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=i6CJyS/1UYoTGb3hmJIRDRMSbBImWoQatL63GXdhhyu2z+00TRSX+WM7lqa4wIwi/J
         aqWUlH4fBNteVMGWKh/C5vtQC+kQfdKbNSsz5RFNWKjHJbK5NigdSFG+NtT/GoXGXaum
         V/urFswvx075kWBjFuXWu+3ab26koTwnO78uWQDfOwXbpdzUy/vlvX0NHEWm4CK+FAtF
         nm1pcSTbTycIclqsPofl2t3gxKkxS9eOqD5G46sWdJXjSZa7s1/mjIx33ANOsudS0z2w
         l0nLgnNP+TLxxOTs+fI/ESFMsRnsqFwRuMxfsvBkccj7GJ4VREIfNuF/UvJeBlnMgioH
         RRFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779953689; x=1780558489; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H0vRKH8/H6W569Razk1c/3WxccIg5kDgZBhCKkCsIQ=;
        b=N3ywbrHziE2Ov6g1cO/Bj0ZN4M/HofPSDWzRD5hxuSUiDwZadIEXxLenh2DN9bKaPQ
         zxgipWBM6cc+aiesM7VXXwR8A59n9fpG36dzl1x4S+M5U3Ha0o7iIX3HHucroMdebAL7
         ysk9DcbmfDlvqYvpsOUOUsIuz2x4M7EYqf7knbB0/Cagfy/2hZ2rMaon2L7sqHdw9m0A
         9T4DxN4R/bXhbX3y34wYI/QnLOXAolnrz7N+H6hfY1vMBk75wNEe2hb5pBB78/L91z9D
         KYpj+qjfBygX+xvAjmHMC7k0YecKnYFjo4NKBRai24xDAvDWqx0JO+Xe+iMkWHKUtHan
         v9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779953689; x=1780558489;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9H0vRKH8/H6W569Razk1c/3WxccIg5kDgZBhCKkCsIQ=;
        b=SYY8tkiK9+uPylhm/jqND+lF8j9JBSgUi+QAzuPk5R4ueCe1M0w5dSv89QL6lqBbq5
         /JSJvPTn+G9PvHUgwrtjw9NxZxlYTQH41/MCnRu08TR5pEJOrRJ85Sc64fwbUdqMucE/
         Wozu+V7CUuyRqB7MdpJvCi6NNJszEek4LKAHkkI2bXZhtkEvxo+Cm732DKhjx4DHwlYN
         QxOem68z16UHJgdJ6ksH6pDkVkFB7Gt6tO9VZchF3I6nnxPrtsqWh8DMvAuSV90z52xp
         nYnUx1Eg/20Ztdh/bnJUmB8ijMFKKTbomqW0ndq8+d3Ig4oY4JpCZrMohUk8f42OaPOR
         NdiA==
X-Gm-Message-State: AOJu0YwuQukxsMU+67idso1ee6/OQF/Yw04EgPVcVTPgGCY6V8fMtwJx
	UsNIS9MEHbsQHGiV7HIwqcvnBkzN2q9JOeBzYExGVWK9IXRvsi/iiry15xmwJHlDWdgEyAz6j7Y
	mXKHMCn/WvVW3CkZsV3YPIfVe10mTSmu8EqJazd7LVe9IgLffGg==
X-Gm-Gg: Acq92OGhL3iSL8mFi5B/KentraI9m9J2cFntL0a4Cg4hGcJ7/MB/SGxpMEalHj4ZFRA
	n5vRnInhR/Z7JbZEURs9z4YnaKjMdOd4ptIbl4RCQWjYP57a7nWQzhiePrR9sXpNuNr8L/8pD+J
	CY+cPa4Xq8KmsDsqSMgBVeSXirETPZOd6z2OYgMrwSU9SvdWvcfJeMXVLZkrqzeXNPiFS1XxtSx
	NJ59zZBHMopt0LRn6y2UBSur9UisIMl/WJnfC9HxB28c0RFHtddjuG5Gqz+kaPYLPVSYxs8muHy
	snnNCO5o2L8XBNcopfoC3uGG7Am9yALpaY14Cm+giw==
X-Received: by 2002:a2e:9b42:0:b0:38e:a777:f393 with SMTP id
 38308e7fff4ca-395d8d5442amr60198821fa.19.1779953689237; Thu, 28 May 2026
 00:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521052611.1815693-1-rollkingzzc@gmail.com> <6a0ebd2f.df581d38.61261.d5cb@mx.google.com>
In-Reply-To: <6a0ebd2f.df581d38.61261.d5cb@mx.google.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Thu, 28 May 2026 15:34:35 +0800
X-Gm-Features: AVHnY4Lrn5qwAK2ay2t_3pkrWHW-dxYs3KNc5btXZFp_2MCvQY1uOjAFC-Nne2o
Message-ID: <CAB7XQsErc1=ziz-5eJHzzLYoyi6amOPWdn5dZyGM-1jyUE+fzg@mail.gmail.com>
Subject: Re: [v4] Bluetooth: bnep: reject short frames before parsing
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Gentle ping on this patch.  The current version follows the previous
review feedback and the bluetooth test bot reported no failures.

Please let me know if you would prefer any further changes.

Thanks,
Zhang Cen

<bluez.test.bot@gmail.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8821=E6=97=A5=E5=
=91=A8=E5=9B=9B 16:07=E5=86=99=E9=81=93=EF=BC=9A
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D109=
8453
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.49 seconds
> GitLint                       PASS      0.19 seconds
> SubjectPrefix                 PASS      0.06 seconds
> BuildKernel                   PASS      19.75 seconds
> CheckAllWarning               PASS      25.20 seconds
> CheckSparse                   PASS      22.00 seconds
> BuildKernel32                 PASS      19.79 seconds
> TestRunnerSetup               PASS      412.06 seconds
> TestRunner_bnep-tester        PASS      14.59 seconds
> IncrementalBuild              PASS      22.14 seconds
>
>
>
> https://github.com/bluez/bluetooth-next/pull/228
>
> ---
> Regards,
> Linux Bluetooth
>
