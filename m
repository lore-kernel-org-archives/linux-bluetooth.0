Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7B3EAC84
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040488; cv=none; b=q/yt3fI+J+kik0dyjwLIMaA3hml567x0SEJQLXzGmOUb9F2ns9cFkFrtfmbPoPXSVrgcAbf1dOIqiaeRaqTEE8rPE2DJQwmaRQnWhQz5J9n48cHdBgAhl4ymYfFBhP2D5eUEkenS78trpP+ItbQktY/wh1LwUUtPxDkkYGh8dTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040488; c=relaxed/simple;
	bh=o2woC1/XZjzHqEllJAVsxjBgZQc4kAsH70dvseZkAps=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C/1pQRoXE6aCxd3YEJowXDoiQT1X7U11ruqLs4NL2+C7yuIxN7eeSfvhsaNcox//w+6sfRF1K09HLVLLSJbZ7NsmMhpW9CPyFJua7nWKekgfi4PiDpWjCo4Qch0bKw0AwwB5UINHE20zeHOJjPAVBh2Z60G3sYO5Q5en+tHZVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqA9vFxa; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqA9vFxa"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb545db3afso626790a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040483; x=1784645283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6k+byLP1be76p8lkJqAOh8sg+wGHFZE8/an9emC04rE=;
        b=KqA9vFxar1hUmLOhZMmaPGUXRG0S8SWLu3myxyFaBRoQpx9eG4dEZu6mcLvu+sDmE6
         KafhhOV/HXz36JCNzlwDgwCnFqS5rcOAKP4E23tTQlg8tapqsqXERLIwziNLu1quHq4v
         vlui+YsNG+cl1lzXhoQk0IkluwW8UkAgCN5SE0/9oPmxZPPbjh/8kgLb0SYfhyG6UWhp
         RDYwaORbD0K2WXa7mclkG0/9RY1J3kC28VGpCkko/Crn5A3z3CzqDqa0orjg0ehOB4lT
         rBA6ASF29K8YdyRykffH9Tm2IWub2dzliNuKQA0I1xEWAxIcLrKGy3Fo4rATMXoeNUeJ
         20Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040483; x=1784645283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6k+byLP1be76p8lkJqAOh8sg+wGHFZE8/an9emC04rE=;
        b=MWzTNTipjQe1YmWhzxWLzBeJZ+/xgYrJq1j/D+W+bbJNRkpAaI6wqcniul5p44x0s6
         sZVwWuGsdV6uaWdTQoCGWD3L6vwX9gSavE3kEMTEReIDymEbVb9T3g3jAyiFlMWdKIwV
         5V8wEbFvaCnS1vYVowEz9xBU4EpNy+ByFIWTndova/XN7dbR5SQIN/rDTwJ1he9y9567
         Fh+s8FWbEmy5oYaDy88qTzD2Ycu8boA8RkstSt59vl+nUINABr9hprnCIzWvQrlIgGeA
         t7WraFnvmWBG/vrGeNUxKkbQdnkqFthoUToRY6jB6lStzN/Myqtm4A3xTOxqvLokE9i9
         S8Cg==
X-Gm-Message-State: AOJu0YyNvYHXLlhgivPQRxFcThywGF+xdWiTsyYpE8w2N2bKmpIhmS0C
	ZjLlNFanm58rebxDlKmytYEGsFlSyETrcx7ngKh2aSMrsMb5UDb1lsK8coB2cg==
X-Gm-Gg: AfdE7cmZWBuhYUHuFhnkEiwxMlzaTvuwderJ7ZRY8oZl6kDcpNntEyAzAuPX8+Q0LQm
	kQcOANKtKJpX1XiA9K9w0BvdNmYyhBRrbzumZWY8cl+25UT+8FRuhx886Ah5A9d6QRy+Zt89gQt
	CBcVUIIr2CTd6r3si4hGKQTkiqe98jxldnstckuFf9ADVPs7v6hmhchNcJYauRU9MwpqudjkJvL
	aH7oPzOe/j31UKLtYIhKldysjz+gwDyUBjS8GPFJ59YEqcHBqXTBi2a2gpjtPsd4aAkE3EmRivN
	WPDUMr/Ug1d8unPjDk/9CwkMxtcqtjsIWm0C8sfMjoI6njeZmSAJ/5ctDW5aVXaTbAd5eO/0Fqm
	/x7iPORnyj2QXQqteTFIh+9zvllK+KBqA4pjB+KBtvsEoC5lWG4PrvaMieVyXRLxXGXH5quOffz
	39IyFc8gYhqRL2bYrgUw==
X-Received: by 2002:a05:6830:3890:b0:7e9:b4cf:d8c7 with SMTP id 46e09a7af769-7ec098f0abcmr8238001a34.27.1784040483562;
        Tue, 14 Jul 2026 07:48:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.238.4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2630casm16401552a34.18.2026.07.14.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:48:03 -0700 (PDT)
Message-ID: <6a564c23.a5ccebaf.28c3a2.908a@mx.google.com>
Date: Tue, 14 Jul 2026 07:48:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5685892327211954655=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
In-Reply-To: <20260714142430.200689-1-kiran.k@intel.com>
References: <20260714142430.200689-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5685892327211954655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127501

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.11 seconds
CheckAllWarning               PASS      29.03 seconds
CheckSparse                   PASS      27.02 seconds
BuildKernel32                 PASS      24.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.89 seconds
IncrementalBuild              PASS      24.91 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/439

---
Regards,
Linux Bluetooth


--===============5685892327211954655==--
