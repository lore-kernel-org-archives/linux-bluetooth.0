Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0D23958C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884676; cv=none; b=kB0HHsExBdyWq4Bek58R5PUzM0rz80eaBWCzojol9jCTCJePLEW9D2xgAguTVqxc54q7NQsY8wZEWtlPjoSyviJ5jysqdFIkbeinz7B1X/vBHMgweNBoH7JfR+4rd4PkkLY6qJzTH/s+/vSemmi7tW37N4QcUVnNSTxajfLZmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884676; c=relaxed/simple;
	bh=AG+OZlGQ0kRKnNaEvFDqYmYyn3EOCFDGhUaXUC3kAXU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EyNrNAHNg1tpt+n+tn5h4egmKRwE7DN8QnjswsBbcWLKjXnZIv1Kq7TbyM6fpmmceV/dLTO/qQ9cskchLdp1YusoCbnw1z68mkiJpW4GEaPBLJ5kt2fwz6Hng2xrE5tg27rx2aSpsD1Io7pf8B/CR54l6fbpWTEVjhguVbytW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoz83s8H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoz83s8H"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22114b800f7so45359915ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739884674; x=1740489474; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s1QEMvmp/+LPXLtvRU3jAgTBCWd1W52qxzDLfkK4Ue8=;
        b=hoz83s8HUs6D14wDwcEGWCzzIVPKAeFsiLi3nszwMAW3505HJO0BCu+YhzurzD5rv5
         7GIX5/ZIqZl6CaEprF6Tjv4g+El1fUMry7IaHrgMB24sDbeZ5C7tP+uHj+VuJ516f9kE
         CowTtig7h8GWypqlaJtqrC3tpIfYTRFujNLg6rLD2PvSCiDU9YqM6kCn9iXNva0xE7aM
         FwSjuWN3pbJTbS5mfoXKRLatj+1kduTYW8Jkhp3T3VGB+UF4u25Z8pxNZGPdvm8cCsih
         hZ6BY9ejgcxScf6AK65JCxfNf/rSPobUxHheJ4UqWA9zHftqYanUbTE7+rE98fuqv1nv
         /pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884674; x=1740489474;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1QEMvmp/+LPXLtvRU3jAgTBCWd1W52qxzDLfkK4Ue8=;
        b=N9JIVUFDoWvWjO9illRlyttpA043UTI8MeFseGKXBJTtOsm3haSlU6UZtkbyku7XnK
         5hEBYuCirFARoJb4ZoOwuR2CZvtCLI8pRrV3+yDqRZFIXEeOzn/PFy+AKvRCB8gmY9PX
         R+Ruzo4JLcawOBOjkoP/ETAH0aS5yO4vq4Z/CrAKUOD0EFUI59GhOD9zJpOn9PoJ9yKS
         lkq2C7mBkPCMX6is4rDvFXw8ZOxxXsemuKy5vAPsJrkSVe00ge70jGP+uOvE02B2Uk2R
         JEaH1YIMpp7UWOAG13XBF2dVAXF1mA9LvfRd4inYghbtWYeDMd6vazqy1zAMnxuHvrwB
         abpQ==
X-Gm-Message-State: AOJu0YxNpXhvENdTaWwYsz2JUdZEd8JSP6hqCdZkk3wBubeLdzi3lhiW
	Yg9O/jKIwbJaksaKwi+5IrlyvpWa0fTKxV+tLMbIujJqEB6JVAlCnpuDng==
X-Gm-Gg: ASbGncuKr4vFdcYggKvSvMk7c5q2F3lh47oHHFOkb2rvKH2Azfd8+tH2zPM75O0kMsq
	n4nz4pQ/4IqIhsiaU0wnuQ6smJjEMm4tMhkjmncBfrJuJ+9tqJf8xymEK76Zj8oPTlBTMQNzmyb
	lXlWEBHkw9mQKuqi6BuodtUqJa1WDzZKgYfAM4FJJ/51TGNGGHLnPQJNZjVpMy6qeq6uSsE1+gX
	Nn78+7xLii0AaOM+/wY6Cb9d8vdbAdHLVDhiP3iaTBI/95vFUbOEJk7QSpEbzu5Ubmbw1Fdzamh
	w7UnNSeuvV8Uc7OLjJJY
X-Google-Smtp-Source: AGHT+IEoKCREnm4K3znTIpqMv6aUAv9SZkl2F7utBJRsCJtRnskS5BWUe6e8eKDyXRqmX2n6sf6EKQ==
X-Received: by 2002:a05:6a20:2448:b0:1ee:c463:23cf with SMTP id adf61e73a8af0-1eec463ab2emr6150571637.13.1739884674165;
        Tue, 18 Feb 2025 05:17:54 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb588fabb0sm7850026a12.45.2025.02.18.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:17:53 -0800 (PST)
Message-ID: <67b48881.050a0220.239e4.6d32@mx.google.com>
Date: Tue, 18 Feb 2025 05:17:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6621214481851824668=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/4] Bluetooth: btintel_pcie: Setup buffers for firmware traces
In-Reply-To: <20250218122620.762523-1-kiran.k@intel.com>
References: <20250218122620.762523-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6621214481851824668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935089

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      24.71 seconds
CheckAllWarning               PASS      26.95 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      431.41 seconds
TestRunner_l2cap-tester       PASS      20.91 seconds
TestRunner_iso-tester         FAIL      148.82 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      129.13 seconds
TestRunner_rfcomm-tester      PASS      8.32 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      8.39 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 125, Passed: 108 (86.4%), Failed: 13, Not Run: 4

Failed Test Cases
ISO Connect2 CIG 0x01 - Success                      Timed out    2.621 seconds
ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.270 seconds
ISO Connected2 Suspend - Success                     Timed out    2.713 seconds
ISO AC 6(ii) - Success                               Timed out    1.882 seconds
ISO AC 7(ii) - Success                               Timed out    2.514 seconds
ISO AC 8(ii) - Success                               Timed out    2.500 seconds
ISO AC 9(ii) - Success                               Timed out    2.507 seconds
ISO AC 11(ii) - Success                              Timed out    2.515 seconds
ISO AC 1 + 2 - Success                               Timed out    1.968 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    1.999 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.023 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.000 seconds
ISO AC 6(ii) CIS 0xEF/auto - Success                 Timed out    1.999 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.190 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
LL Privacy - Unpair 1                                Timed out    1.894 seconds
LL Privacy - Unpair 2 (Remove from AL)               Failed       2.548 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6621214481851824668==--
