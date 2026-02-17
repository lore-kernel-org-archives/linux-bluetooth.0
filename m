Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDB21D5B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347032; cv=none; b=Hry/32QONLG3wuJwp6BM7dIxw2QH3GU3axcoS5qhzhIxRQe8KjJ1bjmB75+zkz6Dsmrl0LbmlQWQcPrmlIsAoWkiIXg63YehWtpbfcTFlFWDra4qbh5E8gjfZar8R7INHBdt0tv+5isv4xeHzHM7ugfsaIqqPcrU2KuRDx+wjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347032; c=relaxed/simple;
	bh=eQcGn7vBxdqoqc+7Y5wactSd3Nt8IVYPrNgq7kHDi+A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hCa7BHvaN0pDgt08ETPXjv2vTg4uXV3K6wrz0jQ89zL5HIvAeCZnDdq2HJXRrXcMWfg6lNE+3YWl8VuhYP8PyxOEb3uq1QnkW09KKa1vgZkbHIZF2K6Y/sjw+NLXt8f1YUnq677NkP0d/O5DRmMMZAPUb76JkubOUwUdvxla0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeWRyXi5; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeWRyXi5"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8947e6ffd30so49084656d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771347030; x=1771951830; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KCTPQrIXw9WMLCCjHVxoh1vT2Yxyo9jX6Eu3JDmktjI=;
        b=BeWRyXi5bmuHGIdsVzYHqOf15Ey4lG33JDz+eiiMIez45z6BlO4TC8mOtOwmaUHmNA
         r8LAH2v2Offad6nYrEMwazcYsdfU/D7yjmzj7/ZxxBFExpDTClG9SJTy3nYK6Oi6vXC+
         T1FFJdESctyQiVPeZCHaM06nY0TXDypDapPsJlUADrYArBsGRJfEscPLPKmk+pNfD/54
         GHaB8TRSWLOyF/EWyJ+jbR4aXDDwbDATyO5WesKrHy0BcINXiCKxO3XAZ9GOujtV0tXk
         vZZNfqSIHy/wQl2e8Re1/JQnX9ZBi90LYKApSjsKHrHJsA+v/pjsRAzK6CKxvQJtgKE0
         HyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771347030; x=1771951830;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCTPQrIXw9WMLCCjHVxoh1vT2Yxyo9jX6Eu3JDmktjI=;
        b=nfub1BeQxSz9DxV2OGBzxirF1tKlRm7vqpwZUN7bdTVEubZIMNmyb/74xhN4Z/lDrT
         kGTasucMfB1oBiqklXkOr/RbX4W3A9ugSdgP3ygZDOFud8KKXWIxVmy6ms3TP13QdifW
         D77a3TZpMykTMhzjHx1RTf0TDFIC7uIHauhvbGl5HhbE4Oab5QH/CJKpTpTrGdoiQgcK
         usKMDTGAqq41ZOkLl04MDAARFTX1MS4HEn+dGshrA4ZJUsW+rPy7/3B+u1h6sbAlZOIl
         3gUvDzqU1sifStwPXZmxsDEENoS/Me9+ks5nqA/GOokWw8lH5gKErR2suNhfn2L4EDst
         BOJA==
X-Gm-Message-State: AOJu0Yyy4mkMn8Bt6RBKZ5+7go6yvMNTHtMlDG9GwuQND4erxqOsh4VA
	kzLt3e5GZ9uXZSASMcbjZAcCRECPOThbvtmWtTb61GRE2urc6D6h0FCZTA+DZmkg
X-Gm-Gg: AZuq6aIn9s6u2cCbZ4af2eWlLjY1c3REsLMbgo6d7stDnpauE68Nqc1QONTbYwzDVyl
	CIsTmc2t7Aaw4ayrWdQtmSqr6QSFkIwdpCPHOSNObgam014jOa7Zvjyb3fQIZQdqOlBpze7vBhC
	JtupmlRq01udJKLIr/9nVWF2ipBHJUXyepRJB1UNBFyJMGGB4gNJsuNur6/mEsZvx5o0Tm1wzw1
	bGTVtXU17PZqT/QWtBVpPz8A0Gh+YnzGfunFv1VqGGhstI13pLmh3PpEXqo6mJjkvz4YtZqR6JJ
	6qqCDXN0/UTDfsEs8+/LILg10IkGyrd8u+UVOoLdDUE8IFgpr6Y9jGdvnJU07W0hPEAgfKhHYeI
	u3IQL/nFOVOOO2CbuxxamwY33tzhvOJgvuVD58ZGJXDg4BSEmb2DlxcLH9tJpMb2uT2HFcjt2Lp
	IjQ/0oV+s5ZEIcLE26ujZprD4iyRp7rHM6prDbFMuD
X-Received: by 2002:a05:6214:e8c:b0:895:ddc:c55b with SMTP id 6a1803df08f44-897402d6e11mr158016316d6.9.1771347030420;
        Tue, 17 Feb 2026 08:50:30 -0800 (PST)
Received: from [172.17.0.2] ([145.132.103.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdbd860sm166547246d6.46.2026.02.17.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:50:30 -0800 (PST)
Message-ID: <69949c56.050a0220.1e74eb.9c69@mx.google.com>
Date: Tue, 17 Feb 2026 08:50:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7994817329464540284=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Fix build warning
In-Reply-To: <20260217153616.394716-1-frederic.danis@collabora.com>
References: <20260217153616.394716-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7994817329464540284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054909

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.92 seconds
BluezMake                     PASS      644.71 seconds
MakeCheck                     PASS      18.56 seconds
MakeDistcheck                 PASS      249.73 seconds
CheckValgrind                 PASS      296.52 seconds
CheckSmatch                   PASS      361.07 seconds
bluezmakeextell               PASS      184.04 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      1026.96 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7994817329464540284==--
