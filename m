Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1372F6928
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006510; cv=none; b=qhJYxMr7o81ZdA4G7qUoi+jfs+v9hFoiKc+g0ud4MJvM+hDBaE7CNXO2WG7uKloG39/6y21hh5Cs+qY5Sq7Aqs3NEg0+9YK9/1PRIxvaInDHqyIkUOZa/+AOEJGSJ1MFY+UwD8Z2FYEqHe+NjubKeTitehw5phx1EnxVun67IFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006510; c=relaxed/simple;
	bh=k83SfuuWYez88HkUBNuc07ujdTBaKWVTJKNhyJKNAs4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W3/FE8QjjW+spdLeC9kFlkKBCqXvi4vdgIwZ4RUq6oB5DVow5Cbv+eGtiGEss+H97okIxfTJCwmaMfQ0KNfjh4gHGj76MMqNoglMDwm2bflrODujthkf2Cogat+i2ODc1s0aYkzw0iOFOh61HH69Cizwjfm6lW6SGudoF1/y7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+suShjp; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+suShjp"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c0f13e4424so721385085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767006508; x=1767611308; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0L4t14w/sB8QWIJcJVoUaYlv2S1MM1DIpAFLARIy5O4=;
        b=D+suShjpCAHJRJi22NL6OGaJYd+fVbaiKo+DNHey9EKBZ09hW9i0Hptv6wz6qz59ym
         5khKNrdeI8uyqFRcQNEma6GHuLANBJIoUPREyb+Q9O5OPq/jVQza+LqbS125T/SFXmKK
         CAp1EPbFFzAarmHZt0JjBIg9ZfEYplvtxuUdZewGxMUNRIewGFo+PHB6xcTa22sOcTjz
         SshxP9uccTwwOpk6CTSNr0rqmTePS3eToQhnaV+rV75nJdxVs407N96rnCaHH+KKeNzU
         3fO59RHJPd+gIN4NF0DZfCTuCOno7s5Pz53KxXU1jZykGbz6yJ8zxQSOWxw9LnZXVqPK
         H8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006508; x=1767611308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L4t14w/sB8QWIJcJVoUaYlv2S1MM1DIpAFLARIy5O4=;
        b=R0kvsDQLtCsyvU43O3vRr6aNXIkCmWPAtQayK7y4GwkvpHi+SCh0L8XeCz4ZVsokP6
         0Sy/lcSssP+ZI8jhWCAfnLQKvuu1yZbdIRQzuSUzjTl2T5Ef1bexLqeBnmeFVvll1REQ
         v/gS53Cffs/sJoZDRDIAWDGL2oHfuVDVISc+PbGRcI35ZcfczSYpqeO1hKBnsJJbAk/u
         KpLjr4VcZH6u10mD5AS0928GFDN4Strw/7GG/PySCAF6wHU2pu2yKBoisc2T9+g1lcEq
         LZ3HEKv/N3LsiwlmzZMEg/IApguxjJulXSbJBrpC1uzHz9ILSiFQFvYR7SH1c22ZsWhj
         Edsg==
X-Gm-Message-State: AOJu0YzDguviO4RyDwnvqAdItwkwLKwMZuDHFwm6F/A5iUTAyxY1uhE6
	xiQdZxr9hKoZIVsZiIpvU12x5lM4kjfj+K1wJ2+EAuhBl80rdhjCxTY3+DJzYxue
X-Gm-Gg: AY/fxX6NiEvVCUWZg8PgCzSRedyJ0OSVNMpvE1sGt/DP+N3MjPwgtR6wbMahznclw1p
	9Vs3zrZ3a3pXfUAXYeLgoKuAJAjfWITaSuE7QKqk+9rnM3sYgD0Br54CJGI6o/UaCmvMuLAppyd
	fwhb9K/H0NSPaOF4RWDXjzqrpEq6dME2IHb7kMEkO8w6tiyLKmg+6a9b9Il1cgnDN1RVdUTdkPz
	ukCoVIiYCf/2CjJjwFi1rxNV2KuR+9AlSZb2MYMhMi1/1VhVTnSq3mzmsm5/Jw6NsPnwKV9cGL3
	Z5fxzZJ63O3uFJkKI+5laFlCcB8+cKVWR6l/A3arqTSWq+WZaaO9Cs+vO8VFsFS687/xR5pjWA8
	8hG4hTMFwKvhyXe/8vZBZcVlteai3sjqmvIg+juEefsh7DuhTEpMi7GaYHx0VE1hTuvNE5Q1JGo
	qJVE7i1B6HC2u/TKwv
X-Google-Smtp-Source: AGHT+IFyHNojexSzVS/UzCEb+yx+iYBWJi+7BnSlTyZTVKSTPSXK3ztAD2aIQqOAMcaa0Kt5IALFgQ==
X-Received: by 2002:a05:620a:2914:b0:8b2:e2ca:363 with SMTP id af79cd13be357-8c08fc0ebcbmr4672776885a.21.1767006508149;
        Mon, 29 Dec 2025 03:08:28 -0800 (PST)
Received: from [172.17.0.2] ([4.236.159.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975eeb4bsm2407752285a.52.2025.12.29.03.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:08:27 -0800 (PST)
Message-ID: <6952612b.050a0220.1169d3.291e@mx.google.com>
Date: Mon, 29 Dec 2025 03:08:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7067427988285574912=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Enhanced or Legacy Accept Synchronous Connection Request command
In-Reply-To: <20251229104630.2734644-2-mahesh.talewad@nxp.com>
References: <20251229104630.2734644-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7067427988285574912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1037077

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      23.57 seconds
CheckAllWarning               PASS      26.64 seconds
CheckSparse                   WARNING   30.13 seconds
BuildKernel32                 PASS      24.09 seconds
TestRunnerSetup               PASS      506.85 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      69.06 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      119.89 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      16.86 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      12.03 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 30, Passed: 26 (86.7%), Failed: 4, Not Run: 0

Failed Test Cases
SCO CVSD Listen - Success                            Timed out    2.757 seconds
SCO CVSD Listen Defer - Success                      Failed       0.131 seconds
SCO CVSD Listen Recv - Success                       Failed       0.125 seconds
SCO CVSD Listen Send - Success                       Failed       0.128 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.924 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7067427988285574912==--
