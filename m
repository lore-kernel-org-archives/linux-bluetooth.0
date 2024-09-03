Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5826ACC
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394282; cv=none; b=Yl0K8/tv9ZAw94ZOdTyz30fsuQwaz/WcuebAS6xWhMgz4pZN8O7XLZ3AuJQk2f/6ERhruRcVsVNEX53J6anDJStJ2eb1/zrv/IL0rPLLyISLiyjkDBxbBwcQO4golit+kvnnthQH6qA3a5eW2fleNbT84c4YPCmjCirdfYVfdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394282; c=relaxed/simple;
	bh=+5m7UgSzqu/4NKjuAaUmztjc+HJECkmaw/PAw+4/0Tc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hXNuAFZP99UARYzBz+hsTOx4DpxrcwN285i9/qZT7tUGwNPEvGQutzZ79Ac7eEyKYb1kqjok81gD1mMRlnxsyIxfZGzWxFcvJjPfH+/SE/C5/Ug8YbZqlTN7XpeoQV6qoR2hMVuX4lQrOneDuVnZ83bpuiPBX0tTmF5NdcGKvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZAHWBua; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZAHWBua"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70f73ca989aso2169476a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Sep 2024 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725394280; x=1725999080; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ePWQqjUQ47q4aBd8q213gyVk0FoOCL2kLAzSWk72II=;
        b=RZAHWBuabLr8ccy2f0HzSXzo3PQPXWSoY9so0XA9cyxuZ3PogaLpGOlCnDqV6PGLqz
         ZV6Tj5zDypqankCr9MJLT7Jwd3iQuyycRu9ogSeQt5diR+fzEv5PZPApR/7xahiHeAQl
         h3oRmnIk8exP83OUffTcxmHRrGtCd3McZUFHv8NDCeyuOS+TGbvQDOipNUlCkCYCfef8
         Pv+B7VYTjeC3F3MUjjOJ0IncQnkMBCxZYKZ8YFeYwTJ94z0VYo/x2gQ7ruPxg2sRFQvY
         OtDrLhWHcETN9U66Qi51erohal6bDmRee6W2jaZdfCHjqCPSvvi2xQb5HiDhxNRVoQgM
         5zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725394280; x=1725999080;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ePWQqjUQ47q4aBd8q213gyVk0FoOCL2kLAzSWk72II=;
        b=R/GFX21FhAlK48Tr9WiMcyhokpMt9ffrsNDeCc0Tq80w26Na3qbYG0QlB6a7J+wi6G
         ew9GmuBqZ/Xczo2bdQcvAjikHJZaFFZQ4rAqjfFNVlC8ZjrnA6FL6Nyb1RUyQ02bCEMj
         +DrJtHzlgRNNtq1gclUvgPfoYcqJirwkAvAOxhCpTDI0L8y84TY70W5ylqk4BkYEoKct
         6Pk6+E1xCYuHGNPy+799fhb7QNnpQxj9gdNU4jhOCFs411/O4Jd+yQ+wqrcZ60YNaYT3
         05Sq0fAdWBCTLRi0F9QephiUsSu0haPkzsuoc58/Uh+HMUtWYLQk74Hr7/MzMcVZo9FE
         pYQg==
X-Gm-Message-State: AOJu0Yy+V6vElN8CIehpi8m53A1ivH9bq8IIiADdm7SOQbcFaG1/WNv7
	BdTNg2u/k1d1gQly0BK4wNlPUnjx4TqsEgfhCai2bu2oeDSS5HBOgPxPEg==
X-Google-Smtp-Source: AGHT+IEvty60exvQDIBxDaW2jj599YdEY191ZvhNJOI87m11flgv38JlQvpGUxrd06/j/VidaSiAig==
X-Received: by 2002:a05:6830:618b:b0:704:482e:216a with SMTP id 46e09a7af769-70f5c39235amr24076870a34.14.1725394279453;
        Tue, 03 Sep 2024 13:11:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c435dbsm56741266d6.71.2024.09.03.13.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:11:19 -0700 (PDT)
Message-ID: <66d76d67.0c0a0220.c11e6.56ab@mx.google.com>
Date: Tue, 03 Sep 2024 13:11:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4447301288362762988=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] gobex: Replace g_convert by utf16_to_utf8
In-Reply-To: <20240903183817.155842-1-frederic.danis@collabora.com>
References: <20240903183817.155842-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4447301288362762988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=886437

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.99 seconds
BluezMake                     PASS      1764.69 seconds
MakeCheck                     FAIL      12.86 seconds
MakeDistcheck                 PASS      182.50 seconds
CheckValgrind                 PASS      257.54 seconds
CheckSmatch                   PASS      363.81 seconds
bluezmakeextell               PASS      122.14 seconds
IncrementalBuild              PASS      1524.38 seconds
ScanBuild                     WARNING   1031.59 seconds

Details
##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

make[3]: *** [Makefile:11766: test-suite.log] Error 1
make[2]: *** [Makefile:11874: check-TESTS] Error 2
make[1]: *** [Makefile:12303: check-am] Error 2
make: *** [Makefile:12305: check] Error 2
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
gobex/gobex-header.c:95:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(to, from, count);
        ^~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4447301288362762988==--
