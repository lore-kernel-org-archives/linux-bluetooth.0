Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3C183CD4
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480641; cv=none; b=eynCzCCDlW6hovErhNLILE5aubq1u4wjxHeunTnoKn6T1RbHZOQpldBSQJ6PtAOdY2NSf7OnhDckGvf/fnIPWHkPlEn9jkEqD37uWYYZPJyXntwkwk0EgOOCfMOxRjPkuNoYOc5jPii8Xp+UR46PVD6tvv+5cHzcAc3z0BmHy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480641; c=relaxed/simple;
	bh=9gHu5/m8Up7dBR90aYsZxrH6HGCiPnBCqQDOr4HOC0o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VJrNpiwN6xg0ZwuEBjDdFRmgN9+FmvPGTQQvFBLzgQv9hOoMFijnKUgVA2fXVmvA82N657BLePGZTPa567EcH0l1+F29dCNxdB4eBdn1oJWMuW/z3/fiHRw8FNXha1HrUiOnVuNrlg9lafSuWnoZKi2YYyT6P4acHhe1VURvV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ihhtlu9A; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihhtlu9A"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ff1cd07f56so38068865ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723480639; x=1724085439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mFW9KpBt0mrFp6W27GRuGo9UCvflcyIjllW2KmFA4HQ=;
        b=Ihhtlu9AoxnM9ZtojVONRJx8KZTInc9Et0ci/ur2H99tX0CVImhkGCsPdmSy6uB9RA
         q8il3L2fVY7+KGUlXdv25Dxx6PuvkuPWrsmIipUvHCmntjPSNiAdHpQYs6E0wIJ1Rwtd
         48mVnf5O8b1lZ9/ph0NV3ZePSxt5t/w9YcXqWZMZyNCy3jUgFQYihLK6CHO+8r9vLsQo
         yIaIri+OeE/XIikkL+odHNnNNKv7aKJqockXj6oUxFtUCOP9Lj5/HhGw5OV0EGzSkWX9
         1BRWqv8wsK0jlQMQ6P3dB/d1aAkzmGAtjZ3tIsoJ5LtMV5hStqqwqYRd3bk07rbN6GSt
         qT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480639; x=1724085439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFW9KpBt0mrFp6W27GRuGo9UCvflcyIjllW2KmFA4HQ=;
        b=liswD0Av04IfWjQcFGz1Q98TGeLdudQzVxY/SCtvfk9Kf5pEWxrCyD8YZMqD3WUryL
         Lu/YaDajE29pE1Wfqkw2VBEotM4NvMbZTmnk3AuzuIjVOfT8nHqjmfrATDTVOdDdpPV9
         RsUYPZ4kZfNjIolGT+MxEDOA3/GXKCQY7E7aQYhG9vz18YJ/TUg+I3DCfhx4/Cd6L6gf
         nsIPyruMMTAaim9Wb8UcxILWf5TK475JBU9cwMsS+30sPm45tlhTt3TFiEIyuZ1LRch5
         FOP2uWhESJENdqRpHXvAv9ZPwkBBRl9+OMc/tKO7Qi4yG2gZ7s3C861BgG4FRtiZpuRb
         sNIQ==
X-Gm-Message-State: AOJu0Yy8S+l2Qd65vXx5jo0ltyEbMYmEKszNRLxPcbcMm7MP1GbMX7YH
	ugrjGRUZ2L+IZqPCzAaLqgK2nzxlrJcPTZGTDr8B/sHqd5Arq/XquzACGA==
X-Google-Smtp-Source: AGHT+IHRBUL5C9DJU7BotwiXMY43Ta0u4sFNHWyepNNsBFplSejzMhPWeUAntlG3nFzAjWTiC4u6xg==
X-Received: by 2002:a17:902:ec8f:b0:1fc:719c:5f0 with SMTP id d9443c01a7336-201ca1c39eamr10296395ad.49.1723480638871;
        Mon, 12 Aug 2024 09:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9038f2sm39878185ad.102.2024.08.12.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:37:18 -0700 (PDT)
Message-ID: <66ba3a3e.170a0220.3bb33.b5a1@mx.google.com>
Date: Mon, 12 Aug 2024 09:37:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7229184904252550913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix LE quote calculation
In-Reply-To: <20240812153219.290388-1-luiz.dentz@gmail.com>
References: <20240812153219.290388-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7229184904252550913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878861

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      31.33 seconds
CheckAllWarning               PASS      33.35 seconds
CheckSparse                   PASS      39.24 seconds
CheckSmatch                   PASS      105.79 seconds
BuildKernel32                 PASS      29.11 seconds
TestRunnerSetup               PASS      531.41 seconds
TestRunner_l2cap-tester       PASS      22.08 seconds
TestRunner_iso-tester         PASS      30.80 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      113.00 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.84 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      27.86 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.175 seconds


---
Regards,
Linux Bluetooth


--===============7229184904252550913==--
