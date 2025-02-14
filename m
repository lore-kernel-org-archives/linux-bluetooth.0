Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBF1C84B7
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568625; cv=none; b=d8DcLZjh4Sy45LxB1U+n95aBgGSc8GFY1sybvqyBTB6SKDbX+noRaDq3VUrXUG6/IVLvQV3w1VbilgjzoYbcwalBK0QVrioLoy6o1OSP/jI9JOMQQ3q3qayQJl5oSd3U1ZjyPdnLimQWz9q5wLxS8DTegzfb6AvgeaW/h37Y3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568625; c=relaxed/simple;
	bh=knCVNbAW+lYltNErEtcV/tsi9hC6nPy/CrVAqRLmeis=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sNgpDLUZNIfkvFFXtQOndufREPdiAqDhKSKfEUbP64T+kJ5xRrgBXWcYs6T6IV/hLNdnPcPJ40Qf2fOzQSePQOd9s/7Bt0sFS6/4hYQCq8F+VHgK3OKtBOS9p5OL48XmM31Btp0UDQGl67+2IgXnIETrdQwjP/iVaLp4dDBH+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi/q+d5L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi/q+d5L"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-221057b6ac4so1520535ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 13:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739568623; x=1740173423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hY4xyRvaE67tYO1yF/02bkuCus/qGQtGgYGRBuyAbRE=;
        b=Fi/q+d5LJMAnn5imcuOSZ7VfN6ZIaFWO/oE+c/PF9UVSpQVILXIl3BNjqRG1RTx8AB
         +WG+GIWPwjNXmL8yWXMZBMhvfOhO5p7SzB2JrRbJ3JlH91rvU3XOz1CRDgWVlnUGkOhI
         01n3L6S4IS5HHNDYZKOr+0BUyQEZi6ObHLzqygZjyzmpye0NTzCnLuB3kl1/aLEywLz4
         XmRXRFV+zvghOe9cw9kYc0W5KBTEb55LAubG3w3l8KggN1IDRzQZGbpwtoO90J0ogdAM
         S0SdP+UNDvy+AnjplHnlPFSrT08ahETN6o69hXNSRBjlTbrV5ZmEvrDU/KnM//G3faes
         nfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568623; x=1740173423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY4xyRvaE67tYO1yF/02bkuCus/qGQtGgYGRBuyAbRE=;
        b=Zg8qKqQwWbFVxT+iB7D6Y33XChI4PBJ8/CK35eFY/61GG1sqNTJtzELkFfLdajlnCa
         RVRXYwJHOtScjqHTlVmM3NGNrseBbEpCCjt9/CAFsWdGWukhe+tlbp12Keu/z7DlsI3h
         HOQkw8KKQiQs3iA42/vwF+avktX2nkig2KFdo9XPYNj39g1PPub+i8FECETdJdkMGqeI
         RBAOKw8NeH76b+htKSxQ6lsx0XE2Tqtiq5ESXkHCJge668CUiE6sjm3RtduaNdVuYWxr
         GcXTIcHXzz1A1aur7z97QqFrfM7jL3/W0oebiIqKnijrp7bFW8jxo68YfGxyz1Bgck5i
         wGig==
X-Gm-Message-State: AOJu0YxspuTBzbKiF3e3ZqXQOs9LQ9JAHgo8ckKNYDrCCo+TotPASi3y
	2XGQDaY8k9pkmwLQaBHaka5H+KkVWD9eEOWGsyp6bDKoxW0YQSvaTZ/haY8s
X-Gm-Gg: ASbGnctMdEElxOdGW6nUVUHUF3nO/ClheS5WV2HPIExPKtGcf1dxRqcK5cEHDUHjbAF
	TNhW1equyESNGP5R9iRbwJIOgp9ovi6WRa4ABz20RMHK5+XTGE9shTKqMdWJu6JsdzvaS99ZmOI
	sGyudOIYkCwf+OkLJMgGPGNdP2sI8NVvyM2xFTgDALltja7V0HoGkdfZ5UkhivkjjP5IEMKqfgc
	viKgALAw+w7LpBjU3PZFm002LZe3twnV1uKmnJkaYTQSflUIkH8RWQV3+K+aBg5vK1kuj/st02a
	Lll5ZEm8dNFZddzKdzEkTg==
X-Google-Smtp-Source: AGHT+IEg46m1J16j28+MTsnDdQlkc0aXT2mMyobChJnwN0qzuBQ2+ROdGZhTXkp2pcMCyoj7uIPo4g==
X-Received: by 2002:a17:903:41c3:b0:220:c113:714e with SMTP id d9443c01a7336-2210405c6c1mr13816075ad.21.1739568622832;
        Fri, 14 Feb 2025 13:30:22 -0800 (PST)
Received: from [172.17.0.2] ([52.155.63.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d45dsm33163205ad.168.2025.02.14.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:30:22 -0800 (PST)
Message-ID: <67afb5ee.170a0220.d8657.7c91@mx.google.com>
Date: Fri, 14 Feb 2025 13:30:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4679438947935518417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] org.bluez.Device: Introduced PreferredBearer
In-Reply-To: <20250214202129.968369-1-luiz.dentz@gmail.com>
References: <20250214202129.968369-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4679438947935518417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934171

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      1450.79 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      158.43 seconds
CheckValgrind                 PASS      215.68 seconds
CheckSmatch                   PASS      283.75 seconds
bluezmakeextell               PASS      97.88 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      861.14 seconds

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


--===============4679438947935518417==--
