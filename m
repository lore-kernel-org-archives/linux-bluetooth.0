Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B63E8C46
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751898; cv=none; b=HS3B+vsufTf1n2kAxRtGAzV4mDjK1rCZZZcyfMOQE/7EpA3Ubb7uB3YmEhOv/FkVGLE2BOwkuETkkW+erxBq6gd8rB53f21kvKtz1Yhq1TJwJbj3IOaNlYe7d31DtLM0EbznTy1Fs4D62igyIKaSfptsfEuAdFuKy7G37BnIUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751898; c=relaxed/simple;
	bh=VpA4zeRbRUMCRARSPQXadrvmNXmu3NQN9DNCq80c8UI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lfEuiHfZP/czTnNH7i5zoyEptfc9ZiqGPS3he4UHRCtYwws/kZoGOqmwW3eWvtrFXY+RlLcFWTaYK70wYS6Qw2KmiT6sah7tjyRlmKLQtCdnyeyGSPZd6RnKLz9hajwl9g1UBvr1kxEXDseTzM5N+6J5iuWJqQN+1Bc+mRwk3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNs7qb9p; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNs7qb9p"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f256eaedf8so14072946d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786751896; x=1787356696; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7xd9gGIXg7sjDItEHam+JeMu9jv1EHrriLo5HlEpz0E=;
        b=KNs7qb9p5wedY6wSJHzzvbgvdrj2EeATN/AN5Wm+0nc8fChWO/ZIlX/Pdcn9/9GHMN
         5oGSpa7cbSWSZ8UhY9wGOhw9j0f43Hwz3eX7qW5d6RIhw8RCcDJhkIIkb/aeVndT9g6W
         4B8b14hR7QDb7rm6RZwCtrSt0lBc6IuPQe4FA4XDj8lmxqaK3aMlwvSO2V+srl8rvohR
         0/p8rBbTiksm2QF2rfFdtvi7AYIUOBb5bw8LPgSbfziWB9ArzPbxBoFXHIlN1fV4/Vii
         98lO5BAMW05o6esbT5R5WO4IzU3l6tCV9gDHYs/7zZM7oYCCdLUtis/9qnoIEX6OaZqd
         kltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751896; x=1787356696;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7xd9gGIXg7sjDItEHam+JeMu9jv1EHrriLo5HlEpz0E=;
        b=rhX7R8aUj9zxQuOjDbY5uYH3ET+zSEgj4xk79BTYN7Tw36511oCHyCcE/sBw1jq4qR
         yz8sD4DIW+KtFVPQdAoLX0Z9LrvPPq6IWSkCK5hq55q3cABxXsCLFtvLsCss6+i/E7mB
         ZgrHnTF2SD67CjxNf2fkMpSYi6596Eulqe0FsSGx4YXRgrmG0qGhD5IRNkNFuAEOmPNR
         3M5DPEGhpzHr5J9kE2uHj6UWPeEHonLyaYoOekJykrxcPg+mkIntpP3OC+vmstRJsQRg
         sdWfPGQw05M6H2RXv7FXUCMxuqx0FfMDljR2xKCktKM8jEK/CbmFyAc9HLRoO3R1X2np
         yKBQ==
X-Gm-Message-State: AOJu0YydSRsHteJT5c36lHO4pTeuDR0Wh6ghv9nojsyrZfzdc+L2bERv
	bpEjytuPugpiQNYT6zTsKGow1KYJ/HiNZvr09bQlVRP7HGCu/5fC/j0XthGGFw==
X-Gm-Gg: AR+sD13ms2bNZC/hRj91L71ATXkijGA02mWkb9U8E31HKuic2TET0A5Ulz0Oij3yuHS
	zHh53IhFixLiYpNXTwCmeN0kgygWPbF7oJSQDM6iue8Qa23kitUPNIt1/EW8BwYcMNXmM+w3GKo
	5YLCPvHdwGA5VMfKKA+DGnV4TAGMnzAQJghSONB4F6KBNqVaT9syxkSiYgEahBWNf3QvkPjCJQR
	Umbh9qXYWZAEMmudBXa03ymmFn5pvXzpFeVAwhkdDV/vLSkEV3eGrhu7xe3pUlx0etb2KHeaQEy
	3ao891AHQrGVO5cPg/zXOIBhr8ZjYYnOkwjRoMJwNAhu/ixKNqd8UmJ8286n/08SfX8leQRXG56
	BIoSspcgjGLj91dayfcwkqBO/juS+nAEs8325ViYqd825mYL032/xz/OWz1p+CewfDXuHDD1scC
	WqNFNs3eMbajxm4bdu+PPSiX+p0sjLI7Rex0yU61l2qpKIYQx2jux+P2n9W3zQZ+eADaEe
X-Received: by 2002:a05:6214:498e:b0:8f1:d3ee:a8f5 with SMTP id 6a1803df08f44-90a91e14051mr126873506d6.26.1786751895680;
        Fri, 14 Aug 2026 16:58:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9350cfb3sm29067326d6.25.2026.08.14.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 16:58:15 -0700 (PDT)
Message-ID: <6a7fab97.7f7f1747.1a818f.8141@mx.google.com>
Date: Fri, 14 Aug 2026 16:58:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5648839002616076279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chad@allthenticate.com
Subject: RE: monitor: clamp max_len in print_packet
In-Reply-To: <20260814230419.2042327-1-chad@allthenticate.com>
References: <20260814230419.2042327-1-chad@allthenticate.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5648839002616076279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146334

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.34 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      583.87 seconds
MakeCheck                     PASS      0.98 seconds
MakeDistcheck                 PASS      156.41 seconds
CheckValgrind                 PASS      150.41 seconds
CheckSmatch                   WARNING   298.13 seconds
bluezmakeextell               PASS      96.55 seconds
IncrementalBuild              PASS      563.82 seconds
ScanBuild                     PASS      905.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
monitor: clamp max_len in print_packet

6: B3 Line contains hard tab characters (\t): "	char line[LINE_MAX], ts_str[96], pid_str[140];"
7: B3 Line contains hard tab characters (\t): "	int col = num_columns();"
8: B3 Line contains hard tab characters (\t): "	..."
9: B3 Line contains hard tab characters (\t): "	int max_len = col - len - extra_len - ts_len - 3;"
11: B3 Line contains hard tab characters (\t): "	if (max_len <= 0) {"
12: B3 Line contains hard tab characters (\t): "		extra = NULL;"
13: B3 Line contains hard tab characters (\t): "		max_len = col - len - ts_len - 3;"
14: B3 Line contains hard tab characters (\t): "	}"
16: B3 Line contains hard tab characters (\t): "	n = snprintf(line + pos, max_len + 1, "%s%s","
17: B3 Line contains hard tab characters (\t): "					label ? ": " : "", text);"
51: B3 Line contains hard tab characters (\t): "	cols   before   after"
52: B3 Line contains hard tab characters (\t): "	  10   abort    ok"
53: B3 Line contains hard tab characters (\t): "	  20   abort    ok"
54: B3 Line contains hard tab characters (\t): "	  40   abort    ok"
55: B3 Line contains hard tab characters (\t): "	  80   ok       ok"
56: B3 Line contains hard tab characters (\t): "	 200   ok       ok"
57: B3 Line contains hard tab characters (\t): "	2000   ok       ok"
58: B3 Line contains hard tab characters (\t): "	3000   abort    ok"
59: B3 Line contains hard tab characters (\t): "	5000   abort    ok"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2015:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2404

---
Regards,
Linux Bluetooth


--===============5648839002616076279==--
