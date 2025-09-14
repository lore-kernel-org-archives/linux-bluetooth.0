Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B21A83EE
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859702; cv=none; b=ZUL0OsmHWgdwUb1/kIJlNUvR14tY8++PPivdh1ZbAKn+NXAWyJKbuMAyTZmnZTFPtsHgUW3MXSRLOUx3DNJ8neD4ocE+RV/dIp7XuNql6NRn/nle+2RnwQL+Oa9+soWU8CBFWOb6TlAG5xKHeeJuYDtGxwEC5mhRRlfuAdX6wE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859702; c=relaxed/simple;
	bh=EdDGyb5ZpZ14d7RvH51c9PlPeLMJgaCNxuPtlVbBbU0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TCKOesDVNiZNd+vBEitmIApKLoDcBJc3UaM/qjxOaxzchfyTHehoUXHOA4OVS0/l76T9i9khEAvztzcagEVL4cv4UE1Bu4rtF3QviiOi0hR6tQ9dy1rPlYBt1h98lSF6EaR1WwrnzawF5nnnTBk6f0DbIznxhEH2vA8BkKpljEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt4wfKI/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt4wfKI/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26058a9e3b5so8563095ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757859700; x=1758464500; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Va1S9mWs2vMQO0wFuHFv6nvtEkeh5OUeU9JE3WI8+A=;
        b=mt4wfKI/pvU83zA1Af+F45Ccb0E95v7bUa2vQESIndbhvUgjAATjJStHDuMFsN7sn/
         FQbpt0TuvQS/AG6JhENmjpdWxoobCN/XJTK1LQmRiksUzyYaeQskRrLs2CycbhmJaTOE
         PSHRKhOSbPx1Hn3iOK4bA2PIp64oAE2U+DlY2tnDhaMomlX9gnGlXE2GmXVUjfGErBmK
         EgwxdwprpQldJHVG3+P+41IiQhhShCD7TAykFBstWS8+0cBCbPFyD2tJCNF+QAHFh/8k
         tPPp4/C/r0fQqfgpPROsGHJ8kN9hm1AQwPAV0ZVwJjNk/KvIwN+A601RgPt9sJsyJEKl
         qlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757859700; x=1758464500;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Va1S9mWs2vMQO0wFuHFv6nvtEkeh5OUeU9JE3WI8+A=;
        b=eX6SOjuE5g5seypFz7/qUDdIZHOxDrU8uTNVyScIKTOCBpk32edHudoE64cTHKJ65B
         M6o/y/AlZUr+Sw1INOp/HgDUJFXoNyDx4jz2JZW9X+h34HcE6Jv2TPtLeg/x8tTboxSZ
         mBxY2Xuj+ctXLTvom5tpuqfkqPodnlHq1Z+Aoet1n+SA6zUU0egTzPH78nj9tt8VfAoW
         hamDpf/rus88S+tMZbJUQs48H8OW5RkD/0WJU21EuVNHqnm8015fkQlrod71w9oOVzax
         J/k+QjaViVeUHvaJXSjIigu9F4yeTVcS03Jxksu8ld8UM+Lx9zXt7oW6aV6cNGMkQMjB
         Exow==
X-Gm-Message-State: AOJu0YxQcnWt0Uy4bhZQ3Pu1a3a9pVGQlwxih61B74AySYBePnPu1uzq
	aSakL4Pkkeh2M56T8dJUBgu1cUbRcDkVYyPBNUNUjEw+HfKfHaKOfQFfE6DNWA==
X-Gm-Gg: ASbGncvl+bNs4ujm0X7srms9vuQE18haSgqWEyp2v47vz41pjDMXnCMErfHe3sXMLzC
	bXjUudq/NqEjggA3oe6NTupLLoSr3QGosYPhz9iSiB6KnurX/axrB2Y0TGdtQie8kDquk7xLX2s
	1n9RQOzvABFwym68LR55GUgKMAIpOw1kzUcC9nXo2xKUw0OW+sX8Bj5X8bFb7yjpWR23Oxk+9TR
	+x709ajzDD4qKw6DwUF75wNgZt4ODVCsQabu2kxn+OsA6MNHg2NfuUuTVq/AE3yIhEPcoxqXadG
	BC53VAbTz4DQ9HZcRHe/ub5snnCkWYysFK/8BFUZP/d9OvOTjEUZ+JLJbhHVznie/oBG7pntpT0
	13h+ty5s0rVFvJgwVcahFUpLhu22SyZ/dS0xcCNkU6g==
X-Google-Smtp-Source: AGHT+IHP3GQcL0kTxtBqXzVAfqRucKDvjgrfy2hkoIobWv1teudrCphV7dT1eWIF781RSx9/jQPbwQ==
X-Received: by 2002:a17:903:b0b:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-25d2675e964mr109953435ad.39.1757859700148;
        Sun, 14 Sep 2025 07:21:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.224.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b20d0b6sm101732425ad.124.2025.09.14.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:21:39 -0700 (PDT)
Message-ID: <68c6cf73.170a0220.21053f.2b0f@mx.google.com>
Date: Sun, 14 Sep 2025 07:21:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1710035852145230955=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] avdtp: wait for L2CAP Disconnect Rsp before CLOSING->IDLE
In-Reply-To: <82a0baea3c6d33392719fd4530e2763f2131eddc.1757854496.git.pav@iki.fi>
References: <82a0baea3c6d33392719fd4530e2763f2131eddc.1757854496.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1710035852145230955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1002167

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      2513.13 seconds
MakeCheck                     PASS      20.40 seconds
MakeDistcheck                 PASS      183.07 seconds
CheckValgrind                 PASS      233.38 seconds
CheckSmatch                   PASS      304.29 seconds
bluezmakeextell               PASS      127.37 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      905.62 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1710035852145230955==--
