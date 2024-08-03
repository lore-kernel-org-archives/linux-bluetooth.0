Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9201F12B64
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Aug 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722724375; cv=none; b=sBrQFBojOOYXZ1HjiaIR6XV7bt9hGGP80Jw0bTdon7dskKpqLWMuJPigA2c3aHTpwjKFjPYv47AkDejeZ4FuOTR0Jtdg+QsnqzBUpp77pdMpDBdKg/oF+H0UEv0igzL3283aXtq9RemLqMLxZvfTiYT4ZXMWN1Ww9/EoMgdkzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722724375; c=relaxed/simple;
	bh=p8u6Sg8xH2NKj8wV8qYV0LDxh/IpezQU0916XaUl6EI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fBeuJ3CT3enp1AbUZNsSurElSPc7OomRDJlARThyfK8DSrMJuF/AjkN0ZMvy00am++ZeGq2j4hutq2i4XS/dIEb6P/GjYSuDypIkBkdAeKPy0PsIcr2Y0qAwnNZJU3zBKkTFkQoFK7mYNuyMGH9n3W95xv4ZB+8iKZ23mEk4ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpl3cQgH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpl3cQgH"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1e0ff6871so523449785a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Aug 2024 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722724372; x=1723329172; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsYAXaZxtbYt2VBRA57IBgt9w5MowRXov7g/uZnkWU=;
        b=gpl3cQgH0GFp3YJibO6arNJov+/64rf8UQxxo9Z2OW4qwbiSDQZqClXqhkwYLkzRr4
         +6FOgrZDnhC9kV7kBmI8VnIxBoxfUR4kl33Yzlh6qmnS5UDFhQ7ulyQs4EEvyL/HtNCS
         7qWNnmhSfTOHaPqUhQ7oIX+3Awz2p1melXTyKNi00AMTHbuoH3nBXDNfl7LQeZ2Ufy76
         1s/6UH/jDINc9TR3XKywIVYgISVcZjqcRMrL353STb9fd18rfwKnhJZ61IP2aP/0SMoX
         moe7sD+Bs3Cwvq/KeKaLPU5MkZsyeKsmALGhmaIruT14gSv7ri23+18Xj+aORY65DS+q
         90ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722724372; x=1723329172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJsYAXaZxtbYt2VBRA57IBgt9w5MowRXov7g/uZnkWU=;
        b=BA1jURVBiCCuPM27YO8qhW4il90uqxitz1PbdVq7z7G3rSFD2SasImDhSjA7scBcUB
         FXJIxfUk+IoIG++cib5kALF1XPXFtvovpOwKxohVOBJC9PbQqsd615nYueNwcc538wLY
         OnvxoanY+ZCzUIKhlpJaZ5cIXQjsaH0cQCN2uuOHLjmA8Fp3cUyy/OwQ05qxUcXgK7MG
         vdSiliVuf8x30bkHz1G2ne5Wlk/m5HKfMfhu/cYuxXBCNSZTU6ZvwvCvMHiXODZKyvd5
         ZuwC8DIQe2qnC7qJurvqb9XFPnisvBp3chHX2dsfL7hhRWHODWiW5A0qDHK+wz3QMnPs
         T0ug==
X-Gm-Message-State: AOJu0Yw3Xm90iPWOSbjZiBScksmsNNONjuoUtPFruG4qIwwVrSJy2Hy/
	mXqANfzYsgUKm5ZTiZsu8GUZ18t0WPL9xUJt/0jcE4hENGfQ0vsY/UpmTA==
X-Google-Smtp-Source: AGHT+IFWjC/WC+c90w718KIcx1xvbKi7AI8BH+8gcuMwqCn1maqybqGtoaQQ8R6DH4PBF4mwFQ3fDg==
X-Received: by 2002:a05:620a:40d2:b0:79f:148d:f611 with SMTP id af79cd13be357-7a34ef0cde7mr963267885a.29.1722724372302;
        Sat, 03 Aug 2024 15:32:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f796871sm204291785a.132.2024.08.03.15.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 15:32:52 -0700 (PDT)
Message-ID: <66aeb014.050a0220.12be31.7235@mx.google.com>
Date: Sat, 03 Aug 2024 15:32:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1874664920589711717=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel-2024-q3@nuclearsunshine.com
Subject: RE: [1/1] Bluetooth: btusb: add 13d3/3608 VID/PID for MT7925
In-Reply-To: <a2cd95d91354168876eab963bb7e1cfa1b31e985.camel@nuclearsunshine.com>
References: <a2cd95d91354168876eab963bb7e1cfa1b31e985.camel@nuclearsunshine.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1874664920589711717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876458

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.94 seconds
CheckAllWarning               PASS      32.37 seconds
CheckSparse                   PASS      37.93 seconds
CheckSmatch                   PASS      102.21 seconds
BuildKernel32                 PASS      28.46 seconds
TestRunnerSetup               PASS      522.62 seconds
TestRunner_l2cap-tester       PASS      23.84 seconds
TestRunner_iso-tester         PASS      31.39 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      118.29 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.77 seconds
TestRunner_ioctl-tester       PASS      7.95 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      27.64 seconds



---
Regards,
Linux Bluetooth


--===============1874664920589711717==--
