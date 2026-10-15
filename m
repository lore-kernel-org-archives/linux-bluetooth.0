Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A752B1EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068115; cv=none; b=btjzJuMO/f7SUTRoa01OT6dN7uX91rbcE3/MFAhnqQ+K2q4xJ97AnCxsGWRxGu016VNO+T8gwoI3tAlQ+yPuvdqCWBtC1t5uKjIMCe0DovEnGc4sqnuWccZl325DlWSfwtGLvvm3Qk9AFWOVed/6VEKMEDlf/Ke+UoCbnqa7xL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068115; c=relaxed/simple;
	bh=vesfGA2S1+EpM9YFFVR87N2o0mlHsXc2loZw1ELPSNE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ubk10X9/nDJv3yaMzs+//Z9E9dhTwlkPrpkQqoFd5zp6teMtJRyi9za8hFrl33TKqsKBAD7dtaau05yMdMz1ev1rqRcfXXGHocSZnha82jDyCvH4zeGcQ3V5kYq2NDprPUBHu9Ij2AC11icGbxL+b6FSMXMy/yiG6dL3iXEwmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uod6GJhd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uod6GJhd"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1043632a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068113; x=1792672913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PnVB9z3NOx6w7PJruhV2M8aowC/s+ruCuvrJgKDrb7U=;
        b=Uod6GJhdNQr66+DLwABB2RWzHDfaXXjXPS25zgsq8lciY33PO081fCXonjAsHtBFIO
         btYx3GGupj6SKJi4MYGC/gl68MUjH2qYaLoXk4fQmVQl0qjhmJV0H6B0BN/Of2LvwOzJ
         c+7VZ3SC0pc6LqRtYWxFrKLMao0IAbn20MvQCD6nj6f4l5jSRH991pJfpYVXlA4fbkWD
         nIZRCp3l9oJGdwbxWIHT9B7O7cjiUaMLsbGqN/kqQ0y/N1YRWpXSk334wqi+WdZsAP5K
         k40s1QDq8yQ5YPVD9YfYq6yWgk93E1N24O/u+8fpZaIKjEQ6MyOG7wduf6nBoIftDxDX
         8CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068113; x=1792672913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PnVB9z3NOx6w7PJruhV2M8aowC/s+ruCuvrJgKDrb7U=;
        b=vVRVZf2esS+R/CkvNi/QOuhji8hJH7EBfrxGwI0uO4DDS6lzE1J71KVfBZTp5uq/vC
         Eu2XLC8u4ztW3xJR81Pq7OBH4axsbXqRNWtaPgiaSO6ecmARL3w94OVIeY0RKbZynx6f
         yoKog/UiPWpdv7ABnq3XRbE5KDhuCHkPQQVfWrAtztq2OMk2+oaMYTqIln+SqN/v5ErP
         2jE0exThmOkXEe7p9KesdSN6NOPEmaTJCFY472K4dzDYYpOzqETV+BcH1ngKlRRYFLbr
         D6wqyTx4zMx5Q1mdY0LUqweAFIEtmG9dfQY3tLOS1R+hYytGWofgO31Eul+lv3Fytehn
         ngnw==
X-Gm-Message-State: AFq9FYLY3YEFaCQAF1mhcXX/RTA+dax4V16y09ENVarePmzacCQ0zp5H
	xXx+KasI/1pm5YJU7sgMmx7c+OBL3Vo+b0Poz1cyqUmADDu8ddhtEJ7pBghyqQ==
X-Gm-Gg: AYBFou2Cq9Y1y0oLOvY0fgYU/RhlO0YrCOjpkEGPQ75/h9e+FqdM0h0N2qkqrDZ8OQw
	jHX6pB42Z23iyLwCzXpB5EEj/5Mj3MBCVmG0jw0h6uRzRJKsb56YiURk3AiPPxZFHPFi+Wy1gok
	5id/CFxt1cJeqygaI9rN/a1wFJ1wnezpnQqVlxxEfphjftEajgAh71YSWJCzcySWjN2wWiFn3TB
	fusIxqsBjmUndlewnKiSTlD4Y0eNZPZgT6Vp3r32zGHrKbh+bdWvYRYLA6/TohzcmWM89nrxUvo
	yoamWj1AwZ9ELG1Zu1SbmfEjx/ND43MfO9PJJ+EVBY4kRIVUwn6iENiCAEMtnkpII3gnPmsENvK
	HyTVLlBgh5EiF/or4OKU2tDaumfUNwK7kt5e+wCW98MoGGYgjAdczU/TSMQbcv8ZZAVbijwiA5m
	rr/ohHgfEx4RgqHLpT434l4ok+DmUsToLZZvgA6Wcjk3zjxlUbKuBkoMKHVQRQOyKgQ9kttcITw
	R6C
X-Received: by 2002:a17:90a:c88b:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3ab3ab32a3amr15083681a91.46.1792068113260;
        Thu, 15 Oct 2026 05:41:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.29.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944511c7sm4737037a91.10.2026.10.15.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:52 -0700 (PDT)
Message-ID: <6ad0ca10.a2c7ca05.1a05d8.db83@mx.google.com>
Date: Thu, 15 Oct 2026 05:41:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4915997403629039815=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Use blocking reset for FLR
In-Reply-To: <20261015080430.3336201-1-ravindra@intel.com>
References: <20261015080430.3336201-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4915997403629039815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186224/

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      33.43 seconds
CheckSparse                   PASS      36.14 seconds
BuildKernel32                 PASS      32.05 seconds
CheckKernelLLVM               PASS      33.29 seconds
TestRunnerSetup               PASS      716.90 seconds
IncrementalBuild              PASS      28.39 seconds



https://github.com/bluez/bluetooth-next/pull/942

---
Regards,
Linux Bluetooth


--===============4915997403629039815==--
