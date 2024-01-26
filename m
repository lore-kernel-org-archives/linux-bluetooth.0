Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2155134B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256350; cv=none; b=op2J3A3Gq8nUc2N+F32SUEUWt4PV3RdCfmhTn8Xa/I6xlln2igdryoL1pf/k7CTksJ4LeLiRRdVMGOBaFgGHy0D0UpFxW4QpzT3Ru89hGidLAPvXACYwdm138JdUgeEg+Iyu/E1o4OsaKZNgGPeU+X85PqJk2s3rpIXxS60n7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256350; c=relaxed/simple;
	bh=S18v+ECthQYHYxhx+j7Lv5X4SvixATw2fTH2k/v1kD0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z1HNDAkNkHUYQU5BQnzZm01/5JGVxfjFgC9i/gVxrduho1aMy2eTood4BS0lmSyRauk+uUfQ4cjfRW+KMuEROIaFLXBRW8F6aflGSGpNYSVNSAX/YATPa+Y9e2qPBzjuCsCV0Dog7dGIDfJAPCWW+SA9+Z1ZGoCwjkbr5gpvC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsbE1jKd; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsbE1jKd"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6818aa08a33so775326d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 00:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256347; x=1706861147; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CsvjKj7IYCfDw1aflW1RZhmLmHhhbJwWckwH0xfbE3U=;
        b=KsbE1jKdPpxSYAVi4ueIn/kR8xjo4aiDM3pj6pKvzoRkrzBFLcUXitUwhm0jX38q33
         xZLMegZKJdY3LQCujvMBospnz+mqf+UJUJQCoQStiZjVJRwlCabG0M2Va9Ywy/oB/QbI
         hj+PUxO3al11H28ZKMRbCjKkrEhlgPyNE4osYU0RJlBc/vQEVbjoyZNlyF7mfK3raDqc
         HS5HMRfKD+TN0/OCE+8fj2MLFkvxQW3KkM07KHY4Uv0ZTztIlPDtBTT+pHJ3rJSKEhmA
         +ZEFnWg5JnbLls1hVA2A01IxKOiNvJr4nyOWNTwQiX4HtGxtB8qrLLwWRtaf2ZgDKuCq
         8H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256347; x=1706861147;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsvjKj7IYCfDw1aflW1RZhmLmHhhbJwWckwH0xfbE3U=;
        b=UcD2QTsPJgqCXRWSvyXeljK82dyo8khKdvXhgEMqJExsWWnD8o1vSsA9SngZX+M9iD
         L/N7a3I6wvhqiMNx9MDevURKRnWD1es+WtJMH1gYA4hGJGTmj4iOAfqFsY9TwYCx/X9y
         mibQHkPXZsooShoelzBQlJs2l3yTt27csI6yntNjxRTGPpKrhLAZe65jsEf+HJM6CK3K
         cM3+LXX86xu4UZopSFg871Fm6QtxcYeYBtqJW/YWm1fn+T1zXX0f1dM9tXKbSPgVwJEU
         avhZ50f36UJNXElscukLJCPDuIZZwu2EESNBXzleui6N+e/BK9DZDHtvslOOOz+LDdTc
         fqDQ==
X-Gm-Message-State: AOJu0Yxou4uqHE58hRUYH9GGHWdEfWcaoW0lHXgqr/1v/TsiaWVx3QLd
	lwngOieFnTbmEGtN+YBjQnzl/wZF+S8obXXSdgaxausCSuAbqtYSbRE8yjFX
X-Google-Smtp-Source: AGHT+IHCL6doIk4W9QgmMnK6A2dBEN+qntG4GlrWgiJhmG83a101liFUycKSq/STA4N9ZQnfL5VhkA==
X-Received: by 2002:a05:6214:d8e:b0:685:977c:b8a with SMTP id e14-20020a0562140d8e00b00685977c0b8amr753886qve.61.1706256347421;
        Fri, 26 Jan 2024 00:05:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0f2y9VpQjF1XoUOzYKnxwty3X8VFAqwoIo/7R9V6qdbyghV44xxKLY6ceTpClavEMjdKBa/eL4ozFDuniaOzBmKw=
Received: from [172.17.0.2] ([20.97.191.242])
        by smtp.gmail.com with ESMTPSA id ql4-20020a056214540400b00683adba3316sm324347qvb.21.2024.01.26.00.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:05:47 -0800 (PST)
Message-ID: <65b367db.050a0220.f254e.107f@mx.google.com>
Date: Fri, 26 Jan 2024 00:05:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3329328193039339305=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] Monitor: Remove handle before assigning
In-Reply-To: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
References: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3329328193039339305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820136

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      23.96 seconds
BluezMake                     PASS      733.31 seconds
MakeCheck                     PASS      11.41 seconds
MakeDistcheck                 PASS      166.43 seconds
CheckValgrind                 PASS      225.96 seconds
CheckSmatch                   WARNING   328.90 seconds
bluezmakeextell               PASS      106.99 seconds
IncrementalBuild              PASS      660.88 seconds
ScanBuild                     PASS      939.16 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1862:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3329328193039339305==--
