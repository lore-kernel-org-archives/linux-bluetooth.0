Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F054745
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091868; cv=none; b=XuWJvGzN/VGUbDSH9aw43q6rR+ZdyMsiCk2ZpK9Eo0TD6J34LfLOg29D/4W8XixVO99cvf9paY8Li+Ce9+Nc2+FiAvIyO2SGzHgt/HUNiZbk5+x27y+MJGysqtpwObKf2xOCjuyf+ibkF+5XId7Qpxa2VJM2QsWqsiJhZH9ZHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091868; c=relaxed/simple;
	bh=oKOlNir8NN8WRPkFhp7YFLr8sEWti1AOmZfUw9DDNto=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t2+rFzTeBecKxMirN/gni9uU6Rorj7vYYGnQskqFGib8U/xzv3xe/sh8/Ngnweqwlh7F+boXQZMU9nUQ30ZHHoRa8BzkurRqxBCdVInbvLCGkVrkr9okmsy3dbHJjESfJ0ilhBz/8/hdlJFwegz4OUHDI3DDb0P5AZtLgUSnowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQrOQqdJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQrOQqdJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dba177c596so7527195ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 05:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708091866; x=1708696666; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g/u1BgS3apT1oJEQwIKKCnh4p2SK+GTx6gqGJuP0sN0=;
        b=IQrOQqdJ5HzFVMMaGxsEBG8eKik4NYDnLkiCRaGa8dyTfXAWxAxZ3zQiN1Tak1RWOs
         5Qdp7lDrfX8N90TBBi1sl/7Tl7FPGagUe7+CQcuskD/JL7khlW0bFgzSLPvjkyG864EJ
         WQT/9+9v9m79Vz43D4tmjPDkWDxJIvaUfwI5pXkFt7OsYOwsB8OcXdwUCq54N1qN7cmj
         IzxSico+b4WXpsWVv7U8mWFmmU5BL7xoM0odLJYB/eY+Lun8s0Rzot6ej7k4qakBavum
         rh7l9rtkHeu/VD7xjS3Wk/TAKRGqyGbeyuWQV1VT9Mffg3ZuzzTrilGZZx/9hBEEdnSb
         STSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091866; x=1708696666;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/u1BgS3apT1oJEQwIKKCnh4p2SK+GTx6gqGJuP0sN0=;
        b=ICchcGSbWk5GvPB0ehYNe8n61g/SJPTpHv8b5oXzJD87vd1xBgKntLtodXU2ytMVW7
         e3EWktdrCIFy2mLV8uNV89FmFul7oen0ltXWkW/PT7a1zATHx8hwoZR5BPuBmA5yd6Qc
         Kwj+vZDkU8amq0yVDhfLfSqBvMpxzS4HU/GN1Y4/B5hsdgTEWVHRwYekyGraITdJdD9c
         +Wtnf63Way1CChWuzyX/aVzXhTheSRCdZru+8+0jgjsmuEF55zXykjNLaKo5o1Vn6EUS
         OxzNgfd1S8pQmarSI0aAsZrzCE+e0ft77BS4NndpGGmp0ZSkwyLjOyPwSrDalD0LcryW
         KeuQ==
X-Gm-Message-State: AOJu0Yx8sCIY3HkwSAvq4RlrEGBuj+yS4AKUPUWe/k72BIg9ds+3f2vf
	PU8RKw67N5vIWmcDd1juGKNkGkhPITFzE7Bc16H5hL/bJfXT3IJolPHmOPw2
X-Google-Smtp-Source: AGHT+IFLiOhercVmemXlg8dRc6+8BbURGDl3Lu6rVpM3f9jFhAMlNVt+jHXqhakYbD2fJ9Ap577vsg==
X-Received: by 2002:a17:903:2310:b0:1db:bd46:a429 with SMTP id d16-20020a170903231000b001dbbd46a429mr65921plh.28.1708091865770;
        Fri, 16 Feb 2024 05:57:45 -0800 (PST)
Received: from [172.17.0.2] ([4.227.115.132])
        by smtp.gmail.com with ESMTPSA id lf13-20020a170902fb4d00b001dbab519ce7sm1144206plb.212.2024.02.16.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:57:45 -0800 (PST)
Message-ID: <65cf69d9.170a0220.d1a23.3336@mx.google.com>
Date: Fri, 16 Feb 2024 05:57:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3490302341289468233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luca.weiss@fairphone.com
Subject: RE: Bluetooth: Add more Bluetooth version defines
In-Reply-To: <20240216-bluetooth-defines-v1-1-6c39aacc66a8@fairphone.com>
References: <20240216-bluetooth-defines-v1-1-6c39aacc66a8@fairphone.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3490302341289468233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826776

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.66 seconds
CheckAllWarning               PASS      30.37 seconds
CheckSparse                   PASS      35.43 seconds
CheckSmatch                   PASS      97.60 seconds
BuildKernel32                 PASS      26.83 seconds
TestRunnerSetup               PASS      499.07 seconds
TestRunner_l2cap-tester       PASS      17.96 seconds
TestRunner_iso-tester         PASS      26.91 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      167.43 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.80 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      26.04 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 485 (98.6%), Failed: 6, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.113 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.115 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.146 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.143 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    2.667 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.842 seconds


---
Regards,
Linux Bluetooth


--===============3490302341289468233==--
