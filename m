Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B9C8C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721361622; cv=none; b=XyVHMYhCmNE4Z84sRRxxBzZn9bZ+Az0g7e+x50L4H60PRl6sDEIUWtmS7s6FZhajhrb5NeF7TCTrCdKdGJk9irH+NjPWtOvECyRMo9rw/kioOROxQb5W0Z33qfL7Ji4Diz27RFQMqIVk1QLycy41/SgXgHAhDIHAZkjWnMLJMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721361622; c=relaxed/simple;
	bh=KnwFgYpdK/hXzWDitaeYwLeBLpbWW9HaUAiaC97HeF0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gdYFPpxdZ70v/IuFKtgfeTzXQdlA3BTd/ycffX88yNsTqeJ6+P4Gsym13ih6kpvcozul24wBgdeHPMUggH5NjS3STVX9sQT1XHlNLXiU8xvHtIlQ4U5PMVh2X3yQJmEvjZ045DPjDxE9mqXUJd3hnVcE7vAqcG38SXIsK3535Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7vSSFoR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7vSSFoR"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44c21981043so5269131cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 21:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721361620; x=1721966420; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBMjBIBim0aJOszQ4w1g11tAzpTHhtlYEt0MxmgDA74=;
        b=G7vSSFoRpSWFSu/Fdo6QQia4L/BvXFApIgETHxITlCA3YYMAg+0dvIdRYuUldx4nnr
         JuRr/nxNEvhVpCVVsQaarBSebTqaiI6WPZGklNK4Z/Mk64FyPmp6zvKkxR6CrDl+5bNX
         nNaSlFOtjQJ3AkIgrbS2vWeKzd4lynaTsrqDta/MnySDDimhKLsasxSgqX+Hi9Q1fIaB
         OVhjSWrynANPwEHuwuKJR/jP32q2h0/YbonPfLHaGWppz5N0SPtv93V+QlcetUL6kJKW
         lrG8zZdMU8BxK73Hg2eyGtTpOYzoiFFr8yzSJY+XXTfDGloS9TwQDAbgfDC5MYJ7ro1D
         B8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721361620; x=1721966420;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBMjBIBim0aJOszQ4w1g11tAzpTHhtlYEt0MxmgDA74=;
        b=dmkVUPLHxoh8uBaXr42sdGPjzGPQCkWk2yQF5HhFFjIEJ9PhNleFRVO7dJR1c0Wx77
         zNpz5fvVsT52Vxwv77hyoK9jHSbQ01mlQEDZ85w0ahgs0E2Y1D8x+vEI6OV/McPVLCFW
         F2cNvhgdLqwDm1dqq/F/8ugjp8dcGsFVl3+awdi4oZAVVDJT3L0u/dKInpKR9X+C5QMc
         DRvmhIHrXMJLc54oSC3AnEGP69wy/451IS7Ho2diV1MuxxFi4u5JbegFrtTQWzq6oHcF
         aw3RThCHgZ4Yplnoi8CcdPHgRhXpgp5qUOi47XiMj5DyMEEQmAiN91dkZiz6H5QypyfX
         r4NQ==
X-Gm-Message-State: AOJu0Yy7FP8a7AqFwWR9AgR/O2DdviWb7O88DpXtWAoPw5P0ePGTUphD
	oxuRZ2etmbBqwcgw1pJUK+4J/mn4oSpDx/K2Jm2YdIYGVIVbpcd5wTCRHw==
X-Google-Smtp-Source: AGHT+IFGo0IHh7nS7WP7CmDpozGwgd20Go0O0PeobBzGC5dxQzBlEDgZqvsM7VnuwpK+1z7IRUJcKg==
X-Received: by 2002:a05:622a:91:b0:44e:3784:7d77 with SMTP id d75a77b69052e-44f9699fee1mr37328851cf.4.1721361619859;
        Thu, 18 Jul 2024 21:00:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd37290sm2519871cf.50.2024.07.18.21.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 21:00:19 -0700 (PDT)
Message-ID: <6699e4d3.050a0220.2d761.0f80@mx.google.com>
Date: Thu, 18 Jul 2024 21:00:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4086778279116152139=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v4] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
In-Reply-To: <20240719033019.26767-1-chris.lu@mediatek.com>
References: <20240719033019.26767-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4086778279116152139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872398

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.66 seconds
CheckAllWarning               PASS      32.08 seconds
CheckSparse                   PASS      37.86 seconds
CheckSmatch                   PASS      102.66 seconds
BuildKernel32                 PASS      28.67 seconds
TestRunnerSetup               PASS      525.60 seconds
TestRunner_l2cap-tester       PASS      22.15 seconds
TestRunner_iso-tester         PASS      31.05 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      113.19 seconds
TestRunner_rfcomm-tester      PASS      7.53 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      11.71 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      27.42 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: btmtk: Fix btmtk.c undefined reference build error

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@intel.com/"


---
Regards,
Linux Bluetooth


--===============4086778279116152139==--
