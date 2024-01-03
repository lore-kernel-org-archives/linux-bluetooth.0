Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52E1B296
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz+0Q+Ih"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbd1e9c5f7so4342173b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704298860; x=1704903660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uEzziF1mQsG97AuWD5xIIsdzrc8CGg35c8ddVyXp778=;
        b=Hz+0Q+IhModZK1NDznJkUpD5GeX22HyU2xuMWnILdw4+6y0l8QAXM43mwG2BGqqRvP
         R0k8gTvFDwouWHriakKUIpIC3ZfJG5I/NMcWX1Li1g6bI9HQmwaoumTzRaclJ3K+jkkR
         igUzCMpC6G53oG00za4whggdSsy2Vgthcx51VBDCANulfa/u17Lg85xtQmmXJlvmH+OG
         rMwHO0Yg4VGr4p+7w/oQ6Klza591xCwbaO3lcKsNdNKoWE3J/z4FvsT4cFfmNW01I6mg
         kEqxrRiU+88uqEXBQ9V29X5FBV/d29L9wDEgf73XkjaRCQSvcizE208OfX8/9DJ+baOV
         Y8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298860; x=1704903660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEzziF1mQsG97AuWD5xIIsdzrc8CGg35c8ddVyXp778=;
        b=VPn6GxDlrB2QBEP6eQgCRlvkzIlzGACL6GUKJ9MOQwqcL7RDYAdwKQhsROw8tQauYW
         cp7UlgxYq0GRYTI1+3oK6Kw7zh8NbsL/8uugOKkVjNI5+ciz8i4p0cTx0PqCJ5PDtbnl
         4J48QQ2RNuoIWeX7nolRWht+BsXO30iqtiJ+iJf7T+DcMkVS5F0gUoGetBID+GH8Y+t6
         9Sz+DLfggBeNlIWGOLBHdzWzkEb4ddLELE4C2oxbypbaj7DhA6BBsB24SBFPxnDJO2EL
         0kFT8rRmfC68gLkLZqWrgBy2nHRRZ13NG1g4tzsT+XGWDmD0NfuanqlbC0AjfoZNVOKV
         Arcg==
X-Gm-Message-State: AOJu0YxNltov1zD+PiLXQexudSeO+w6kI+I3/ZblPuK05WZNPAnqYYZ5
	bg06vQeedevxhcsCawxLw9MWVvsf59o=
X-Google-Smtp-Source: AGHT+IE62zTweeusirQEiXk0k+EldePsnK1pk6Be0A7vuo4g0BR85AChnvcaKK9mIW5r+lyKcKaxvA==
X-Received: by 2002:a05:6808:1709:b0:3bb:e8b7:f3be with SMTP id bc9-20020a056808170900b003bbe8b7f3bemr8617707oib.12.1704298859901;
        Wed, 03 Jan 2024 08:20:59 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.37])
        by smtp.gmail.com with ESMTPSA id hf8-20020a0562140e8800b0067f51698bacsm11048323qvb.119.2024.01.03.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:20:59 -0800 (PST)
Message-ID: <6595896b.050a0220.68f7a.0d4d@mx.google.com>
Date: Wed, 03 Jan 2024 08:20:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6650694444483932161=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,v3,1/2] avdtp: fix incorrect transaction label in setconf phase
In-Reply-To: <20240103143904.77146-1-xiaokeqinhealth@126.com>
References: <20240103143904.77146-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6650694444483932161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814123

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      24.34 seconds
BluezMake                     PASS      756.61 seconds
MakeCheck                     PASS      11.85 seconds
MakeDistcheck                 PASS      164.66 seconds
CheckValgrind                 PASS      225.23 seconds
CheckSmatch                   PASS      335.03 seconds
bluezmakeextell               PASS      109.42 seconds
IncrementalBuild              PASS      1397.88 seconds
ScanBuild                     WARNING   979.52 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/avdtp.c:896:25: warning: Use of memory after it is freed
                session->prio_queue = g_slist_remove(session->prio_queue, req);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/avdtp.c:903:24: warning: Use of memory after it is freed
                session->req_queue = g_slist_remove(session->req_queue, req);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============6650694444483932161==--
