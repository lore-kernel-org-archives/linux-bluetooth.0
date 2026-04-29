Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A22727FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474729; cv=none; b=oO1OgBCyZmZKM2Une+8CqE1MQzPbisDn79oiLWsY2uKy9/cjhZ1rAG2xyZZuAlhkQf9opjBytZQpmLrckZA1a+TSQq1IKi7dEaTjMKvsHxAyH2K527YNNfY5AqylUvevNbvap9wM31q7kBZtmOQhchnk5TtVhiE4ouOGGzwL9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474729; c=relaxed/simple;
	bh=y4d3h2nujZz5grA4WqCUsG74T2UW5Sxzk+TlQEHO8g0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cz5eWlHPOzOpdjWh/yhQKKIw9hDuAM0okJ6drubiIghfS7dcRZBzVpTbamhkIhHXGDESZdW1gI12g+6v7kS8qCwgREQP+clJHqmdRzQGYvhK8/8e+qxsoxO8KR3edPZl2G7LOweDEXlUkB7dvZzjwM4gRtkGrSs6O0FUEQ7D/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtaQuJB4; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtaQuJB4"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2eadb000b8cso4860568eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777474727; x=1778079527; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=joenIq2O3Mhnt0pNGuc8/3otC7ZcgmJdvkilpYLN+t8=;
        b=jtaQuJB4BxZmgURXukjGqF/Z4pS2wZbj/RWoUhqeLk8k0BOocV8nF+7sc6o0+U10jI
         JYsrEqnLfOGi8xHYBI1hYtXvj6Ho07YZ9ML5+sK+TbGZfCRJz3877whA62D/v0bXj9ys
         80efrc/Mz0AkpPRnI/SzgTRVnyKTX+KpYIbMZ/Fb1Lqpp4xOMm02neRHQYWRCcMK75nN
         +cXmMM+Q4uASiUFN43j8tWTtSTXlppBj+LutOgsgPalQaY755WUms1BOVTP3la6eUw/G
         p7/4owCR0pbGV3rm3KHgP49i6xPCNA9ZqerFBRpw9iQwOc1qlro514ZgS3uX2csM7RTk
         gOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474727; x=1778079527;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joenIq2O3Mhnt0pNGuc8/3otC7ZcgmJdvkilpYLN+t8=;
        b=K/Nkgq9PBuEwR3bPzTZ82Smbd8ZIRmbMSFUKijtkiCPYAnmfHzP7PveExz9voyJc8P
         URmsj62M5VGdlKExB8oDmOHxAEU5hR6Z2SSi5bzawUNzo7PvWNjkU028eeDBrls9ZXbY
         QaQwucnLDrXNsIAXQ5W+28RP4Bi8Y/++u2GZknsUR77pMuFEJ+hcohvmmt+NYyeBtcTf
         P4Jrr9JoslLgKEC/ERKWrwH6mSj+1zPkV9vSQZu35ysLNIT9TOeRgrc5shr8kD7Ul/YB
         0YLVIyQvG9UUIpXSwisBvtSj2j9gHheVidtFrcjKqE91v4W6QYDqb36YVj3tanNvPuy+
         rw6Q==
X-Gm-Message-State: AOJu0Yy4IPUnMUk6gnejXEaMfkTJMv6wEXoI1riiWpLoa5KnA2IJIY8l
	R9Z5FzNXpxmCY8vVhkw5i4vCKyi47t5Kk9/y8Z4z6mUocieNzeOdt7p73aGa5g==
X-Gm-Gg: AeBDiev+zhcKAxH6U14SUeMGcAU9SDbkn8twkY9hu0rXgsUcgfBOhusJsyd/8A4JQFi
	7S96s9hSDEHPik/jpzzMPgefFw4AjOcOiq9OBtCyJC4B910JRfEieHYwql/SfO194K99MgJQj8s
	kwIB+2nLFGEbR1PIJECzBb8aJ3/1zhLufSI4XP5QwJNa/hX7/AxvIf322tB4xaqc2LEiN+cZ6Vi
	T0JNRcni0JO4CtPEacxQh52HG57+DIx85kzxW+gmzxq5GgoeO1jPB7I1GDN5jX/erOHPvSeklDx
	tLwpa6QeWsbDFrgAnihWPr/kj9LyoQHHKHjNgZqmsSzzqt1RwZ39zb4HivSzUrTxkdCLHryGbaS
	aU85lDT2yz6IHv6nOjs7ahVHgPPYTq1RGHucK9Z0V48AiZr74qRX/CLeAszSuGCAi+P4IptHGVV
	vjt6Lavobih6e/cS5Jdrdti25Q1MKUVX5S61uUJz3nSWbX5kMElzVG5g==
X-Received: by 2002:a05:7301:3d15:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-2ed1977b8f4mr1867372eec.8.1777474726519;
        Wed, 29 Apr 2026 07:58:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c07058esm3230873eec.15.2026.04.29.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:58:46 -0700 (PDT)
Message-ID: <69f21ca6.050a0220.321bfd.803f@mx.google.com>
Date: Wed, 29 Apr 2026 07:58:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8889153505972318648=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v5] Bluetooth: hci_qca: Convert timeout from jiffies to ms
In-Reply-To: <20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com>
References: <20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8889153505972318648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087462

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.43 seconds
CheckAllWarning               PASS      29.32 seconds
CheckSparse                   PASS      28.06 seconds
BuildKernel32                 PASS      26.08 seconds
TestRunnerSetup               PASS      577.43 seconds
IncrementalBuild              PASS      25.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5] Bluetooth: hci_qca: Convert timeout from jiffies to ms
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit c347ca17d62a ("Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling")'
#125: 
Wake timer depends on commit c347ca17d62a

total: 1 errors, 0 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14546625.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: hci_qca: Convert timeout from jiffies to ms

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B1 Line exceeds max length (84>80): "  https://lore.kernel.org/all/20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com/"


https://github.com/bluez/bluetooth-next/pull/131

---
Regards,
Linux Bluetooth


--===============8889153505972318648==--
