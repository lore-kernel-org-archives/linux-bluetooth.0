Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45DD2FB
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976780; cv=none; b=sSAkGqDE0r/jPBZC1hIBIiDyG3Mb5bzibRLTqhdSroAKo8TCqwQTuSL9KHI9YCekKcFQ/eFAmScUDPLXXX82tWd2NWJ7osjW6LQEss1kc1MsClYSwIyGfJXJ3Vb+EAeT6/h4S2tjFg9T0ghCA6DpOTQs88UmudMW9cgBuwASb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976780; c=relaxed/simple;
	bh=9rHR2UDhz5kYlA8mPXRbmKArZAu0tsBjVyhPFqTtZ/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z83i55tAZIO3e8KXWyh7yUsGfQ/XfbiuVfEiul6z+Y7YAwf7Qes1qbZN3l+k3QiibTd9NcPl4OQqvPDGTP9PU+fL3FtOjJ5sVTdburtgFBcttLc675TYz4VUHJwYZc0FWoWwwzIbzVG2JJMrF/0Z9DYO951sq5/s8CaJDZADYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9EWTl/z; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9EWTl/z"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4335726d0f2so354445ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 11:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762976777; x=1763581577; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sP0q5fwGQ5rIK3FfjDb8wge1/fP9XjEk/NH4nhn41Z8=;
        b=b9EWTl/zWVpG9j8ZobbQ7HPqBuVZCqHBDVj93i/LfvG0H7FuY2iGthCrkapOQreMK7
         QiuQzTtOq0blz/roGLTBH8Ai0jH6KTXPbYg9O6kO7aDekv0HjtrAC7OSkUShUmEZuagS
         QgEOmLE5Z/K4pTY1utRIfOPDXldJu2ujakOY38TRdj94eOJSDYna5ln21dQzlkTKMDrt
         O2GXy0ubWu6GwSvv2NFjltA4jT1Yrn0h4XotXlOB4XOZwo185rIk2x9Vy4Fol3lswTzP
         f6du46pkIcGHSV59iHwoIgWXQdWkB15OfAcQzbdP6SOUMZqlXP15YG5CE9GskeBRJO0k
         XmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762976777; x=1763581577;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP0q5fwGQ5rIK3FfjDb8wge1/fP9XjEk/NH4nhn41Z8=;
        b=eV90mOgopL2eTMhg5yTL4iXZDzOT52yxOBSOGDB9qFcdBzBGFVDB7sj3tJth5FphqO
         fb66FwWynTVzT6da1mA5+Xo//fN4GhRMLtLBH/RSPwgo89Oe2EK4OzJg3Qlc56LvrtPD
         LTbI6cY6yQxXoYPMN53jiDmAf6j+c4h8zJk4ipYcB9/CrGY5BvsmsJ/YFpVm/n3NeO+8
         BnRiBZkbEmWmhcLGXQv2PHS1ADVT7Mg7HVDUUNStMPfOylbkH6+HYsaP/+aWPupxSdG0
         KGD7fsv8xjAY0Hfoz6FLpvYZNKzZ1gnEXT7ftGg4iSNhyovtMSf0TxPdD18W9Hq6NcSi
         NsZw==
X-Gm-Message-State: AOJu0Yxn4zV+ot8tqOa6H+Z6o641kGchiSBuubwEEN5/HgtqjLBa4zTO
	U72r7QdMSHoyAqzoEEe4HHAvPP5UI/NRue5KSfDUhSq2qb4jyV3fzcYDCCZf0w==
X-Gm-Gg: ASbGnct6zke6TxCYBIFZXNgP5OkSNQK2fAufRw6ObapJzTLHZ1hwxTcyUdKLG/UYygx
	aO1kCX6lJcjn16xz492KobkZkCjeYmzELKBsQXHFn9wjr4mp5zudsuxDytg6/mWmXLX+/yKPg9M
	O3wQU7MVDrDhgR+kkgGJvG9KtDB2PArVHor9zVlhx6tEB9HBCPl532StrBxu148x/e+tJMJMxq2
	XIljTX2lA042PVXkcXKxj3Git5bp+sOWtAPDZXY6pGo4RnKqLLrKdgvZ99u33OJR18EqfyvcSek
	jvMihatRUdZn7Cesz5IYUlaChewbmJ6EyssDwOf3WQ9hmdh4oE3uwLy7LC4ooJ8tJHoZ5EQ+7Pr
	dkWY0xI5SJ8BtMV5NO1ZFAaXH36GDihlxwWu10G18zLydMZEOIVDcW01r3snasJiTWBDn2CCPd5
	wB0JILIqMqG1q53voARA==
X-Google-Smtp-Source: AGHT+IGP/jD8j9T5bVc3y5h5a03SObs5umBqcjVVjud+gIAEXvwpRMT3qkxLA/rs9zDKYn3fg7CDYg==
X-Received: by 2002:a05:6e02:339d:b0:433:7896:3e51 with SMTP id e9e14a558f8ab-43473d17c00mr57754655ab.2.1762976776844;
        Wed, 12 Nov 2025 11:46:16 -0800 (PST)
Received: from [172.17.0.2] ([135.232.232.21])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434767dc5c7sm8647275ab.33.2025.11.12.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:46:16 -0800 (PST)
Message-ID: <6914e408.920a0220.14e5a0.1a51@mx.google.com>
Date: Wed, 12 Nov 2025 11:46:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9122203105699690162=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/4] shared/bap: fix channel allocation logic in bt_bap_select()
In-Reply-To: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
References: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9122203105699690162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022641

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      627.35 seconds
MakeCheck                     PASS      19.94 seconds
MakeDistcheck                 PASS      236.21 seconds
CheckValgrind                 PASS      292.19 seconds
CheckSmatch                   WARNING   338.54 seconds
bluezmakeextell               PASS      178.85 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      974.80 seconds

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
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9122203105699690162==--
