Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C66149C45
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850560; cv=none; b=D+a2NX/wY8H98AeX9YwLdvPlorZC/Z5Xx7g7bd6KN5Lq/yWSlU0YbGGgljGrEtxWCcke8V3oFzIlsqqmbUpAQccwz2kxgaNvGmeG2UY28uEsOpYMhA0+sEGGmZ469uriRUpvULSPKLVUiQQyVhH5g/MNfJOC9mLBPCaGdmO84sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850560; c=relaxed/simple;
	bh=5qLZGCWu4dzVyB6kdV0dhtOKef7kOd8Anx58aOWRQbI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VnBElq1yKOvK4bMcC3QCS6PaYqNYSmYKFimWPekW5YWYtisq9rx8giagh4YmnrPdrKm2e7RlVEqkLUDmHjvzn+WbdO7Yoo7gEkYJyBBqy5PA0ShC6hRBMwlQ16KxfDNOyegi6kUKwu/a1cdzefEacKq8eecEVLkkVy15wxLFxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeX4dnPF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeX4dnPF"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1dcba8142so407666985a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722850558; x=1723455358; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=245YtpPU6W9KQcQM1vzpZJgpJVNKtcInJ3CjwgcxejM=;
        b=DeX4dnPFAtoDrHER+gEH5EMduFHRkd7b6RelrTEKea5aNHa6eMf34K/JPFuNWuJKO+
         amAA/Q7lAb5DbuohhF9x8ekvfNjw9K+2GZHzGeh6YXdCLl943Hw1QK83BInzgaExJXP+
         4O+9GD5BrfWqb/1ZhuMBIZDUkEtKenctRdigxULlwzpBCoOco3Kd0ebNdVyYjtUTAK+k
         h6ASqRgmwFpfv8JZOE62ibYT2fvzpMncg9Niirh29fY1aBp/82duch4gcLC+Zkno6kf2
         RL4KRcuuFy5mMIVFTbCFDmBqy17Fv8iFfUzZ8hMVw0TqTuAZrEiOfljt5Bk7eVy24S4i
         MmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722850558; x=1723455358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=245YtpPU6W9KQcQM1vzpZJgpJVNKtcInJ3CjwgcxejM=;
        b=tcpxD9PHRVYtT7E2Waba21kekVHr7/qnH/5XhqtDGDz/G5B0bvoPSYYOnt9vFc1tIv
         yqrf9CBeJav340jvRMwci8XkrT/ubCPyk2rA3/Xq/szyR/A1Z2a54taJxVZfVsJhRUay
         GJR/DLjIELevzg5p8OsBw3zrN+3Q55HpOgmyIRB2dpJe+ManAczGoSEXQQXL4a2idoz0
         ikGP1ncADHYLw40l1WSgPzeKmrWWzTerxSVjTW7/odSzqjrXpoNAsG/Mb/gmQBMd5xP7
         StwkJjOeNhQUvLuFYlg70wKse9ROKT3ey3MFydWlw/TBbIG/bFPg3V4I9kwfW0kNPPGy
         VJsQ==
X-Gm-Message-State: AOJu0YwdUVpMGeKPUTEThnkCzLS8E40RcjDxdQNrIUhooERZmhaIwLwV
	wrT7s4bE1U819c3ynACoITSMJHTTGsbqt48rxcnMnuP533rQ1BfDAVYqwg==
X-Google-Smtp-Source: AGHT+IHPTYxrWWyc7QTtRF2j5KxQTAqls0m1+H/y8z18u83efkS4e//fUdkcqkjbNXhzJx2uuQOnZQ==
X-Received: by 2002:a05:620a:c4f:b0:79e:ff0a:87a0 with SMTP id af79cd13be357-7a34ef0ab37mr1929944085a.11.1722850557595;
        Mon, 05 Aug 2024 02:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.118.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f772dc7sm331197585a.94.2024.08.05.02.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:35:57 -0700 (PDT)
Message-ID: <66b09cfd.050a0220.ac4f0.9dde@mx.google.com>
Date: Mon, 05 Aug 2024 02:35:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2745381757000119178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: clk: implement a new managed helper and add first user
In-Reply-To: <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org>
References: <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2745381757000119178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876621

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 FAIL      0.56 seconds
BuildKernel                   PASS      30.19 seconds
CheckAllWarning               PASS      33.30 seconds
CheckSparse                   PASS      38.25 seconds
CheckSmatch                   PASS      105.38 seconds
BuildKernel32                 PASS      30.05 seconds
TestRunnerSetup               PASS      538.80 seconds
TestRunner_l2cap-tester       PASS      20.72 seconds
TestRunner_iso-tester         PASS      33.48 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        PASS      115.35 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      15.24 seconds
TestRunner_ioctl-tester       PASS      8.16 seconds
TestRunner_mesh-tester        PASS      6.17 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PASS      33.70 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2745381757000119178==--
