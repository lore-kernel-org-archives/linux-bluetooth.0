Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934D664C6
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367634; cv=none; b=piWDbPiVgByiHYU34y4hiqAojUMwhP20izIDYK4I+aPfiXr1RW1sVx5mQkcESpOvXmWJb0laxHN7xWhE1M0StPWymYm9xH2pfz/P4tPREX6WMB24R3+k018FjwpRGnycN6PI3jC067D6qcIJGXNJey9YSF+psRP8qvGVaJ2x9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367634; c=relaxed/simple;
	bh=XFnB8mcIqfzi3i6Y17tr+Ne0w0yjIVvBPAaswviJV5A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EXDsd0eEKsySoGuguyiw/m/cMeCBb8P8GvnkJlAu5H3VrwPmF5bnhq/019u5gIBNtWnDKbxxv02bD/vIgGltkvLBYiczLXc/SOIqFri6NeuCdJPnKHB8EVYsjlU6BSCNYsxc9ll/VvVdHRgP+mgqxZudhZYG7tl34+1Dp2ENoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3ZCV/4B; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3ZCV/4B"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e900a7ce55so13441806d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 09:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741367631; x=1741972431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ABaHTV9iBGj7pZxCkhZAedXeq6pg8a9o7Z61fpc/z+o=;
        b=i3ZCV/4BO1KxtUK3YvY5GZ8H25+ySpJ4xSU47aZfsFEIICO345P4+FrriysUKV5IIb
         YawDO4SoT43+uOqvHcDNODYbyQBwFSznajK/pkcmeLlh8M9kCRo0ICbujgWdhBTHaapR
         5qxKMLcOpVHlUjDu3HxkzbHaPNHyGsLZc+Wsyoj42xpn1Iyk7uXsHHkGfVAOraZj3qck
         Fph80qs1l7fbpC8QqLuXTEcewn6NSdF+ydxqxKMGz1ppdz8bTExf+swRtoJHfIhesuF0
         KfFGyfExG0g3ajgICOOURpw1zlR1CsilCi9NUTME7UUxRADxLGTbfsoy8H/u2wvdG3MN
         RDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367631; x=1741972431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABaHTV9iBGj7pZxCkhZAedXeq6pg8a9o7Z61fpc/z+o=;
        b=ez1hsK0Uxl4WYWs+3YQqZYEB8RF1yI0NQRYm+HC1bdn21LpBrFDpUprKyxqwQhrogr
         EjGsTlWFIU2SCeFPx4lKzIbI6/8wu2Jm32q7bwPzctqsWZbTamsYb7cmtoccI4mwlhhX
         cFWfkT+q2h8/61oPAVPxzADUAdpwBNvUsjaeUuPZ9EPpd3i+GjdKVf0FpKIpT4+60r9Q
         2iHoW3a25ra7eWNeNUdqHUaKQ1fCHDCto5kpFnuLgJzAUbqV2U3lJE+CpyF5GrREVtXb
         wyCLZ6m9rezjxWgffV+2p805kBgUTewAlKjj+Pv4X121mVkh2FTw6Z/QHc+x00EeDdc8
         c78g==
X-Gm-Message-State: AOJu0YyUrObfJNG0dyaCnnh9a2VBvGrP1D4dn9d3GfrXbNOM4HU7CNId
	OqUvxCS2D85VBDH7HRRXr1/9TK0XKODLsQSgaqVMYRRVz+xZ6w5hBiJ5qA==
X-Gm-Gg: ASbGncsoA4Nw97CDT9r3gKzKZiiHXPMc7XhQL2CsP3CM9Xdk+sXPaeiyjg3JnOQR1Pj
	t3DI97dcVXn6reDDjlT2xf5+8Rv9ShwbnO9klSCSCsC5d2UW8lO33P2VIYQ0ZuawmcGV8oVC3sa
	nQ38qtfIn6SkTPSRLy/vqgVy+aN/1LbcFg5l0CXmeVfYxRSt6+pfCAD9RB//THG/c11R9h1XbTq
	v0Q7tIuViw5+WqGjM4QMi8kCVlLOLo7/kDq1IsUp5QDeHNdmzN6ecvOVPtwbTwoqtmPpYxFxa9Y
	KnffDMoCNbwkGFouK3gU7sSZ5ibj5YyAZsNgK4v/FLJxesU6CAnE
X-Google-Smtp-Source: AGHT+IFIwNXw148fjO3bdM0h5KlJEkdoJXn5PQ4PjayE7FkwfzqXBher8rP5kZez92L6NByRCoEp/w==
X-Received: by 2002:a05:6214:da9:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e90060420fmr66457436d6.7.1741367631085;
        Fri, 07 Mar 2025 09:13:51 -0800 (PST)
Received: from [172.17.0.2] ([172.183.58.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a4db2sm21517406d6.62.2025.03.07.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:13:50 -0800 (PST)
Message-ID: <67cb294e.050a0220.97082.8491@mx.google.com>
Date: Fri, 07 Mar 2025 09:13:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3194284412009237764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bap: Remove interface
In-Reply-To: <20250307154457.85751-2-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3194284412009237764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941567

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      1495.76 seconds
MakeCheck                     PASS      13.39 seconds
MakeDistcheck                 PASS      158.10 seconds
CheckValgrind                 PASS      214.09 seconds
CheckSmatch                   WARNING   284.59 seconds
bluezmakeextell               PASS      98.07 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      864.70 seconds

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
src/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3194284412009237764==--
