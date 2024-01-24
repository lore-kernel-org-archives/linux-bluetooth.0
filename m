Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770863124
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108336; cv=none; b=Hz/UCvzjmB/AQs2F9ui4wpG4NNZL4Seey/Yh/9NmJJuNQoWLOVE09TfohGUzaDOUlDYA5ST9JrgXuI+bKl3lGMP4892WkL+D1jYO8wCODa9F7M4VfSGxUsNcZdljIMmKWiwGxWqaW/wxi3NoRY4BfHPdb1/jm6+ku+z7W2oB1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108336; c=relaxed/simple;
	bh=YKginXR6Nb0NJogFXMA+NnDjiJ3AaZMX6Ei1akWnUpc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iA4wU4eZ2wBXMz+kFq+fXVRibxusuccvP/yYYO0kcV7eR3styeYMTXRd4GG8hkBlUuBepgAYi5vQCAtMSAjxKo9bDbzvVSge2l+92lgS72dU0qbqmrswTUNLnBseEQV1daACAnpH3b3FmvIvmfMxvRyfW/HF8rkcIadwwQ0T+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwbx+m2y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwbx+m2y"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dda21c33e2so398835b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 06:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706108334; x=1706713134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=il3omqpilbvP10dngc+URQqOTHoQzi4m1eA/qdi7pvs=;
        b=lwbx+m2y+kKwCMoKVn/5E1PWS7o95k+rTsXgBAdOB84eL0gsJgX464gxts5pzfeHnl
         uSMDw7q48WQLA3cCb1Mwsgl1aX3bkfKxbZl0wXYJYmcSFLeg+DsRdReu1tgrtx14FQ5A
         WNB3uwis4hniAl9fQOqIxB7xeeljDdcdyRQZ9FCYnAeilCHsi67j1uXLbVegKEJq0NGF
         9Y6+dy81/X5B0gNmTswgTJl0kB0gdM3+H/+eB5d78iRmryKmJyXefB+glE3iLdYO/n50
         EmLYf0ecaiNFnZGXUo0cNqMK/gPT4cVcYAkyizSpfFRkMajkaCCfbus4SV9BVr1hWgWT
         IsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108334; x=1706713134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=il3omqpilbvP10dngc+URQqOTHoQzi4m1eA/qdi7pvs=;
        b=h14jAoWCp02GTwh81queBhYY2SZDnwU5JYFGB5HsnQN0aCvxYSgO3234kQMCMuFT3n
         vzmbrRs4MWU/ljrcCWO27AgQEybkLtMkn6yfbCyl+/UP4UJ3tjkGnzbFNdAeTUn5U4Dw
         Ov8OWAjcHscTxdfZuCxrWBiDBmyVuDWpAWlTdQFKYL7BvtiP/MwNzjUcZ2XYk13O/3ue
         YT0Y5Ld+FgCDHdPZlM7sCwyR46nao70L5YL2RDfRLmnUkE2VkGKX+PludQVVmohSFiQS
         KwPFBDTbhdjR+MRGPQ2Udf5G2U3UMtD9vGjz/K+4V/dnpwJWWtOx/eYa6qJcr+KeiL8G
         2pWw==
X-Gm-Message-State: AOJu0YwBtdl4ApYSJMz0Xv7yWlDY1C1Csg4/bS1AwlptYx1x2wgMBzLr
	4h1N9AD0WxPVVmrsOQLmW21c7xWjR0nIH8nYt3qk8D+E7Z0+UEiGcGS2hqyz
X-Google-Smtp-Source: AGHT+IFNMoP7KnM8xJl1t1fBBjIhhCKwW9S9Op8TjfIkFASHDVtq7jJA0dvAPeDxKRzIyqTkQ7AxoQ==
X-Received: by 2002:a05:6a00:b54:b0:6dd:8211:9ff0 with SMTP id p20-20020a056a000b5400b006dd82119ff0mr2208264pfo.18.1706108333625;
        Wed, 24 Jan 2024 06:58:53 -0800 (PST)
Received: from [172.17.0.2] ([13.86.227.250])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b006dae5243740sm13802703pfo.60.2024.01.24.06.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:58:53 -0800 (PST)
Message-ID: <65b125ad.a70a0220.b9bbb.1f06@mx.google.com>
Date: Wed, 24 Jan 2024 06:58:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3782303645381193502=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Bluetooth: hci_qca: add check to set HCI_QUIRK_USE_BDADDR_PROPERTY
In-Reply-To: <20240124143042.27790-2-quic_janathot@quicinc.com>
References: <20240124143042.27790-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3782303645381193502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819522

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      30.48 seconds
CheckSparse                   PASS      35.93 seconds
CheckSmatch                   PASS      99.17 seconds
BuildKernel32                 PASS      26.95 seconds
TestRunnerSetup               PASS      434.03 seconds
TestRunner_l2cap-tester       PASS      23.07 seconds
TestRunner_iso-tester         PASS      42.71 seconds
TestRunner_bnep-tester        PASS      6.81 seconds
TestRunner_mgmt-tester        PASS      155.96 seconds
TestRunner_rfcomm-tester      PASS      10.91 seconds
TestRunner_sco-tester         PASS      14.37 seconds
TestRunner_ioctl-tester       PASS      12.01 seconds
TestRunner_mesh-tester        PASS      9.00 seconds
TestRunner_smp-tester         PASS      9.76 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      25.91 seconds



---
Regards,
Linux Bluetooth


--===============3782303645381193502==--
