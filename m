Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41421FC0F3
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052838; cv=none; b=kLS+X76ChOhPK8gcYP4DrrrfemKciAQciWDUC+IqKd9Yiny8Oxal/yFb4I65EN2hN5OSOd470yFIWASw7OLfWeg8iAmBTpDGVmY0HtSC3/LoD+vk4ujnzOJCzEgwrU0tyQLPd3O7Hm2TMlLq/p8YdRswo+QKsWQ1MseLrWkrySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052838; c=relaxed/simple;
	bh=pNeHU3S34yB6X9U66n7DL8NDkLFaxDxOYiqPiOqxEYk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mDb8LP2pYuwv/jUEalkQC5UgeAbf9/H5VM0j9w1S4PEkdthi3yXCBLKH4MEfNeF9uKiEZOP+o2B5bQxfbdA43r4DDkUI4TA7Uk8Sv/mvbXcieeszcdiG+KoPCUHXqLgo6wjbUXn9J/3qfL47XK4/s4NQriSvFVMhWvERdfajM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9MVC3J3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9MVC3J3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749068b9b63so3309612b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752052834; x=1752657634; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pNeHU3S34yB6X9U66n7DL8NDkLFaxDxOYiqPiOqxEYk=;
        b=N9MVC3J3Qw4wWRQNSgEkbCfbsp8bEd1PHlnc59xJNGia6O9lu0u7yngag3A1YATZRo
         vvXlJCbVS6oNAwmcy+HaWlozlzvU4cGPCSBdQ8lSr/ssQ6c7c2fO+aw7NZVrPgw0dwBI
         hHQeKTfM84jmvf/lqxuhTh3U9JeF2TdpN6WuuguDJFiaZnN+ix1Q/LY5/epRt4k4onWT
         VX4qN12fcvs3BHSIxLB6NFBDtmIk4ND2mpFwduvwa1w7HutkUnJTrfOJ779KsNLvsHbP
         YB7fZdu8UA7kNq1YcClLzxeCk4IbJfhKYRpY/sZMuL8FjO+Sov2nAV+gsaZmrnuH4Ynr
         7gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052834; x=1752657634;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNeHU3S34yB6X9U66n7DL8NDkLFaxDxOYiqPiOqxEYk=;
        b=gswypB7MQ/6QNnlPKTKuthy9mNQTNv6yjA1kgBW7uBgnLExpXCg2mnwac8yWivMY5i
         6xclbpyaQhhQxUCJx8ddnf4RDdn15v/z8ZrlbcZpJXCImjG4nAPT0rI+XjbYb168gzbJ
         ibucEFIawdryMujfrCghZpGxs5v4D+tkEcg7AQnoQYhEPT6jL0SIJFMcxwFWjGyukatW
         7ZOLxcGwDfldBeH373WuITzcwgA+bLHUgX0KJbsBJrhLbIWawQt9hkVY7gTEXROnwizo
         klYZ9lyQkzV9INH2zTJmH9XKkf2m9v7uwbE/1z+xFMzyNLZLj3vKwAy4zcLoBz6jPbS6
         F7kw==
X-Gm-Message-State: AOJu0YxwG51MOP2kqeCdPE268FjbL+BFVZYpt/JgbIbnrGoC3a+nmeYv
	4xW2gEdXtYrfYmczp6uvyLlpjfKZpoxRCyIF0ekBZl99lJEb7JDH/sVBGUlxhw==
X-Gm-Gg: ASbGncuXJL/NrWvIhBfVDcwhQklUEWZbOh2r98VWcIl83X3YqrqsoUD7ZKmi2IcmbRq
	OiLXdLmxPAa+6XGGz8/C8wAxRbC7YOKfmb3OJfyj1XXR0y4XfJ9RYA1+GidJ+Ek0ri6b0i255Tn
	0mWnr7U/J6x4vWjosWAy8Xm2BM+iA/wi3/vDovh+xSYkVQjlC8wvW0Z4KB4JERAkqnZxmjKGfPd
	btUpzPmsUJbuSLwDX9yMtA9bqxEOxvRlNDLHwxfINJ5at1auXv/9msMXWEFlwqVXxuxri8tzOPW
	+yN3pbbQFbs/BHzPoukTyed/tGmmkAgKVDaUBkGr6Mta8mD/N2FeM4N3Ex0RYt7Xhuf3XQ==
X-Google-Smtp-Source: AGHT+IGbVMIijLypWRYvuinfjduvgGpYBQaHDd7MRTv91tkqcWLSD/H0NhmcTZaQXok//79cugBx3w==
X-Received: by 2002:a05:6300:6141:b0:222:2a34:624b with SMTP id adf61e73a8af0-22cd5dec15fmr2808419637.15.1752052834421;
        Wed, 09 Jul 2025 02:20:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.103.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce4180970sm14055854b3a.93.2025.07.09.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:20:33 -0700 (PDT)
Message-ID: <686e3461.050a0220.88307.ccf3@mx.google.com>
Date: Wed, 09 Jul 2025 02:20:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8902729341329555932=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [6.6.y,v2] Bluetooth: HCI: Set extended advertising data synchronously
In-Reply-To: <20250709090551.9089-2-ceggers@arri.de>
References: <20250709090551.9089-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8902729341329555932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:2139
error: net/bluetooth/hci_event.c: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:1224
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8902729341329555932==--
