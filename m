Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF6302CB1
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581628; cv=none; b=KXD9s0t2CTjlAJp1RVHvfDVYrSX1jQnsHnRZgahm9cpvuWDhvXERK12q807nI9Tikmp88/kUKn5uiRzvYtSk76mlGM8X/jpJQ5p3KCxzxCdbqF1ce3E2DHu5ldmJ7nbtRQ7eC5vlgbhwWKaw+KzwSrHjpJTccz3L2jNBoO4G5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581628; c=relaxed/simple;
	bh=UNkblSUNEOJmpqcNzNaBBKg12zH5nPtEhktHjUMPhDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g8ElnMybnztNxnEyatjjMD7VMSk5BOoGFfoAJEAQ7VVyZwlULJa/NgrWYxniRkVUbrJNIjwTUB2m0tNKkjMbdoNWaBG1qLrJYBlw6gAlDWxrnsJy4sQF7BhuBS4w1AESvoHdxndUAFkkmG1C57Ark85ExLOP6jNdxcvI0p/AOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2zN9UAe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2zN9UAe"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so3664274b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 01:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764581625; x=1765186425; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oLFvBofzfee5ujMbE+Dq0Grdzku1pyk2/8X153uYEz4=;
        b=b2zN9UAedNueBRvIrGfwZ7qgy1DmGRVLSUgNw/sBonvFr3SX/gMWaEFBDRXwf9xlZA
         xEBYkZEXJzelOmJBYxPoJacyYMRSn3caVsQ6n3aMBZFxa2DWZ/8bTiU6vzUgX1GUy/de
         VnKPIP+XXEEoLbaOFPFeFy1fjwIimH7dD5piD9/yuiY4TAa1HnfzZ697oL0woFOPVrKO
         HFmDkwpTsMG487QVmYUeAEuSSqF4UhMExuiWJ+F5i/Zzu87xSYK1OQMGfLVasTdGJ8ng
         Agqz+DWjortf6Po/LZqVhivbq1mWliUHYK84gxlBkZvY09JALfyVbSyDJXGFRshna3lx
         OCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764581625; x=1765186425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLFvBofzfee5ujMbE+Dq0Grdzku1pyk2/8X153uYEz4=;
        b=G1KTAyxc08J8auaOmeFohz8j4dQ70c9+ons4N03bCYr+DGHvWfAzm9thbNiQS+sQsU
         /BIGLptxDlC4+1VBtYGkWm+utU3mj1T3n+a2EJPm5IJZdkYyLSemxoBzxm6LJ9pt7E/S
         y5Q0F4GvxtDEzKzL+hQZk1+o6NCOmVbIw+2Es3C8sY3nTufVhtJTgSMSKkJ/+It5dj2A
         g1ODJ9Ibqu3UNuTfEk+vwYLoevESm2Kn2J6uOLnQy1Rb4zDzGG2E92gQRRF6uaFEqeHt
         INQLDCW80BSbk29OfWPTwZwX/TZwOYhybYmOfOHa9aY60850OTbkHy+Y/uWWJH6Is+EX
         lNIw==
X-Gm-Message-State: AOJu0Yzln+6v7ieUO+KJKdtLM1anM+xA3Y8EM/v8G9Ux/6CU7wAfnfC/
	Ig/3q/EGUBmdA+w96zU6yzJ6uBxAqBx2YQwVKNP3wOgr2y22ygc6MxvpAMbRvg==
X-Gm-Gg: ASbGncsgxdqVwoZEO0XqHyOf/3b/Hk88s8YxARdLWZRt1nUJ1rYD+1kYEvscKSNH/d8
	n9rrbGrQjZRwmBP5vy5RKs+RKZd/2ylmzH/2vWvmVZKhNULtaocs+1yPmCKxB7QOQL2bXf/IgFv
	U9KtV9emACr1aObZ7AS44dm+WGoB5wLrOSgME8NqsVXHUQbvbSXwRH7sU9WdnSMtFQnvzNW2Wee
	GVcYkoFK50kwmp65s0fO/XrwBYROnTt5HyvGJxgVRRgRQXnhnq6zcNBh+gNYU4Neet5OaOARNxm
	yRUNgSWPatG/WPLC9kPYfFFH0gpRKqLRiV2HD9QOJ4dzs1RHRXIrfJIYE8FxHTymuxBqGqLX2Hl
	iFsS8rAdtthUG+4JJrvOW4r5BqR0NB2BkZusOmwJUbOfPvHXOTuOFnmhzNmD1fa5mEieOfpzicY
	AXKMByFM/PejlBz8rGZA==
X-Google-Smtp-Source: AGHT+IF9/A3X/ix/9Uv7ZvANjFe1sbUzI8g1WZJR13ENySnSLd1BL9/5xlLlvP1hBsOYu92vsAibcw==
X-Received: by 2002:a05:7022:41:b0:11b:b1ce:277a with SMTP id a92af1059eb24-11c9d8482b1mr22437676c88.28.1764581625373;
        Mon, 01 Dec 2025 01:33:45 -0800 (PST)
Received: from [172.17.0.2] ([128.24.161.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb049cdesm59567119c88.8.2025.12.01.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:33:44 -0800 (PST)
Message-ID: <692d60f8.050a0220.30d7dc.5508@mx.google.com>
Date: Mon, 01 Dec 2025 01:33:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5768194910614757240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: Add implementation of bearer connect/disconnect
In-Reply-To: <20251201-bearer-impl-v8-1-f944b6f9f201@amlogic.com>
References: <20251201-bearer-impl-v8-1-f944b6f9f201@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5768194910614757240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1029135

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      650.16 seconds
MakeCheck                     PASS      21.81 seconds
MakeDistcheck                 PASS      238.37 seconds
CheckValgrind                 PASS      294.76 seconds
CheckSmatch                   PASS      340.62 seconds
bluezmakeextell               PASS      179.98 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      972.27 seconds

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


--===============5768194910614757240==--
