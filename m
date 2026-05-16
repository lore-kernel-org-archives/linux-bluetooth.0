Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383717AE11
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778916789; cv=none; b=sTg4F2CXZtbWtkkNKtnbjMiykicTshYjLdfhVU0vAfm4gauabVuX94HSd9mWh4JA8Wy2qHGtkkrEEtSr1xF7kacQGbd4vz61EOL69+yasWFMkvydCgXhjQhg133xpn/HcXYBfc8/y9Pjc27DTEYcRMxidHiIVSrOm74GkxWbXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778916789; c=relaxed/simple;
	bh=eGtHUmprR8kbS6qEqqCBH9GwXvMj8W87W38nBSvxgfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LQLT4f+rvsXo7DOVliOMqSg23bnoi9F/JDzC0e7Aepy9f+vjLSNjwxvWId2wFbzpZRZX4adWnXCYfwoNqhE5Rnr68p7jt8PMm7kCnIJhwx87mFmH5ah69TeHzUjdnD3VSPJ6/zYuy09jmmScFHDEG8itlYR1cE2vhFU+pudXMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpZYc/Yg; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpZYc/Yg"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-135200bc7d2so2408751c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778916787; x=1779521587; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y5WbkuSQYjxDJIPTzyn42DSDzQOTU/1i+hcewhInKtk=;
        b=SpZYc/Ygqu2EkKTvPKsIhvPBc0S/sfGOAsxX06p5JB8BZU0a3AhmLsQ6UG5lsQISc5
         OSMALlV/EE1K8nT6lScf9mdd6FTXKQ8aHDrVAENut+5CjZD8SEofDUd5edba2ZlAVPNU
         y/8aznwyIOCy4O9IWrzRZMETYZ6U5VUoyFswtvBN9n9B9XXV9znIwp8j+hM4Yeglg3BD
         qcH1yoORR4NyKep+zqjLR7xNCSdn630M8iP7fn63Twj4gw3b8a9PmD353za3hVstUiQm
         mO45dp4C4U+aZWMtGQx7JZuQ/mMENk3TkcAp5gtvB6qts2xXnOtl3VhnxYgZedDFosrz
         jENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778916787; x=1779521587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5WbkuSQYjxDJIPTzyn42DSDzQOTU/1i+hcewhInKtk=;
        b=SGdjkSK37NvfnBP8G8ilYfGkvq+u4D45LK4/VqCqYc3gDYoBDuTRosL5TP5waB2hKK
         vC4nHgiUoCJXH9SIP6Q93Y8iyZ9M/2kHTSlcscN/G26MsNZS4IiBTDP+OjkAZi6VUC5g
         k+deyPHcU2bBMZMCOGnjSs7PVSMVvYIX8mNDwXQVVENuynr9DbyxoDuq60yVdUcuQmly
         wfyjI+A3Sd14XoyhFVhJqtAweU+SavVuRuQ+x8G70JMqb2mgbHyNt3vVIbk0yYVBOnVk
         TJiEr4AudNawp01l19aicvU0dyf7zKoFD6WGZoxjGw7NjsCc8On2J9y2cebtM3nAqy+7
         Wxnw==
X-Gm-Message-State: AOJu0YwOQEOrDM0BJVhdbFwLZ+CGKx4U8kElckX8UsMQ+jrr2nSe0ysY
	XwNFof/woXeeDESw1lsmH+hhngTpoNvcAp7Re3CXzBd5GOus0VoailSyj8CRQQ==
X-Gm-Gg: Acq92OE++XDNvJrspJZ8UlGilIGoUBkFgn7v6QLeJRC/qfI4M7hpfaCC93Zd12zjIc4
	HpO6rVyFpvpxoe5j+0KRKij+6S1IJGPnlR5zgZWxtL4pyQzBwuekFbiH4dkxqinUWKHlLTk7YVg
	CNejRil3A/uh+5u7EieDFBnEBnY9xiFKv1kMsPAuvhFTVA6zrLn03skATHO0ZhlJmdOjudOl0p2
	EqgjPFm5k3UvDChChrTqrCZgNJZyu7Fz3pKOGKm0agq1LgIBO+hrf8FSJen4R0DoC8FvfsRjly5
	1rh6UWGJMOx7vknK5fYobPY5fvta6gsE5fuShCZM4BKDRFESUd6NihoObLjejzP3UBS21Z/CLam
	hGrbA/jQO8A9ZgD2bsqVx4VEn0mCdh5FE58H3U6urW61xDCNTV2a63qV1Hz8h2T7hj/eE9Y4Itr
	HWlhYhEAbqrzqO79rebL+SQ3GGpTSomA==
X-Received: by 2002:a05:7022:6993:b0:134:df7f:910d with SMTP id a92af1059eb24-1350451e077mr2959906c88.7.1778916786554;
        Sat, 16 May 2026 00:33:06 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm10712794eec.5.2026.05.16.00.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 00:33:05 -0700 (PDT)
Message-ID: <6a081db1.d5797644.3a982e.c24f@mx.google.com>
Date: Sat, 16 May 2026 00:33:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4045391463316943186=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: [v6] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
In-Reply-To: <20260516053036.399005-1-w15303746062@163.com>
References: <20260516053036.399005-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4045391463316943186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095757

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.41 seconds
CheckAllWarning               PASS      28.73 seconds
CheckSparse                   PASS      27.21 seconds
BuildKernel32                 PASS      25.63 seconds
TestRunnerSetup               PASS      541.24 seconds
IncrementalBuild              PASS      24.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#85: 
skips the teardown of these workqueues and proceeds to free the `hu` struct.

total: 0 errors, 1 warnings, 60 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14576250.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (124>80): "  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940"
19: B1 Line exceeds max length (86>80): "  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0"
65: B1 Line exceeds max length (130>80): "- Fixed missing `hu->proto_lock` write lock in hci_uart_init_work() error path to prevent race with readers (reported by Sashiko)."
66: B1 Line exceeds max length (239>80): "- Added disable_work_sync() instead of cancel_work_sync() for `hu->write_work` in hci_uart_init_work() and hci_uart_register_dev() error paths to completely block any concurrent re-queuing window before hdev is freed (reported by Sashiko)."
69: B2 Line has trailing whitespace: "- Relocated disable_work_sync() to the very top of hci_uart_tty_close(), "
70: B1 Line exceeds max length (85>80): "  before hci_uart_close(), to ensure no new work is submitted during device teardown."
73: B2 Line has trailing whitespace: "- Adopted Luiz's suggestion to use disable_work_sync() instead of "


https://github.com/bluez/bluetooth-next/pull/200

---
Regards,
Linux Bluetooth


--===============4045391463316943186==--
