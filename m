Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9B433DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314774; cv=none; b=hnZnW6YkqatS3Kp0eajaeMngEoUP+6bSDgfKCLg0/bWuFAYu28kXWOEKyyLbtz7BZJgcGzJVvGlS4VZi6G62Pl36UX50DA/rgIf7OQKryq5yz0UxMTXrmKwWitB3c1MuUVg/gB7uU7p/UYcS8UJfBLqbs3HJ29BCdLwDEW2jitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314774; c=relaxed/simple;
	bh=foZfCC4wK8739Ne29OKbDeCe/elM5vnKh1MoHnxe3W8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XABkwXQwjqA2/HwQjMbsff+HEn0HI/U5naGUamdA/pREVONIw24ciGt6KA+6oV2YcsvYtm/D6MQFhL7TfeQh+CvYqPlLNzVE2T6+cMDWXx82EKEvoGkSQZaKJEVV5LRPLbhneqwohqQWOMZAY61OO1/wtHblb7P/vv01zm8MsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXNYQ7y0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXNYQ7y0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b04cb28acso687905b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721314772; x=1721919572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g6eWP4eD0m6IzW788h/tpxiJMyx3RMlufCqoxUN99Vg=;
        b=dXNYQ7y0NUgF59UOorTAEMZZkQm9+eh6aFG8QNvciKp4KY6ZNOgEoC6SAF3UicyLux
         Lwtb7CquQNEbSpCLqcXWxixB1UQJPJ09CaI6AkUGm7kHJq7Xb2IBqV8wyEPO2ZAIDXvh
         2e6FdvFL7tYyCFCrdobYH95GKXHcWD5DFomu3nIm6aam8Avgpw1GbqPlcQPp43sW5UtO
         wAGNMq7Awe2hnG5lKFbZw3FD+5BEUY9z05dabzWSVK8q7StPDxYfNJvCzPRytdhDK89O
         EV/GG9msjvVAtcUhPwjaSXbBoqD8p+Bxve900xlwnY7L5F1fU7vmQqwma6egHiy7M3lQ
         thQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314772; x=1721919572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6eWP4eD0m6IzW788h/tpxiJMyx3RMlufCqoxUN99Vg=;
        b=NJbkkuxt7wp1FiHF6dYAS4VaUvexhYVQwh2ItGHfXyKZvNyGzCdP6FG0c/mc1y+KiD
         +htk7Sl9UtJzqQo2twvtbnrquHIzM1jnquqdMMrbw/hls+djBHAb+kxSDZ7lsspsUFkq
         euSvERAYQmtKskkb5MGiI3Pmd47k3zFszv2Jyl7DecsDnquIizaMO8TGx+zWV25v4hyN
         cu6unHK/O7kzJ/bGjjU6clb4zbwru1YBW52A42/urTRaZA/V6Uq086Z3780/1tq8cSAc
         s9ZyyN1sEOzuc/QJqXluo9sDLDDpcPtkkHNLcoS2Djw4tLwXsRi9tCGzkhfF20KKlqzP
         zMzA==
X-Gm-Message-State: AOJu0Yz9Yl5jDlx3PBqTz3vC3Tn4Zm2CZX/+NabMsnkD12/ME2u4Daof
	DBso7zFv67HYhBlUelOr20tOpvjZmJ17+lh3nqT2k26Ec+ytOtcJlUnHDw==
X-Google-Smtp-Source: AGHT+IH9GJXvp2mS7K4zpfpnrpyLOzILn2NlclI7BAivHwtMtDNlxh8X/q8kPlxkeBptlxLiYrEUtQ==
X-Received: by 2002:a05:6a00:928b:b0:70a:fa24:65ed with SMTP id d2e1a72fcca58-70ceeb0a665mr5985295b3a.4.1721314771170;
        Thu, 18 Jul 2024 07:59:31 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca8303sm10472584b3a.173.2024.07.18.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:59:30 -0700 (PDT)
Message-ID: <66992dd2.050a0220.2db68.a225@mx.google.com>
Date: Thu, 18 Jul 2024 07:59:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5255162587173945582=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v5] Bluetooth: btintel: Allow configuring drive strength of BRI
In-Reply-To: <20240718144804.3953833-1-kiran.k@intel.com>
References: <20240718144804.3953833-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5255162587173945582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872290

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.00 seconds
CheckAllWarning               PASS      33.23 seconds
CheckSparse                   PASS      37.82 seconds
CheckSmatch                   PASS      102.73 seconds
BuildKernel32                 PASS      28.72 seconds
TestRunnerSetup               PASS      532.11 seconds
TestRunner_l2cap-tester       PASS      20.19 seconds
TestRunner_iso-tester         PASS      33.94 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      115.72 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      7.92 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      27.89 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: btintel: Allow configuring drive strength of BRI

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (81>80): "[21.982720] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 build 45995"


---
Regards,
Linux Bluetooth


--===============5255162587173945582==--
