Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59041DE02
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275075; cv=none; b=QpyKXvC121fcpUCEXFCTBP4GNiIZ8lAiB1eEQjk0KJCKVAZPRRvndSNN+FvBER4oXYr5QsNoWMvkIZqUybgzNZ3X1cb4yDfFRLTZW0mfiPbT1yMJThkhSk14MEmogixosHFTHe2ayTMSnWcRRF5kNXVRycLHKEIuYwFL20xEOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275075; c=relaxed/simple;
	bh=l9t3//NdjCmCfoRkhyHeuuU+hTMHBXIRv2vJRo9WOHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=emov0KYUxl5+BBxlOkTYtUVkuul9EFJHN2dxhjcKGSE7sRUM6yBjjjoJA4CRzNTrkmyt+siWxjYTT9XZdKcdIXdX61CbAVKYQ/XhpseoNQqU5oIliiKUDUvQPWGN8N+M9WfanVd9417HRjS/VD/sBs+3WKbD49tHsJqVuVq/jCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2IyKAyM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2IyKAyM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398b3c37877so4109108a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275073; x=1788879873; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0TGP0enk6e2iPhzjtVY1uWvapqGW8BtpYYEBY+DaLMw=;
        b=l2IyKAyMhjpUdc2UOQCrd/pnVjmpZkdD5xL2Pctyqs06DrW7m3o8TS7B6uuEsHjNOF
         6K7yC9i5Bw+tSV0X/mfvR7PevSzJJrpxt2lICp6VEcwBeW276O/jUlUzut9zlBW1JtO3
         2lO5ciOecNZYFBn9TMQA8bLhHWsDR1zyQIS7S3uhVJAjJSUO8pu6/2J2Z5MWgghGhOtt
         UhbfokZ8C1YHi02OIWpoDwZ0w3H0GX57UHMH0lwjkhp6bWk5Yqf3Ipm5tFoD9k7p2a+C
         gLZpJGWCmO/CUAH0vkPcyYwirnWr0qSqJ7+XmWtyYygInmWS7xD/RSViTN6Nryy96a16
         ShPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275073; x=1788879873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0TGP0enk6e2iPhzjtVY1uWvapqGW8BtpYYEBY+DaLMw=;
        b=I4PbEvyo7v6/fY5C6d6TgcobS5e7ZDDS7GUqNs5InxngzPnNtFFVBz7EztTclBmF8A
         6yv0gJmnAu8E//rBE06TJL4YDZs98UNjyRlQVCFLojTcwgAHO6MyYeKEFN7+NHpUTbu8
         3uCKbXmyPU3F+sxg/F/JxQkB7383kVp3lBLo1Vduc3fa+PNDmfIfdzNi5qhiBjg/wS6/
         s3REClFdNsJktFXk8RKwDnXQQPTR7yS7ZUiGhKYBvqBX9mFXaQCmx7VwmtfnJqlz9EBi
         qPuotRa/cwnhzHO9aB8Ues/OZ+MWE7xfJmzktIBrcDqBHQSSDUsxyOP3VF9QE33SoEfi
         V/qQ==
X-Gm-Message-State: AFuF++mKpyimWTfWdPcewEC2DlYb4rmZtw8iuhgMjh3cEtbn3i4eGN4M
	+ObyZx3JIS99PTqQJZayqZz8fYqe4SEylJrIhIjYART5lgKXhHS8llsfUXx2pw==
X-Gm-Gg: AYBFou1mHpF+csItC3JOYTHo0C2q+YZHZN70wbmhpYbTonkxGBtE4KJtRbkJkPXzG5u
	J9eVpyoAWX7Az7PkkGewx1blhdr/iUyAhDoQcLKNfGaryMSIxVxJsnhIkAvnNuExGbcQwrZ95Hn
	b6uWTRNOMdx7ZKWe8J6W2eZfDVema2RfjmlwQ4udtScbxppxS8e2M5mLzcB2izfTwPvjIvShyDl
	a1Byzl+ppDodCj1qyIdp247VtLaTaQTzgwMPS3QK9jlOUo4pgheR/ixIdg+dHHNj1B01eByWI3Z
	HkwXgEI3xsemmV8CkxMlJn7HX1kZvS4j79UvfXa5YaM2DXnW3ijdpJ9VvgYcjYP0OUzpG/GvDKQ
	ZoHzih1FoZz7JPurA8vnI7tYqtASOHB42aA8Yv6cOQqgUnBXyOFk/708VgBZ6bIXYSrXMB7zdT2
	rikDqWn9rvi83ruvjq7Jm8bIfq860mS6ni60QykIpOcs9/vMNWCM9ST+7etVPvlce0iA==
X-Received: by 2002:a17:90b:57cf:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-398d132c2e0mr27031272a91.21.1788275072758;
        Tue, 01 Sep 2026 08:04:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.231.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm42666425eec.29.2026.09.01.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:04:31 -0700 (PDT)
Message-ID: <6a96e97f.da55105d.18229d.b6c2@mx.google.com>
Date: Tue, 01 Sep 2026 08:04:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6572592621606933111=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Improve GATT read
In-Reply-To: <20260901125440.355578-1-frederic.danis@collabora.com>
References: <20260901125440.355578-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6572592621606933111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155344

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      21.05 seconds
BluezMake                     PASS      630.53 seconds
CheckSmatch                   WARNING   330.70 seconds
bluezmakeextell               PASS      105.59 seconds
IncrementalBuild              PASS      635.85 seconds
ScanBuild                     PASS      1031.83 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
client/btpclient/gatt.c: note: in included file:./src/shared/btp.h:335:41: warning: array of flexible structures./src/shared/btp.h:340:55: warning: array of flexible structures./src/shared/btp.h:363:47: warning: array of flexible structures./src/shared/btp.h:392:42: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2465

---
Regards,
Linux Bluetooth


--===============6572592621606933111==--
