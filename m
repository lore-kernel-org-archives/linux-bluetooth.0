Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356056;
	b=M1aKY+yLUK4GlxFDyDEnJ+mlm6RJQsX5GwZHhZkhiuoJ533751cxdUVlVHGJSPJOkeoH
	 mCqVAHnxqx86ioOoEn6yQRLBTw2yed4JB150isi1g1QvDbDtty5eS2QF2wPiRSZun3BDa
	 XKic95uaFKg6LgiQnAY11yW/9yIbHfam/bzoqS9c46IhEfvr8yd8AYHAuERxcxXrLu+cV
	 ueE+lc1Is7cpJecyicivP2X4Ch4djFRabOMsiQhNqHvisZ8FI6orgFVMsvtx4ftjt4ra6
	 ucwF7sMjJhl9rGAJ0ciQ3XQW1pdS9/ub8D3wRQY78JFaGnTe2Pbb6wY2g2ox3YHUzbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sNH8fkcWZWRnk8DYrAXGvdpg3OxQq64OFdIUOwlA30M=;
	b=HmwCCBok1dU7gJtVFdErPmrw+KDAE5QyQvEPnsSx1d7ohALl6kdvN9VQ6WsAV1uMPzfx
	 NYfJO4BtK8yg74W2fVpgIIMrYHDX7raSsLs5Z00M1pmyqT6jeGrUAA3wr/KolrxtVFUHU
	 GeO5fqXP4HzDE3grxfMCPKN//XRPMnTsPjBd4//i4q9CdKNc4LlZN3esnZkdwvSg7FjHc
	 FGow5YOwPVQtio3NyvvpJj22jVmilVg19sudalNyd8ymUnb1FSr1ODjw8jRd5eJv8bRXp
	 YNmfYkth1R+oNQOJ5n4ig9JllIy1GjY7lX0WSnbIjrsQZY9iQznm2Y8DoKLrpMU4dWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO6YBFjk;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD64606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 00:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD64606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO6YBFjk
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91eed03da8bso23461486d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794356054; x=1794960854; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sNH8fkcWZWRnk8DYrAXGvdpg3OxQq64OFdIUOwlA30M=;
        b=QO6YBFjkQ5fNdjythM5ZFe/k5+wnCMEQeZwHOhfRncu4TIEf9x0W6WQn3Wx3by2PCo
         ZRrlUD50RZUz4x0xFCIEJ0CR1ELtaCkVFheswiJJ1Gyih9yS00V6CGmU1Hb5SI2i1CgO
         ZK+ZWOeLskBjr+EHZlcYLqw+eS62FY+Lkv9nBYebkL7+giJETVDUISIO03YNHNnXGXX/
         LYmZ86mAnJXaHvGEp958Z+VL9Q7geHdDHrdLqv1CmdZinIV87PWXB22EhDyHLbNDgiKF
         X3VfdRGtlfptMqC5NuAXb66+Cu1sklVyGq8wnNxN3I2+ysUABFsi7Kxqxj6iLXVBKYXy
         ntqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356054; x=1794960854;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sNH8fkcWZWRnk8DYrAXGvdpg3OxQq64OFdIUOwlA30M=;
        b=In1JdHqS863Fl6MsppSSds1FV3+eeqlXDbHiF+lWO69OjJcUDWW+HZU57Gz1F+u3qI
         CBRrlLYGDvnEUjE+IqyavxAr2EseVIbu7joLGZXM8pMROAkkBwgkMnF0IjK290CA9n8L
         5Z+sJ/TvOS/F2vdekCsC0ylmKziLVH9DqnxizEeATKOYymXvphrmisTmBmDvhXzGtWnM
         u6qoWTs9EvPWcGJXnR2jhuHJ2ug+Lqe56K+e938Pdkfcutpf6nNJiZ0oZf4zG0FmhTWP
         vH7It6qIpn0OI0yS80Ky3wzNvSGc06IGT0VTFzsNJScV2f8B8JwnZBJSKM2C+WPSlgnl
         CpmA==
X-Gm-Message-State: APuU4Z98tPtuWWNx7KmKTpqIGXZbGxrhR2q5te4sWqIuHH626LhB7tku
	WZVIfJS7Faj2xjXPMUkr4eFDBx1QuhZa2Mc75cNqE5OSdnB8SOYBBllfVpW0ZA==
X-Gm-Gg: AYBFou2sCW7ilPn+5KihsAsgn0s/inN+fsgqdCKw2O2ooRfyKiC0tkS/nt++RJ4hGOo
	EiH+Hiq/rUuLkx6+vDT7wStJRpvuKSYmzUYrU7rRr6LGBEhhIhIUvXhg/PgJOHK/+1Vqae9XcYd
	wIrD5ZHGdYDP9DxHTc2C0XG3PimeqGMLkMDnylyF/aWR2QoWHjN0KL7QCb0fclm+WO/C3Jvvefq
	Jhs/NgGRnUnF+s8EiV2bjW9BE3zYDzF/Ts0H51nvqrKgiTfduJJbPaUwpWUKYGwzAKFVosKmk66
	zq1f/XJ2ycqThLNmEFKKee/q1DmamCSOH2GtMyaFYngbv+M0We4rgqF/zU7T1pZZWQtFT3YAfUC
	nE2J8OHGUhgk67fg6qIclBwDws4JFUx3ZjdzsSrHMQcsf99JkLkR6a6euJok21rtcVczZK7UEQO
	TkE2ITzSOLmO3eM5PYLJdnNXoj8+2YBU73VkZwP+GKw5t7H7U2RUjc45tiv2a2VRcejknOfB7tL
	zhrLI1hSVjOwwUmI2M0fTuzUOSehKH9JSqymH4GzAZ8/49rpDcNYvqqjNI8ZQ==
X-Received: by 2002:a05:620a:1d06:b0:93e:66e6:fa4 with SMTP id af79cd13be357-947afff34b2mr118589985a.16.1794356054441;
        Tue, 10 Nov 2026 16:14:14 -0800 (PST)
Received: from [172.17.0.2] ([20.25.10.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e785557sm351375285a.19.2026.11.10.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:14:13 -0800 (PST)
Message-ID: <6af3b355.0d30fa7d.2dfa9b.3ef6@mx.google.com>
Date: Tue, 10 Nov 2026 16:14:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7607535082729819357=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, praneethb2002@gmail.com
Subject: RE: Bluetooth: hci_core: Hold hdev->lock when freeing an adv monitor
In-Reply-To: <20261110222144.204736-1-praneeth@ucsb.edu>
References: <20261110222144.204736-1-praneeth@ucsb.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7607535082729819357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207695/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.24 seconds
CheckAllWarning               PASS      35.23 seconds
CheckSparse                   PASS      37.42 seconds
BuildKernel32                 PASS      31.14 seconds
CheckKernelLLVM               PASS      33.13 seconds
TestRunnerSetup               PASS      745.20 seconds
TestRunner_l2cap-tester       PASS      12.77 seconds
TestRunner_iso-tester         PASS      10.84 seconds
TestRunner_bnep-tester        PASS      3.22 seconds
TestRunner_mgmt-tester        PASS      88.50 seconds
TestRunner_rfcomm-tester      PASS      4.57 seconds
TestRunner_sco-tester         PASS      5.75 seconds
TestRunner_ioctl-tester       PASS      4.78 seconds
TestRunner_mesh-tester        PASS      5.62 seconds
TestRunner_smp-tester         PASS      4.44 seconds
TestRunner_userchan-tester    PASS      3.29 seconds
TestRunner_6lowpan-tester     PASS      4.54 seconds
IncrementalBuild              PASS      29.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_core: Hold hdev->lock when freeing an adv monitor
WARNING: From:/Signed-off-by: email address mismatch: 'From: Praneeth Balasubramanian <praneethb2002@gmail.com>' != 'Signed-off-by: Praneeth Balasubramanian <praneeth@ucsb.edu>'

total: 0 errors, 1 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14970524.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: Hold hdev->lock when freeing an adv monitor

34: B2 Line has trailing whitespace: "    "
37: B2 Line has trailing whitespace: "    "
40: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/1107

---
Regards,
Linux Bluetooth


--===============7607535082729819357==--
