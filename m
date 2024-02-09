Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556153387
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496365; cv=none; b=bfz7k29RjRoahDKITjRPrUv9AQSeegbvm+4l9VWLHJ7bIvB8+D1vIaKocQI3RyJqQbBPAXhHKl8l4cwvMWuQmf0MJja3YANrnKV681/bkLQHoJDqNvYINXTM6wVn2BMTWcU/XGdXi5fBdXU+WhfV4GUTe86/606zhdIhRGMzRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496365; c=relaxed/simple;
	bh=LgcDFDflGGGpVsmnEpsCxauUE+tdy1UT9ox9YqVNu14=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cy7pqqsSxxExqJWKMGKrUJ4LdyNcnQEMgtSf0VY7NzENQRkZrgCZR1NBtYAeD5emh995bFZerHAdn16IxYwadOfvK7AuZiHZ3sbtHIpJ1/l4KpIJLVf7nEzb6clkDuiwbCRpXXJ+v/M/Oee8tbVoF/y7xZ0572F5UhK6cR2lsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9hmN4w7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9hmN4w7"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so853825a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707496363; x=1708101163; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Atjj3wZrZlZKtSpRjn8WY+oKICYKkx1Dz6egiC8uUh8=;
        b=R9hmN4w7FFL/VNH7ZSsc50mjpZ5GG8UUR/nhCWBtKxZyeWQ66a2FrphwLd1yzWaCEM
         r9qoxAT36nCcu96HgFqWPO5NckqCrSmqjreUe69Ylu0fv23GRM6Wax8R+/FqRJq79skJ
         N1oZigsT/cPVe6F78YzeaxnTTvJMCmJkUsLCdtEdQr24/rlKbdm8411rS9oPYYbXuOvg
         /AvwXX/MgYxs/6ujcJX53yM7k1GXHgSFyC3C7UgIMJgkk+6SUPVbTpbaxFUJpXoE9W36
         /z3y5sVOQhfxOmZYFoHgXVQsXpCBsKV+EZrQ0ojnRH471TMYUknp5Essw4oInfAjaEXR
         PV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496363; x=1708101163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Atjj3wZrZlZKtSpRjn8WY+oKICYKkx1Dz6egiC8uUh8=;
        b=g9NAnPomfCcbH9h/XKO/YQCs5mZ1QkEuv1xPZ4ZKVe5krt3Rl3euBdWsVyFwTQB0AY
         AzXqfmBSo2CiJBsdUX/2tKGe4jNKBoekmxPOUzzj/15c1t2+AIm0yf7ZgFaum2shZGrl
         pXspNJEd9bAf7k0zbps5guM+CyooyHshszVDgj/ImR4euVAIsktuGZ9GimtAk1S8IiXN
         8vM8t4xDawlL3p7tQCVEuumwGYCM8VtVnwiDYUqSyasgSpZMfSXIhk3XbDrlwUGmUgcL
         pVXT1K0+2UHYV1JMP6Y6c3CrDtdxPycYzVdH0HfodSV1UFE8fvNW57+bMwyy9ncgr0ac
         bSCQ==
X-Gm-Message-State: AOJu0Yx6Ltbyr2UXeg0umdo+1il2QeV2mFzlqTohnudfMqtode5Iq0y3
	wrddPtmEVJ20O0170BAP05WujalIq3TReV2P9/ceiO6qEwywlUYMUn7yxTNa
X-Google-Smtp-Source: AGHT+IEkF2DrSwDCAlygS6miIJgVJxUolfJI4BsruMZoy8RNDHMMQshjMLe59krbWUaIyMR3rd/Jgg==
X-Received: by 2002:a17:90b:370f:b0:297:fb2:119 with SMTP id mg15-20020a17090b370f00b002970fb20119mr1167418pjb.42.1707496362905;
        Fri, 09 Feb 2024 08:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKMLcRjKZwNu7Mii6RRUvnUL5V5cIb5/b5Rvhb1yR7pVFvIswncaXeBvqMPuhhM30ic6Otuzqe6s9R+qHiK22SZD+ob3bI7te52A==
Received: from [172.17.0.2] ([13.91.68.215])
        by smtp.gmail.com with ESMTPSA id nc16-20020a17090b37d000b00296f2c1d2c9sm1998631pjb.18.2024.02.09.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:32:42 -0800 (PST)
Message-ID: <65c653aa.170a0220.90c06.6da5@mx.google.com>
Date: Fri, 09 Feb 2024 08:32:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6767741123358635659=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] hcidump: Fix help message for --timestamp option
In-Reply-To: <20240209150921.1187294-1-arkadiusz.bokowy@gmail.com>
References: <20240209150921.1187294-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6767741123358635659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824687

---Test result---

Test Summary:
CheckPatch                    PASS      0.24 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.91 seconds
BluezMake                     PASS      741.59 seconds
MakeCheck                     PASS      11.56 seconds
MakeDistcheck                 PASS      166.35 seconds
CheckValgrind                 PASS      230.05 seconds
CheckSmatch                   PASS      332.64 seconds
bluezmakeextell               PASS      109.23 seconds
IncrementalBuild              PASS      707.72 seconds
ScanBuild                     PASS      1006.33 seconds



---
Regards,
Linux Bluetooth


--===============6767741123358635659==--
