Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6C4E80CA
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450816; cv=none; b=SaAipJvs+2oE8RafikpDsm3bnyFqCpwfV65mP5sNqv/XDGY4D0aMwRSvZUMUFU9jyCCOUUQL58j2LsyqB6PMDubfm3qXhV2E6CCKm6IbhdChe3b9kidmT/Y4xy1UXQgfdVK6qFWFtus/npK6OaK6DAK2RkVCRb3Bh2ZMPmt+iNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450816; c=relaxed/simple;
	bh=PJ2n6G3OtmNk/5UhQM34lvfUTOw9Rw4F/EkuzPAyOfA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hslsqR8oar5KaWmICM1yE4WpWNO25j/O0Dl02UMil9spQsTNjLTGJAqdwU/ckmPlvJF1VX+zrDJr5Mbmh/tNTnW8So30XSuM9dPaC77GZ8UySUy+L5U+H6ZvP6G+aI3rPtUu/rPTM8rjs5GyvoqUKwyjbZ0J6Fc4ZYfV1dHXasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYDXoRPm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYDXoRPm"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso90293a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788450814; x=1789055614; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p5T6/BPAxN01bxioUdzjrvh/EVdmnoRxr/kG3Kl0h40=;
        b=bYDXoRPmDigPjaboY1WNtf+kqL6g465hczjFEQuDm/BUI6u+fwqebATvpT4vTxXslC
         ncKBgWdbQQO3e/vSqkGGakrNsU4vOueVbDvi38RjYnZjxKTmKNyLjSpV33nNAK3Sy29A
         V0mN2esXNlGLcSrAOBxPO29QJ+/JSzWkcrKVVH7cLUAy/G+DDuX2iWAhzB3jVdvQcudv
         uyURA3NDZ3rmohhdHit1Ft0hev7Tz6yfHIgEq2fc3YM005jzS1At+nEhX7VyasNO4lZq
         iYa0soPvz2MeVyQ9R0sMwXqbm72XFhIxJe6UqmGnb77vq2SxfNKfGquLokcd/r/uxRmp
         TGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450814; x=1789055614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p5T6/BPAxN01bxioUdzjrvh/EVdmnoRxr/kG3Kl0h40=;
        b=S0zIqwBGNCmKHzws4TaF207i//n1yQTDjj0QMxqxxr//TjtusmUupglW/TOGDH7oZt
         doSRcvAQteuL9Xe137NP+iI0a4iu8za9HPh0jjECz6EKmL3+26Ou8eJsr1m7tr8hZtc0
         b6UroeS13KBqO1RyzPyF5O2aphDYzZFQMaA5nuoyP+Ds6RFivTPaCfKMELLsQBHWknLs
         6Eh/A5FcNpNisDNf/h4lYU2uckmksqeaHucJArwdtVWmtCSqs2r5o+GlbiShTmh9AM+I
         mRb8M1bmSIAXV9aQfvku1GJQYr1y32hqiTOrAIhA8J/tadtmyX2f97Z07mpLTqOJc3dP
         N/lA==
X-Gm-Message-State: AFuF++mNAzhkEyvD2OoLJTGhIzR2ajIv3cfyGDOuVdTXM9kBFhRoDy+h
	zIITcnGhVSvkDaqxN6ObVKEwuWf4aMWGEBh9tZHm3Bf2xa9l4dEoUqEYzBG2qQ==
X-Gm-Gg: AYBFou0txT3UYw4XG3z26UpIgF+iSAXF+yZnzyDd1FM9dnoz9Co4eP/FEHugVU/RWkl
	66E1MdDKfej5W3rDZuPn+megcIwEOJhPbhHdlrDkdQB7gS89ZJ4K0k5Fa8ldHzLpBOs90sTZYMM
	uIqFTejKyUmT9yFo/kx5FE5b6GFNOrlj9hiN6lyoH/ymColSjdC5GNpyJLmWjQ/uic3bbWw6dZr
	K3QPZSgIk7I3rNALRGTtK1zkrc8gpNZOq5CTY8jGAfTe4S3yHwVGtjH+FdlesluHcQeK+T9srxt
	dV2tqHE2T9c8r0nkCs1w/SIRCJK9UqQQURyb6PZR84gRZi3Wh+F+anuEQldhrDdltQsxAJoOpWj
	FBiRIDRrSc/mj1VEY7yufSj+8KBf7pfWvNWsI08bU33DrsaaKBueSn49XbFJ3A7N/S0AivKtSKK
	n0TY4eTGnl4+M/C5+uHBKj/pl/tN5xzLeuJyck7W0mQTqj3zxGn2HCcR1KbD/9CuYNd30=
X-Received: by 2002:a17:90b:4b91:b0:399:149a:3f27 with SMTP id 98e67ed59e1d1-39aedf162e5mr17835252a91.9.1788450813928;
        Thu, 03 Sep 2026 08:53:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.45.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8e0b117sm3200078a91.3.2026.09.03.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:53:33 -0700 (PDT)
Message-ID: <6a9997fd.6da061a6.2816fc.db92@mx.google.com>
Date: Thu, 03 Sep 2026 08:53:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8557875693103393287=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: BlueZ: Support vendor packets
In-Reply-To: <20260903-vendor_hci-v3-1-015d62a57c91@oss.qualcomm.com>
References: <20260903-vendor_hci-v3-1-015d62a57c91@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8557875693103393287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157193

---Test result---

Test Summary:
CheckPatch                    PASS      1.27 seconds
GitLint                       FAIL      0.86 seconds
BuildEll                      PASS      20.46 seconds
BluezMake                     PASS      607.30 seconds
MakeCheck                     PASS      19.51 seconds
MakeDistcheck                 PASS      163.48 seconds
CheckValgrind                 PASS      235.45 seconds
CheckSmatch                   WARNING   317.06 seconds
bluezmakeextell               PASS      104.20 seconds
IncrementalBuild              PASS      663.91 seconds
ScanBuild                     PASS      1011.07 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,1/4] doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example

1: T1 Title exceeds max length (83>80): "[BlueZ,v3,1/4] doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example"
[BlueZ,v3,3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER

1: T1 Title exceeds max length (90>80): "[BlueZ,v3,3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/msft.c: note: in included file:monitor/msft.h:88:44: warning: array of flexible structuresmonitor/packet.c:2003:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresmonitor/packet.c:2003:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2481

---
Regards,
Linux Bluetooth


--===============8557875693103393287==--
