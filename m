Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012E1BB69C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934810; cv=none; b=YDvz5PiXKwVyazVweDxRlzSs0toIB+dDR7gxu4vg7ElAeLOHc9wmVb+01Ub4BbwlQoZbPVHCQuZ0ABpUAAGQVI0SUdyONjrjq4l8S8lAL6FotQmBTLYs3VNBeFGcoatbbKiZTnOyVD3M/DtwnHBS4bsyy04xF0xTlEfofLbk190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934810; c=relaxed/simple;
	bh=5esw8oq1nm1/2cRxgPqzksc5o68xE45Oib12DT7y7ZI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=chsAMfDyQ3yw777KQegNVnmpBIcR6C+UhE2s+q9eLyYEaSrEPyAcvwbtt1RnR1nksoXaxfO6wQi4oRAEGJgLBtjsjRZGmZPcUaMA2QidwbOWRFj68gFbl1mkIlmD7aDBteVThuWn6ibGc2u0D6gvTg9CyKk9YskQZzJUEHV1CQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFBlAbO0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFBlAbO0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so3365999b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719934808; x=1720539608; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SOAQ1X0UmZSxC0eWy0qsRGB2+RRQywBtotqEmk32gdo=;
        b=GFBlAbO0zw+XW/jGVsUvJdum0QWgh1OpiujRYp+7EUOpsbYznciTUOhrkxaT/kMIS9
         5Ph1wvXHF6quC6yKQw5I/ZbD8bwFeXKaw4G+9a1FVMPgN23B5Iv/2cXpLSzVqQgS7b/c
         BWFxUmKEUZakT7pqvhWBt3FjeFIAvcUGqOoQn2IB/WfCwRHyg4Lzts12RRgcCAqp1+Hv
         qOm3pkn9q7NQLunIUbW1cPY86m1UxjJKlMx6ETfjvSPQO2MdFsHOLQoVouBLkOPl8ieJ
         4lDpBmWOgndoNe5JgwrXx7iuO2CLHroBKhEUnrAsQaKAtvmwe3HZT9kuMbYibBtRNWfd
         FKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934808; x=1720539608;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOAQ1X0UmZSxC0eWy0qsRGB2+RRQywBtotqEmk32gdo=;
        b=mTlgx854OpuOW9YJk60BrA+TsytPt+1HuXNPQUpsIn8p7D7gNQrW+hK0qhR/ez3Div
         rq9d/rbu8tYP7/zMyVgJ89GTZ1tPBHNimuQ0E277jLY7gOtXPiBFGJtpT9oax5ILS+Bc
         wT+DBwsi5Qx4uWQEjy8nCnE8rVcsP2kxjh4mo59WO2yb1lv2gZbdapJQq1D5tJ4JCHJF
         tTRLAk/6p7dE1sgAZ5RidE/p8pizQkLrU3fILaXS/RqorsNuhnaMJSObmc2q4ZLm8LpI
         HAqtlOb6WehzuMMBh8PCIhTddug1ntdF/JuG7agLzdHz/H+mSzTHDSRzyUIDRtZ5A0tp
         zfyQ==
X-Gm-Message-State: AOJu0YzS5W0WDw32O8Ui8lDchDWU4SJQZAc8jTqneo7OHdsy0cPLkRDM
	ARBNdS7gb2P5bMMuDis3YqBUgXChr3uNChdVHw2jTbNvttTO34okGyGH+w==
X-Google-Smtp-Source: AGHT+IFeJ5nj5sito6FSrhcQnyU50dYJTSsgBqEMNIdtkZrdNS0DDMWsco2q0erKR8MhuTyFfEvAyg==
X-Received: by 2002:a05:6a00:1744:b0:704:23dc:6473 with SMTP id d2e1a72fcca58-70aaaf35102mr12766463b3a.30.1719934808482;
        Tue, 02 Jul 2024 08:40:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e635aasm8965266b3a.17.2024.07.02.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:40:08 -0700 (PDT)
Message-ID: <66841f58.050a0220.61e65.00a9@mx.google.com>
Date: Tue, 02 Jul 2024 08:40:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0426871431734395052=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/shell: add return value check of io_get_fd() to input_read()
In-Reply-To: <20240702140313.107131-1-r.smirnov@omp.ru>
References: <20240702140313.107131-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0426871431734395052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867571

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.82 seconds
BluezMake                     PASS      1728.14 seconds
MakeCheck                     PASS      13.76 seconds
MakeDistcheck                 PASS      177.84 seconds
CheckValgrind                 PASS      252.10 seconds
CheckSmatch                   WARNING   358.33 seconds
bluezmakeextell               PASS      119.41 seconds
IncrementalBuild              PASS      1461.06 seconds
ScanBuild                     PASS      1001.32 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============0426871431734395052==--
