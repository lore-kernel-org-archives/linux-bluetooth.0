Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AA263F4D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478371; cv=none; b=fV4HqocW+95kMlKQNEVa2i5BxKYbhoi0jMFS0bWGCemhzwyfIDQo+0euJkL8svm1dnM2i1ZayM6hCrWibft6HRMCRTw2Eytq+3huffiYt72GWphPTCsI5PQMSsiecLKsIKii5woFO1tIV35ehjd0qNO/F78aOulJDcTlLF033+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478371; c=relaxed/simple;
	bh=t/M7sUnyjFZOrXmue03imtP0qZEgZaGQdGqkqpvUV2U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ioivzPNJ9xGSfONri//Fv8H7GJtjRn3ImJjRkVWYV+jeYyutHGcJElXDOY/GVjC7ww/Xqkah7SHTe/LQ6yaGdVisaoFgRfhI9gDKBBaALH5SCzZ9wDw5vUV7TqSMfidmya/iSW/swZA7Ysa+GSBBIp0/MS1AFNQYVgTYTi43MfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdguCArV; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdguCArV"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be6fdeee35so1038054085a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478368; x=1741083168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDQa53LRsQ2PCaoxq5EkmBrumI3WTkXcNYLoP5hPjqg=;
        b=QdguCArVC6P2bajR+S1gBmrl9iMmYLYhGUY1ypoUSUoVcuA5FkMVhIEtprisvq1iYD
         wYBYUdns6luL/Zv2NaGk/DwLNOD95xxAM4Df3WdGWNFd42SzYKotC+JKeQVLvcp8rEDA
         7UcfdTdWsOcP/AhYLZ4b9lZCn9MQ/82Ag01bBUBDe+Rch2whg8qP9lsFI2/hbaYf+kvL
         J+8FqM3o0qzXZ5iZ7IX4qPTxV615qqc+H8msKD/VqzgKpLQdrmg39FWnoXhUkq+k0C1z
         Il7HjQn9Xu3dzDJP8Bx8tNyNCllhC2kDNNmHefniHpvILgVwmeq59cvB8Ug0D7UyvfKQ
         X1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478368; x=1741083168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDQa53LRsQ2PCaoxq5EkmBrumI3WTkXcNYLoP5hPjqg=;
        b=JZUfXNmzGshGZBZVcCKnlPPOTHi+CoLehF4npR+fSZ1gSJcXOMfPC0Ub8y6c6fmPz0
         ncvmKLAsPrOoLHZub4BmbOjfa95/HYwPfpJjdcIO/Wbq51ZbiPqRlTRuTneJFeFAqfNW
         vFkJE+KvcZf4Uvk20o/ay+plmIeyEWl5aHc5JpVkfH7Vm9tVU6X8h6zKFoto1ix/qviO
         0OUc03MuhGevbASNCyWZfaS1H7Tppbdi1Op1M7D3+s5w4MI38ubfpe2bwS6Ao/O0MYTd
         XrYvOOO9eDxkj5zd0qx5WTP71iAdDp29JPdkcV3Sf9V+1R+Dio2MKkM0pGJe9hJ2H/Zb
         rW3Q==
X-Gm-Message-State: AOJu0YxYtpGFI6+9R/AuhJDYlg1btqov9qbRzb5zGtoTrUow5FAAT8Dy
	wJD3I7BufP4fL1WjyMBaeu/8OBe8eyOLZAnkeL1iQGskOOsO44FZJKzvxg==
X-Gm-Gg: ASbGncvFJHLsDE85ASE8VjX9/vcIjiEiCOxepIU0WVq8c7WRNKWxvh70NgELHhLhus8
	HrpQs0FDiKTAQL/nBtfNWPuiksF7si2abKzRVO3cyDnsXfk4mWlGXTiX+kgxhhs51V8LXUv02+8
	ebOhWNu43eTBqIa3HaaAJ8y6b2diMnd1mXGpc7MDOm6+hpddJi8u6AyHPazvC+pprmNG8QGG4bZ
	sR9934NSNgOtJXiZvt3T8iY5saGRbGYSKGDKQIjHJ/D/irNIY8Z4cboDyG8rZEvLbqpg+S0/xXD
	13fjdTvDHyQw2ubXaWfatRKQwjEY+m4f2w==
X-Google-Smtp-Source: AGHT+IFUxl4Oko3hQ+qOweWTdVyJsAbl8F6OGA9dP4LbYpTrJsAFIv9qa+QVa5Os4CE/oMR1RWaEGQ==
X-Received: by 2002:a05:620a:2688:b0:7c0:a0ba:2039 with SMTP id af79cd13be357-7c23bf454e2mr443050785a.36.1740478368460;
        Tue, 25 Feb 2025 02:12:48 -0800 (PST)
Received: from [172.17.0.2] ([172.183.221.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c32724esm89512585a.89.2025.02.25.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:12:47 -0800 (PST)
Message-ID: <67bd979f.050a0220.3798fe.335c@mx.google.com>
Date: Tue, 25 Feb 2025 02:12:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0079331302806248486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Register bis probe/remove callbacks
In-Reply-To: <20250225084414.28677-2-iulia.tanasescu@nxp.com>
References: <20250225084414.28677-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0079331302806248486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937397

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      1567.34 seconds
MakeCheck                     PASS      13.22 seconds
MakeDistcheck                 PASS      158.55 seconds
CheckValgrind                 PASS      214.36 seconds
CheckSmatch                   WARNING   287.70 seconds
bluezmakeextell               PASS      98.16 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      879.92 seconds

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
src/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0079331302806248486==--
