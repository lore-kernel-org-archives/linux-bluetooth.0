Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB221147C
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744061877; cv=none; b=bYzF7My7Be1hkBZ4Q00X5VUOqPe6m2IwhBNq/s/Gf1XyinO3L5MhldJONj55n0pzmxew4ScTj2UnQAFaAfw1whL8wPAA0buxfop/Op70jYEz1O9Yi+foSScCNSDxApZ738XQ6Xj6XLLxKu5KYN8jGzib7N1WXFRI3cucJsZszVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744061877; c=relaxed/simple;
	bh=CQPhiA4VhsnInighPM6dxsBp4lYkZFN92nhqNQq3vWE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hBtf7dMD4axv7L6OgIIDy18Y7OLIMq3snNNCTGu3E7V1n6/4B33Vw884hSo/+VsPj+wCW4g4xG5e4mBuo3U/TzYMAZ59MK8YfApxqVg71QiNVEJ0/C0yQD4YzHXvSDt3QHyJX2G2d38mRiLS3BUg/QFfNtz/D+ylxkxzkFalJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFuPzxXb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFuPzxXb"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso44813026d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744061874; x=1744666674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=17RneGU3JIQnMHPKznJwyRd5AtaFq2T+RDqiWYww2SU=;
        b=aFuPzxXbU6C1Z5YzRWGFv9+282bMGt6uTUBjSDA1ZwFMRVCMJaM5Vvt6rUachsG0No
         d2YJ6/c2dDuenZOCehbRE0bt5jG36cYY8Ss9LU4XSrgE9AfccivT73dXRRowhMp0ndeg
         sw6XZrixaeZYttphcZLp48WiY/83jkVQV3HoSpW3fXjuDpAWq5oLgEDXOzRrb9GKWFpB
         cKcMHPIm7FZRAf3SO9tOzS8s1QVKtLYmTxjyA4xj26ACR8jhPCPq/PmEO7SIrFoEgGwh
         2cyIyDJfqrk/Aq/ANoANlTLoIsB/WrY+nSHWjHzwMkOejnedGBUP7F513EaTIezHBc3e
         yKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061874; x=1744666674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17RneGU3JIQnMHPKznJwyRd5AtaFq2T+RDqiWYww2SU=;
        b=m5lerwE8L/bi0+yvD4H71u7QYMr8ksF+qV1aXLszkmz/+njHtFMiCbNXxRuqlH8Xx3
         dvTKn6MVSApMI68NEW0+VYq+cjLMF3TkgVKxEON1dMO3nmhj+eb6m5WD5oOp/IoaFKP0
         uu5PZ9SznaEU1dpuqXBUi7i+EPKuOP8+b+zjweHM+TtIs6b+wGQzT+Pl+NAUg9pe/jUp
         RUks8jUELed7JP5Bj5BWARDqxpneKU55GjH/7NsakjpbhQXAPOxl0geuUbEglXh4WxMX
         s5alKlLcVX95L6M4S7htyw3XLFBXxfPKa4jTZch0hOyD/wjL8ZNdkOQyaXmnKwdFzpQe
         lhUQ==
X-Gm-Message-State: AOJu0YyA+i9fB+/7E1UmNcmUHEUmIrRopMI7pIEsmcjbo1Edk45zNt6i
	2nI0+rK6s8tVitU6PkD1WbTkWHDkpzufZPdU4gnrctorGC+T2neKj7lLlw==
X-Gm-Gg: ASbGnctIysGLrj7+zefoBVTBsFTksEIwn0WO2pN0knV48KuKZbb4WnPT8IB79EQnugL
	W+eBRPK3Db2EeR3hzs2ri/yTTD5bWtP95aqeG5EOJ7LhaWXVde7ZfAffXGJj1KmAx8v9/pHdAHH
	FA8vq67vtTDNZmtms7inv4rJTmJYPFBhur87drVH0Bz4nNShZUdQQ0sO2EioRz7tUH4+tWC1+0D
	7xLnMIJpPesbBwg+QrpoeLOpAUX2Uv+seT0zA9n2c7+4n/M40F65SD+3vNyO9STywWLubvDUE+3
	9i7PTHhgvvZ42r7zDEJpaV8Ownuzaby2Vt+dRxtzl0oMY9/P
X-Google-Smtp-Source: AGHT+IFI3oFaRoY6fmJUj7PSu10qvrK+aCclhqWKV9KKwVe74utDhtqpXZzkga/cqEYXAjSUsXLYbA==
X-Received: by 2002:a05:6214:f6a:b0:6e6:6ba9:9e84 with SMTP id 6a1803df08f44-6f0584b75b1mr218049936d6.26.1744061874546;
        Mon, 07 Apr 2025 14:37:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.17.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f00ec2esm63456306d6.47.2025.04.07.14.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:37:54 -0700 (PDT)
Message-ID: <67f445b2.d40a0220.121c54.33f7@mx.google.com>
Date: Mon, 07 Apr 2025 14:37:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4329906070661456669=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: BAP Server test cases
In-Reply-To: <20250407200124.881534-2-luiz.dentz@gmail.com>
References: <20250407200124.881534-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4329906070661456669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950796

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      25.11 seconds
BluezMake                     PASS      2752.24 seconds
MakeCheck                     PASS      24.90 seconds
MakeDistcheck                 PASS      202.47 seconds
CheckValgrind                 PASS      277.53 seconds
CheckSmatch                   WARNING   321.20 seconds
bluezmakeextell               PASS      140.26 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      887.91 seconds

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
src/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4329906070661456669==--
