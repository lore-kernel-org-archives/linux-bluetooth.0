Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818C22541D
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603177; cv=none; b=M1sGvDfyJXqM1zLATEnijnjsiPr+F+dV74aI4ALeZ3yoSVEZudFSpzSSbMcGgMlywR2JxTC7wszh8FCdz28yC+0cOCIChHe9rUn9Chml75KpGOCmDti7eUZwx9JRXDyn1KeFgiint54xl2yzU+HEHDqnIetEwoJ6xv2CCrSy1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603177; c=relaxed/simple;
	bh=d0PLuGSNvS8vAiglNNNgLIm50fX1g0iY2MpIddnZ6E0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b8jurWdFJEcKNQGdqFCIyfiQKwvF583dJpIt69qKrzKejzoSIW+k8SbTj9pzzqXdzGCOy61n0yprdrud814ODEsN9E9SPQj1WT7g8Ei7NyraD02i9RhgODUCV5HnEgdC7Qc1k5R1zjK4yJoTlf1KT6ImRP+t2789pHGFjJAa2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Vvu+iN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Vvu+iN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22334203781so89772815ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 03:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741603175; x=1742207975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0PLuGSNvS8vAiglNNNgLIm50fX1g0iY2MpIddnZ6E0=;
        b=O4Vvu+iN+LbctV+jkmVHckO+0lZ5/W2PgMJrClaDZu6osAXvQtK/BMUsfTUt3DPsJu
         Dwi021LwwQta3qFxGf0QWrxqglQKm1qG04xju+pmE26sUElo0KWip0n/nDn8M5EBCwOf
         8rRe1KDRH3D+u7jL3B901+r6dzHRoa0lhSB+QxLNsCugMfXR/tkRa2hTvkVzoOYk2sFE
         hU/48Cz8+hKPjf/FPBJUltc414ExPSpsmUOdtzLxW1R365ojI8vTWZhfQ280qoqNq13J
         mB08m3kqRBaGggkjmQ0iZW4wC+VD1mUzlBNxeFwIxo/2eGiV5+qoWEKR8PdIkDi2401v
         CGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603175; x=1742207975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0PLuGSNvS8vAiglNNNgLIm50fX1g0iY2MpIddnZ6E0=;
        b=cUhTzxmdx4apbrN/Ie0q2xar/MbKv8Jo43hjyqUy1oxCqlRBh8KtifLo2a58FpJKJV
         96L/CcziXs/UHG5GbyX4rCyLN0yk33ZViBss9RtCAMa9oGcSz4W7M8xeUm6TUVH08ib4
         T3o1t38Fd+0pWomZqYx4MB1/wpUbEZGyIBka6w0IsAOxnQ5fC7R2wnH9aqoH7ckGjijS
         IIct27T8pdTVpzx2rMHHFpG87YENYHc0KM6idRMJPRrhWSLb73K51FtxxfQweeEegqou
         bM9sCzuUHrYMS46r2ULB8AMjYvcYdyxuEWBZnxm4xaISqmI/WxK7WK6gUz09Wmy9Fs7q
         RjJA==
X-Gm-Message-State: AOJu0YxGUbP2xY/LtVHXGUs62depIx10pB35mBNURvOyhPSFoDMtWSrs
	GLVSDifKdFKaXRXjS18VvwebpNkv41LHBmMYU6+RsisypUPfn99NwVk+KA==
X-Gm-Gg: ASbGncsN1a7J66qMq0X2Ub/zabFUBEhsjgLgD4lhcNIn8Vm2wdeOlydmI56o5Y8VJBv
	2AqMcMw+0fPzYxQLUhM0F8nH5FJpvv1brJmYi43f6TOO28DaAW25ufY6w9cw1ODbqDBW30ytzhG
	kbz50PduuiDodA8xpdH1C9DC2X+FA5mFu+TjBEl4rrmNo288x7bGF9Yg/poIb/84QcnXyWzcdgf
	L/vboL2dLRVWYj2DQ5eiPf0E9xix4ILV6XAh8DePiV9GdBBvbWa17JvR8lSjn85eqMnFB6O4mUD
	g68c03uZWyKA2rcqYDZyirKeJerO2TcORBoXNvsj2ie3jZRbYWEVC5K9yChy
X-Google-Smtp-Source: AGHT+IGijaTjQwmoZmjvbjV4I4kwxd4ZYsNHGX+vxxftUfmWRMwDeDA0vt+VGuhpdC2B5JPs/0IEMQ==
X-Received: by 2002:a05:6a00:8b85:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-736bc0fc156mr12997880b3a.11.1741603175015;
        Mon, 10 Mar 2025 03:39:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.33.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281093136sm7326903a12.18.2025.03.10.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:39:34 -0700 (PDT)
Message-ID: <67cec166.630a0220.1d98b4.613f@mx.google.com>
Date: Mon, 10 Mar 2025 03:39:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4854323968525294389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3,1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
In-Reply-To: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
References: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4854323968525294389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:310
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4854323968525294389==--
