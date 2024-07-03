Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA61822F8
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025082; cv=none; b=AGF3otbJdIR7KWwya/1DD+jQ40sO2tNLFGoH+h8/5n2mh5JBXagdYhA7d3XT8TJ9eQX6Mp5aD2d9LLWR1mPODpRIMd2AXrvV8CBPjpxLXTljVqUlD9ZnClVoyfWoAPtUoDjiIIQ1yW/dDr1g7z+hibbHk7bQyGGttuGY4G8jTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025082; c=relaxed/simple;
	bh=XH67f1sqZ6+3CHD1NIZCcOl+mDVlWv9NZ2P61y3Bk/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fx65iAIT9F2jbmKW9aDg4y+gn04WW9lDD+LKEx2sfjHP6Qdf1oJT0M0l9bGhU7wT3O7LaaS2vGYNCmAeO8WpP9T1gOkxnTajPlTHHYh764GS7ijjnInAETZVUBGJrB2RRiBFmat8U5AIgcSKeyYFvw7Qgx2lbWMJmYUK1XbDwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XElHjbwZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XElHjbwZ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b42574830fso25714756d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720025080; x=1720629880; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gQKgdoRmfR4gUXJKWavER6U1MQGGwiDsGqCBgYVv5w8=;
        b=XElHjbwZVULqPdPc/AYgTd4+icnOlgv0ffj4ZhxFznS+lV47bu3FyIOfq03TPf/Czv
         UDGEbDy4CZontVq5tw+5RJt0CfH/C5Gq2B6B7N/dSKqekVAq3oqHDsoeaaCy+qrjVrmj
         7m59pQ4O63nEqlEpMWoadbI6wi9cr/lfVAWA5nszzjEpyaOCmH21PhwahRkaTbVIdB/y
         WMpYxGtiVEr5ZrXPa+UJT8XJRhVQwXlypg6j9AhBUhcgur2n/OP5dbdDJKrBEDF8Wgwz
         n1mJNJevKqDsikQJXddXOr/PAtDRdhEQejBumtpTY+rkbmdgYZH5w6gikQIcePhpMUSs
         SrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720025080; x=1720629880;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQKgdoRmfR4gUXJKWavER6U1MQGGwiDsGqCBgYVv5w8=;
        b=AscupYcvvNCKqJADNOHMlK+WXNEzfd/pHRWlHo80L+8+xO9GtMsAyOULEvs0oVczg7
         BbflGEgpg/kPRGGG+mbz6U5AOo9VI2A4Wh0yk4vf1q6Nxi3c82O305nrG2iAOu+fzyJC
         65LmYc8nORNUF5ZKQZZXaMx0ot95XaRiV7VJAydrGHigN/2qtmvRE/upzxswm91o6V5e
         l0qGrO2aAsFYbZOIgjfJnSNSjZQ5hqAhtLDOvpYEaQvhpLzYFbyLFbgu8W6ckCsVw8Lr
         sdhDCBR587kkN9DhyOTlcTX/PYqQJh6GOTg8wdNSwDZTMq/noJs9gaaN2swktgam1IYI
         dvxg==
X-Gm-Message-State: AOJu0YwfSzOJuKj51BCgZtwqFpGInVPO3x4FcHpiqKe2tdB5MpEulEUW
	RkubOxHToJzw3iBz2sIO4pXDtaK1GRMOWaZ5Vs47p9CRootte3uEXyQ2DL/w
X-Google-Smtp-Source: AGHT+IH7rwFeYTSc2HVtvQDwY2vEu+C0pWs4S6NxeHdAndH5sME4rnJ1GKddzDMOIcH4PRbEFX8VQw==
X-Received: by 2002:a05:6214:202a:b0:6b5:e3cf:344b with SMTP id 6a1803df08f44-6b5e3cf35e0mr22402246d6.53.1720025079847;
        Wed, 03 Jul 2024 09:44:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.195.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e615b8csm55025736d6.123.2024.07.03.09.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:44:39 -0700 (PDT)
Message-ID: <66857ff7.050a0220.ff9d9.77c8@mx.google.com>
Date: Wed, 03 Jul 2024 09:44:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1933975638718536643=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: doc: Add initial MediaAssistant rst
In-Reply-To: <20240703145839.34828-2-iulia.tanasescu@nxp.com>
References: <20240703145839.34828-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1933975638718536643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868086

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.60 seconds
BluezMake                     PASS      1737.66 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      181.06 seconds
CheckValgrind                 PASS      256.46 seconds
CheckSmatch                   PASS      355.81 seconds
bluezmakeextell               PASS      119.44 seconds
IncrementalBuild              PASS      1561.86 seconds
ScanBuild                     PASS      1033.72 seconds



---
Regards,
Linux Bluetooth


--===============1933975638718536643==--
