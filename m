Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667B6FBF
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181136; cv=none; b=UpFQ6BFIpbdgu1X/AzkNV5Qw0OYRwwAUA4hZUCMHxB/2cnTS5A4t0U3QYwzu1U/zYZMnc+cDDdZsPD7ROJfykX/+N2EWGbhlkuccaScDylBu0v5Z6cui5oWF+zVMQPsoedJA5jZGRADrVT0Kxq/h5Wyv67qx5BZOQNiyIQnUoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181136; c=relaxed/simple;
	bh=+d68i/m43E9fv7nLh7WYrSMjVFcaut7V+s9F+otqsWU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TzCp+ZeTqXkFQdBbePxIRJDMuK6dnlzkDNw9aqRnC637y6AY8by4uvEACO1dncFIvsA2IXd6i+kDWgV4wSQobmOQHYmg/uWsipQx7iOwmgFDbbUCwcHvTuKhPFuxkVe9ojI9r96GOX8/aVXqqqzm5uL0KdO+/IAJMIfD8wT6Ot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSma7cpw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSma7cpw"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c35a23b378so9360976d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726181133; x=1726785933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kVtut/aL/Izv8m2mLmKs9tgwenTlfuCzqPDlqHjgrCo=;
        b=JSma7cpw7BnJaRkf32p4BPtj6YYg8+wch6OfqvUnInfZAp+1Pg+38sQowvDelax6Kn
         QmQdkbeCFrVyoooTDPju46HjfLCqcfIrPM4XvNbmhkVVOeRfRj36EEZmhA1Fu6HGItJb
         OW02LKPjJs9O8y/1jWOxRIfw+vZjJQ7C28lNBxUg8POO5lwgdQF9mje5kRTsD+RK5Mxd
         /L8vHfbQPVsJnnKU3959r1mbRyK3jtXreiPsqTLZgXZQ2AemobaV+TkPrrIVfQn/r3Qm
         78ZJyZMWEHe4KQquLG+TS410/inqvg0v9Nbgjyubbj8viRrPnxix+FhnUMLd5j9yY61u
         cV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181133; x=1726785933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVtut/aL/Izv8m2mLmKs9tgwenTlfuCzqPDlqHjgrCo=;
        b=nGf2wajfUJuqbF/kDujdBGreMxmttEe7GJsqJRfPZ0MTzbTaH+irupQA/EPU+6OgUm
         UdIQeAZVbiOgVWLkVdq6xfaRgiWGObzrsUf0uzJgMKFqLQVv9gjSS49HdFsOVyCfyDmJ
         4GkxXk3E14dK8pZZmOQW2neXYXil9tLDyYvj42hqm2joaUnlSB3w8vVbikaGjS3RaYiY
         VgO9g5FLFjqsLDCSdmiCMLrE1X443U1x0rUvuwA4Jq4/Q9sIWU3VQgKcK6eW6sLl7jnR
         gRtcNih1afhYvdSoy716vgGMIBW9awoU/owgVvGVqVhrJodbb82m7NF3F2YoCJPBOjwh
         OZhw==
X-Gm-Message-State: AOJu0Ywsoeg8lfxIE4jl3Q3mnjL3ZSStr0QQEiYqTKhZAfTvkBQtJxzx
	vLkJXI4e9kYrthDmyWfiQ3ypupVXvyG1E8A6v+/wLXUZYf+YvuqefNfUfA==
X-Google-Smtp-Source: AGHT+IGDnI6O+Pi1u29eNdTixSGQTduz5zmWDMURLqC3WwMwGyU6cSfAQFOCsTQ3HUXz8eHEE0+aMg==
X-Received: by 2002:a05:6214:451c:b0:6c5:5114:96e8 with SMTP id 6a1803df08f44-6c57353515fmr64282266d6.21.1726181133408;
        Thu, 12 Sep 2024 15:45:33 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432dfadsm59448826d6.15.2024.09.12.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:45:33 -0700 (PDT)
Message-ID: <66e36f0d.0c0a0220.31e0af.69b3@mx.google.com>
Date: Thu, 12 Sep 2024 15:45:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7177864037746081394=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client: Print a warning when setting discoverable without a timeout
In-Reply-To: <20240912204458.3037144-1-luiz.dentz@gmail.com>
References: <20240912204458.3037144-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7177864037746081394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=889892

---Test result---

Test Summary:
CheckPatch                    FAIL      26.93 seconds
GitLint                       FAIL      36.52 seconds
BuildEll                      PASS      45.36 seconds
BluezMake                     PASS      1678.48 seconds
MakeCheck                     PASS      13.53 seconds
MakeDistcheck                 PASS      201.91 seconds
CheckValgrind                 PASS      254.43 seconds
CheckSmatch                   PASS      358.21 seconds
bluezmakeextell               PASS      120.68 seconds
IncrementalBuild              PASS      1514.42 seconds
ScanBuild                     PASS      1027.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] client: Print a warning when setting discoverable without a timeout
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#97: 
[bluetooth]# [CHG] Controller 4C:49:6C:44:F5:E7 DiscoverableTimeout: 0x00000000 (0)

/github/workspace/src/src/13802641.patch total: 0 errors, 1 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13802641.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] client: Print a warning when setting discoverable without a timeout

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (83>80): "[bluetooth]# [CHG] Controller 4C:49:6C:44:F5:E7 DiscoverableTimeout: 0x00000000 (0)"
12: B1 Line exceeds max length (86>80): "Warning: setting discoverable while discoverable-timeout not set(0) is not recommended"


---
Regards,
Linux Bluetooth


--===============7177864037746081394==--
