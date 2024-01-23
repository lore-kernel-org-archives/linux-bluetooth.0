Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDB5F564
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016672; cv=none; b=n/lLkmoPUchiUI4CokuoWYFwfmKnsU05OC5fuC1GtBmOCi7E2SrRZ8EgCZe8hMMFRfVRDRs1BgxeXMIV8dmJw5Q1KM0e5XLgEZjiQsOL1abqX0aigEvL7McpDEm4i7msWtsmAj8KhBAXjvyGEKHKb6nd3G7e5U4vSitNZkRQtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016672; c=relaxed/simple;
	bh=yrB9kQrF0GXsskYXJdMDJDowjGGvl7FoK7rZZYjVMn8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZDm4OBMN9dyJgb59jUaaxtKW8uK/syM9h7jT7ZYXi4+JgVBewjWsJ3PuJLz0B+SsaukDrrNsEvMu2fqgzpvDSfOVWg++8Un5E0hfgBVjSx6CPdSS9DtQIj88MP+JP3J0AkjqgPv8tiVLZSxPMxz6bgNtyo5hvTCgTzLpIMLgNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4/qfTN0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4/qfTN0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7834a91b086so333329085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 05:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706016669; x=1706621469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8H8Th5t7Ouj/jEy2+NPhD14Q+wr+ypwD2gTkYGUSrqk=;
        b=G4/qfTN0EAbZmovm8ewcI4JwF1CsOEikrXvoWBeoeYL2CgkNCJPAy5z1gBfICRU4UF
         /jgoRwAJ5jaOsYUzdcX5zrdP+XPoBTYcn/8Ftf+Mrp7T/6JH5v/LuwcXfzHeVOWvELMh
         ghBmudAqtCpcRvXo7kDp9jG3mMh5ku1p7ofh8FZj75+/WSvdYqNXtORsHLmErxyIrWUC
         ibOCeeK4d0Yfe2WTj+n+cVo+C8XG1Ue4ZsKIl8EFm+PT5GhU/K8LE0l4zyN4HpLtK7C6
         hIQsDNGof7CAFjWtd0MiL4GJ94MOLBJyUbz5SnyeFZsdE6TR8pDuW0EjL+rDix+phqyJ
         XFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016669; x=1706621469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8H8Th5t7Ouj/jEy2+NPhD14Q+wr+ypwD2gTkYGUSrqk=;
        b=NH/k+KJltoYlMl8kRVCnLo92XmcXTCRq/7XHa8vZ3rlxHZOIJ44OOHd8vZg2SRW1LC
         0AkYsuWmedGVhw+9zpL4OFrQl5mhPxaS3fHdK+lktxy6sNiyiFZt/rV7Rc+fgZMxic7D
         j2/FxlRXSniPO/3FD0hlGZ589tulPEBthDtTGA/xrYl72qcnHR+eSTM6/5lIEIAP3paA
         GGV7ndsSj1fMWMZT4kX97RJaqNIGneM6oYKRLR021I9ry2Jfz1WJRWNFPfJnGMBShR15
         gKpB7oJJe6njF0NtIRDZtpOZKyaTkvy1s3XYKCNip4P9MnLcgKWZ3XiT8xif+0tfC7Ia
         ldCg==
X-Gm-Message-State: AOJu0Yw7mesOTvjL2BN5OFp11SyC/3mV8F8TToJuL6CL+CynB05S9171
	8Hc8x2Z3hLN1XIDZHrvVtc+BeV0KCUZjBsvFH9Ehxke9Jy0wep8YpuevxMFu
X-Google-Smtp-Source: AGHT+IGiA7OolIH9yBeBSSh00mFU7cejVsCSMKwqDWOu2PQ+55/beKsbpzN73PH3tsK+Ri3eMSimDA==
X-Received: by 2002:a05:620a:2234:b0:783:33d7:68ba with SMTP id n20-20020a05620a223400b0078333d768bamr7016469qkh.68.1706016669328;
        Tue, 23 Jan 2024 05:31:09 -0800 (PST)
Received: from [172.17.0.2] ([20.75.94.37])
        by smtp.gmail.com with ESMTPSA id oq29-20020a05620a611d00b0078321f3e7c7sm3118645qkn.114.2024.01.23.05.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:31:08 -0800 (PST)
Message-ID: <65afbf9c.050a0220.7201a.b52c@mx.google.com>
Date: Tue, 23 Jan 2024 05:31:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0021430026513676766=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] gatt-server: Add support for signed write command
In-Reply-To: <20240123121519.523735-1-frederic.danis@collabora.com>
References: <20240123121519.523735-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0021430026513676766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819093

---Test result---

Test Summary:
CheckPatch                    PASS      9.83 seconds
GitLint                       PASS      0.80 seconds
BuildEll                      PASS      24.20 seconds
BluezMake                     PASS      714.71 seconds
MakeCheck                     PASS      12.29 seconds
MakeDistcheck                 PASS      160.48 seconds
CheckValgrind                 PASS      223.80 seconds
CheckSmatch                   WARNING   355.01 seconds
bluezmakeextell               PASS      107.03 seconds
IncrementalBuild              PASS      1321.14 seconds
ScanBuild                     PASS      944.83 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============0021430026513676766==--
