Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B2339366
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841955; cv=none; b=tiB0F7K8WRqCbx+n9nL4M/Rt+q6bzjx1JGBHopPJ9feoy5FA7R/lXQHDmDC+cFj6v1d8k/ujTRhp6q0XC3BqQBC3g7Qnl93xhIiooxF1EJZB1hPSc87FNcUYeJfg0AZklPshynH6Rfnv7YdcR4yGMoJ3oMydsGNWblKnAW0lEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841955; c=relaxed/simple;
	bh=YMVfWdeDEXpIo4fP4OwHSvH0akAHSzLjdeX6CUpwUuI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iPzFdlfeffbp1J5DWIGGe9kbefYMrfJxZchuN19/ZCeMfVtwf2sW91ZfVYeaeV7UlR8wJw8LDQc1jjro3kzTTv0xeNCYq22FTS2JlazBFzW6FkLjostIdZFerXL1XoDVU5lRAGVCzOwIiuay2NqEGYiXZSnbHV4wkDUFmINsRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+bui9BK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+bui9BK"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84830c774a0so3928055b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 21:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788841954; x=1789446754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YMVfWdeDEXpIo4fP4OwHSvH0akAHSzLjdeX6CUpwUuI=;
        b=h+bui9BKZ1zH949vLp9fv6MGz86lcTe4JlgPujta09XONQrz2hY4Y8rEKcQlLn5cXM
         jf2yn58dL2GiyJie26LERjmmJ4AlCymlmEh4PyxdAipnnwSd9mWO9qkg2oNpdLLk/CRC
         LxzBzRwjFBwslfIkQ6EweiwhimVbOiCtxBpKt8EefgAScEQMXWyTJ4xfCUyMQdFVj2iI
         6G2XCwSRCXDbF+DTy9KQU6x4kUtut92fh4dZLTLIDqmuhVxPusLkWGiOy2moS0CoHtvj
         RLbQd00RuHnYNLXW6j2mOQKsoEI3+P+PXHagnlY2OVPZwS42/0EWCcKAhdw+eG+t3HGm
         nqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841954; x=1789446754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YMVfWdeDEXpIo4fP4OwHSvH0akAHSzLjdeX6CUpwUuI=;
        b=WuqXBy/xs7H2szhwmgGJaXtubw1YnA9sj145Pef3GbcPlI16vayzSHWVUxkqPLz3sI
         zGIudOuLHIZTknbg2GX1tX7lecA6ja5BVg8OcZlOukrpdENLPuhOcBSeBdRals7FWc0o
         hxwFNn1BAKrjnkl9739KAIUbMRQDhXbD91WtkD0UiNLECyBMdMTl/QPbkXtq/0gCUbHE
         Fz24qeACCW3nCToPH1v92ngZckfrYBHveGNq96f4k3snRdK2HyP8/kNIv71CXFDQlJmp
         hAdiEinF+s2OL2G8g/PeHz82/05Rk5CHsEDhPzOoA1U7SKtbntX7/Xpg9HYPTJmUy7jM
         Cstw==
X-Gm-Message-State: AFuF++lhL7Qzz6pHL2f4cYmoK8Qt2Tc6RzxZqDF4eUi/8XkCt1IMRqAq
	wI01wYXtz7yAb4A2FMOAYfUSS/5aRtRpCsZnu4MB33F5pPM3vb1HT7MZlqkJzg==
X-Gm-Gg: AYBFou2VZMGH5Xgvk0/p+ppfY8rxH02NsSBuM21dkoE2i3xotIA7c+I/bTR2BUUIW0y
	xiuZYjbHZ4ZQKtj646zeL1n1wIjNNVLdv9x51DoDr8F6bX87qNaZF8HsaxuLPsPNEHclA+nPXwM
	QIp4GZSGFFZJDtEylnvmB8BFm9kvSxR9uFCF9fYI8CP5S/qxurHN6IVJLB7tRNSNU1mR7tvo1G5
	ZkUdWdSi0/o7KSsdc6DT+UCtfiaS2BMfedtzd89hkkqfCGJHcvj1SEbgXBSNrgCxa0wfm9JLzl7
	hAnDXi80ZwlK9TrXP9wJCDImKqAS8TwZnqeQGVtBVJNfdSbQcapOc3X3hehAde7Pr9q9fitI+vC
	TJQT4M+N2QMyEmTWZF9eavnLaSueo7CKs23KgZfD0+CHP3194nWfSAuEz0Z7QPRCF8WNXD4URWH
	wqcFwfP1ytgLXLwpEOxEbUDeVJawvuAskOrXQ2W44nNSDYU8d7srOA6a3MUHE4fIVmpmNuKw==
X-Received: by 2002:a05:6a20:9389:b0:3d7:eb3e:1c58 with SMTP id adf61e73a8af0-3da39d13c08mr44658764637.8.1788841953633;
        Mon, 07 Sep 2026 21:32:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm36717549eec.21.2026.09.07.21.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:32:32 -0700 (PDT)
Message-ID: <6a9f8fe0.ac292227.3c9bee.339f@mx.google.com>
Date: Mon, 07 Sep 2026 21:32:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2611181593547205765=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAS: Add support for on-demand ranging data
In-Reply-To: <20260908042727.1677501-2-naga.akella@oss.qualcomm.com>
References: <20260908042727.1677501-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2611181593547205765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2611181593547205765==--
