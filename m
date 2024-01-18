Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6363B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555970; cv=none; b=REu7Adw6D+0GVoF5Lf6iPbbCQlO3uqQAyyzhOdjrAplzg9hfFynXYZXD2Kt8gpYIeilW8gt1nrZd9wKtJtMVU6u6qgQpsWt31+ZECvXU9GK696g4QcoHAudnbvyhgv1bUZXGMkpmuSA+egb5s4ZaMYRChplDfYlnLHqa2Ohg3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555970; c=relaxed/simple;
	bh=yjAUoPhEIso6F+wueJbfiUo9Fg/KjbRwTP6GKcfPxYM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References:Reply-To; b=FNvIDZH51cpsBjaTR7ojBRj0o3ChII3/nmqXMac12zYfhXnnAKdF0uUdF3UPP/dCidHLEQTyeBrbFe+MPEjfyaMsHrZvpu4JPLAbP9PI46tnltpl1CXXOrctGvEwg9eotZ1V79cpATrfbU+egu1G5xcqEKDSHcTYuvnUUYz5IDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmL1o4xz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmL1o4xz"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-429b76f129eso42412231cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 21:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705555968; x=1706160768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IWTM0Kj8dkhDI0fAVDiDDraUX/SLIgacD876qLOEK3M=;
        b=kmL1o4xzZCfvEz/SpCBq960ya3JVmFhC91eUL7BKnev4tfnylVNKGTwP6srySUYe2V
         aYBIN1eUqM6WrLp0YwIB0IWLNI4LTST454sXqT1FA7J5t0h1+l4l1MnFg4DF4y+5MOf+
         Xhmgiqg0hwGzBgNJpVlLQbcriXC72S31PUptx5y2UhYJRqHTFcltnSKlTn3Sc1MjJotS
         RFtdM4tKLdz38b8aww3gAm6xHTUhvMS4hQpPuH5c146gJCOsCD8KFqYUAEuehjSZh7cr
         +Mb6wLIaGibWw29tXJVB2sojJ3zEDKDTvest+0NIMqijyxyQ3sdZ49AGI0+VjE8dD6ka
         gpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705555968; x=1706160768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWTM0Kj8dkhDI0fAVDiDDraUX/SLIgacD876qLOEK3M=;
        b=YvuBIxcktDymWaWbBNTExvazcaruDkcpeC0MSFsuDETbBMMx2A6q3p9O9P2TaWi9PV
         OuXq2BkqAmkYWLV4s2HGmLRntyLD5QEqWjBFXtePsWRPmT7I3xT6WvWARkNAM9myz/g1
         BRzaBexWqdodExNHX4w7ztt3h3fOF8gZa8XqxXvPQtHoWSmXkp1VKWjNrMd/SIfHIrR3
         2n9G2DDKwLnol8FN7NvTcnYSA+9VgZ+DkpP+7A45emxpoT2u8uqSOcIB3mdTyze5U877
         auLIOOp9SHXeHIULoyuFaHi39190aWbsfazvV8i/V1J2Pkv83y6H5B4kHrZ5x8S7bs/i
         Xpxw==
X-Gm-Message-State: AOJu0YwXzM7VcBPX2r6R5/2QWUEv40nCNvq8UEwoT9IgGpmQ3Tev/fTE
	mWRH9m0H5KV3UqsVgbru672cmDTqR+vfa6u3iv2sae6o/DaDwuMYSWUiza+f
X-Google-Smtp-Source: AGHT+IFsdq2CcDSrNmOGgdxzDgYfsO/CqKnCjLO/A6OwGqmLz/yhDWxwEgBj5ASYVhev+6kqIieQSQ==
X-Received: by 2002:ac8:5c81:0:b0:42a:a7:7b40 with SMTP id r1-20020ac85c81000000b0042a00a77b40mr329007qta.30.1705555967918;
        Wed, 17 Jan 2024 21:32:47 -0800 (PST)
Received: from [172.17.0.2] ([172.183.161.204])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a20ca00b007832961ff29sm5039634qka.4.2024.01.17.21.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 21:32:47 -0800 (PST)
Message-ID: <65a8b7ff.050a0220.1220f.8571@mx.google.com>
Date: Wed, 17 Jan 2024 21:32:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3234152954063464470=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: [next] bluetooth/btintel: fix null ptr deref in btintel_read_version
In-Reply-To: <tencent_E60894D8E85AEEF2CD9C787A6CA82F656C0A@qq.com>
References: <tencent_E60894D8E85AEEF2CD9C787A6CA82F656C0A@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3234152954063464470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817714

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       FAIL      0.92 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      30.64 seconds
CheckSparse                   PASS      35.85 seconds
CheckSmatch                   PASS      98.80 seconds
BuildKernel32                 PASS      27.17 seconds
TestRunnerSetup               PASS      434.34 seconds
TestRunner_l2cap-tester       PASS      22.86 seconds
TestRunner_iso-tester         PASS      47.19 seconds
TestRunner_bnep-tester        PASS      6.79 seconds
TestRunner_mgmt-tester        PASS      155.13 seconds
TestRunner_rfcomm-tester      PASS      10.67 seconds
TestRunner_sco-tester         PASS      14.34 seconds
TestRunner_ioctl-tester       PASS      12.04 seconds
TestRunner_mesh-tester        PASS      8.75 seconds
TestRunner_smp-tester         PASS      9.62 seconds
TestRunner_userchan-tester    PASS      8.21 seconds
IncrementalBuild              PASS      25.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[next] bluetooth/btintel: fix null ptr deref in btintel_read_version
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#83: 
If hci_cmd_sync_complete() is triggered and skb is NULL, then hdev->req_skb is NULL,

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#86: 
Reported-and-tested-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>

total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13522361.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[next] bluetooth/btintel: fix null ptr deref in btintel_read_version

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (84>80): "If hci_cmd_sync_complete() is triggered and skb is NULL, then hdev->req_skb is NULL,"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3234152954063464470==--
