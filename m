Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C238BF9E
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136102; cv=none; b=VxsCV3+4fCVSDPs8tDhTQ5BLPtTlEDSm7/hLzqa3T5+NXsW/iwZUjRcEG+3xfXcmFELzj2savB3kSz2W+XlGEdxPotifQW/pEOp5AIHho9pjxDGiPTz+nB/kN7JxoRFuJ0UA2V8qw6z5SpbHGhCjX8ziQCzeDFtMXHg5fSMey/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136102; c=relaxed/simple;
	bh=ab+V3BKLxvQDzl3kWngPlTu9WPGwy/ovK4nuaXNv4LA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=coILsb8BWsQhSbR0Zo0yGJGM/gn8R7ss2Pp1JVmrEbs30Xnk9mdrlEXc01Vpz9j63eAEfvR6D2e6zYm/xDXS7v9ID1H4kP/xUBlyHXEgSOHVPlsjE8XipUZAt4bxIZjo09CFayv8eE18lOMlhm7SYZ9laVmrsLEDrQDHIP6s8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meHBc3Y5; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meHBc3Y5"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-133466cf955so10374037c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779136100; x=1779740900; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GXYhU+/8Z+lhqXnJAyLr1/xBhtiaSvn+eU7Q20yQgYU=;
        b=meHBc3Y5c9L+SukHpBFov45NFEURFeHpJsm8I24YQ+ddVMW0uHmnmsogdX/U4T9szq
         JTAOWEsalwWK03ZmTyiEiBpqnB5UxU4dL/hNLGoMpDm5CJj8Z8lUtEukxTDtHvOCssgE
         Ear9GYWyOwM6XKMmtEJrXK0yLQSjTZJ29IDVdfQumbhKUc8GbH0nQeq7ITdMjJsftf9r
         fK/p0VUSNPDP/utlbGzXMU7tTkyVvPf0qO96JTYuy1BdOSHH2un8g5v9rFYHCbCZ22K0
         WvYUIxidSyR4/B0dkSa0cmE/qKNzqgzVkPK8v5c3khD0CXEoyNTlmV2xowwvv2QVtvNF
         L5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136100; x=1779740900;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXYhU+/8Z+lhqXnJAyLr1/xBhtiaSvn+eU7Q20yQgYU=;
        b=fv/T9i/vCH2Et94RlhjaAnMglJV14UvwQw8wqmVzECzAJrhaMa/WRQhwMfEWRpSj0s
         XZ+Ve1JFctyc/HveAsneXhDHNHLwbL3kp7JAg56Xa5e4rUFOgdIw8Sf1av9b1zGQ1vW5
         HfqeyR+ZWUk9zWXYdqN8TF1ogeHLHf1p82f4TZw28+KTSd+WEIrdZwi/ihjpXt7LEllO
         Zu81boQY7m33lz/uSD7wKUmxBbFKS2IpTu+A0wS0TWJy/BPKFUKKyQuZXe+YMHg5VNn0
         MTlnvQnLD5HjZX/IGCyxEjP79MEMBfBR0egi0EPB+PGSO9FGkFfMs9nodYfXbidlgxb3
         e1jQ==
X-Gm-Message-State: AOJu0Yx2ORSLFLQvb7sWuJpw+sdxDxVEFkXHsuYgJUjyh7way15+X/CF
	ie7ls0DmTsIiNcGuY81mbC/zMr6m5rS07DTmhQ/Iiqk2hN15X0NDWxtlurVSfA==
X-Gm-Gg: Acq92OHj9y+utiCnhNIXh7r5H6mVynYq30YryLKCKT721BVNerH3oEmRcrOHYf6eVp9
	4TqoBMQuizFkGb4YQRrrp2uXj0z+fibznKByLZ8JIatR3gRZbeI9qU3U0ga+dkpf1eOlfOmzd7V
	IhN6x4xjsnVURARwMxE67hB0kWlQyYEmEcJdNG/C95LRR4UDXB6dgJDww/PTqToG2pCoeXQhOM7
	TwerJ67jmMSHhh512kwcqNaZIS0Hdk3l/EH1TGpnggUDGr8W2HFGbPe3qAYqF7brSi2orx5Lq7j
	p+cSrQLoKr+C8E3vinX+jd/MvgFfm6C4s4Ar6dks00lqe3OMpTlt6F9S/8FqLmuy0X4U2zeAQiq
	/9iV2TlUyTXVhWGsis4k0mzsSIN6Y1aHq9N/g8g0ikZV0BPrThc8NqbYy5So2wN2gX1PORmYWIU
	RnMel3a0s0sQnwOcHizVAAXzu1JUUX
X-Received: by 2002:a05:7022:eaca:b0:128:d4be:7428 with SMTP id a92af1059eb24-1350483f0efmr8436494c88.19.1779136100182;
        Mon, 18 May 2026 13:28:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.140.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm21272645c88.5.2026.05.18.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:28:19 -0700 (PDT)
Message-ID: <6a0b7663.20bdc49f.3a3b9c.7457@mx.google.com>
Date: Mon, 18 May 2026 13:28:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2937721782987577041=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jarys.cz@gmail.com
Subject: RE: Bluetooth: btusb: Add Realtek RTL8852BE BT 0x04c5/0x1670 (Fujitsu)
In-Reply-To: <20260518191654.615129-1-jarys.cz@gmail.com>
References: <20260518191654.615129-1-jarys.cz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2937721782987577041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096820

---Test result---

Test Summary:
CheckPatch                    FAIL      0.53 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.63 seconds
CheckAllWarning               PASS      28.96 seconds
CheckSparse                   PASS      27.75 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      565.04 seconds
IncrementalBuild              PASS      25.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add Realtek RTL8852BE BT 0x04c5/0x1670 (Fujitsu)
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#123: 
  Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b lmp_ver=0b lmp_subver=8852

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14579881.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add Realtek RTL8852BE BT 0x04c5/0x1670 (Fujitsu)

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
28: B1 Line exceeds max length (84>80): "  Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b lmp_ver=0b lmp_subver=8852"


https://github.com/bluez/bluetooth-next/pull/210

---
Regards,
Linux Bluetooth


--===============2937721782987577041==--
