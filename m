Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD3402453
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541546; cv=none; b=XACR84WhI47BV7cxBQ/LujPT/sa4t8s8QCsWZ32F30+tqkqZp9LOjIJEkIvrQpt7s1X31+EuWU1wIlGEYMNNltGHsoxTRmz7Luin0iOqtHIs0CBQXjSIY2i8kQUuG2MBTYfz+7tU292nJtmIuUg0nkgbBLDFRRo4yWd5m1AMmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541546; c=relaxed/simple;
	bh=q8yepwVuLyhtaYdp0BmwycKz0TceLkhVnR+kqIj2hMI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CNGdCvLIEmBHBk0Wba9tAw8H/cNWzX0JO7cRNGQUhdisxZz6bTEzqXr8qCs34e4Q81LRfEK+ASpeY8aAnmMb3/D1zFYxlbg1EZJn+uakgALZBJ10pciIZ+BkC0XI8xGkeCF+zjtK981ezs+0vbMPRBQT+d0oQhIjuX6aW0Llme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmV3Zlxi; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmV3Zlxi"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89c4f7f8650so19149436d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774541543; x=1775146343; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s2pq+nTOffjTiAHo8/MCPwyWHWcVsg5c5Aqk1Dm5BuU=;
        b=EmV3ZlxinSYCsyvoKj/rdXbCHeqVjGsY6TuUjsdFPPh48I7TXLeotmq917+h3Ff639
         27n0IGcRTol8B1vGM1irZKoUAk/uZhd64cJzOnkBBuZEP0B7NATvqakuiWUdkpLO0yDj
         xnsjcgOo9VGZB2aHBooV9pOEtr0umqTAFRU10/bfSB8B1+57RAwR04jQpqJFWa4NyTo7
         kbNjvaO2DN3ys93qkHfvG2i87An5R5drGMcb976gkqlook9Pf3Q5sAiu9IzRnq8OVYsA
         MBw3LxzWYRmQNO1tcfiy0G5ie+Cd44qldeakUQd0/+46KFhA7AHMF8I/jdEgMFORFJ70
         tKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541543; x=1775146343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2pq+nTOffjTiAHo8/MCPwyWHWcVsg5c5Aqk1Dm5BuU=;
        b=RkdYlyZhKkCDcH+XMrwhaGldkoapFp4fFTGAM6oqcjkfrUwlzL+iTzffvqFvTNpdy2
         tB/ro0E8U69Gj2ZCZloM2LH8YmLdhVlu+KyZ46mhiYnXhq0n2uDp92kiBlAc8+UC2vYP
         fYL+jYjlEp56eubiJwVHL2S7Feo+WkoJ7maZ08rqPn+VLIKYmDLQFFgxVA3zOqJQw12N
         HEScXGvw7rsSXkRIqXa7QNmENe8NoZxtWAGiMUfW8uMUcdDi3QseoPU1p/Ix5lnoDGwH
         1Am1VDr8d/pigyF2V0dikuLTGzkt48Ol2si8aMVPLvYNbvemZTJaMySoS5kR6xj231w/
         6g2w==
X-Gm-Message-State: AOJu0Yy7ODRR2QFrl/PkC447wXJl/Z9BgeIZ7n6Qb9YWZw5sP9hhN0cl
	/m3gT4d1Xz1+NxjwWJ2dj/XJbB8Btrnn/mfmLyL6MbmQMJPXVE6JyM3LRAnWgg==
X-Gm-Gg: ATEYQzyWVJhZJ7KdYMBzsicOnOMGZxylEv8lSW9uzBSse7oAZmBcGeker87gbGJcPdU
	i5AFrl97/Z2hYk+xgX8H6O4MneVAzhBRNTDD+jH6swuHTlvBClAnbpEe1E0xC0O0g2pldh1nlzn
	1lom5mAJvGOlp9yoMMQ0s1vKA4wnh/UPspNLlfU44famEP8lFBZ2kiOE4pTT1/ndepDvVjwHVdJ
	9nyQlJq1XhRL8v3TtHHwRC+zSsTL8H3RC2efegH46wq1RVP4HHnUNkjNcapJQoGwft/i7NRhrKA
	U+cxEaE5Xx8tezDvn+tVCDx+JZjwql6bBWpP0wNgtwJ7vVN+c9O3zph/1nJCJjeBjlMnuNLExyQ
	9Eo6wyluo00g6urX+5ceEXuWLh6FfTofaCQWSehsH9KteYRQeU/jB2CxtjOwqoBKF3pytV5GN71
	aXL/lw3//aLUmiydfNSP6X+MLFUAPn
X-Received: by 2002:a05:6214:5786:b0:899:f993:f2a3 with SMTP id 6a1803df08f44-89cc49cc9e1mr116326576d6.23.1774541543370;
        Thu, 26 Mar 2026 09:12:23 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.143.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd58553dcsm28464786d6.6.2026.03.26.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:12:22 -0700 (PDT)
Message-ID: <69c55ae6.d40a0220.10d3be.9039@mx.google.com>
Date: Thu, 26 Mar 2026 09:12:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3658091437988682962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, security@1seal.org
Subject: RE: [v5] Bluetooth: hci_event: move wake reason storage into validated event handlers
In-Reply-To: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
References: <798ca355ce0144488610929e6c13e383.security@1.0.0.127.in-addr.arpa>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3658091437988682962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073020

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.46 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      28.11 seconds
BuildKernel32                 PASS      25.59 seconds
TestRunnerSetup               PASS      566.92 seconds
TestRunner_l2cap-tester       PASS      27.99 seconds
TestRunner_iso-tester         FAIL      36.65 seconds
TestRunner_bnep-tester        PASS      6.27 seconds
TestRunner_mgmt-tester        FAIL      115.75 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.21 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   1.00 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.849 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3658091437988682962==--
