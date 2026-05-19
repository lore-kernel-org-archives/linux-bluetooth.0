Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA237F740
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171335; cv=none; b=ImEyQzgf/0cZPA8bQPRVmQuadxdqnomKDTHamjq2MXRmCv/fbeR5lXE8pRMbRdYGJW4UaxdVhPYDAzX1g4TJUdE5zjAkZT+7WbhJsgjcejBcLM6VedRf6OQvZ0pC6OzGN4MvTAoY4+8sduif3FxRVFZVIevj+pw1ABwHs8FeaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171335; c=relaxed/simple;
	bh=qxRfhvEWsUY7b3rADPpVOUeTrNJ9modj3IhG4zbpeW4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o5SD9b1zeERr/R0bL3dkzutG3l9OJxfyImv+070NGoBd3hREVHRWwDpi5PDuLl0te7Lu27172n2nMdGk0OK6JQn1wZPN5MiAR1tK8GkV6nid5pRXhB88RAMx5NvwBRUOTbDpzCaGmoZGUn+UiEPBLge9Jc1kMhudf5jmidXxsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvb3Tqus; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvb3Tqus"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30246cfd41aso1847984eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171334; x=1779776134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rQcqf9Jvc4Pg0PpN5h4QV6SyOxzapzXZypkdandFV6c=;
        b=Uvb3Tqus2MzXGz0Clyk4oaMyWASFHjr4QN/Yj3oNAGndWMkhDZy5OLbiabMK4v/yEr
         8X4o8w2UV7+VPaoUYGIAzLysA9NkC4QgnzMJ/DsIpR+520Q/WKXFc1IPnvgScrpa8BS/
         ArVoxxdGv0VQe0EzDHkz+hZLDtt7NT5L0IiEFgZR6KSa+1eSbSDMoyI4M9uHsTq7bDl9
         GUsSooJazNbJriy39kA2mfG+y2vNBc5KAhezIdrjGgEAY+SbHXeHCJ2sAvfplg8f+PQP
         4g42vjCSldHawbPowqsn03DPM19tnlFTfKAlmpJSB6/OKVKANne7dL9woUqKzTmeelOP
         V/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171334; x=1779776134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQcqf9Jvc4Pg0PpN5h4QV6SyOxzapzXZypkdandFV6c=;
        b=CPV6mRUQyOPu/BbIbOygqEwoEqa6PkJiPDTszHvK/In2/2Ot02T40Lyu27tXDIfVb4
         3u0VDZ4R/LqOys0CZyji0Qaibebbyvn5OgMkb6sdaouhw+KnNnkYMHFty7qeqcQZWNS1
         xqRJo+SZk0q8MIxg6Ar0zxgC8SJtjBg6wkEq5pRrtfd/mzbTwIk5ShphficbuV0QrvND
         FaCGlQP2AYsNlYR+3ZddmaUv0VH4g3OClke//dzmEAP1BkQJZRGqMNT3R2gukuZZeaIs
         fOtAP+jKXb7y5yeOiPZMhKxLt6kyeXBh44tx7bMHm0ZwU4AgFA4gaBq2i1hWOGet7J+8
         pX5g==
X-Gm-Message-State: AOJu0Yz6TJJEuaLm3PZei3ry9KPYIQqAJo1dmOt8xGIGwmAWJu96IL/E
	hqSpmshygUQtDgrFNDUwxScphnJUEcsEP0H7nOyAJHi5Zwxe1iVe1/ImoPupOw==
X-Gm-Gg: Acq92OGQVjbqGpKuS/JOsoL6nIpSo+S7JVlKUOStlUEBqyHpn2x/Op3WNAay0y2+j2l
	N5/bIluh5vVttURcBGb6YegkcHQGbNnFaD/gu8oHcL4KC/sNyw7kB0vlwaBNgCp01KI64GhpOqe
	0sntZlp4T0e4nZ/1CsVC/9LqQ6SfWIv5WUXcybc9N5nYfFUyHnckEOfKX8qe0mmk1hcoBh/0Kpx
	Y/Iw8EtbKy+zDzwLP8txDkVc0dPrl51RtvKe4G/BVF3vI8/vDTTXsWKuMrRSyVZXagHJPfAQYJH
	9tNzPIQqN144vhAHgXl5sR8k545D9ndJTQBcFW3i95H1614rD+BQSJmB1TeCQe1sb+9PhS0LpLN
	1eg25BYjahHj3WSfZueNk0o57hHrGoLagmnVoNUvHoqrUCJBxnZ1jKxAHo3aH6RhlxifnQkgXfB
	Th/PJR0uHzu/QiBgWYSrVfYfoXJpo9BUJr6h10dQ==
X-Received: by 2002:a05:7300:578a:b0:2d9:ad46:4a92 with SMTP id 5a478bee46e88-303982b6da3mr8584988eec.13.1779171333894;
        Mon, 18 May 2026 23:15:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.6.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6c3sm19165747eec.19.2026.05.18.23.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:15:33 -0700 (PDT)
Message-ID: <6a0c0005.0aa2cc0a.15ad70.13c2@mx.google.com>
Date: Mon, 18 May 2026 23:15:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2176052408920493682=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2176052408920493682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097025

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.00 seconds
CheckAllWarning               PASS      28.96 seconds
CheckSparse                   PASS      27.22 seconds
BuildKernel32                 PASS      25.35 seconds
TestRunnerSetup               PASS      568.42 seconds
TestRunner_rfcomm-tester      PASS      63.54 seconds
IncrementalBuild              PASS      24.24 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B3 Line contains hard tab characters (\t): "	skb->len--; skb->tail--;"


https://github.com/bluez/bluetooth-next/pull/213

---
Regards,
Linux Bluetooth


--===============2176052408920493682==--
