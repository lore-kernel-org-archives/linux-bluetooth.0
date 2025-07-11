Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E621D018
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268724; cv=none; b=B2GoDPDnIjt/mhiCJ4ocEi4y7acLBg4cFzjTs25xhL1VNx/Oj5WJGMl31o/9TRUGLrCJeOGI4f3GVUq3HqRnkMYikujTnHLctA//M3YSPLZyPnRSE5PonWRDRt/3T+o3Z35IVyKoGnDgEBdJvQwBC27/u0XiGHtweD9G5UnplQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268724; c=relaxed/simple;
	bh=07o2h8GXHZ6QkULmvSr+AjBlH2jv/PnowHc3ua7h3DU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iupWGQ+L8lYH9BCa3m/FpY+rqIdLH1xHGflJaDyQAJZr0IQpzXANaX2SuonG34gakhm9BvUL0lYw4/MrrhoJvqvmz73EHBq0DLm11xoK9ekPd2q6/t9nQV3T9UvJy6NQHN4DVBjCVSr0a3SXxAT5VLocwYPhd+tL1ScoQc8xthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfg3NLLi; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfg3NLLi"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7dfd667e539so114399685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752268721; x=1752873521; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OFqJPzYPvAGksQS9dVt+uC2pzT/+CpXvsckZ3Hddsds=;
        b=nfg3NLLisHzm59WnZe5kITZsak2KW2kK0IloqhsBb1IH8FHj0evXHkjnCAMHZw3gNU
         R0w2Dg5dstBaHTXeuX1VIUlTapInMGTHxTvoJ2nviVotLSGS0b0LKyeZOmTXYj+uVOX1
         w3cHMGchi0LQFdCt1gVB3i5DqyVzrQR/XhPHlKFAl4SySwhVMVPwLt6Q2bPqq2Ys7i01
         FSrCfdAYt7sskvJOuS1bXV9W1WOsGwFskugoKdBU8ihas6dHrPNKaBrjwxCmdprnTdRt
         auKx+Q0syT7zDgvMNCmnZDnbOA6ZZoDD8z8YCFuLQy94UxZ4Jk3IkbxcvCYLTwSglst6
         HHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752268721; x=1752873521;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFqJPzYPvAGksQS9dVt+uC2pzT/+CpXvsckZ3Hddsds=;
        b=f8YKVvoMR0AYOLooDWMmdrSbwvaL19v5K6NjN2PaeIArHat/zdPEP5n1jOMNrfJ6fS
         tYNgdyNK2kTQEEP0avvk8htQeKNqo0mwC6OapWHxIsKKde/oZ3SJcrzncyfoAMS/emAM
         /XgbP/hNP4QwxEd5dnaby1VfMhPuvk6a+E4I+uJ8YxsHSIUlP+MqwQfCPa66d4IPzRkc
         Xf6xUdmSg4d9HbId1/baaYMnJLXBGB44/smXx2PPIpQlM0QfatQpfr8z38oiHCkP6z4n
         CdFxx6HtjT5HeoLGkII98iskWi9/1ewlE77bg/eGPtelyeIkiUEyCRWMgz9hac3iO4Ng
         JcjQ==
X-Gm-Message-State: AOJu0Yyh+Zuq5fkFXvxsT23yR37+Y+EB0ztwx/l3SBU+iyoIheZLp4WH
	5ksaKwoXUyJCBU5RDaHXQf9oGN41Pw5/pNKaOTuHZZaorpLvjlk9pE8B/ka9/g==
X-Gm-Gg: ASbGnctZNFZ7zG1SMGxGnHpTheTPsc2I9doT13mC7wG3oXNuDAzasAmGA8stmFZfJdT
	RfhG6u8/p/RY9r+Oo2DdxKQi8M0LVakkwXFcg4viKQgoyEXiS9reu2dfDKZz+9gyzrn7agb5IEM
	8gsqs6o6MW6Axnu+BlF/JFt+FfcDN6E5U5K9IdYNtSK9II25wOd/4/SEI8YHi+uqWOUIT9oIaqL
	zxf/gUYUz+npRAQELFyn6HWb79IkcBXTcTmETpCmzv+dwC7i6bV2ycrO5AKvUlp+vO0Vesf3DBY
	vSbspp4by+potz7UcRDAg6sWNA8q8liIs8CFYR1ZS7LgjaV/EXucC49Zf9AL+uMXoTcAqRWqx0K
	ixhz53p4fV5LdLRPDUMPFwpBKokq4VXgWR4Hmm54D
X-Google-Smtp-Source: AGHT+IF27vBLWw2eZDLdJYEc2FTyVc23yiWDyHCPtvzREjbq+UrAImdxMsh4WUhnPrch4+8K5VrZnw==
X-Received: by 2002:a05:620a:7006:b0:7d4:5854:32a8 with SMTP id af79cd13be357-7de06ac60e0mr771478685a.31.1752268721190;
        Fri, 11 Jul 2025 14:18:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.129.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f63f9sm259227785a.34.2025.07.11.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:18:40 -0700 (PDT)
Message-ID: <68717fb0.050a0220.372a0f.b75f@mx.google.com>
Date: Fri, 11 Jul 2025 14:18:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1177535920100015273=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC,1/3] device: Add btd_device_bdaddr_type_connected
In-Reply-To: <20250711195043.3875400-1-luiz.dentz@gmail.com>
References: <20250711195043.3875400-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1177535920100015273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981640

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      2821.51 seconds
MakeCheck                     PASS      20.21 seconds
MakeDistcheck                 PASS      189.53 seconds
CheckValgrind                 PASS      241.04 seconds
CheckSmatch                   PASS      311.47 seconds
bluezmakeextell               PASS      128.44 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      918.46 seconds

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


--===============1177535920100015273==--
