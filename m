Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7118733D
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480644; cv=none; b=T3S1iGseqYnYfB/oAKyT4mAdYMJl+ORFK7mnozRukfw5PvWt3q4gfh4zcbJk9dCx82/e9rkuTWE5DaLg1VWV6Cox1A4bGtv8APKpClk0gh12tLE8plWlFfqJENUG0gU9fO17C/gneMh9KP+UzLnRIeGbYpW9WfZ+P5MsUXPU3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480644; c=relaxed/simple;
	bh=LsqYatbRv1R8r1Rv2N59WgctizpIoa9XfMohagZZE9Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U58p8W1BsVVjgzxeQK7I/mOC6zS2u3DFLQ7+CnBP/DUn/rWlvOg67OYVBAAF14n45bBKdqjNn6xMQVnUkuHYib9BzH1brD2A1ybuz0Zx9gIxXcP4R1sAVsRSZchHjIYnhMTkhL4zChdUBGOmZaaX4hEhP1f2fomJ2JnqLGwYgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrYCRUP5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrYCRUP5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ff4568676eso43553885ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723480642; x=1724085442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f14NAlVU3ImOebsP/km9u1ZckfdCoyU3l7EB4/mhS7U=;
        b=GrYCRUP5tr4cOpjwO0ZsxiwN4ZabcBZFGU1yXQQHo5mzcVFkqIBIB128ff3XJDiwjW
         cQtPaLi7z7X1JFzbvzET2HWfN/kxkJ9lPTbmiOS5tdUFMrYhqKkszpF9wbcd7cJJ3IBt
         puzpdMK8ATXi5gjOqxHtHeX+mo5o8kBPp6oXuMyX9xDxYFIeH1Y9fx5GT0hi3sgige6F
         KeUb5X590UotOgmRWAPT6LsQPZrjxdjYvI1d3mN6S+0qgL+VILhp4sokEEFhtry0aKZk
         ZcbUhbebyR6v3xA3uCR99JpEUD1hVgUd7nbxC44ln+RMbQBnVhQfgiTrnYhZ7U4I1rlT
         y5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480642; x=1724085442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f14NAlVU3ImOebsP/km9u1ZckfdCoyU3l7EB4/mhS7U=;
        b=i5clOjinwD6eUFv/0MklWBAuDNEq+m1A1bspQUjG6APL0HynqGXPzTLck6uaAy7L+g
         OKNVctB0GWXK1JHFVg6nh2hVbTFZOGCfAMDQqGX3J9LRuOT+w7U0AYlfhvWNGHh8mJzA
         WH3kDY9pn1PPvF7jH8SoFu6C7j67gojp8C2+/UITutC+guAW///W8DYTIP7nS3UR/0zT
         HykK9r7bUymbw4EKAmCohSubdeclQLm021CAwlw0UXXQIYdDyOgvTOmvHCkvGMQGxLz/
         jN5AYyXWIqC12RRovs88XyKUMUZLfPOAgAhqNvh1BPFKvBgrmrYwdmhbm2tgNVE1nSoG
         Ds/g==
X-Gm-Message-State: AOJu0YxyDf15uVWBVW3AQEBoJePxP7dQNN9dkukTK2644redAs0oREQo
	mmK0SJUAcbavFkCyush4EKHGh78b3iTT84QX3rpUoRKwWXIyrn7Nyn8q0w==
X-Google-Smtp-Source: AGHT+IEIfREygXrTMssaH7gojBqJJWm+CBrk68AdQf4lw3ppKXetroSRBmLyX/Uh1ZaefWb1TYx1bQ==
X-Received: by 2002:a17:902:cf03:b0:1fd:acd1:b642 with SMTP id d9443c01a7336-201ca1e9f13mr10624965ad.64.1723480642130;
        Mon, 12 Aug 2024 09:37:22 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb3fc1bsm40036485ad.264.2024.08.12.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:37:21 -0700 (PDT)
Message-ID: <66ba3a41.170a0220.188600.b5b1@mx.google.com>
Date: Mon, 12 Aug 2024 09:37:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9027294666952006242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
In-Reply-To: <20240812150439.283920-1-luiz.dentz@gmail.com>
References: <20240812150439.283920-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9027294666952006242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878844

---Test result---

Test Summary:
CheckPatch                    PASS      2.89 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      30.72 seconds
CheckAllWarning               PASS      32.73 seconds
CheckSparse                   WARNING   38.21 seconds
CheckSmatch                   WARNING   103.02 seconds
BuildKernel32                 PASS      29.98 seconds
TestRunnerSetup               PASS      531.60 seconds
TestRunner_l2cap-tester       PASS      22.03 seconds
TestRunner_iso-tester         PASS      40.25 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      117.59 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      33.05 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.470 seconds


---
Regards,
Linux Bluetooth


--===============9027294666952006242==--
