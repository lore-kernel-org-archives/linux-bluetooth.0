Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082E2222A9
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204679; cv=none; b=GuEwMseXVLGDUrDFc68zrWFcpQTd4TjZrt75S8CXb5J3EIelQ5WamTCM+JpP0NECkLwHM+HP62YYKyWkStAjGxtcCzTI2F7wR2d3ZdA/LhSRGaCZ/Qw3x7auPkuIG6em/2kX58T5xZabZzZBPYnX0ufBrYIkytng4iBtky4dWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204679; c=relaxed/simple;
	bh=dQEovcSL4bc4BOPEVwNtDfwbpgwmNgnZEJkeXjmfLW8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OJ1ainyEkTYP2EbgRPalpz108XmeAanhSPYWoLyM3fjkQ8f6Kx5rv8+v+/YpURrEIQFyCe68shP3h8yoDm/an+mlQeIS8LUYDMwZ8/8UG5kzOr0LLpA0RfV97szDC10amm13l2mVNF0jyiUkIhMSPkIwiB+VY7fQOA/XDuogZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWYJMv+O; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWYJMv+O"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-82380ef9395so1202970a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791204677; x=1791809477; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r4uiNsesHsyI97CXev02rqkUKHUhZf2hvQpOgjRpMrY=;
        b=rWYJMv+OFX2PmQQxYhHfjHfvOjw9d43fmIG6VIhb1Jmla+HPpvX4LYYYEVRW/Zkj7d
         hbtPh6hLcWH23O0tbYdtqqXrPUPHiSjeK/bJl4M03VhZUtyXYPKVPbUrdLLpQQ0Va258
         5WlNxJUl4n/Qcz35bODj3VcRrrzG5lEX0Go5RqcsavnQjC44yb2sxZ/hK8/p3LVpMQbj
         G//QTwmYgSfsvdJ36fpjQ3b4KcXNICQ27shniSod5PcSWpsFvDUJyyuMlhdZqDTlUeEM
         5dZnCHjXjP35YtOEXK4EHYuPjld9JNaGjvtQy5IlCe7w2wx0wx+XFM5Q/IYsLBlvcz6I
         XhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791204677; x=1791809477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r4uiNsesHsyI97CXev02rqkUKHUhZf2hvQpOgjRpMrY=;
        b=Hdr5odQHDbokZ99nIvJPmEV8siqo0rLlohtKB3KaS8MmY5Ha09NqpawvS3elygvP56
         eAbsyJLIf2Xi1mb5oT+iXhuP3jGe4zlsUy7UZii72QOavN9re+lzSCjqtfuEv69hmBlU
         BXat0ruk2bgJsVCHDwlBdksOZrTKzBzwhjMXam/1AzZVjzyvCrUD6KilfmODU6z9v/RO
         CKn+X1pkuTzCxjKkzEVoNq3J4v+d9iesx3mGStM6htKT9uihFHzorSjgUKTDhtQffzBx
         EL47Hmyrwqg8Mk2B3MFH2HbcAkleJMa+j6ydAyYCp9pbuhJ6vaKP5ltYLSPFZQNJUShN
         d8SQ==
X-Gm-Message-State: AFuF++kWPXKynCjbvgMqcfMHozF8LiOeZYRTHMChJvVipzryh2ZCuga5
	h4fPS3MWaacAjFsj0nvRCRvMZv6ib5mpE02mIUWNvEF5bGXpPHf7HZzNwBCU9g==
X-Gm-Gg: AYBFou24cTRhDavcujIUzKmhKv/GjqeAfI6gyde3xd4S3AVnxqF7cxmWZg/gbj2flVE
	l0Guovro00XsdgsOTvRU5AuLNcPRe5eTONXqgAi/0JxeqrMPXMLQPynSzZNo8fdeJNCbtsS58Nx
	Arwj3YdLJPNIP/6r6YBio8b0Z215LVjnAo9B/WMwdRpazQCx4v3nfEY8G7EyXZYKpyQ12+kRlMk
	e68k76gSU+4/J1/tQ303HDxZrnzn8+Nid3Jpqw+MhkHnG4lpE3cMNChN38f1Ew8pyl1rb6km4a9
	sfYedT9B+YxHO702sd1KYuVusE/1z3cdbY860b0rjLgaEVonfTuZ/QPGKIJ7sUMp0qyFraxeORP
	Q84sR8oIRRZXnoE1U9UG4dwMu1bxfMk+AxqZuVpY0qThe5Vc5blyvZfJauPMnax/AhgMvJWSBjD
	MygB2VdQwSYgSUPdwnh2XPHK33F9Y1S1Mpeas6WzJH9gQWmlFIG2nd4ELk4rhdkjhZuhDUvfL/g
	VuUIGQH
X-Received: by 2002:a05:6830:4910:b0:822:e7cb:3e8b with SMTP id 46e09a7af769-822e7cb3ebemr8726790a34.30.1791204677145;
        Mon, 05 Oct 2026 05:51:17 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.109.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-823c2ed5076sm8166883a34.2.2026.10.05.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:51:16 -0700 (PDT)
Message-ID: <6ac39d44.354fedc2.1e6f57.6eae@mx.google.com>
Date: Mon, 05 Oct 2026 05:51:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2635681946501015614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20261005111946.550573-1-chris.lu@mediatek.com>
References: <20261005111946.550573-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2635681946501015614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179593/

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      18.88 seconds
CheckAllWarning               PASS      23.43 seconds
CheckSparse                   PASS      24.50 seconds
BuildKernel32                 PASS      18.82 seconds
CheckKernelLLVM               PASS      20.93 seconds
TestRunnerSetup               PASS      464.48 seconds
IncrementalBuild              PASS      20.52 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btmtk: Add MT7928 support

29: B1 Line exceeds max length (92>80): "[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
34: B1 Line exceeds max length (97>80): "[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
35: B1 Line exceeds max length (98>80): "[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+"
37: B1 Line exceeds max length (99>80): "[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
38: B1 Line exceeds max length (93>80): "[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
40: B1 Line exceeds max length (115>80): "[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."


https://github.com/bluez/bluetooth-next/pull/860

---
Regards,
Linux Bluetooth


--===============2635681946501015614==--
