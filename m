Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE892218AD4
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113926; cv=none; b=V/qFjcbHfLkr0bE3TPosD9Wudm4ksilpfpGAYezCwtHhA6P2palBjgMW+n1lKpMrfZZ0x+TgltD/xg/Z8XuDdpfpUcj7XW32u6zR61qyUt24wnvShr+PNI3bwTQF99R1Pid2f4mp0clsbnDWhp8hDyxFiaMMH+36w1PBk6Vy1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113926; c=relaxed/simple;
	bh=OvMsQbtrNTMh8mTvuTqZF8xnIuCXfq6ygxZd4oK0Kkw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iOldxe3A/TnnJsjvyuUrDQTyCFpqUeN7YfbijgpSjSM6dpGWxEXZfCBVRVKAQDTfXB1HPFzVgpzXHhTVwTiyz7lk3sSGqE0BX17nj2ahooS0W4McZ95zm8b5Nadf38eVroIU0eylVkNG85RHrw4Q2XCrTjHP0m16UE+pQcULwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VntTuxYX; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VntTuxYX"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df303e45d3so13837925ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753113923; x=1753718723; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tiXINZ4PzefP1GKEcFmGJ7L040AUl6jJy6BmUMfJ9m0=;
        b=VntTuxYXNWF5c2BCtfxmuKgh5C3vA9XlrgfgaeWuXVzCrDS+/+GflVA5mx6svQmFbf
         sPmeIeE17nf2CyY/SxnztNhny8yN/2yJ57ERkfM74AMbHN+kjb5W1pWlqOtBpv+lKJKC
         2q7hzuVb2L9wO3eN+GNnY6sb8xfMRxNX248MR7l4ZsJ08SbdpcY0VDnMZasUOTZ+lp4y
         WPlT1+/peXhXNxebDowoxFzNQkb7d6Ct4q9vySEo6MK1OcHt7KmlDyZNLQt319oUn7eq
         01P4GLaMB+AM0VfulmQN99RLePGXvQ4/+da5E+n3nQzkpTzcDvkcr+HGPdomNSkmoyXN
         EW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753113923; x=1753718723;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiXINZ4PzefP1GKEcFmGJ7L040AUl6jJy6BmUMfJ9m0=;
        b=hJJi074L3eOEOV0D8eG5FAfHhTLTfdePb9FwVLcNUWhrtx9U3TEufNkL3+BxjPK48D
         wH8luKJIq0TqMGRAbkfOilxWx5s1tCyqjlputYqP2Eb9NymXdjEV7KsbydR+VTcikMN7
         Ph3FG0EVMk2XDdSrtr4cglL8JMv0GD+UmFn1ZOJv477fGiEysueFe9HkkSbrzmoIs3hU
         JUg7vK+YAv1Tbop+Eo7Npe2cqMe+ZIZs9swUSoPrSANpTHosSwyPicv6R5WSjx+AF9/b
         270ctWXep4Z++Mmz+3bFqYA8ncFuK0DCb9t7gpq1813lAVqIjfmmq9sRhV4oLuxZMwhD
         eMaQ==
X-Gm-Message-State: AOJu0YwC++nOkblSRRxRL+lXJNITvta4HLjKWgMO6ToK+n/ZIGGwk08O
	v1Yow6H+LTGCDzeQWwCYMLDidg3L5OhNRoGsXx6wP3vnAoo9V7CKPOSsEtaLz326
X-Gm-Gg: ASbGnctutW4dEdGRh0bE28mv2f0/4cRYBeyx1fncpXXcypof8Jp7FzHIaZHqFUtRCoD
	RXk7+cYRxzBf5KkRb0/9ZT4UCV31gjzn3+wzM9ci3SxY2LVh/+x19zVNHAmqvyS1unLeP56pAYl
	jEpc5p6oift+y3q9K+hhlUhufBT37hlNz7DQbOojX5lOIlddDYDNERw9hljTIAHdUT8+9wB852v
	PwWqT344K/fmuq+RIY+QKGagGFcX3khuN7/eT70oDVwOjVx/g8S7XF+p8GYoU3gILuU3q1HDH/P
	ACF1XljHAFwk56LmV4hslqRl0nInnR1V4xjGM/7vuDewmFjQImORqiuyf7bupV7oPBxUROoQuC+
	OE4whtLIfOTRCDv7yQgHl9Te5IVah+g==
X-Google-Smtp-Source: AGHT+IEpC0zU1Iz4jmicegfZpiMwf14ZXYA/5F1FURM1ryl6ZxF79fG1FOdm3IZN3ayq/KJZg1ItrA==
X-Received: by 2002:a05:6e02:1a25:b0:3dd:d194:f72d with SMTP id e9e14a558f8ab-3e28d3e4449mr193946275ab.8.1753113923254;
        Mon, 21 Jul 2025 09:05:23 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.144])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c9b5e76sm1984594173.73.2025.07.21.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:05:22 -0700 (PDT)
Message-ID: <687e6542.050a0220.396224.3321@mx.google.com>
Date: Mon, 21 Jul 2025 09:05:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4392255718284488238=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris@chrisdown.name
Subject: RE: [v2] Bluetooth: hci_event: Mask data status from LE ext adv reports
In-Reply-To: <aH5dD1V0K7qZIOSJ@chrisdown.name>
References: <aH5dD1V0K7qZIOSJ@chrisdown.name>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4392255718284488238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984368

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.81 seconds
CheckAllWarning               PASS      26.08 seconds
CheckSparse                   WARNING   29.57 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      481.61 seconds
TestRunner_l2cap-tester       PASS      25.59 seconds
TestRunner_iso-tester         PASS      44.57 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        FAIL      131.04 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.75 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.66 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.212 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.201 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.204 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4392255718284488238==--
