Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77113396F0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877801; cv=none; b=d4dJjeSwpKnsXR3yV/K/7oSFtxVI7xmx69ASx0BFmX91C6Z8ZTf252uZaDl1AnwEnOhUYrloEGKpRuEAKrPYo3ihTcjIpHa5Ks7rVgp8sINJ9ZslT9W/GPSRvELNI4f8yUra2+z3xtUXuZhn0mlVVCZFZ/FEP+KyJ3QDg1Xi0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877801; c=relaxed/simple;
	bh=5DVNYbY3BN/6ARi6ktKRNDvVz78zJZ2HUgqfQWlMJXk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hpC283iBpF/PsXWVbXihnkP5WsChLKmgVNVyw6QgteBooRcX17xbBrZrG4QdNMkitnPUA5N4Hd1jDXcMrKXoPmlQmGjXKtY72JZ1IPN0Cpim9olCWMIhnDqbKJa/F7nQTsSe4Mm3iU22t49zcLrjHMjCM9+eE+xeWQzIGbxioB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMI+g0aE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMI+g0aE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c7613db390so785821a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Dec 2025 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764877795; x=1765482595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta5ibw1IvPUmu4KdOdHQlhK50S2AvCey6oOPuK6VpYc=;
        b=aMI+g0aE9FDfZTZkrjwjNDpjVbOo9pgraFK8CkweL0UFELakyshFAF16m1PjB4347+
         I5Cd6H3qmibtS15LZnNlZuuJmx9hfcBx2iRejhaijcSyPxw0Y1AqO476YU5+A9eNgyeP
         Jvuy5J8iECPzdhYuDJu3bcm1onnGb50cOUlU00DOyA5Cms5jP5OfDYgoMOPFBUendnIO
         qGywRBP5qKwI31wnQT7qDqS5KZhr91T07R7vIAwX6XAsgRErtxrraoRD1C/PxmOYzHzw
         A0Fy0Qi3SnLabdWIEjKzp9iK7PD6kB9q+RRP+llMwD3P2+LE80kPJF9pteXVhQnvvK3y
         kNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764877795; x=1765482595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta5ibw1IvPUmu4KdOdHQlhK50S2AvCey6oOPuK6VpYc=;
        b=Nyii2owyKfcXQOQkYbjE/xBJ6lKIcdWqCgeEQBkEx1FlQciD3JGaz1v98mu2RolDXf
         PmYJq0JgLH3kK97l+qJw/vGdpa/21Mgi4rWZeEVxmxYa7MeS8WWb5xXyoqFg0/0aYrup
         2W8Due89b2qQIWsa7qZH70xN76YtzHbW/oZ78oAH5XH45BGYdH/j8cQMw0hwjkslGZI7
         1Wdn4VkzKVd1TatK+4N90ZGeb4s+qG6tT+jZAHGLb4uSa88GbZHbYw2wamSeLZmRmhpE
         qG+4VlX5CZv/qoduWA0lNhkU3WVAsMEtLLwBEocc5ofLUsGxae0Szcdiod4XXWDPXVIe
         9KCQ==
X-Gm-Message-State: AOJu0YwxCMqHW+q58VqpbhZzHExbgil/jdKn/K/nthVZCLZr8FQGgQiu
	/1kvOmAPoLOcyHlmiiMThgOd/raCz/szwby8f0cectKNlULx+YDPqM0fasnx1w==
X-Gm-Gg: ASbGncuCa6IWesJBGd5anZkIYXnegNuFuOhhTnQAcehZFCXkhcXcR6d4OcrHfVTn68r
	GV14lDdmNs7CsXZLgI+4B7SnFw+bgIyv+KThYeePhXhQ+yfSGdVXT3g66uRGMBjiOvhxXdQy2Sf
	+L1SiuZO6sJGg2DYz35ZfKD/qzfX7FmOD76EgQdxZOrzOBB520kRCx0NmLzVcSPeDZ7dlBa2OQ7
	g+UvjYMABph+c0Eg4bD+nAJw0jYIHLNX7UA+c7cekAI/gsiiZEYP352LAZEpN+pQiNOYmqq6B7x
	k9XAmZHnX578DQ8i5yW9Axqt4ttLoYCJcsE4ByEWdv+BpeiXJ17xEvWe6cge4AaMIGh1JBCMbYg
	13k/iuTFC1j85ERQ9UUc4l780GQoPRu81yxdn7+ZPS52egjX5zpkYIEMHr0A/dgBKgWZXQp8OrQ
	XAJW5N5Pjq7kokdyY=
X-Google-Smtp-Source: AGHT+IGjQ/qXmyZrWeFO/Xm/JuR0JMocLo/oC9jUyLMqEqAiJZ5kA2b49mXysRavvxOSEJf2bbmhmg==
X-Received: by 2002:a05:6830:3494:b0:7c5:2c10:b6b8 with SMTP id 46e09a7af769-7c94da8dc4cmr4407912a34.2.1764877795060;
        Thu, 04 Dec 2025 11:49:55 -0800 (PST)
Received: from [172.17.0.2] ([52.154.21.55])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac8418esm2019419a34.16.2025.12.04.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:49:54 -0800 (PST)
Message-ID: <6931e5e2.9d0a0220.7d2cf.605c@mx.google.com>
Date: Thu, 04 Dec 2025 11:49:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2370332425324674413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] bass: Fix attaching to unicast session
In-Reply-To: <20251204183115.2533504-1-luiz.dentz@gmail.com>
References: <20251204183115.2533504-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2370332425324674413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1030563

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      644.50 seconds
MakeCheck                     PASS      22.28 seconds
MakeDistcheck                 PASS      243.38 seconds
CheckValgrind                 PASS      303.36 seconds
CheckSmatch                   WARNING   352.64 seconds
bluezmakeextell               PASS      184.62 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      1028.84 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2370332425324674413==--
