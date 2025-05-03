Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022E2904
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746282668; cv=none; b=YWSyNVJ+Rf33OFhVC4ltKzrVESx/20Ul47n7yJGU7r7E4+ZC98XOfeM4zZtEMENEM/jzoQ7pB2ENkj4fu3UOwi5hKIbaeZhZqbB8LniPoJrbNv9H+8zOxTKiaTlPoUTvRL8gZi6Ei6Zblsvnpgz+ihwjC/XquGI5DkoKPHIMWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746282668; c=relaxed/simple;
	bh=1I3/2p0KeN9BmphvRDIXVwpSH29pv6STK8sk1k+89i8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZTZgvjMszT9bd1rCBOBSlTBgqsl8aAyIRky0i35hhi+qJS8KsY98369oXym3jT0mIyudZ574Vdj0PJv3oH2oSBQKp6+YiwoVuYf5unmanb6GcasjPXmb+BQ7d9BeAdBsiZvB2eOH7Ni3vMqsW6QKXnW3VgLcRQK4FRdRk+Y9MBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AautdOXw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AautdOXw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5b8d13f73so373350885a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 May 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746282665; x=1746887465; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KrDGYAn7c07iP2GXpG9246oDsAdbirbKwIODWb9n410=;
        b=AautdOXwEdlz8gZgN8UyY/1S/d+3x8RRTfzVIC+udDgDNZIqKVQwN6A+Z2RLKuu0/y
         1yK6efqJnsogQfujnwEc/U5NVNGYuNhDOEDoBSyqbema+pS3hWxYPMUXy29AX8RofUYb
         uRoINdLxE/hBVHi3XnlgsvGG4PUnPvmfgoqXEgVnTEkBW64uuFcn1yOLNYuUIu7WvPa3
         DhwaByyeM30+EpF4L6Evbv4TJwhNdmpS1mGZbLWPpw1DmNCI6OKKeXuwd7xnsw9p8nCc
         N8GAcC73iJF6iXmpg1I6VDiwk1dUW7Nt1xYarmteN/U6t78FOrbPQ+klKBIXkA/jhiHr
         Wvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746282665; x=1746887465;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrDGYAn7c07iP2GXpG9246oDsAdbirbKwIODWb9n410=;
        b=cFD5uhF3g7D/uS9gHwv81vADWB3RKIuFMf//a4BtxBCosP2RY4zRV5mUJ6o5JAVZVv
         fpf1TUkR9I3Un8zuwesMalDjKCIk4ApGVu98rdFW30buYIifcI+mvfBQVoDMH9mM4/I5
         wHUddaMBRnjmbgEzufZnOaxi2wMHO22dWSLRbkmdgTZK4e4Trg2BbBjsN4N2ZlA08dca
         wJnCUoCInG3+FSiqQ0fI92H6OukEQBxKWAD884/63ItUYsV17dKs27HVzox5H0WiOYvZ
         5h3kMfERrqRC6kZywNEBWAUCs4RFM2T6xVMKi0v7Xcxqpk6Led7n2IYO+YDd+ddRFYfu
         IkiQ==
X-Gm-Message-State: AOJu0YyiSR3kzK0ipKqKkYtlh9HOI0yrYITaROZMtrkMWff6NDjKlrbD
	ds2VQLzn5ZFf9vwN5P+r4PMLkkCQnYQ7xV56O/g8AZEQ9Lfz5U/JNDSNiQ==
X-Gm-Gg: ASbGncvCqy1YXBmYzVJE433gvE9V/4fKSCP2WdIwzhTIEhVlCNNyUaLSJnzOGrWuMbg
	7RVVNGK87JIQJRtVncLeT60wdKV+GTrgBRP+tCB1q2ZKGjE0QaJjsRtPrvb2P1/C/nflmt4SLZ2
	E23ajkj9CinxdG7uazdBB5hvrf1TA1wzP+cBvzdW4hlOklF8FUhUZyVTFw/FD6LkQnaRU2vlabO
	FcZNmwKh9h8IQ3ID1sH1ZprwihtvxD9vAYZp07Dvu0elfj4hwqGTl7F2xkjJR3iu1xd7WFA9vKK
	6Z0ikZKv0uZHXaWsS9wTis2ntyVghz7c7qaYGQdFkGiYSQ==
X-Google-Smtp-Source: AGHT+IF0R40noRQtsg/N3MDW68DBZKIunBvonKmvWpYdHclUyVm47IuFwJVdD0BN0SRvX30vSOGPBg==
X-Received: by 2002:a05:620a:2611:b0:7c5:61b2:b95 with SMTP id af79cd13be357-7cae3ab2974mr175615285a.30.1746282665229;
        Sat, 03 May 2025 07:31:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.49.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23b5c40sm320047685a.23.2025.05.03.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 07:31:04 -0700 (PDT)
Message-ID: <681628a8.050a0220.1b26d3.2253@mx.google.com>
Date: Sat, 03 May 2025 07:31:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0844043499112264568=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: separate ISO_LINK_UCAST and BCAST link types
In-Reply-To: <e26c5c8ef755e9dbe2e1a5204a86ecd907fd6508.1746280854.git.pav@iki.fi>
References: <e26c5c8ef755e9dbe2e1a5204a86ecd907fd6508.1746280854.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0844043499112264568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959334

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.05 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   WARNING   30.19 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      453.53 seconds
TestRunner_l2cap-tester       PASS      22.11 seconds
TestRunner_iso-tester         PASS      30.49 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      116.81 seconds
TestRunner_rfcomm-tester      PASS      7.81 seconds
TestRunner_sco-tester         PASS      13.10 seconds
TestRunner_ioctl-tester       PASS      8.27 seconds
TestRunner_mesh-tester        FAIL      6.27 seconds
TestRunner_smp-tester         PASS      8.14 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.158 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.114 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0844043499112264568==--
