Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE952560C
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707348850; cv=none; b=Fcr30VXLoLfx78K4TIyoEHHJCqE8GjHAlv6RHduw/T8HPUGdkNyVL8St55qgX0/tbZudcGwehUX+8hZK69wLa9uU9V1E9Pxgm5fbkOAneWh5MhVzIGOZkqKq+mFfcQDGaX1jFXn4FE8x6fhVrGAHiLVse9/zXH3JAM9rD/Eo+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707348850; c=relaxed/simple;
	bh=6T6vGgMbqhNjSOxpmGcozVqePN3i9DQltzcv1AtvahA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jAqgBO/9ypWCc7sDqCG0rMQbV6cKwNyNGVn+xz0YOj3ucAsmAzOgOYifjQmbu40B2oCI4vbX27YHbVuhpNZ5pqFxNqP9DRvzACblfJRycXr93xh85lupvBUMk55p94REIwY/97lZDUawNyIO3BR5SzeYu8e0LtroFIzz8F7ETP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObQXTJ4h; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObQXTJ4h"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc11fdddd6so1051370a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707348848; x=1707953648; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/1N8OzEsXiCDJzf8MYjRE+/HaYDyBziL6RsZsH/qe5k=;
        b=ObQXTJ4hiFwFf/bdL1fpOLOcKqsq7SCr005C6X2CTb7s6iBb1oLIiSshdDf8R+sMbb
         iIBUnscdChs+nfS43QBiRU++rQPdL3qhS8wmbBPVSJrsb0QvAinBvGNzyLPk2OPiTzwv
         EpguX7nlT1/edH1KxBYkeAoLSzhixKzBkF5akCHsg2RQuNT/ZYkBfMv/d+Lc+3rgeYCj
         aWXWqO8al/9dQiKW+K7FXv0LMtf89BW9P93giAv5UDDjbbSH2wJnrKcMxjTe8B9MJc6h
         Yz8TyQJuGV3MGJmo16sWiwmJxhbKI1QVVUWWv8JNIKJc53FUzHQT7+ypcgMujbGiNDJ3
         zuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707348848; x=1707953648;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1N8OzEsXiCDJzf8MYjRE+/HaYDyBziL6RsZsH/qe5k=;
        b=u/GZpN3JBLZ/epd50v5Z5GhCPM7piG+/qCL/SQElbrA5QuhQqBPJQdMqtfqqAhzC6o
         qky57I3+pBW1pAp5cyN+Q5snp3sEbffLKl8zfWVGNInFPZVBA3QZqgYNqGPXY3E6qbAc
         jYmL3Xv/efeTeaC8FZdrrQSOh+YXUyX8MRtIFieO9xeUfVqxtwOa3sqUuFiBrMwqjhT4
         yzE9t6NklEvWoTecuyvJyYgcHJSOqju0PCAtsWqMcaA6008qkhKVJ2E80fvUG4wnnQuy
         sXDOF8VT1umqDdrwU9sfy6jJGd6DlJZi+q4vNivZfPMRowOeUbz9l7PtGVBTU+XLTTfB
         k1sQ==
X-Gm-Message-State: AOJu0YzOvC/jipnEdWvIj2NRbvjuUL2P6sw5/OTlqfVvMeVFE1CjpkL/
	xovELJx7L+YHwxWQ81nONxmB1QBAjjXNsI7eNuNdEkjClRZiEF1uCWNOzVNY
X-Google-Smtp-Source: AGHT+IGxupaiZgNBWxD2BZ8T185zSWyF1A+sb+PEAQnv4XdPq8nk50jkGYe6Bt1KAuzgqG11URVaXQ==
X-Received: by 2002:a05:6a20:d38f:b0:19e:5d4d:79b with SMTP id iq15-20020a056a20d38f00b0019e5d4d079bmr7326628pzb.1.1707348848062;
        Wed, 07 Feb 2024 15:34:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtLHBlZXNaiRKSZVFaXZquXJCxJiGIAXu7s//lVy0OiA4WlJ24mGfy3Z2oEDpY2h68mF47gLzQiCvw
Received: from [172.17.0.2] ([52.238.27.67])
        by smtp.gmail.com with ESMTPSA id m3-20020a62f203000000b006dbd9501028sm2276402pfh.92.2024.02.07.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 15:34:07 -0800 (PST)
Message-ID: <65c4136f.620a0220.fa12b.7d8c@mx.google.com>
Date: Wed, 07 Feb 2024 15:34:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5770170492636235149=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC] Bluetooth: ISO: add stream synchronization mechanism
In-Reply-To: <ebaa4168cb73733ae8fca3c8f47fb88b757ebdfe.1707343746.git.pav@iki.fi>
References: <ebaa4168cb73733ae8fca3c8f47fb88b757ebdfe.1707343746.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5770170492636235149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824130

---Test result---

Test Summary:
CheckPatch                    PASS      3.56 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      30.77 seconds
CheckAllWarning               PASS      30.13 seconds
CheckSparse                   PASS      35.50 seconds
CheckSmatch                   PASS      97.63 seconds
BuildKernel32                 PASS      26.79 seconds
TestRunnerSetup               PASS      494.47 seconds
TestRunner_l2cap-tester       PASS      39.67 seconds
TestRunner_iso-tester         PASS      27.98 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      168.73 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        FAIL      6.13 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      25.58 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 487 (98.0%), Failed: 4, Not Run: 6

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.115 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.139 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.143 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    1.819 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.102 seconds


---
Regards,
Linux Bluetooth


--===============5770170492636235149==--
