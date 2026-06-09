Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A13749EB
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033529; cv=none; b=hCzhVoPLJENJfUnksKdeQPtWzs9l+LvOCkFzC2B+yV4wpBi3NjaZ4oRf9U6bHcfzJP4Wxm7fF3dUoC04oQldPqZkorh7miLCmuQePTKenWjYeJYi2zoEtSBd5cIA0bbPUyHZi06NFyWZtA8Zzj2Wr55zpG2qDfGTL9nHb27+yeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033529; c=relaxed/simple;
	bh=W4Wet9jvEIMGBk8O5fj7rH9H8iJ6UbdNWus2KJVp4d4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oil4Ntc/CXTp2qGVqRasHSxX98E9tluYogdpq49RCFyiEIo0f1kBGyS1czWD6BW8X6msQGk6GjaOn09XxWcHyt59vS9y5f4XAVGln6WOGGeXs3eNkL1jiqe13P+r+faooQnhqbaByOUrMAdeINYMxzDC1JFQO1GhS+7U9hZ4dKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBg1LZbH; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBg1LZbH"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1382533d428so1795938c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033528; x=1781638328; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LKG5ox7RkIHXlIE+ORwqTcK+EKH6/sdgxgan+YuVWxE=;
        b=eBg1LZbHsNUuVe3IkX+vebM2n3YhMs0yYmIO9ZkF+oLrSHlAv/4v8SErXlGypWQxaw
         QA3L+b4wBpco58B7NL9jJqZ0Nxnct7GVl4qDwLPwMzK34VKqGxWiZcp8rhLDY8XCFmAx
         SRnug4LMJXT9wAABVCWOpQ4sLEApNK6VB/JWu5EGwBXlP5vIsFegOqRJDk6hdtpyAOU6
         QGKcmbu8sGJ6ff+B+wtd6oOE5O+aivrjbgX+WzpZg7OjN59yXSVR70tpLulUZOwci1xl
         XqomQHnG2qrcTjPt1rADzfDK0Bgsxa5SQBETl8xW7FtLPBX7dRJ9rbMaEw1NT7IyM5KC
         1k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033528; x=1781638328;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKG5ox7RkIHXlIE+ORwqTcK+EKH6/sdgxgan+YuVWxE=;
        b=PQoXz8hfsrFDavcQu7pcN0f68RAwqSOq/I1j6fCoRW3iDLXFkwsnABNtoIj3gmdv3Q
         dLf+ZstyuOo9EJUYGwS2H3eGkoetlhbQiRRxaEky71wpmTlAvfwlECQg+Fw1XerJBwI6
         /oL/XCgKTnz/ucL13W1FL5FoBrNx0d9Kpox87O3dJ+lUv/cXlUCiM0dCDU557Hulhh6F
         PfsI5fgnmUJFbHUXP5pdQEMg74tDxAhzTkDhNMgRBUmeJHw+kOMBLe9iOJkhYUhTskQi
         PHrG5Kd+49Y7UxQBi2Lvgmu4wnOJD1jM/lhAcqdZ2x7+ZS6HQ9d839XUrdlUiaoSFZKA
         Rmqg==
X-Gm-Message-State: AOJu0YzIp6RepcHqqJzosG43b1+cb201BNkwIySAPJduY0PZACIsNhgM
	WRA/5E8DytuiplMUbj4xxC7tHS7kHnAgpMraPF2tVWLBpVpmo+ygSKF742OGcg==
X-Gm-Gg: Acq92OFO4TBG6JkaEU/GR8EKf3G10gajqon2XeoLNraqaGMvweiskKvzvW6vy70DZnP
	UyuLI1WM2DVBGHbUQ8T9ysXYqAcD/LqQ4PqnAv0xgGHNCZWYnmYZdwPYnvZXLmFEyQNxNIM3oJC
	aU3tsSUFBoeCFRackMyUzNhImibghd4OnwK7rYne8FXC2giu6VmtLzH5ARhwGHFZ+ldZY6a2ccy
	O2uoQDpZP9EXHmUozlM4oGuhKouan2RN+0pGBTdg4CCuV2SgEmVo5ERqfNIAcvCebUFOF1lrKmL
	45k3qDmAb7mLaXbqj5SRConVkgedXaN+N6fEvmhamRn2/A9+pOC8sazd53MDewn0t9rzeZ7xks2
	36ygOW6G8B3dSVWdnSlWsrsBBarlT7gZ7BrEJkHQ0cKEGzFdfnKqky06Tldka46Wp2wbcNbi00C
	lT8hiJs1msZYoTbCFge/PGULeHSgsY9IjSyKdJ+r9UnKy22Ti9tg==
X-Received: by 2002:a05:7300:7253:b0:2f5:2556:5acd with SMTP id 5a478bee46e88-3077af4f7b2mr12957309eec.13.1781033527608;
        Tue, 09 Jun 2026 12:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.25.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm32628280eec.21.2026.06.09.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:32:06 -0700 (PDT)
Message-ID: <6a286a36.44930dee.3c8499.8168@mx.google.com>
Date: Tue, 09 Jun 2026 12:32:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6484452719599363535=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] shared/vcp: Fix duplicate VCS registration in bt_vcp_add_db
In-Reply-To: <20260609181351.3787741-1-simon.mikuda@streamunlimited.com>
References: <20260609181351.3787741-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6484452719599363535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108772

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      641.79 seconds
MakeCheck                     PASS      0.94 seconds
MakeDistcheck                 PASS      244.57 seconds
CheckValgrind                 PASS      220.97 seconds
CheckSmatch                   PASS      345.87 seconds
bluezmakeextell               PASS      181.21 seconds
IncrementalBuild              PASS      645.43 seconds
ScanBuild                     PASS      1023.19 seconds



https://github.com/bluez/bluez/pull/2205

---
Regards,
Linux Bluetooth


--===============6484452719599363535==--
