Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE728BAAC
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514538; cv=none; b=IV3Jsxjq5TvLEyzqiV6tSeh+pyeLpE6bJLt39a9MfaTnXbGQqJzg4T/chLcUy6ORkBhneTfQIhswsEeQWCvGCCw+g5mXu2seNxwWXJ2Tzob5bZCbf2U6OdEboDg/xTsbert8y70lqFTlk+T2260ysvwLXR2aaZhx4/WzECYtAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514538; c=relaxed/simple;
	bh=aPkqBTubF9Pz2dSFc+Qbj0ndJgCwclUoOib/7bOHem4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P/y5SKyl979sE3xx5WLubW3uQnH2QLp6yNcHKnocbexzA0Oid8VCtJWM3nOem+GfrbZswvcnkLVUxvDlwUfK8L/yYiKYH2HmVvjHulRaC+oZ8PRd0nvHiBDPHydL4sTaqk48APr3WF/gXiSnkOwo0aAdp7pcvlWQO3QwaIHmIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwnDr9SD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwnDr9SD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739be717eddso976950b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514536; x=1746119336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JedDlyBLZO/kTunZHWrbt3F1Lv6wM0VCqjyZT46Zdn8=;
        b=kwnDr9SDki/Uirv1LqggKsEJibFldi6GJdbfLMY+V0weoKBpXuX979FW30WccQomoP
         1u7XIEbTANaRTas1g9J4Nq8fIObf2RQavpZ9KVmPjiILwNof0Js4p6v70JbqlahQT7Jz
         yhbM8i2wYi7RZk+8WKeeWfR9JxnyYDcVWm+Rv8o+i9gPnk+ZkpE08fDenOcqsb3Zh2ht
         Q1rlAuVVw2QgkeVn0bdVVxe4ZKpD6O8S2QQ2peUQctxjrvzXdm58yp089plxrCpZ3npO
         dqPPSEqYkvsBF6Qdn9gW8+xndFB+2B1Toz2doaSDJrAeXKSqGZ3OTK/UE6KlU/SkSnAT
         q7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514536; x=1746119336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JedDlyBLZO/kTunZHWrbt3F1Lv6wM0VCqjyZT46Zdn8=;
        b=bstCiaPKJXpmjzOwx7/NO2raGLa7w2W7/TVgcm5C9cMruA+u9j8a3tzfbhUgBxtEK9
         4QmMFuouBlm+9rscUTXTS2vGyCF78ByR8Yc+TMJNDWumkAqjhDxzZmirPFETW1Rs+zYt
         myt+PTb0Ugahu0BotIcbrd22B8Bw/sRcP1giJcoiwKZAsvoRVxUfB8OqwoS1AXi6YRyi
         Qt6FjE8EcM2/QF81o3Jl4JFZBfyuxPLvLvFTF8yF6gzyd3vBwv9ydat4DMw4ly7srydD
         6TxOBEAXxPgSL6RlNCFn4hrLkwa2c0T25sn1kQ9eC2dA+PShn+TXA+WRZN3oExA32h4q
         ATGQ==
X-Gm-Message-State: AOJu0YzqlgVGRtot/6qDIG5+LZ3PzxET/ved0nStP1Cq5FVvAUREsfea
	4YUe1E9od+SqFDZ0nmSvKfYx2JvP6yZY9ryJZJsJ7oSdM/UnHXEqCtrBJg==
X-Gm-Gg: ASbGncsQHXWCevdRGrnu1b8CxRnxLCPJcjHd6CfgBfOttUERO9xG7SFbW+bQhX8pMcM
	uagYodQvTRim8WerplEmS1VO5gdzGpxnU/Fdx0m9FIeU1BU0PvR0fxrzVOmSZV/v1ItgwunlcuG
	OCkA+9+lcc2d+hWAVdiLxw7EzH1z2YcAoNt7MsLm+wORfDOl2QTuRUPsOhfWK8tvrleZBg2lsTe
	SeUJSHcV7A7AQ71cOa6DeWYpx0TJdKm3nWH7gkLlqe8gyTh/h9JXxc6wRce1UNhsDWSv9XDVqN5
	r/6FY00sH5SR/WMqI/cTFq5RMyw1brR4vvRhEO/mgRYEK20=
X-Google-Smtp-Source: AGHT+IHe9nU60UwN6puwVQBi5iHyJIvmqlaBIvyyBCUkK/L4d2IoaLWPtdnowWqFzGpbMlcxPL7Bdg==
X-Received: by 2002:a05:6a00:2149:b0:73e:30af:f479 with SMTP id d2e1a72fcca58-73e30aff4edmr1142174b3a.19.1745514535710;
        Thu, 24 Apr 2025 10:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.46.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a544sm1652191b3a.126.2025.04.24.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:08:55 -0700 (PDT)
Message-ID: <680a7027.050a0220.1215da.4766@mx.google.com>
Date: Thu, 24 Apr 2025 10:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0095932028403544678=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] org.bluez.Media: add SupportedFeatures
In-Reply-To: <fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
References: <fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0095932028403544678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955284

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      21.61 seconds
BluezMake                     PASS      3048.67 seconds
MakeCheck                     PASS      20.51 seconds
MakeDistcheck                 PASS      207.32 seconds
CheckValgrind                 PASS      280.12 seconds
CheckSmatch                   PASS      309.45 seconds
bluezmakeextell               PASS      131.69 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      958.45 seconds

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


--===============0095932028403544678==--
