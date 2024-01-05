Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739F46B8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzKGyp0m"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67fe0210665so5708866d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 19:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704425601; x=1705030401; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AEuADxUP6pNffVQa1n6wIocuS+PV+Df2E4Rk0zaKkIo=;
        b=DzKGyp0mXXtyzEMpxaViEzVnUfabi7eG6U6BHu0YPr8BytcwCNYd7RfdUgV+qwSKMr
         K53hX5QHgz/h97M6I7aTufFaiCyu4kneSLpKaSw8yeiMLLJuPp2gKFZ3bN411tGnhTSP
         lpGPIipp4icPg9eS688Bv41Y+tQv+Vd6GrdvAeLbpK3qeUL9+zijP/yyTLgvJVe0ZsVX
         L6xhC7q2LsMYppdM72iudztOI16PRvBuRN32q+8mmBSTFwW/gqLyZqrqnQPASbNSweAz
         IMyrwHVGlUMLM33WMNu9Y2gRnuhTigsXXmbPQeW2+Vls+wPCjksrUidZusAhPQni4iLO
         yJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704425601; x=1705030401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEuADxUP6pNffVQa1n6wIocuS+PV+Df2E4Rk0zaKkIo=;
        b=gkbEH2UNmC0eOSZPt9qU8WUaSYy0uYcqXBUM/rVFAuoSM98gRJ3wTM65qm1jOyIcXS
         /2ux6Hgb7JgQkqGgclsV+5fXg5G0VSNtj9AJPQXPC0Ua4ZAQhaLNhwXEms6tDLOsKr00
         N9vtqoZakT+f63a0VCBhuCq+n7EGbA/2yy/ZkpDyj2PUGWmsvzm/hogWxH8wu5WO/0G5
         xsuMnTduDhXD3N9DIzfSyZdofa4Hp15ZvhBG4lQNF11DwWsaxd00d4ZeQ9+pxExIzQIX
         bbseIL5oBCEeoi07uqF6ofG2xjaytlbjvB0p3K4vddwzRZXa53lHp0XtuQOo7KjzaGOR
         RXKQ==
X-Gm-Message-State: AOJu0YyfUgByo4V7qS6WNdw+xobyOG2LHussaXe7iB2FeTT94/x4pmza
	ob9hO5smcQFDIVDz6wUtN9z/5Ik2bOZBLA==
X-Google-Smtp-Source: AGHT+IG/3u5cISN5D2rAQHwiAhdweDDIyl3gJSCe3CckGEH6NyJMbXpS71aem33UVXlgPsIFb60sjA==
X-Received: by 2002:a05:6214:250e:b0:680:9cb:344e with SMTP id gf14-20020a056214250e00b0068009cb344emr1522443qvb.21.1704425601653;
        Thu, 04 Jan 2024 19:33:21 -0800 (PST)
Received: from [172.17.0.2] ([172.183.32.35])
        by smtp.gmail.com with ESMTPSA id y16-20020a056214017000b0067fa1179b57sm290639qvs.131.2024.01.04.19.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 19:33:21 -0800 (PST)
Message-ID: <65977881.050a0220.d6acf.0f6b@mx.google.com>
Date: Thu, 04 Jan 2024 19:33:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0052104454255598784=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: mgmt: Fix wrong param be used
In-Reply-To: <20240105031111.132851-1-clancy_shang@163.com>
References: <20240105031111.132851-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0052104454255598784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814542

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      31.19 seconds
CheckSparse                   PASS      36.28 seconds
CheckSmatch                   PASS      100.84 seconds
BuildKernel32                 PASS      27.35 seconds
TestRunnerSetup               PASS      440.50 seconds
TestRunner_l2cap-tester       PASS      24.18 seconds
TestRunner_iso-tester         PASS      45.43 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      162.31 seconds
TestRunner_rfcomm-tester      PASS      10.74 seconds
TestRunner_sco-tester         PASS      14.33 seconds
TestRunner_ioctl-tester       PASS      12.19 seconds
TestRunner_mesh-tester        PASS      9.03 seconds
TestRunner_smp-tester         PASS      9.87 seconds
TestRunner_userchan-tester    PASS      7.21 seconds
IncrementalBuild              PASS      26.10 seconds



---
Regards,
Linux Bluetooth


--===============0052104454255598784==--
