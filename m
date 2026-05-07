Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4633264F5
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186306; cv=none; b=k0+Av3DWx1LL6sVVt2srPL+nAujFTqkiGDvV16ytld/prM3144cwXuDeWkJHwq7uOVXW3jVfXc19RjyJ7gPpyWQABmj3pAfhiIPNDNMk21t0yhdo72gib8NPZS+NoaHJQlDhhlhWOCPQTuWWAYju+F1gDS2FpVmbIEGWUhjQ60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186306; c=relaxed/simple;
	bh=XOQIbRne+a3B14JZ51e4ozaSqpXN41MdCnrUYsvz9Cg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MYtTMoTo7+8COJGR22P9915t2yPQyvUB+U44aZWF9ubW6ctGs9emJdyqTUjU3vImWa89m4mBQTTrI6Q4HVTaecVWoGY3ERJMZUDwTqMWLd55OsAYVSrwIctcGngY+oWAHxJ4aZ0wKVF1FNX3SkJ1OcLUjMdb8g+cNI00EQ94pVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0l9NlrZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0l9NlrZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5b55062fso9539961cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186304; x=1778791104; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bmdRnWstFo3anPhhov3RU+qNwsdw7x1IaAguPjX8RpU=;
        b=T0l9NlrZ2Cf2RUpWADmCCuUrft5SgsQ8rBfjMz9z9sWsTkYKk/eEeRcmEkOHXuKqVx
         rHzGP8gmh9LI8gq56BMUA3m3Pd0C/bDd/V4cnEsehHbkXpgHiATsZ+tRk4oUXCJKsXGc
         SrURoCbjmSxGVDmaj2cKMSsIY5+fFqyE6GQsN7gAPGhN01REZHzNjdEAxeuWQFmjeQFP
         07fjJ8LfHI/6CNJ+dMMeQgcyXpyHhc/tcHftJXcoV+UNN3Jv2Em79wBacgMKw/IpooN7
         hrxU9q8PVG0ZtrOYeOqR+14B0mJYOS5+cNv9MDaUl/T0d43/UiVXlZPPPUQOdqvrxWSL
         VLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186304; x=1778791104;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmdRnWstFo3anPhhov3RU+qNwsdw7x1IaAguPjX8RpU=;
        b=XROUOtI0XO9ej7rTINJtaAxEIj+Ca2vVPGYj4B5FqwLvLBV0Phww9247TeKK++9gsq
         fvUZwSzO/oEdIzY8dElEajOrj2tmyRSjabh1BUOh/he+D8qqOWxK9tLIp1YUau8J3Xrc
         F6DLlFbGZqJL5SEKet5Mck3A92O+7i9Un/JP5ybjTnbpxoBn5T99hvkRZLQ0XyccENmf
         qOe89JgpyO0RxvP2C1ofHOe0hzTFhoeWA74fqVBCXL0ssLx/izQZo7Qb9KVw8zWCHY0X
         UQ+06pHX2uaCvN+Zy4jlMi6iXO5zlZnpDHPBA4MI2EIveSE2itqiJ8VD3gwkiNZKgccG
         3w6Q==
X-Gm-Message-State: AOJu0YxisGOOnX16XeHb5USrYbki2ls/80FAuqc0Hm/6kzbhqZKxToKO
	9fMR6QN+wfFfMtHgvwG51xN/DXKJgEXLeWd2jHfqZyeZnPfBlAlgMqzJIRmXZA==
X-Gm-Gg: AeBDieuGOJ9olOrouO6tJvLUqGxojaJKQZLCUQSgDiJ38jg4GZZyKBCETWDNWbrN0d1
	Rku0+119dl8kmyg89KXgOuBluF/BlLNFcloMssAMv2eyCe00eJTdWJL+GkF4ZbdapYyvMGoXdpi
	H79LNZzKLa0ghZ6ofXzNTAfW+ZMr18kTZbqbr9/zBgdJXT7Ys4VrMqN3DNeegHVkihKw/ZggsUb
	TAipG9evjKEvDLtbY6r7OjDgaEE4bz6JLzONpj/mHevkdP6drQBxevZASfewj0mplflulQHuZjw
	BPf9u8fSnuma2oM+WVPGXhFv0KiWzt9C8ETN1bj8R55u++4TVd9pKrPJFFjParr4o4nyAymUYEu
	zhAm86izkNIvnnM3xsHmipighjl++OpYnUTLGFJI+VYmy9LLi/BDhZpDH9bvjWZKR3q2aNYqrio
	zmnaxe2S69wbVks+GmJL2UMI8AGvrZWgPf
X-Received: by 2002:a05:622a:2596:b0:50f:b81e:c663 with SMTP id d75a77b69052e-51461fc24a1mr133001091cf.40.1778186303530;
        Thu, 07 May 2026 13:38:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.157.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148522a22esm6168231cf.18.2026.05.07.13.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:38:23 -0700 (PDT)
Message-ID: <69fcf83f.050a0220.14a21.cd12@mx.google.com>
Date: Thu, 07 May 2026 13:38:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7576311424037974669=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature
In-Reply-To: <20260507174205.209488-1-luiz.dentz@gmail.com>
References: <20260507174205.209488-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7576311424037974669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091208

---Test result---

Test Summary:
CheckPatch                    PASS      2.66 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      26.44 seconds
CheckAllWarning               PASS      28.96 seconds
CheckSparse                   PASS      27.68 seconds
BuildKernel32                 PASS      25.19 seconds
TestRunnerSetup               PASS      560.65 seconds
TestRunner_l2cap-tester       PASS      377.96 seconds
TestRunner_iso-tester         PASS      593.01 seconds
TestRunner_bnep-tester        PASS      18.45 seconds
TestRunner_mgmt-tester        PASS      2034.02 seconds
TestRunner_rfcomm-tester      PASS      74.65 seconds
TestRunner_sco-tester         PASS      141.23 seconds
TestRunner_ioctl-tester       PASS      133.55 seconds
TestRunner_mesh-tester        PASS      59.86 seconds
TestRunner_smp-tester         PASS      17.97 seconds
TestRunner_userchan-tester    PASS      19.24 seconds
TestRunner_6lowpan-tester     PASS      51.22 seconds
IncrementalBuild              PASS      42.05 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v4,1/2] Bluetooth: HCI: Add initial support for Short Connection Interval feature"


https://github.com/bluez/bluetooth-next/pull/154

---
Regards,
Linux Bluetooth


--===============7576311424037974669==--
