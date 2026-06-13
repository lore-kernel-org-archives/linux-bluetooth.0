Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817E2EA73D
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367944; cv=none; b=mF+/feNmF1uqwEjyQ/9bB4Hd+42ZiEXSiE2gugtbWYayiRp5DHPbOO+rEVW8Qd11IvGdR+KIdkxJR+Z0Y+Q+Vkhgk9m/9CmBIwauiF/+1bxXgO83g0bgPSt+/iyV2L+OTvb0LyINOr/ok7SKhjqJJ9Jul790Gdzs5TPYHMIZXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367944; c=relaxed/simple;
	bh=Xc1bxDmhuD1dLJB31wKQenAigCExjxKDOMffhyxXdAM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iRVHYCaeO3nA3g73KsE3Zzvg9kAe74BvhG45bBiGdH1E7UszdiV2NQhHDupI+P/BxpgVJNZmN/anW3fdrEDlMHCsVskYQCo9OnYMu0XmvT7OcLl72SuuZoqfwagoSQFaGg5BT+z0Gc/yRJkcUfv3TPyT7FkPiVkHdfEEbP8ykBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keTaNQjs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keTaNQjs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9157d3f2098so226092985a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781367942; x=1781972742; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fnQiq6rAZruYzAxa9n26xV9Cvlfa5VwW/5xRB/jRXS8=;
        b=keTaNQjsqyUwtXhvDCQ6ngWQciWgwltFSSZqzzhCGF6xoQ6IMxJpU8IOLWr9/oThuX
         YB4ZrA+/zt0aMZAZNu7EKZ2XWH2aftRc8swyuGgKjpedLCE7GeU+35fkWnwEMTzYLgY2
         W6ZGE6bTHFup+QrhcWq6TTieT/0+2+GdY0vL7gQU0uN7bxBHHKvETsQrEYvuMyJXmfdA
         9WN8/FyNeqyl4giUcLEu5Ix7MXPDXOryUz+xLKKz0ccDVvu9E9mpy2Qqorq1jkQgmQoJ
         NfsONqxawgPSLeBZEcuRZtUug7GtOFePtC8k/msDKMbEzK9hQItHmFBL/HKgRE6IzwC3
         lmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781367942; x=1781972742;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnQiq6rAZruYzAxa9n26xV9Cvlfa5VwW/5xRB/jRXS8=;
        b=GpcwifR0E3cJWFx5/qEH+YDqGQGYPn+FgbzbM3S9cVEd5gbAzawJWrnrbx1eH0OaZo
         kvrg/277LAst9AvqRXUQL2L96XPyPDNBjAo03w9b8x3Iv+GEJPH6Bcll3hAiUAHgK2Fk
         +Wrl04EEKkF9urmpYQMbSs89rrDWRgJ0OtnHt11IpLSvnUvwW3RPlhUrMXZkjs92OLMS
         XdVi9k6SV1siJPY2zAt5LO+YW+BG8bqJpVXqz3W9xlS0W0RuFGL8hp2CI2ge+hIxfdIN
         s2f78AxA2blRYamOX6EbIpeMK5xG/fA/+UK5HS/jpiOkHbU2c4vffTrdeJd0pLo8vJQm
         DpNA==
X-Gm-Message-State: AOJu0YzKX082SDUmOQYS/7cBj5kVRHBgyBnk29Cq85q56kHvw7+sZ3hA
	ADpxzgQ81iDp8TeIMto4BPt+f+A5yprCzgR3hBotzfH98OO0byZB70vS6S5F8A==
X-Gm-Gg: Acq92OGGM/300b+fPY2WSLa376tYIMpedZHxaqy5bXoYzyP+AyVKoEUqNsALoEDawb/
	vN3+O0/+Uv5gpPobash0s/V4CZ8GgVRx+CTnJODakaqXhvAYZiwBk7HQrDK2szL9FoJH70nCsvG
	Rw6Kcm04+WumqEqMeoAdt5C4HBm1wkNSCJn96iWsvACEz+5StHFpN2uZWPkOb2KLwSpJ8cXdntg
	T45IzpkYMCca10hqWd11StfXBUjDjZhfpOD+tl1/Tctazy+JwI5e/65UrerDdpWODZx9Fbrk6Hv
	BPmxyliN+dnpG+9zjPozc/kmjWCKR/KUkm5hFse5WQUlxBEm1AuCg84zvog43AjrV6Dlf0Tnd0I
	2sl1/uwq6Wb03sb8oyNF6D8JKfufgfHzibbv3XtS15asKRlTz/V8iXTMuHjvLmeUCMl56MAzH+w
	w28U/jtGvRVGiIKfX7k80yrBufqxc+7uQmKupoUQ==
X-Received: by 2002:a05:620a:28d4:b0:915:9efe:6dd8 with SMTP id af79cd13be357-9161bf6c258mr1117762985a.42.1781367942200;
        Sat, 13 Jun 2026 09:25:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.47.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7f16sm523695785a.1.2026.06.13.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 09:25:41 -0700 (PDT)
Message-ID: <6a2d8485.27211789.1b7c5f.1c21@mx.google.com>
Date: Sat, 13 Jun 2026 09:25:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8882522739429043109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
In-Reply-To: <6888691461070a011d31632e6dcbfd73016dcc6e.1781364475.git.pav@iki.fi>
References: <6888691461070a011d31632e6dcbfd73016dcc6e.1781364475.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8882522739429043109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111067

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.81 seconds
CheckSparse                   PASS      26.40 seconds
BuildKernel32                 PASS      24.70 seconds
TestRunnerSetup               PASS      524.23 seconds
IncrementalBuild              PASS      25.70 seconds



https://github.com/bluez/bluetooth-next/pull/312

---
Regards,
Linux Bluetooth


--===============8882522739429043109==--
