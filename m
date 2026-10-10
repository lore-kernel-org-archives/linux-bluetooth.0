Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5B17DFFA
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791592565; cv=none; b=hZRyyoj/6kSLsDudDJeX1R0FvPgFuxdhmkxJ/YkPDo/e2YedVWtnBhLQDNxy15JKrivUGAE2F18ioxBx7/XJdz1fVZdl/COn12XphOLMzWUjw/cVHe385ffQ8xJ9umoPcdBYaLcENJWRDqkuwW/owNAgbxXPNlqGa4sNAUoKSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791592565; c=relaxed/simple;
	bh=G4mixDfmhOppId3+jDkP+sOp6M/UmVBRqiNt63/B2GI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bvjlVrP6K1cMW+kI1vY8INDytrmsO0EGyI5D5cvguQCsf6liDwvHJVEZEizjUi69x74SeWH+0vMmnfjkg+CHc3Tbd2LAJrkqzUqBjiDB2Ue6golmv7j3awXwuc/BhcC5nvmXr6t7AnUXUdL7cVEeZFNuVpGn8OmOxWCl+cADi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siw/Nlja; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siw/Nlja"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-825b40f8a26so168255a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791592562; x=1792197362; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MkbYJbVXpveWdN/D2QCEljoJoj29ZJtoCF2HF5XYp9k=;
        b=siw/NljaIzOdlDTancI0Wb8Fa0kJzeHGz+hI2Jozi9vylBvUrqwkUworqTfcxYBrro
         jQOXpoeXMwHI/0HFBxi1QmyLpGcczdd717IuxkAKaCtFonUPvfupiBWHBw3VhFseIEKu
         rkfLI8K4s0EHpGv0H89ixOp7KRRmKmwS9GyIE1Oj0ntfzqJPthPAEJAlF6LE8xSqllQ5
         8pn4fPuJhVHa3w/KRTslYbA+LWav5Iak0R8TcYvYQ8v6Ao2rDGVEDZiAy1EMGkrfj/2M
         dryFZYQQ9AmXAPWOEzmAt376f0Mwng8HigdgxbPY9hH4/zPoGMoeMk+BYnUgJPca/3zw
         DChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791592562; x=1792197362;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MkbYJbVXpveWdN/D2QCEljoJoj29ZJtoCF2HF5XYp9k=;
        b=SKaF3keWpvpDVdWa9SdrhtEefqMFFou7ViR5p/EGk9o4rLfKqFkaXjq+jB7oX/Rn/w
         WmlGlSau2P9HbGJ7TJhPW2sjPkqfDnb/gMPipRlrj28HWW+m5pEmlNoYVNAN9LuyOOHV
         h4epF/l6n0/8TeAdZKkoYbfdBTzsyYgkFsNZiyPfa+1Fpliw47zYXgv5yiVIO+LyKV9E
         2wdt6N7YH3cnLp5NB1APBTlf1Q0evapB+JRvAfRE+3SPj63f4qYq07+/vhLmhWcGqrim
         dfagwK0KI7Rc943nrvubfKfxsiImP9fJVZVmaulm7RcRlWMnGslmTF/rrBM31WDrhHhn
         EfMQ==
X-Gm-Message-State: AFq9FYLX0EKzdmMbpF1pbOqvRb2UpuVFFaa967x6lKlHEZzkIHAdwrVn
	unweoijDJDhX0JtCyBRIKR4JPXuVOODEoKYqrLl+0zLTocKs9bLW3v3AanhWE+AU
X-Gm-Gg: AYBFou3uBzCSqhxqSwhIDOANlXBWJwj2L3jFGDCQOVB62D/sKJRfHe2uXElQt+oB3Mx
	2BhoR+r+ntj//Or3h9uF4zgcOwGH9UIaK/JgKflpJ13ZfUPM4gbloimAO3o9f6M2DhJaHEENVBk
	ORt9bhhAMjz6oNwWRLk2ucaJSxHQp8wLn1G6FdCQX9fycmJzd85NQx7fuSh9lwXN82Vu8F1DSho
	TWNAWs8mcI8y/hYcortRGkyMBpD1BK0hRNvym4vP7Om5oK+/WNbO+EeGu2DQRLnEXxV7lYbQe0M
	G9aCfvKkEGjwgUjAjWctDbXUdKtaVWFzz6fwVKbL8sWXaZHd/eabhUUkmA1Y0PGUK5rONThsCmc
	otWlYSNMtR+kU2OgTKuW37KgTn55bzcUFmPZtJql4D1K65mzTZX+gy+dh8l3lJqx6Fyt6xHX1YN
	35o+nUsFrQ8C8vCU6WdOHDna9/QUYRx6Hm+SBiX2mbxJlcMFbtAj2G3Epd0T14zZr35OzZwXN60
	vMlOQ==
X-Received: by 2002:a05:6808:1920:b0:4e9:6a47:be26 with SMTP id 5614622812f47-50c4e961ed1mr3593799b6e.22.1791592562452;
        Fri, 09 Oct 2026 17:36:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.246.224])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c167544b5sm3936506b6e.3.2026.10.09.17.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 17:36:01 -0700 (PDT)
Message-ID: <6ac98871.c41479e6.157a77.f624@mx.google.com>
Date: Fri, 09 Oct 2026 17:36:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7374947402193797736=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/rap: Track RAS CCC state per connection
In-Reply-To: <20261009173341.1143848-1-luiz.dentz@gmail.com>
References: <20261009173341.1143848-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7374947402193797736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182593/

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      17.65 seconds
BluezMake                     PASS      308.92 seconds
MakeCheck                     PASS      0.79 seconds
MakeDistcheck                 PASS      131.48 seconds
CheckValgrind                 PASS      140.30 seconds
CheckSmatch                   PASS      248.33 seconds
bluezmakeextell               PASS      94.48 seconds
TestFunctional                PASS      1078.28 seconds
IncrementalBuild              PASS      316.23 seconds
ScanBuild                     PASS      1002.11 seconds



https://github.com/bluez/bluez/pull/2646

---
Regards,
Linux Bluetooth


--===============7374947402193797736==--
