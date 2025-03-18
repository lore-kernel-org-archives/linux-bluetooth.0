Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5317A303
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327645; cv=none; b=iXNhaqG4vghKxJSmrEyEnBiZeEgUyANAkAIHxr1/WvVz5mO/KD7hPbxniVkZwvrm5VUqO5OdOjcf0PkmmFPgOvK/nAcpbwBzO0UeAtws0QuADbxyTLsytCmuV0OAS2mn/mOo81Pgr9AXiQEY1m/dTdnluScKxi4enXv9HiiP3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327645; c=relaxed/simple;
	bh=bHiQZVIUT1U29rNzO9hc8nUxzbKiwq9RmelJCA43WLU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LgnMnmjqeqbjg7V8B3nBta01LxSZWbn2ps1BIUs83nwM4acTRmV+dAQpZorRoJq+v7aWnWbVDcQwFmRwC6nFbNTJKa/PWRhekyuwniYVURujbFveZgfFXWIcPABO3ZJMZm6pJMBtm0VlfE2DdhDNRDVBGmIHRISVGy2bt4gsjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adUamdsS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adUamdsS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22622ddcc35so2942795ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742327639; x=1742932439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqxf50qbwA4UMzsid9EV4Fvi8PxCRx80BZL8Iwl5zi4=;
        b=adUamdsSXSdM1TaA3gkJ0czLVBXalNGheWbFAjNh8F7BjQd5vp5ImGig4MsAKRvwyX
         yTOi/ZU0dzCcNEmMnCoBNS8YHOK0AWkQKiO3gtHjxnY8aT/Bxi4967QXd82A0NSWrKCZ
         St0nU9LmYQ4dpq0RUfxMpm44hK/+MfLiPy+YQOkemJ5p4rs/kCsvItdTrx/PEMKNOjq4
         19FtswbEEqooVGqM5197K5sqTQebssH9uI1iAE0rKTkYH+SAndPfWHmIc9MGo6IvNcYa
         6qmuu7Sl5qJR6hm+KQRv2Sb/Eb5TnYMSNjgqhoczN0aRdeICIYH2bGw++2f4W9FRVl9p
         9iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327639; x=1742932439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqxf50qbwA4UMzsid9EV4Fvi8PxCRx80BZL8Iwl5zi4=;
        b=hX3DkJCl9Zzvw/yHwtRUBogQYlZaGn9CqgXJMkkwYik11KuoSMx52zUKVQvqWOdVcS
         boGfMIu8p82VvTsykEYwk29SHEkbjtDL7aFEs9kkOMBEHFMp+P7ccYmUyQ1fNljnqlpz
         sjJrEaw22Jhtq5jwKMj2PoYL8ceR60xUbT6HsmVIYPEyGuRXVRS+OA7XbG6Hp8lWRsc5
         XuU2K31JCHxQnDAPtJyrt/W8pcJnM6/9atRkeotRr3yUBWNK4ld4XggsvzRQT3qzwkCa
         bfNNAjutLxVJo9Knj5BmsBLlyAKWESHN1FZnDNs6gnGKL8veumWcJzQXFe9Jpz7+ZfaF
         bMQg==
X-Gm-Message-State: AOJu0YzPHgQYXNn6k2fDciMPXfOmp7yf2sctjc7rZ/SxzW+O/nlBjnC0
	abHgGjoxVWv3mJR4QwiQ79KSpcGleoVPIBeK7UqMimLSmiyo6rPAYF5YCA==
X-Gm-Gg: ASbGncsqa4Ag0bd7VcrxwcEbEBBxVS84wNgjnnP2iTaLG1MUsWEG1dl/4/LdVW2Ps+H
	e3mpKNzM+LpTbhmfOi6cWvQ41HwouuwUvSHHsgIjBZqNePccuNqdzaUxMUt8KIf+qSbrqdU2r6K
	8LfJCPoIAeGY1A1WH4IyYNCSRqB3oBeAbo7CeOZzCdcGirDB7oH4e/Fgk4pwA15NMyvP+kXwPgd
	yWRy+2Wt8UqOm13ulEXKg1hivwLvJZ50MOZRx4VxHymq0beNpufZf/HGnor0ytu9t7MmFYgZO4a
	v/wVYOOohezJbm9lTaYVV62H4cZkRAz+I/AEfd9KhfH521I=
X-Google-Smtp-Source: AGHT+IHaHxNW0FIIpIx/Z//eZcVlYz9011smcYQX+15LM5V6RQWVN/OTvNiXR9vgBeUV2987OjHsvQ==
X-Received: by 2002:a05:6a21:329c:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-1fa43cbeac7mr6776986637.5.1742327639511;
        Tue, 18 Mar 2025 12:53:59 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.7.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e5d47sm9415991a12.32.2025.03.18.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:53:59 -0700 (PDT)
Message-ID: <67d9cf57.630a0220.2b7092.5da7@mx.google.com>
Date: Tue, 18 Mar 2025 12:53:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4029494355262140662=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, calvin@wbinvd.org
Subject: RE: [QUESTION] bluetooth: Remove duplicated h4_recv_buf() in header
In-Reply-To: <2b612e2c1f4fa697b47b5dd9b72f1949d7c206f5.1742324401.git.calvin@wbinvd.org>
References: <2b612e2c1f4fa697b47b5dd9b72f1949d7c206f5.1742324401.git.calvin@wbinvd.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4029494355262140662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945301

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      24.02 seconds
CheckAllWarning               PASS      26.34 seconds
CheckSparse                   PASS      29.85 seconds
BuildKernel32                 PASS      23.54 seconds
TestRunnerSetup               PASS      423.74 seconds
TestRunner_l2cap-tester       PASS      22.97 seconds
TestRunner_iso-tester         PASS      28.73 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      120.62 seconds
TestRunner_rfcomm-tester      PASS      7.74 seconds
TestRunner_sco-tester         PASS      12.18 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.134 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.151 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4029494355262140662==--
