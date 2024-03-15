Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753F15E81
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487977; cv=none; b=dw8HzpWMOmXK55CwfLyHflMGPtSz1NvhGsUgHTbMjzTGBZamCUWS1kHs7OsmyyL1gtdYU22CVD2Zg8UBiYe2318G19MvwB22ZI49ivElkzZhjqz8gN1sP+5Z6nxSEhH1fkUcN3mnFSFN0qw3mZf0GM4mwa6nSnzIW4YXtCushZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487977; c=relaxed/simple;
	bh=qa4O7rB1Kf2oJ6vXF5wYXbBbv+ZxtmxpFtYgvN2t8pw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D43Cm4/3wfH2OZf89CARmkwVNqNkCrLgAGVsujQEeFE0uuoKZIqRIR4Z9m8Vgc88XYEUD9shEnDS7dKpCDboUfSP+bMi3iweJkosqwPfZh7TZG+blNuJ0heSDhyZAoYZJ4MEhR6tmQ3L1H4njXEC7WCjfT//8OmARX4fZeguMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgJrS6oK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgJrS6oK"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a1e1e539so1459605b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710487975; x=1711092775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm90KGxilybxbZ8Hu2qlCC4zo0u4HXiUhI6lSgXwUAI=;
        b=IgJrS6oK4SG44mC2OX6v+9p7t2g3xXaFVQ/NGKK6wPd+uKngQgPznk8T1J4cvfAm9c
         JgOZx/Ah3UqGEZ8S8FrAGuYwFyKIGcXTCE2lM7InCiA+hLvDRwstYw7QvdkwR3cE//2i
         ZIK+R4Viva9xAHYTUdj5OLdaTBlzPoBEEqhpK+Z7Z4omrcSX1/Kbn0WHGC/eFwbhcQXP
         /qNEePlZtDaF6/gYnt6AWQfRMe8hToMjgL57j1zmzvkS0U6Nk7Gul0KkxEtgTfGDZWgY
         loG+u5pYs8tmN8Ef+ZSGRA2L8ctsdROw/yn9+KJvnJ8pxn878SeLbrFCLS6ZnFQq8kw9
         XsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710487975; x=1711092775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rm90KGxilybxbZ8Hu2qlCC4zo0u4HXiUhI6lSgXwUAI=;
        b=tuC531t4hqfKLpb7aSyw1Nt1iFpjqCPkKOqTaEILxCMpskL09IRJi9PsoR4W0GZvJi
         /sx3KUidstVRpdSIZj59ysmAdcmhou9Gvec4SMi7/JkLoMYk/Iy00sODKPWzh7uSPRnA
         QITweCK+R9FDXQQV1uFHv4kkngMKYej+L9xV4Kb77ohLN0+zhgAa2cYTuQBaQqHEBSWt
         iQ0WGEchFE0ne24NipLNLY2dDMdjZrSRcKl4VvdgYPFzeqR4KA5KPGVuJ7af6aOjxNHD
         /w2HbjbhSahQJLbwftUlHFq1TO2CfhR0o/WwjzoK9NlNGFHugyt6P7H6bBY3Mp1SYqQR
         THxQ==
X-Gm-Message-State: AOJu0YzluyixyaHcYejRKnjtdwvphnpBtfdCQTtXJWOQwMhiW0alf5rj
	GoTDtoIUUNmh+lnuEzFdxufxqmdjkSURBMDqJGfeq3eI9hdYY4Wa4xqb5xtR
X-Google-Smtp-Source: AGHT+IGzmVSE4tpBmy4D81RYjORM+KcmbF5KB+kFU7fT2Xu/ukW4iY89tlzMrD6TsVN7iyiTYZ/OJQ==
X-Received: by 2002:a05:6808:2803:b0:3c1:e79e:5b2a with SMTP id et3-20020a056808280300b003c1e79e5b2amr3268324oib.29.1710487974883;
        Fri, 15 Mar 2024 00:32:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.74.1])
        by smtp.gmail.com with ESMTPSA id gc14-20020a056214230e00b00690fd3f6e3esm1616484qvb.104.2024.03.15.00.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 00:32:54 -0700 (PDT)
Message-ID: <65f3f9a6.050a0220.81cba.5d18@mx.google.com>
Date: Fri, 15 Mar 2024 00:32:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2055078461994511957=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ianwmorrison@live.com
Subject: RE: Add support for MediaTek MT7922 Bluetooth device
In-Reply-To: <SYYP282MB1197FB116B937D8CB0E57305AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
References: <SYYP282MB1197FB116B937D8CB0E57305AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2055078461994511957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835504

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      27.57 seconds
CheckAllWarning               PASS      30.38 seconds
CheckSparse                   PASS      35.91 seconds
CheckSmatch                   PASS      98.70 seconds
BuildKernel32                 PASS      26.81 seconds
TestRunnerSetup               PASS      508.29 seconds
TestRunner_l2cap-tester       PASS      20.12 seconds
TestRunner_iso-tester         PASS      29.92 seconds
TestRunner_bnep-tester        PASS      5.45 seconds
TestRunner_mgmt-tester        PASS      111.99 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      8.70 seconds
TestRunner_mesh-tester        PASS      5.76 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      25.70 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2055078461994511957==--
