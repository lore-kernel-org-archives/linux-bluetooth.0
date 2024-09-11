Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32542AA9
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 02:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022517; cv=none; b=gcu6F5PqvwV/ovtr9X3NkRQH4MVwq1L8NzlweZPNCwbNVy/Nmv0VXX1DYZXzeS50grFnNiU8tuQ1ZI2JPXy2SofBL0ra4Gl8DwRKhMvcyFERqekj74UArA4gnuqhfq4wfC1GwgQw/EYS7wBrVVrxJ+P8HpXzr1VegtmLpm13PHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022517; c=relaxed/simple;
	bh=FgV4cGyZPWUg2Ny2J9naxX95V7p0uGtqaY2cxk0O2yQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gwIsNB6UnAOrdi1SdBs3Wsq0h4DOh1PWfRtITZIyLQOicxQbf1gM+POZYyfF1FvsKLYPNYRKV3OiZAcIYfOtN+AAQrN9oybeStPf5BTaYlIDnT7+lg8A+FBxVAO3lwKy/bsA6TOgUJZ9ebqj2kyV02Pvvkv3xmGwI7RqM9X97nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chjvBCdW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chjvBCdW"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9aec89347so204740685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 19:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726022514; x=1726627314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lGfF0LwBq0rWaYwauV9SO7z1jHRiJ0iXWZJsHHQ4rBw=;
        b=chjvBCdWiEDfejqFX3M/UbSoTQkpHEWu01U01v5O5Xc24c8HeQPQIfkII74TFxdCRK
         M4nCSp0hQG9LF9o44YlSnUiMtPxdb1T76XOBbKHyRVW1ed0BJAVk15rbVferbjbUL6vI
         S90wxG3RcGO98CjU2BK2442KTMtcoaYmrdAyomBgRZbVewLMH6fvjnYsKeyHsZJ3S1xH
         FDXoLzIT/7yIZySbdQHWM3hI4UosTR4OWeqEsAy7+jsWaTOZK7M0nsKrGaVgSRaIsUYT
         PxB7VuyMfVj6rLvFnKCULRVchsn4DqcJ8UzUVQ5emPm4ckIhnt5KBfWtJ8ImDdnVw/BE
         LuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726022514; x=1726627314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGfF0LwBq0rWaYwauV9SO7z1jHRiJ0iXWZJsHHQ4rBw=;
        b=JWx4Tk15XXz0iIcI6s38bRvLzeIbG2WtdOtPTA3gD5VSTaCKO8ZlRjDWoR7FD9zCGj
         +coN56ImOx706ks2WR09AjTzEt3wMCEI8kkbP5rMQ9T2OEdSKXuACDujC6BKzO1a15AE
         Zjbk3GM89mXcGjQFq5WYVTBJsxmhkpg1wga052tNfid+cF4Yvl0E5cndtAktLEckDhMe
         fWKfJViaQEhxD6KH3k/0szKaBoaZajN/oflAdsCjdyfBCPCtTSGbTdPJhU2E9iuiWlmb
         liRc/W5OuNnQLCtv9fmKeM1M+89irCjpLbdgkiELyKuRFjBqnUwHI9Of5gAOFfxJyuZu
         gEZA==
X-Gm-Message-State: AOJu0Yz2/t4qn3k41i0DLrQ5Zrb5RHW3/oW9quqVMjKxQcxW5PWScsBi
	JGu38TikuNoxRA4FFggAt3zVxgHW+/9Y5awsZ1HqblMYP52F3a3E2of8/Q==
X-Google-Smtp-Source: AGHT+IFna5rJz/MTDfko95Nypn+XtA4DvCoqM5lASgV1HYrSuX6n2CRS8wOxTO1D2ScUzF7ttZpdLA==
X-Received: by 2002:a05:620a:458a:b0:7a9:bf33:c17a with SMTP id af79cd13be357-7a9bf33c416mr811996585a.33.1726022514482;
        Tue, 10 Sep 2024 19:41:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.86.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7991f7fsm365348185a.62.2024.09.10.19.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 19:41:54 -0700 (PDT)
Message-ID: <66e10372.050a0220.22ea50.d904@mx.google.com>
Date: Tue, 10 Sep 2024 19:41:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1067610497247079118=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: [BlueZ] mesh: Add config for provisioning algorithms
In-Reply-To: <66e0e4e6.170a0220.de5c1.1970@mx.google.com>
References: <66e0e4e6.170a0220.de5c1.1970@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1067610497247079118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=889107

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      26.18 seconds
BluezMake                     PASS      1880.05 seconds
MakeCheck                     PASS      13.93 seconds
MakeDistcheck                 FAIL      73.82 seconds
CheckValgrind                 PASS      269.96 seconds
CheckSmatch                   PASS      378.41 seconds
bluezmakeextell               PASS      128.60 seconds
IncrementalBuild              PASS      1651.58 seconds
ScanBuild                     PASS      1121.65 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
   31 | #include "mesh/missing.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7857: mesh/mesh-config-json.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4681: all] Error 2
make: *** [Makefile:12233: distcheck] Error 1


---
Regards,
Linux Bluetooth


--===============1067610497247079118==--
