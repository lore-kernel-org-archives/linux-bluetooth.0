Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032532B100
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205625; cv=none; b=oxGzb9S1cz2mCBgpokaDPM+uLLIimvI0GgSqCri4+BbNjxvizzNj4iuquDXX+Ao/2C830dz19gUYMdwIDaGuyDGBea9au2sWkCUqPAE7bcGVu0oyWIybJvzB0UcHL7gZQBK0UZ3VU9KGAiflkFleAuWB+50ghpyt+cwmNNa/1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205625; c=relaxed/simple;
	bh=6olxPlys7gPdXvqvavlCwGj3RbO/kY6o5OP3jaymM+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ujXQUxaP8Z6xL8QL1QM9xujoUsuPJ+M8G05Fwvdh4QmeOS0BhyeKnAp1T85+lLzoRzcLQEc2uhK1ljh1leq0+SfJ68CLQW7EIIeV5S3vBD2vY0qty4bb4vTpWzMOTRrRDyGVrkry/aBBrhUXGB9xHZj/BwDPC9e9cD/wa/s+tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLwQOaJ/; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLwQOaJ/"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e98c0516dso182043eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781205623; x=1781810423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3PCVC9AxsaZYYw3Pi8lCS8jUQdYt7YvsW/NBIiiz7Yg=;
        b=JLwQOaJ/caLdqpKYjNQ6tCsHNyaZlNlTNJPP7dBI/Vt9GMzY19P35uViFBFMU/MUZh
         uoOuAxFNoIk6lqtLCFBa2vibEK+Z0l2JJNy1q+MM9SAjx3hcP5X2jOWO8oT/TXxzwffJ
         QbXQ5IYYjVSC4gb0EI0aEQt9kayKhWgeTbOFBByjYBlFddsqVg35aQWP71Rx+zaOuVxC
         vjcS5wsFgq6MnzZcFyAf0TRCkWMJNl8w3VjDQn4CqevYuFlu/dCO/kkKjzjZDhUrHI9Y
         erdrQPd74MykZ2uta9MsuRnAQ1+rAYQHMPtBARgsiGkRNEbqiYUW7waFD14Y/+bz4ksA
         aEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781205623; x=1781810423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PCVC9AxsaZYYw3Pi8lCS8jUQdYt7YvsW/NBIiiz7Yg=;
        b=eNIlhFvePPCvNXSb63qOl2agAAmSrPxUgbZudJP/RPSlW36Mo5WzB3e7/BVCv45U38
         IFbSMUzJfQMqoJWXYCw9esqCqo+3jgLHxNYetnrs7SvKz8V0aphLiCyRPHGQWpjIY73R
         SUi/tbIyfk8ek+FoRySzZk170R6t6Lel7hcNDjENVgFthZYRSNnwqXZ2WA40zgX2uxIt
         bcPROeulc/5u71mi8WgSBjsrgVetpdktqQzdSTlH3nCqvAKhE/8eSB2+VZqDEgiG6mO8
         W2egDKZmrP08OJ6pwFjrTkb4o/7zQP04AhWC1zbalqr/skzLdrg6WVuJ/QOEYgFGyral
         kKWg==
X-Gm-Message-State: AOJu0YzoQvxzxGvKHx4SCd5nwQOY+BvkfFfJW++fJmeJHUz37bdQiGu0
	d3yZCMxywm+GZEbtNdnSnfouRF1iRA81Jid1UMzdW6hyqfPHAVW/RfoEAxSBnQ==
X-Gm-Gg: Acq92OGLXHqJ9ZGdWV5HxtUuHq4rIIu4Ns2/DLTzgGW11cfaiVvmvuDfgzuhWLi0vCf
	oI9FgEGrg1ZROlJOwhEoUWfrgfhdBAfLFKiPW8MDxlN7iqq9Jgd5YBXROZgvQ4Xm+x3odL0Siqg
	the/zvZRoi657oAGc8lh+911U3bYO+2VejLuuufj7qkXGT0kGq4V7Q09jGv5MUcNIpoHXKCLvSC
	Wv3W6w/saD3hvZIfF0evRP+rq1DZE9f0cVbKQuJmbWM/fa7MPhUilikSRV67MHWt7vmulHjRPFF
	iPG1It/L9IvRNhNjGenQI2XNwdfYlAQ8VjhuMSPnhESUS+UtyFQrOe7lczE+6jqVfFAG5o14Gst
	t7FLFU4Ck4OwrtrOGRZmJskSfP7NEFIsHNWnpZWoh4XHnKeo+6lAyJRJZF3Lroupxs6xQ+vhuPm
	FCka2pEtlbBnWB29X6zfMIhd8BBF0ftOw=
X-Received: by 2002:a05:6820:220e:b0:69e:44bf:f44e with SMTP id 006d021491bc7-69ecae167aamr3108552eaf.17.1781205623387;
        Thu, 11 Jun 2026 12:20:23 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.86.105])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ed854c10esm297161eaf.11.2026.06.11.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:20:23 -0700 (PDT)
Message-ID: <6a2b0a77.58f6a988.156c41.2a93@mx.google.com>
Date: Thu, 11 Jun 2026 12:20:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3212538221249762073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
In-Reply-To: <20260611152039.2176565-1-oss@fourdim.xyz>
References: <20260611152039.2176565-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3212538221249762073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110143

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.48 seconds
CheckSparse                   PASS      26.19 seconds
BuildKernel32                 PASS      24.16 seconds
TestRunnerSetup               PASS      531.43 seconds
TestRunner_l2cap-tester       PASS      59.98 seconds
TestRunner_iso-tester         PASS      77.10 seconds
TestRunner_bnep-tester        PASS      18.80 seconds
TestRunner_mgmt-tester        FAIL      216.57 seconds
TestRunner_rfcomm-tester      PASS      25.55 seconds
TestRunner_sco-tester         PASS      32.10 seconds
TestRunner_ioctl-tester       PASS      25.34 seconds
TestRunner_mesh-tester        FAIL      25.86 seconds
TestRunner_smp-tester         PASS      23.11 seconds
TestRunner_userchan-tester    PASS      19.69 seconds
TestRunner_6lowpan-tester     FAIL      45.82 seconds
IncrementalBuild              PASS      24.08 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.239 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.495 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    5.057 seconds
Client Recv Dgram - Success                          Timed out    4.985 seconds
Client Recv Raw - Success                            Timed out    4.996 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.997 seconds
Client Recv IPHC Raw - Success                       Timed out    4.998 seconds


https://github.com/bluez/bluetooth-next/pull/305

---
Regards,
Linux Bluetooth


--===============3212538221249762073==--
