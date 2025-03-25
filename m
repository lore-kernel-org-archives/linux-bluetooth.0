Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB62E3361
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924384; cv=none; b=osL4vc0tyWsD3CTNTGlLDsSfE/K7ql03xtwKVyci6HMAqUn0tXPUIqz5RUfoxu7PJNvtEgL37L3z8JL9suzw8EjzbnJY7XJMNBJ4DTVxMboWeLbdYDNIG12nU1HafuQ/fp2iFEwXZzhNVON5dlwZr3jKq7YMB8XKeX+mlTNKrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924384; c=relaxed/simple;
	bh=OyWRe2VjAQsls8ESDzwcmlbRvsHbN+B8FInxZq6lFkU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kdoilHHfPB92W4amY2W6bmI3j9xOM8lC5a2oZkmJ/K64YT2ByWYPbtisqcZa3jgF8YThBgNRxLOokg4koRG8jef7hY8TzFFGQqY+clrubNAh1dWnxpK4/3Y0zyJ/7zY0YZA56GDbdqhTQNfC+XXjb3FJl5O0soLlovaD6yb0seQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRNEeGJQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRNEeGJQ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4774193fdffso35707421cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742924380; x=1743529180; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sFrT7ufJcr8lBXG5zwgSEvfnW6PChoFfNZfrcrl28Gw=;
        b=bRNEeGJQ03sahtP2yxbx2Vuj++fa8JUeaxCrM2Dw9k4OiTlFzi32gqMKJrZrEIdFZF
         5wrG/dwDKKGdUgaTxYvmy3jbII3eOp8Zdi7YASykIHcd/BLPAUagpyilP5+lIVkd1yBy
         OVsYYNg/vIQT3bibLZ5QXhZMhosFd28NGeKhA1NYm8O6Xgp9nS120GxUvCbHcjc8rmd6
         ubAs0j9hocrLW7Xltws6L1uYow8J6PetiaEfIycRkuahnMJVobSHLJP9OrYxoZj5idPI
         NJ21NqYdkBC+j+dfCOdeKBt77L5EpmaRL7tzcUutRE+oNHoEK9vO39SG2fgxi91AKUOf
         Jhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924380; x=1743529180;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFrT7ufJcr8lBXG5zwgSEvfnW6PChoFfNZfrcrl28Gw=;
        b=jWQr+zu6S/NxVAwi/h9xzrRAtb0VhP6id2XsbqFP8QD2RU5CJILk6lIEKXMf8MZP7e
         lhTN6NTP/JTpus9qVxX8kESbw/1XFWcZFRFhb2dtZQCVOaKsdq3zpTas93+UkEKdztsU
         bSusvUo/KPyFcO00aYDQBlDjINLMxp4lHMbwHFzjGsqMeAsh8Jo5VFjlIxk2E+l9+ivC
         W5zqixl861JNKWUCcYb/1G4ALocilUShs2gNqYAfASbHD1lzOSL0a/caYgBIGbrDl6T5
         7HrV7qZSR9VsOFk82qXdSLWXpa/nxluaelz9DutokioZ/9OtW2Vb3Su6YFK6VMKkrffU
         E05g==
X-Gm-Message-State: AOJu0YzFbt4pmGiy2RNwykyIyB0jzOVSKXdpCbYOyagUf9dA5E+I1Yl2
	B+zNIlk+2lmbXsxHH4O8dQuOtbc2w1qvtGGJjzqWp72nWug4kA5hYe1Miw==
X-Gm-Gg: ASbGnctqx/CFp5JareyGbs+cQCWzRoUnAaASGxsFaYISRzuYfAE/uyEZbMGeIyYCPH9
	XLT5f/pL1jpCn6RuCRGCToatjc/5Bvlk7Q5dWwy5I9P+Qy3SWYTQZg6eStLa0+wfSf77PTUd2TA
	+ioxhwd2GX8F8FMHs9Ce6zNCG2bb2O5IFZYvz60b6/PK9pp0lrXXB7D+xIpJwsNsZC4aX2qIb7b
	8uu2YQ2eBEIC4UaxuMXMpCS8tk6IK8ltWgC5AfIJh+0+lJKs9A+tT3yMKAhyWkd42ic8/GmAnsL
	dCJvaNrd+KqerZfJuXtP/BdhKel0skVCTjJJC5mzS26/3DoReYm5Gydd+KI8lg==
X-Google-Smtp-Source: AGHT+IHDz25gdnZkQO0TkJrMpnzR1EUGZW7jzcMiQymWA3GSptcpqOxkgf6FFM7zRBzqObBy9bUhWQ==
X-Received: by 2002:a05:622a:4d8d:b0:476:a7f2:272d with SMTP id d75a77b69052e-4771de8b4b5mr333875351cf.44.1742924380231;
        Tue, 25 Mar 2025 10:39:40 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.30.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d15a3d0sm61900401cf.5.2025.03.25.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:39:39 -0700 (PDT)
Message-ID: <67e2ea5b.050a0220.5f395.b735@mx.google.com>
Date: Tue, 25 Mar 2025 10:39:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3619322780063263068=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] profiles/avdtp: Fix reply for bad media transport format
In-Reply-To: <20250325162548.149495-1-frederic.danis@collabora.com>
References: <20250325162548.149495-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3619322780063263068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947225

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      1506.42 seconds
MakeCheck                     PASS      13.68 seconds
MakeDistcheck                 PASS      159.55 seconds
CheckValgrind                 PASS      216.15 seconds
CheckSmatch                   PASS      289.42 seconds
bluezmakeextell               PASS      99.94 seconds
IncrementalBuild              PENDING   0.89 seconds
ScanBuild                     PASS      866.94 seconds

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


--===============3619322780063263068==--
