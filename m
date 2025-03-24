Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0886334
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829000; cv=none; b=Fg7oWDjbR4/COIhuL7xt3lXYtaUvZsF0KjIgwQy9fELPiyVLP+MduZaiBwWAXi0MkPcFRJAU5w8Zpbms25qbC1Y+CriDAzIYNwPWFCBaoZTs1AgEHBpUlIyEsSARiOLWFYRlERVhdhp1vjm07vw8USMIwC+4j/FaMfmZk3IMz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829000; c=relaxed/simple;
	bh=nqzx+U4pCHzJQ3CaCmEmQFyZiV62qJ42X6xIix+jMuM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CD5wZPRyjLbEQ9ZDLkXGhD8YLAvQafR8iS2yBVnemvsO4B8XipkVCzALuR1TXWScAtTugO12zo2ea8Yc/9mmbhh3mAp05IkoESTCDudGQKgZWB/IpK2zsBbt9ZZHrloc/Ofj61V+D9+4LfejXEDACdiDz3/nAFu4a2cZf1mZrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYrKwlHq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYrKwlHq"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07cd527e4so419900585a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828997; x=1743433797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bKMBQ8oJa3tlvLxNvqlZJy1F2Tux7LG5MZkFNKJr05o=;
        b=nYrKwlHqTTXk7/tPxhDsqSRz4okIt6vtnFSS5+D/8AjhjKxKmiIvprMoLtUIYmgDCQ
         4SIP8F9bWlVosyaSYoP01Z5H+K+5yXzvMialzTdOBzLjtCyxAcKtLLjO3vkInVb7Rr2B
         21le77h4D/ebfhjVDXE94dcKt+5oYJNI6u6LHspWQIW4CPOH/J+HRKJ+P5H3qdmJbkKT
         IzNkABiWl+v1PijQOJa0btkiSM5oc0TuZlrja/cLwAfkdXnEwddQH9XCJz9vTYFMFcOR
         rKFSSIMxT+THBIIqkPV920gaE68YaJmp5PIdYbXU2BQ3EzqREG3KSK6g8EhJa9WWyf+b
         OMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828997; x=1743433797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKMBQ8oJa3tlvLxNvqlZJy1F2Tux7LG5MZkFNKJr05o=;
        b=nLEc0Q7AXEvBoFFStSHi96rwd1rIm3pjy3bkXhbEZrtkFH9lIZ/dXwYDeep+fOg4qO
         iA1mPQoEyIPbccD4OzgKngNB+piX0N5V8SahvI9n1h2HmFyAcgbtKVhMMIEduEr4XEp2
         RAIrQwmmNzzgTZLPm1yGeJA3CQDF/YstUxrQOO3Jm11LfJIAo5nl8LZlFImo/Kouzzrs
         St/gW15tyP4s8pALmmS6M9RNZ78nzGRqcWDPWhjDOsFANKpxiGbJx5Y30bX+zWmrJoyN
         BdVvdwrLauOigWcpSAsfZZ52hlmVh+qkrYb4PD8uFlxLoE1cF0JRUPlVv6D4JxAEG3PL
         F+iQ==
X-Gm-Message-State: AOJu0Yxnwh+xCD1mnHXLVdsl7ohyV2RS3fi3HKWGe8k1j+mnuFll+TFa
	D1L9IpWfdArC48Bq5rRCQJAbNtsdbUuLfT6H+h3yihy2rTkRc0uMdq6mQw==
X-Gm-Gg: ASbGnctyek7gQRw/0wCygAacrn6h23P65us8lwL3DsWHnmMokUhoOLJxYx8NjX9NnM9
	SZ6kO/GvlnBVJNj3piyH4hnyxJdQSkgu5DOgfnhucCJu8ghWzC087S5u5+g9+Bl5LwIJD9MrtpX
	+oryn5PymI4AyMNluGT7gimFtE/WCyRKqb+ZbdsCAMCUdqMKNLq+Ivl/Iq4rz61MVQSW7GueddT
	UPRcAZRLmen8UXaMBaL49+QQqWgWj7g9Zrjc9i5mc9zYZyooPQINg8aDqgkOq+PbSUzfzgKSrPA
	9glns3W5NubhVb/fQrY+3bVifFMKfAtQmp8G+pj1fL8MB7Myh1nUxJoFvH2nmroP
X-Google-Smtp-Source: AGHT+IGCoCzecU0syhBO8rjpDxPvXLxFX8v0yOgshzYbIWFAL9y08nFAPDPr/5mfUDQ8tzwXAZgNdw==
X-Received: by 2002:a05:620a:2545:b0:7c5:5d4b:e62a with SMTP id af79cd13be357-7c5ba1ffa11mr2785701985a.54.1742828996856;
        Mon, 24 Mar 2025 08:09:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.215.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d68dcsm521525185a.42.2025.03.24.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:09:56 -0700 (PDT)
Message-ID: <67e175c4.050a0220.d4e08.43d0@mx.google.com>
Date: Mon, 24 Mar 2025 08:09:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2760741814747183723=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/5] mgmt-api: Add missing Device Flag
In-Reply-To: <20250324134920.2111414-1-luiz.dentz@gmail.com>
References: <20250324134920.2111414-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2760741814747183723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946846

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      1452.10 seconds
MakeCheck                     PASS      12.82 seconds
MakeDistcheck                 PASS      158.05 seconds
CheckValgrind                 PASS      216.19 seconds
CheckSmatch                   WARNING   287.51 seconds
bluezmakeextell               PASS      98.28 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      867.26 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3607:52: warning: array of flexible structuresmonitor/bt.h:3595:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2760741814747183723==--
