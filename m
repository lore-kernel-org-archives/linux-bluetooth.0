Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D73BA5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566952; cv=none; b=Wt/0CcYs4mZlSJOe1KlMY5I0nmPuL16nNJ5Hx+qpEjS6Ns76EB+je1XnLsA6icn63paFlPSGavUickQlrudRbV0/ywpauEjRlmAzcafdJ47TpWG9XWTK0MEY56IGxON8/EeT3SkQnnaMAvdcu3LLMVnF4awr4Y91dF+zN7Vm4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566952; c=relaxed/simple;
	bh=UdwLD2MworUQaNrCsGbdRhKtKGhOW39Tb/4/T6q6HCg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References:Reply-To; b=hi2uv+Ie8neUBYG5CHopsqnS56MPlO5vJT3Vi9c5VHOebPR1Ma2wt6Fo+2fWJU1Ibnt365LDH3jaK4jpvqZ0cSNpXEQgZHUxPG9F9d7kSlR6CTtxHgst97e5dLYtutmCTL3IlPeEpJRoHOxIljnUTfXREl2dHzkkh1CsdBrV/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PriRhTup; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PriRhTup"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7837ead0f53so11111385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 00:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705566949; x=1706171749; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ghkO3gX0x2non2j9ojPnfwspdOFbresFh1d1R/0IRsU=;
        b=PriRhTuppHmCtGRu3yxcI+j2qhHWEIRuX1XxsEKoMJR7NmQW0bmyiIRBfDFILA5hcS
         P/1Y/e2Mh8roI6y9FwTzzvv36cyNK0TNDJsHgjrzHYWuxdpWxaWGuTWZInCw6VDVUJqw
         Q+90eWF7fshcchgXWpe43Pdt1oWxI0eHA1wqPTojhnxPpcB/SIRe9EMfDfB0HRC8cK0Y
         YIoK9XioGarQVvmcxpqCKkZJQQduEHy18i1pmZwnZwc+Z9jpXBuMdwB+RV4+MIfKs5fP
         NhxASf0z2US3w2l3lLlo7oMoSJMTN7ZdcTYJRp3iGkKD1oxzi3GjQlbSVy7JVj3De7jt
         jFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705566949; x=1706171749;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghkO3gX0x2non2j9ojPnfwspdOFbresFh1d1R/0IRsU=;
        b=lSa4ntDY0y7YGfjWQDjNlLn1ysAT9ebmtDc7Q7/NDSqgYVZSXh5kpjc0AzlHKoVRat
         GrGTWgmSzqts2xguCvFPV+LBKFSvu5l9XS9t7PRB09nfMGO+wlcoPQjTl87r62R3nUGs
         hTH3uu+apUPpekBCuOoi6zadfTRx0GkrIdPg1XGt3HaG06zGpsIpxZpnf5O6kJX5SgHf
         um56OXFqrIabFLzrF13vJNv230t1ng6BmO2R5kiKEy7iuo7gcfZHQtmYqslrxenD4UMT
         7/SZiCAy3t7L6h01okHz3KNbc/7oJgU05R0M5e78lCLar//GwSQ9pwe5rxTGaW5OfPqm
         CcJg==
X-Gm-Message-State: AOJu0Yy8floohKtRQ4fNHbJqKSZVX6tCtOkOsop1ukThDAVPorztOFX0
	yYcKH3cbp9MT33oDoE+kSYo3zyyP/UeqhtaqPpO0/ERkFp5qsDy6OtNiMpmt
X-Google-Smtp-Source: AGHT+IFMuPjkgNyqBsw+hCEq6s/TvdiWT0fpNlGswlVYEWq77KvYRca1UbQ+dJ19hC3XmHoXebj0Xw==
X-Received: by 2002:ae9:f806:0:b0:783:3c71:fdaa with SMTP id x6-20020ae9f806000000b007833c71fdaamr395095qkh.106.1705566949304;
        Thu, 18 Jan 2024 00:35:49 -0800 (PST)
Received: from [172.17.0.2] ([172.183.79.3])
        by smtp.gmail.com with ESMTPSA id a22-20020a05620a103600b0078314f2144bsm5153445qkk.44.2024.01.18.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 00:35:49 -0800 (PST)
Message-ID: <65a8e2e5.050a0220.c4534.8a89@mx.google.com>
Date: Thu, 18 Jan 2024 00:35:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3768107949124203443=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: mgmt: Fix wrong param be used
In-Reply-To: <20240118074927.2051489-1-clancy_shang@163.com>
References: <20240118074927.2051489-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3768107949124203443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817741

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.12 seconds
CheckAllWarning               PASS      32.02 seconds
CheckSparse                   PASS      37.87 seconds
CheckSmatch                   PASS      100.44 seconds
BuildKernel32                 PASS      27.37 seconds
TestRunnerSetup               PASS      441.70 seconds
TestRunner_l2cap-tester       PASS      23.54 seconds
TestRunner_iso-tester         PASS      42.57 seconds
TestRunner_bnep-tester        PASS      6.97 seconds
TestRunner_mgmt-tester        PASS      161.70 seconds
TestRunner_rfcomm-tester      PASS      10.91 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      12.29 seconds
TestRunner_mesh-tester        PASS      9.23 seconds
TestRunner_smp-tester         PASS      9.95 seconds
TestRunner_userchan-tester    PASS      7.47 seconds
IncrementalBuild              PASS      27.13 seconds



---
Regards,
Linux Bluetooth


--===============3768107949124203443==--
