Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD02E973F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523861; cv=none; b=GDL4yCgwpYzZuIHZ8CgmMuCw/eGY3gMUk93NYrtlRcBMhxOXZiq0gc7Ebm3v4OhTOle7Cb/y8+w2kaD2JSE0ynueTq+W4FxkTB21ZYCiyWiGi+jVPizuyHhpO3jxpyCDaANlcBGEs1Xujj3T9rTvSoizg8eH50Pm4KnZXiGJq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523861; c=relaxed/simple;
	bh=XrUDLIBtj4LcCAw4zmoebF7NajOnSUD3ZofLvpvpGOU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MPEVJVsWkNc676YrVDwXM1SVcak56/FuU0ZldyT7nE8u7qVxKgeCm6YkCa9cIua7p6mArmWJn1WUQgzYZohir8jj6DTJa+4jVZagBcCwAKF7JkrjHbwVTYhznNsi6+x9xHpPHUgv6LQEJuQcxCgdnnv2AJ/eZn6fUAzhdoNvbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh0lS0U7; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh0lS0U7"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8954c9daaeaso15086916d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523858; x=1772128658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Et60SLOhlKwtyefqA3qvWkwxeijGuJehO64JOmlu3j0=;
        b=bh0lS0U7CwDwhqXCJo93Xn0NrnOy4SXy3eBHhByDxwBME6b4Ytr3FcmL04ej0oIl9T
         RUv4EFgAZDjrOvfXkrYr7DFeZ3H06dN97/m5HM+yKuh0iof0F5scQSnPj1+duBim0aN1
         MggRtaYVimHcig+s0sHYetQWjBzIz2rwdKMRS7I19AzY2XhqykTGzdBtN+2UWpUaPeQw
         5tsBsDIm9oyzju+CJLEhxFNRHf91j8+q6QUQPBZMK3qtchUHWrPIWmvJzDjcnI25MQNx
         ymZjBWmobnFS2viStkcsQrH3OqQplkgS0dd1GVj0zL6cU17QUxJiGFbCgYOf3VrqmUOG
         +4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523858; x=1772128658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et60SLOhlKwtyefqA3qvWkwxeijGuJehO64JOmlu3j0=;
        b=bU1ZSN32O3Tafi7bQwwsDCXV+JD1WamHOKfCbHUKU4oTiBKMmpa8N4Qvle4HwPQVQS
         WcYjGeXZtgDUv00ExUFfjKkwVKbO8S1C1zXmnm5Y3K9nkSpPJkTc1d/ohdQd96hPnFAQ
         d5LWkNYwxN5h4Z8wVvXPEZN+D6bLTBvxpBfbFF2vUSw3Hd1cX09PUAI9xk5/sr938Hvg
         pKdMKYh2CcJfzuIHH41G12Cid3KXDu4xkxhQ29b+OaaOSHqTXKlAseuwPKleSMjuS2Th
         Rqf2Tt6t79E0zbQ4ufdGPdjy7WGBw+1oVP41DtARFgyaNZL55JC+fDVkdnbDs6WGaq0/
         ML7A==
X-Gm-Message-State: AOJu0YzMtpPIxX9ip/DFE8lzBRCxCxx2P5SZpVesViy7hr3loZm3hsSm
	4qffVNYoBljC2qtVIlEVVpKfv40M+0CWWOMBzFzWzqCpoQuH//dc5aT8yWVs4vengGA=
X-Gm-Gg: AZuq6aJ+HTOoC4bw8LYgPjbyISjSsxFOn3u5pbgJsCrQ9gamp2lQrAd/U8F8OW9NYui
	BU3CNYIFVmFYWl4ZUyQrlBatt1Tu40SWWQQWbnct979RDPSX9WT5XZ5ziY6GLxzohJoQqGtQLt2
	Lw4y8kSFhXf1sCo465e/6i7q7JWUPcAZ5Z5apBgwpkG/sq2Qf4kGFQnG6mQ7KUjLGaWZIc8kVg/
	VYhVEZ4yEcIerNG8rM+Jwj/6e9mZOS19HNlf2cFQOvSAxsI54laejPXWxrmUiA1/N/zQT9PIswE
	/2zK9eNp/UhR9NKSxkhaGRaO9NhnHmwYX8w3bSSPtujvqUPuF+BASg9NFeUq6I5FL2LnzAVLoQp
	bxe8nCi1AX2TOExr1I+fjaI2EuYKxMrZmAPZ/tdpCpmEefE5clOjlZbKLZiOhfBRK4k0HLn1oJw
	80I8YfdMbHMLoDVdua//k3g0cCfjLqEg==
X-Received: by 2002:a05:6214:1cc4:b0:894:6510:4946 with SMTP id 6a1803df08f44-8973488141amr309917646d6.10.1771523858368;
        Thu, 19 Feb 2026 09:57:38 -0800 (PST)
Received: from [172.17.0.2] ([130.131.55.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb4189da7asm1620534585a.37.2026.02.19.09.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:57:37 -0800 (PST)
Message-ID: <69974f11.050a0220.f7f51.b1b7@mx.google.com>
Date: Thu, 19 Feb 2026 09:57:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3372922536163193484=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/8] doc/btmon: Add missing documentation
In-Reply-To: <20260219162230.3074355-1-luiz.dentz@gmail.com>
References: <20260219162230.3074355-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3372922536163193484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055603

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.48 seconds
BuildEll                      PASS      21.54 seconds
BluezMake                     PASS      642.32 seconds
MakeCheck                     PASS      18.62 seconds
MakeDistcheck                 PASS      252.23 seconds
CheckValgrind                 PASS      298.02 seconds
CheckSmatch                   WARNING   361.63 seconds
bluezmakeextell               PASS      184.14 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1063.68 seconds

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
monitor/packet.c:1993:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structuresmonitor/packet.c:1993:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structuresmonitor/bt.h:3854:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3372922536163193484==--
