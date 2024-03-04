Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA41FA4
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573558; cv=none; b=FDrPxAY3Jj9T6O3DCAZ2d9ybLZtgy55I5gpz9O9flrCijSK3o0qiw0n8RRLxbfWcZXpFqZBNk6jT4Nt0ZzzyyHbt1piM9uUJrHI5+SN6h9F5DZtlooxKWNFKEWWv1j0QVRkGIf/cw4vHvb88UD3vSxylcBYwWUL39FlX/mWPZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573558; c=relaxed/simple;
	bh=Y+arqYes+VjUmTFq2gHu7QssI3kTD6xqV6o5A7m8wwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VglaSqwlVV4vQOkKP6wBgcCJ6SigInszJDiazVHkVFmrBFYaxDSdnp8OSH8o2XmyT8Yw9qOJu5M1TV9U+1MmK9c8KVJsIbkoADdxPir88COMpEdLtbdZpA/N0ZQ6YkTddwONJ7fln2Ye4vvDiriyEy9VFGk909591FR3rrpHZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHfw9cAI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHfw9cAI"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42eeb5c2d08so8306651cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573555; x=1710178355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=coXTyd9bs3E2yoz3F4gRk8SZTlN0Ob0kzhVSshOidWQ=;
        b=iHfw9cAILU3N+RCPoIShFCqjN6NQPYntKrMBapBUvvGwk/JxYj6OuywqqEQ3NvMGRM
         mptrBgE+rVMg3ea8CPOWVXzaW6qw6bw3x114AQ4Qs7vIGOIs9gW3wBCRK2mlAwJtonqx
         dE7+KTAmhGi7+60MX2+h5FFSA7Ej7rLJQp5c4q0tzb0ZZqDsMILAEjF6tV5liDwC2yaF
         SvIPwP0j+FUfvp9h2HWz+aZfMlipCzgr8EAjJwVsYKsuGRPkSeNZdQCI6MmvYj1U6elk
         jbOyLFLbP1Vn8GUNHdwjUagtZkKROL9yuT6CrueIl0bZWio+GGaEFWQfWhRq33vBo38o
         xfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573555; x=1710178355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coXTyd9bs3E2yoz3F4gRk8SZTlN0Ob0kzhVSshOidWQ=;
        b=ZXadWInVYwcs8jkWt/+QlyxHiHYsAVF5jTZA9OGRYJIxvKKlCYsr/3jHLg+3y9O9sv
         3S5Wbw/+hYVjlA5QTrGRz9//MWJqe7+leH3QK6FtijzxP4Q3TRLd961LFo8ajaTWrb4k
         IwGGRFGdY68mbbBYKFi7N41ZS7l5B8Cw5Z5i5ZtPYXI0OME0lNdzWDhcL7UP+beO/0oP
         pNzO+iQQ8wj8OwU/R/RQ7sd0knqv5h27sDvPglT3IH1iEYx/YGRrnE3peLsG+cW48M9A
         kc3qtBRKvKfwfeHgn9XBStXeLl2IY80lS8S/eK9Gdn6OTzM8tD1bJHZN11Y5l0kKoPtA
         UC3A==
X-Gm-Message-State: AOJu0YzaI+qqUX1quMOW+tvVjfmD+3+mbAOCwZuKFfVANeBNfJK7W2Bz
	sCnxXy5ASzHLBsd00xzx1wqQZVYhUG5EHxE7vTke8pR0Vs61ql0nCxtIYO+7
X-Google-Smtp-Source: AGHT+IGEFARcTfLo9r7G3OmtzlXw/B8fxSyifkIde5GRf7vYzUbAq41RdGRXTmsCARpH3So2ubtNhg==
X-Received: by 2002:a0c:fe8e:0:b0:690:6dc1:5c99 with SMTP id d14-20020a0cfe8e000000b006906dc15c99mr4970496qvs.2.1709573555671;
        Mon, 04 Mar 2024 09:32:35 -0800 (PST)
Received: from [172.17.0.2] ([13.90.174.196])
        by smtp.gmail.com with ESMTPSA id em19-20020ad44f93000000b0068fdb03a3a3sm5278682qvb.95.2024.03.04.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:32:35 -0800 (PST)
Message-ID: <65e605b3.d40a0220.116d2.4809@mx.google.com>
Date: Mon, 04 Mar 2024 09:32:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2677990487491228202=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: iso_listen_bis fixes
In-Reply-To: <20240304165050.3430-2-iulia.tanasescu@nxp.com>
References: <20240304165050.3430-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2677990487491228202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832164

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      28.06 seconds
CheckAllWarning               PASS      31.18 seconds
CheckSparse                   PASS      38.29 seconds
CheckSmatch                   PASS      99.54 seconds
BuildKernel32                 PASS      27.30 seconds
TestRunnerSetup               PASS      506.43 seconds
TestRunner_l2cap-tester       PASS      20.19 seconds
TestRunner_iso-tester         PASS      29.34 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      112.37 seconds
TestRunner_rfcomm-tester      PASS      7.46 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.82 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      31.30 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.906 seconds


---
Regards,
Linux Bluetooth


--===============2677990487491228202==--
