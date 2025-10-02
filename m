Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFA1DB54C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427588; cv=none; b=bwqw0QKThVjNvmF2Z0v5tNyHprIphs4fpdZqs4BEdW8miqU8t+UbH9QpGVUg3e9qg119t+ckXBYBlqQ3oXctqQy9NrDqyxcux6NOPjMHfs+URklrjIM1tWg59vu0kgrYgWqsh76sliFEHaTtfUY9BmDpj2z/OcKODs/DlNX5klY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427588; c=relaxed/simple;
	bh=N0q0iCa7dSWdh/9hiVKxiUZ9Pss3nQL1+IjcFFi0038=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TdAinur6fGYvR6k7r+ZwmYinwJH0iCfSay7zoK1zE9+7NGkT4QWGivbGY0WAgnW8hennte5x8JR0uR68O54yUhip+gy/E/wXLEzHhlc3GL8DE9thmhXeLJXdHFzrbWm1VMXC3bxys+4tR6QCocfs38qWv0h5ip83p6VKM7WKgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8oAgOVg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8oAgOVg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7833765433cso1878147b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759427586; x=1760032386; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aPwiSZPTTTsNxxaWyMOZ4N2qsAZcY3XjAqIllITkkls=;
        b=m8oAgOVgVm9SlSAiknBs/5fjNzp8hE5pN9jdRKcPChxKKqbyQnUDAZIqvg3rp4dGdH
         X2qPXlMov2UyTviT4ey27BQZN0ycIfBmCCSruIPuB2C7qQWhFdAdSsZQ9a2WY1tc/gez
         Y4ZYHkMAbFC83XjcOOeqwp93fdOjZyeu5vWcIh/U1+3DcZ2eKxnmQ0FiU6oipmdvZMKP
         KDcGIy8t6G7DnHDhOWqUPYZf0ksBLO/sW56Xk6aXDl5WOZ042gG2CcZW543SjBz3Irij
         GVMPQxedRjzSVZyW0z96Ts5Gvy0vOT2rr/TCjPrYvhaqYfuqZH8TSzXyHLUCl7WwQD98
         kOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427586; x=1760032386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPwiSZPTTTsNxxaWyMOZ4N2qsAZcY3XjAqIllITkkls=;
        b=JZaASsrY2pnIkGak5dPxFILPqRgHGuN7P232FbdQzUFgUGqeZK8r33OF5yVyiTyy3x
         DFSvhhvDLwLczBlmtNzVu6xqWd9a38+l2M2n7+JXo8HIhRG6Axa2xg5+hLyohTl0KWCy
         r35LFaZmiXe63OvQpr5ZdKmQyCv6LWpuD26zNHudSXfHSwSttvE8pZyGSuPSd/dVruOb
         P3xoaRDkI99hZF8r1rZoW2gDDU4h0ycrMY3jyOlD1MUpbXIaal2Tsq72Dt4psVndbcRn
         Zgr8MUPbOMkL0qXRoAVGFZOJX/nfKRQu+3ZBSwZnLsOJIcFbLeHh2rqbJAzsmarBpWWm
         IRGg==
X-Gm-Message-State: AOJu0Yy+TbxquyL56AJOzIaJ2ENCcw/yDwX19P8EFLGT+fAFiXi9o/7G
	r70/9vVB43cnwnBO6M2KDyG7JNxhg396IjYELARfl7YPIabdwKG+ros4dysQvQ==
X-Gm-Gg: ASbGncv+kE63TMc8PGiazWgUuHvA9NVHuP3kESp+iwtxlSpbGk2CSwBxa8y90NPPgeh
	7k9gcmWyDcH2EIbCC6z2dQxAaX441O7+iNY7R1JuSQxK8ZiLHWuVi8dcztOZPClRV17xannVT0c
	l2sUAbWe20V9vMcq55AkNBJOdm+n+jWvblRjgP7adjszvRp5wCs8CSW7hwN9BGj6l3ityrqEVur
	JL+JoECyB3OPu5xQPXjtTmBMO9aYxErB2MzKHfmPT1wdwWJdRf7gieYskvz15++MWZIgfpeuJU8
	0X9zowOuIzj6iTGNktbi/iRyFHI/LEAUw4Z1g57wSU+KgH3cK6C58OuF4QSPxXUnjntkVv6FVPe
	pvJqSRkPWtw6TYAv7BNZRS1aCxVMpkFITxmR6IbGRAG/L1GAA9Ui6
X-Google-Smtp-Source: AGHT+IGXTzcImhhL9knJbx97k6QuhuEib9fZ/Lkv9viZNxiAi/oKfZf7MSYswKQ0P5C0M9yd8E8/yQ==
X-Received: by 2002:a05:6a00:2e18:b0:781:1a62:4a35 with SMTP id d2e1a72fcca58-78c98a7ec0amr552806b3a.0.1759427585783;
        Thu, 02 Oct 2025 10:53:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.55.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206f619sm2644020b3a.67.2025.10.02.10.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:53:05 -0700 (PDT)
Message-ID: <68debc01.a70a0220.15a923.b3c6@mx.google.com>
Date: Thu, 02 Oct 2025 10:53:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5319244285411671582=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/hfp: Fix issues found by codacy
In-Reply-To: <20251002161119.937608-1-frederic.danis@collabora.com>
References: <20251002161119.937608-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5319244285411671582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008059

---Test result---

Test Summary:
CheckPatch                    PENDING   0.93 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      2703.80 seconds
MakeCheck                     PASS      20.15 seconds
MakeDistcheck                 PASS      185.88 seconds
CheckValgrind                 PASS      237.01 seconds
CheckSmatch                   PASS      309.45 seconds
bluezmakeextell               PASS      127.31 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      909.99 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5319244285411671582==--
