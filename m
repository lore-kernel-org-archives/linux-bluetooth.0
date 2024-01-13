Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21062DDD3
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jan 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ6oklsS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-429ca07044eso11323681cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 23:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705132576; x=1705737376; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=phQ63WKpAHERms3QQtgoHDOiXkcJb9NnaLLvPbJpEFY=;
        b=lQ6oklsSUQoXwhrDfLTthr3QxCtfgL7t8i3TPtNAyC8POPdV+oMoEM82fdl1vVlw82
         QcholEulj2pv6T9bJlOxjLjWQXHIaQiyq5yxhg317YTu2QKrEVTdtcn3/w6RviQDlKE0
         +sMqfuP6O64XmY68lLRd2gG7aNlUWWx/l+aU3UjNj5UZ1yegw9u+tJGpOln9Dr0SAQzN
         hx/BfxmzS3VwZoC6hVG2zoMQjSqiEPhJ2YZ96z9KGUNF7p7yyzxZlQtovuNXCgLbRjYs
         nrXxNIXAeUMkXznYLveV2jbfGSTbvLV8ds0iBW+NtWHqi2mAY9/q3XcoMSFHtvhCOI/x
         PE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705132576; x=1705737376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phQ63WKpAHERms3QQtgoHDOiXkcJb9NnaLLvPbJpEFY=;
        b=bwg3vXx4WcMPpygdfaLknSvqiCcEcORCrAURO/+9AJMSdyKePOTHtPcbXux0EuR1LB
         Pry4VEWVvEEumTcQ2g+/duRHFxtNB1MQS93Kk2GVHo7IjyABQSZZaQ4JAO/euatDFLkP
         Unul8fiEgl1QIrU1EqJ5uG20DL84xAG0TbxlN4Fh6khTPkBFtD+0PM0UJR0vZ1ZvADk2
         iir4FCXKQAAM3NacxC0X7fO06Udal5CgkSyTEHycuWbLvaWrorMP7Fu/eKPI0bXxhjum
         1OpvF1xsKMdsrLlxlvHejiYoSkODYfZYGmLa+Ej54feoMM4NAHyeaoCVoh2BtGDr+aGy
         eqGQ==
X-Gm-Message-State: AOJu0Yy1aNmq2xN3XEWFHNnMW4UPa9eHNWJpgGaokMPjicQDQpB/hc7Q
	6UCJ3yCnI1tjr4Ri5fEiTWqrNC9u5Tw=
X-Google-Smtp-Source: AGHT+IEFXY6NZn+6sOfIzp+jOtMiG68r3CnF0QAu93so1Ny7osxqE7LWsM2v/hAdmEPFEeN1N7WC2g==
X-Received: by 2002:ac8:5bd3:0:b0:429:c009:b30f with SMTP id b19-20020ac85bd3000000b00429c009b30fmr2650074qtb.44.1705132575874;
        Fri, 12 Jan 2024 23:56:15 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.192])
        by smtp.gmail.com with ESMTPSA id fz7-20020a05622a5a8700b00429d79557fbsm524900qtb.28.2024.01.12.23.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:56:15 -0800 (PST)
Message-ID: <65a2421f.050a0220.e717d.272f@mx.google.com>
Date: Fri, 12 Jan 2024 23:56:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0497461786226368490=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Deren.Wu@mediatek.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3602 for MT7925
In-Reply-To: <800469f157c862bcdef7213793004d2de977791f.1705129502.git.deren.wu@mediatek.com>
References: <800469f157c862bcdef7213793004d2de977791f.1705129502.git.deren.wu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0497461786226368490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816655

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      27.76 seconds
CheckAllWarning               PASS      30.29 seconds
CheckSparse                   PASS      35.69 seconds
CheckSmatch                   PASS      98.67 seconds
BuildKernel32                 PASS      26.85 seconds
TestRunnerSetup               PASS      432.67 seconds
TestRunner_l2cap-tester       PASS      24.47 seconds
TestRunner_iso-tester         PASS      44.95 seconds
TestRunner_bnep-tester        PASS      6.91 seconds
TestRunner_mgmt-tester        PASS      162.06 seconds
TestRunner_rfcomm-tester      PASS      10.82 seconds
TestRunner_sco-tester         PASS      14.58 seconds
TestRunner_ioctl-tester       PASS      12.13 seconds
TestRunner_mesh-tester        PASS      8.76 seconds
TestRunner_smp-tester         PASS      9.83 seconds
TestRunner_userchan-tester    PASS      7.33 seconds
IncrementalBuild              PASS      26.20 seconds



---
Regards,
Linux Bluetooth


--===============0497461786226368490==--
