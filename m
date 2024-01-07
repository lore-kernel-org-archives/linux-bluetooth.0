Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252F10A17
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jan 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXOM5ZKw"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5955a4a9b23so751646eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jan 2024 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704652497; x=1705257297; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ryx7hKQ75lME+uU4/hrICvcL9DvVJmhRTQzE0XreO6s=;
        b=OXOM5ZKwZF57BBSvJXi1Twx2Nip7zokhrwxif/hVQhIUrHGehMt0qVZ4SEcyYuX6Gz
         HTw/ITW7qxskeq2DhBvsrikYdR/gl25Nw+OJbcI50HiKdnBSk+VfhiUr9NMc0U5fCeq9
         3dsWoZjQSelPVjsgtQzD52TgO7ja8wjvQ1IlTqTgyUZDV2nYULWy80sFFnRAj7dD7+5z
         I7VB6LqzYFx6+97XrfUHQ59/s7I/fJBR7q+Xt6dN3gSGRklO7jFzG3dsMCnX+qlnCEJJ
         nwU7VsfgCnWgdYIorP+o9AqKlTaRRheL4GVAMJKIqhAz/FEVurDB2GqJZe+CCN/VJ8dN
         p2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704652497; x=1705257297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryx7hKQ75lME+uU4/hrICvcL9DvVJmhRTQzE0XreO6s=;
        b=pEGy/49JeGkrMJYjmyh+LJ+NPCmS5gVyj5fWpZr4rv34fEkNaoRKhFl3IVtYnY0knF
         eJXj956D34vZNRFltHXXVTOE2S3oDfSxrlkI0DbvBH3dotLt9dlxpr6UYs5WDAvudhI9
         A0Fd8kVmIzeneWUgdd5I8DiEd2VMkZApzOZLEEkVayPmC1w/yAYPXQTSFGprkkIcgTVO
         79hKUEMLU9vdPQHzFxevfQAKvUbtEygjHwtKJuJXJloVO7zEKml8GGJ+6nXaj/7KBM3+
         qoAOCaxJc7OTX3vA1sC4gJ2+Dnn2CfrmgvCnqz5TmKH+1hCSlInbd4tOvjBW4DKPL3uN
         Qb7Q==
X-Gm-Message-State: AOJu0YxUbi3RmP/Dll3SxEpve2RoSICfbvPhgd17elUODIb+aoeRsci2
	3KSDVT9el6uaj1KvA010pjG9I5QxXp8=
X-Google-Smtp-Source: AGHT+IHjBXM+FnX1Mcm9IrtPFYgd0YbTcU5jcqrj7j7Ih+0KMRjiTylem2mtwiy4TNpbbzNJKH7Tyg==
X-Received: by 2002:a05:6358:7e56:b0:175:73aa:c9f4 with SMTP id p22-20020a0563587e5600b0017573aac9f4mr1206999rwm.29.1704652495817;
        Sun, 07 Jan 2024 10:34:55 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.82])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b0028afd8b1e0bsm4791974pjb.57.2024.01.07.10.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 10:34:55 -0800 (PST)
Message-ID: <659aeecf.170a0220.d53e7.9307@mx.google.com>
Date: Sun, 07 Jan 2024 10:34:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8637555365289576782=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Disconnect devices before rfkilling adapter
In-Reply-To: <20240107180252.73436-2-verdre@v0yd.nl>
References: <20240107180252.73436-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8637555365289576782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814930

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      28.64 seconds
CheckAllWarning               PASS      31.16 seconds
CheckSparse                   PASS      37.44 seconds
CheckSmatch                   PASS      99.20 seconds
BuildKernel32                 PASS      27.28 seconds
TestRunnerSetup               PASS      436.83 seconds
TestRunner_l2cap-tester       PASS      22.96 seconds
TestRunner_iso-tester         PASS      45.40 seconds
TestRunner_bnep-tester        PASS      6.80 seconds
TestRunner_mgmt-tester        PASS      168.15 seconds
TestRunner_rfcomm-tester      PASS      10.99 seconds
TestRunner_sco-tester         PASS      14.78 seconds
TestRunner_ioctl-tester       PASS      12.60 seconds
TestRunner_mesh-tester        PASS      8.83 seconds
TestRunner_smp-tester         PASS      9.72 seconds
TestRunner_userchan-tester    PASS      7.23 seconds
IncrementalBuild              PASS      61.99 seconds



---
Regards,
Linux Bluetooth


--===============8637555365289576782==--
