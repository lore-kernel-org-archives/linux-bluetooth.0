Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8733D6F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350834; cv=none; b=SeqHFIAdKjZKbKOEV1yf00O7/GIPqPQtCE56CqtggUrTedyVwlZbDpT1t6mj4zpMJWiH3Cs+7EUeMgi/N3YGY3RmqGPPe2gHlP80tHKBc4FbuXE1Kh/ZnTh8PjjGHbrJJG1BOuRFNe0LFA6J9Ibd9bWQVXC0+321e4OP5fZ362c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350834; c=relaxed/simple;
	bh=Q+WDD6v/xb1fTTlz0Pse5MaCHyxm590l61+8i/FBZTU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pt7yCgcylODmg4sNgT0aBWnBqI7YzDXQpFs+afbOJfvA0P2NKptnyR5qkxXCDEmVzJ/YfW4VcSMae3mIZ7EX7JOWAO8iDpT8DPL/u6D/udbmJ3QJpULPzjPFs0lagkeDL/ctInRK8IM28xtvUJ+DG1WmdwRo56OajdmNBRAJgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvYfYSLN; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvYfYSLN"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0ad52830cso7515235eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350832; x=1779955632; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ofJLXJKfzG+2IoQJtnK/X1yTmUJELIlkiLla5vjg3Zc=;
        b=pvYfYSLNtpS7raviD+L7vnP2dwcOvElHO1XdZdu0tRaVkgHTm9aepSTEdRmJoKFFNq
         4BzpLAJNEQzs0OhsbUT4ozXQ+99AV7oadTvOXN5jWddqWyHp+LA8ko6IgHrXxFrhYgqF
         s19CUggYCaJe6kk230kinIWg2xgNFW1lb59OZ6CWP7iwHCrZfTpdsiH08gTwknsfZIk6
         XGHbaJh8ScNFVXSzLheIFmnMskY0gPZlVjFjOkx1QlVVwlwlRnvJVHZ72mIvPlAyjZ5R
         vT+l4LhOdkcfpD9PjpLs4RLHnR+m6DU5cQ7LIq1Y1Wch0Kl3aDSnoelP9RSVf2ijbVUm
         4k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350832; x=1779955632;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofJLXJKfzG+2IoQJtnK/X1yTmUJELIlkiLla5vjg3Zc=;
        b=qrbe0Me5iATDHTcj8WVLp9hesZv5AF2uGEmI2wacwVXAA74HgDLI4YJ4VZuFpsd1Mp
         OX7Qich+N1A/L2s9oQ/eOrRRbdDy4mKjeo/zzaTcK3llG/M2KTkg8tdDand4/zsgKTLz
         iSJh9wH6QJxggvRX2Y3Twzxkz+ktZBzPNotOi+RVt7o0Quv3lOUb/UgdRd7PKmwoZHhI
         t1ktHM+FY+1zHARl+XxZDy4fLjJN/eh1ySM4xwu7MSdch8umhMedCSVYJJgp6Riqzwfe
         kBHgkqLw56WYfpZVOCnZQU1TQcU1GBG5pBlnDych4nUKap6ErD0TPmfM29m4zofnU69r
         Se4Q==
X-Gm-Message-State: AOJu0YzwJS1aBtEx56U1d08HeBiYqCTYO5ikfRnqlEU+EhNjcabu7++4
	0WL/tVCk9GzD0Af2vC8cFkfJdJbpXhYiq0wcTvbfVYidEDuonD1R9nHx7fQR/Q==
X-Gm-Gg: Acq92OEI8VPqBrQgR/fJeA8DWNe9NMHAv5fDvPIqxi8qucX54M0VkMWIkrkabqFLqol
	C71mK1obHukUakm+kbfaQjNl2XrCU3CnXzb9UTTuyr9/+8hbnKzqwlGC6hYjmue81UGcibF8/D/
	ruFtcQwBJV3xMABQmkJSKPtioHBWQas1dBbBpmzldUPu1u1vMCaFW1HnDzJl0spCfDb/KVdMJp+
	Oqsb7Mq2cOWGBKsZ3ITt9KOVJHU7F7Nngz++yNh91jBHx1KzJVmJnq33KBNQ0zOVYI5LwB8I6zt
	u/Rrro/s/3Fe8DFBqXezVvFGn/ZRVUvypLqqKGvAu6jDPTAyvA5xr7cfMGeYbnLbwo5o2EUqJJ9
	oA32bJ4Xk11xzU/iniXlURbFRv5OGliqJJGWhuv5IKko6NU2TVhAvI+xQJPk2JhIuXR6G5J7KeY
	jE3qplQjyRF6/8ZDxFxIKQ+wr/a7ZKglTXNvIaZj5M
X-Received: by 2002:a05:7300:641a:b0:2c4:dd55:ffc1 with SMTP id 5a478bee46e88-3042f43486bmr1086366eec.2.1779350832230;
        Thu, 21 May 2026 01:07:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.107.134])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm20293423eec.26.2026.05.21.01.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:07:11 -0700 (PDT)
Message-ID: <6a0ebd2f.df581d38.61261.d5cb@mx.google.com>
Date: Thu, 21 May 2026 01:07:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5254201406813117241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v4] Bluetooth: bnep: reject short frames before parsing
In-Reply-To: <20260521052611.1815693-1-rollkingzzc@gmail.com>
References: <20260521052611.1815693-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5254201406813117241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098453

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      19.75 seconds
CheckAllWarning               PASS      25.20 seconds
CheckSparse                   PASS      22.00 seconds
BuildKernel32                 PASS      19.79 seconds
TestRunnerSetup               PASS      412.06 seconds
TestRunner_bnep-tester        PASS      14.59 seconds
IncrementalBuild              PASS      22.14 seconds



https://github.com/bluez/bluetooth-next/pull/228

---
Regards,
Linux Bluetooth


--===============5254201406813117241==--
