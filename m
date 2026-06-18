Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27911353ED9
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783342; cv=none; b=o7CzPDakJS8vT4YSEb1Z8QOCcMYsb73MCjlxk1iMXjQBRBk0RzoN4nJIZFBq4PjzWrwup6MOsZQtOOAHKVrx8m89tVJdqPQdI0QAP7ylEw2uLR/nKP4KCWInbSD0bAkeuaVLDsxTRx9+m6IP75diLwP4nRxbGxdl30fCjJHFHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783342; c=relaxed/simple;
	bh=pFNq3dOsdMT/uoLyXLkmMCo8+WG/ZIXbfoaUshxfhxg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MvzfKPB2wDuuTvfVlHZz1cMQbN/UltKyZMGn0crsJMGdRnWCfqSqT3YhGKX5s3plHDY3SJiDI7zGQi6DaJyMcloOFosG1kStr2T9I7mo144BheMEVgWWHwHDJFMpgAR/3QD1cIpCUIcszrBQGYpFgcuNv6PkcnYRKj8C04AOj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP2nRobu; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP2nRobu"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30b9e755555so1862243eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781783340; x=1782388140; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4SALu0k6gXJfUzph52uhy8smmUlfLwzPHLlf39hIiOQ=;
        b=IP2nRobuEaV3Ppz3k4BGGFb/4BnwbBvqwGm1U8umquCFA14cZ6DWM777YFj44Ydty8
         kzIz5NxGMaBby0rQTkMN3UGby348NEb54KIE23H3YKhm4/n/ktdYWot8ihE+t6Leq3yU
         s4/qTxs494l/tU1kA6A8oVlPuQK5g9f5FsA6bs6EfhV5N8KPYrY3i5m18Gc7y7by/tiK
         6TEg5IqJQnzG/tv4+IqkL/bqaWdHWtcxnZkpi8gS+B9FuSka5DtDxa7ASuWNGguT6C+0
         of5+8W65vKZ0wq0mYLlnJ8D/g3oLL5QZHcIicoPHZnXr1w9Hf/05qpgQYHcwY6kOmN4r
         nGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783340; x=1782388140;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SALu0k6gXJfUzph52uhy8smmUlfLwzPHLlf39hIiOQ=;
        b=DMow1Qm5jODn6wzb1XL1VMFj7WHgRb6XSa7u4iJrWIRtzlydB/mevQlndqCBhMov78
         gtP6EmZsjtOu/TFB5NYMGy9cT3gaXPPPVpVJgfmMpYPa8z+j3peXc0w7JCnscPHvR/MX
         XeZADSNIISKb8aLObP9kH7PKkKJB+xiyQvP0g9XvEmnIXj0XrHZ5P/4QWD5+GqVu7YcF
         TQrJT/qShYgv3eLsdg1l2PYEKBpMAysg9zZkuR1h9sZMUJUSOfv1/T9WROa9v7WkzqI2
         zkk8EI1TDV+AYB9tr3S7S+SzTMq+dyxYkBhJ7dE3jCRJYghg+wAEtJ/FlXcnNMMli1HN
         gI5Q==
X-Gm-Message-State: AOJu0YxZZsIfUAKmviwv6ndxMyYxvDTVVLRRhgUrBSyhZkQozsJWa8jo
	5gthl5yyBWjvGqhqrwW5w42ob8lIS6Z1cVc7YvLMBHNWRt0iHGihbzrsPPRCYA==
X-Gm-Gg: AfdE7cnTuRj2npMhvFayysdWoqL+3bxIQKPLc57ZxrjcRHkzmulAoyulxFiqhdDFhky
	dIgiSdumjvWrUmaUk8VYYDSKUFOyrIpxsNedTdIE9t7wnYbgyzMaJDra/ys4Bj09H1aYMHDQelH
	aen5ZyGjM1FiA9QWGFYc8pFcAzYhZTNspKMuab2LBiBQTEMdNp92NFrhFh7rNzWBspMAAmVOKJV
	HjPSQmhwtRETMzMrPCWMyyyQTIzt8r4+uljuC+ulFcE8aHbeyoS/9CdYB5nYyBIR70EfX3a6ELn
	/N3bKpqFHRj4kL1PYm0CRoDnyEQOuSFXUKp9+HdN9Ah1We1ZZfj9LG9mRDzCl7yrRn0iMWnUzO7
	vJf9JLX9BxSpq9Xv06MrzSurmR2vG0HxThvX6deCP91vhKOlx3d4POnBoZVa9kRcqIUKcJ8dEJN
	gC+iY7evRzJnv9+MvMDfYZ
X-Received: by 2002:a05:7300:6cab:b0:30b:e3c7:27f0 with SMTP id 5a478bee46e88-30bf078f484mr2226046eec.13.1781783340230;
        Thu, 18 Jun 2026 04:49:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.141.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30be0c45a16sm4149657eec.14.2026.06.18.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 04:48:59 -0700 (PDT)
Message-ID: <6a33db2b.2355c4e0.37068a.b633@mx.google.com>
Date: Thu, 18 Jun 2026 04:48:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4664215228264317345=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v1] shared/rap: Fix Mode 0 step serialization
In-Reply-To: <20260618075529.98419-1-prathm@qti.qualcomm.com>
References: <20260618075529.98419-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4664215228264317345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113283

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.73 seconds
BluezMake                     PASS      658.34 seconds
MakeCheck                     PASS      0.95 seconds
MakeDistcheck                 PASS      246.72 seconds
CheckValgrind                 PASS      222.75 seconds
CheckSmatch                   PASS      350.52 seconds
bluezmakeextell               PASS      185.67 seconds
IncrementalBuild              PASS      663.38 seconds
ScanBuild                     PASS      1039.96 seconds



https://github.com/bluez/bluez/pull/2239

---
Regards,
Linux Bluetooth


--===============4664215228264317345==--
