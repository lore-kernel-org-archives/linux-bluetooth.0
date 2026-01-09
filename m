Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109719E97B
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993959; cv=none; b=nuHcGPdQ6EToHhces/77h4cNtOVB3/Djv4LME1UDkLTFaSizudrLABC03xtVx2Az/VSgtUqgM5bjJRVZ2aV1HFujg5I+ovSxrzFeveQ8rifvFWpWqF4mjjoW75/kV8YpmpibTE4KNPixYKa+b2RF2BMKLoXz89izeLzCRpN7JX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993959; c=relaxed/simple;
	bh=4GVKvAi+rfXNqn/dzEZKO/5m1kBQjM7iOeRrendW+3k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CXVlDa4Tfy5dnMIW54nq1cuT1xp5jxkvUZ5BCJmVBbVxMy3LKyng0Y6NC8BRMjOfZkDntzDrq7TmCzaMlGAm6NrtGAOVkPzzrTH262XbRFydf0JWqUVOIy5Rl5rSQ82O334LZD+cz1ebmWSazjCPU4z4uYjhy2qwEpnQkUseFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In6U4nF+; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In6U4nF+"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ae53df0be7so7018047eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jan 2026 13:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993957; x=1768598757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ImGOVjXhGE380xP5JlwGuAu037Jj4w1kI97Kp3hF0Wg=;
        b=In6U4nF+FNRNuEHSK1/s8Pwu7ZaTLCeY3n+/Wr/Wa97rEJcU94RU0CFJ+8AyCh/6CN
         oM0woD8kPE6unUWM4FPOfX00QNF0D8hsZ+egKVyQTsFhq+WeSdlodtPM+ukLBDdjpsrD
         KGxHJtIGXD3o4pfMD5BFLdv+70LcP4sTPjjEDveYsXamHnT+WU+hlXthWTcFWpgmJdwq
         SQtFh3bZKFa+4xiAPnegIa2IQLGDvwPYRfn3zsbKCgWODvv9ljSpy1YmFBD8AQEUCDAU
         ZWwhKai47JujGMKSzblqiAbo81Is/mEDL1IiZd3fm3K/fSN5m0ybmCUe6KGrKLLVix7m
         Y9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993957; x=1768598757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImGOVjXhGE380xP5JlwGuAu037Jj4w1kI97Kp3hF0Wg=;
        b=QnlmACPxINAoMRQe/t7q/Gt3h6VWgmkssJr/E7tMS9hmkXE/MMwJ52CaP3hbcIliep
         8AJ0zbAmsMDHEWsSAfGtAVsa6wuaAyK1m4EufKUIZj0TC08ZVTekQLrIqa2dbOQ4gFMV
         sPKHZjnlVpV+hQIAPElg8XWdvhxFDkM1zIUyYE+OwnB54gAc++4KPG69ijMKk9O/I2Pn
         GTu9+tIPSaAHAe4VNxEUBCFSR0Xr1n7sn/yjZtrgolVqLARMgq1xUfWTntxsiZ5Vc+CI
         fcpLJ0GCez+SHIli5+zuQ8+uC0X+pXwYK6ACkdMOfGYYEchmuUWwOJxI7HPVikRo1zpg
         mgqQ==
X-Gm-Message-State: AOJu0YzYN44xczLuqNegxK3aukcH2nBwmigNjEI1S/N/LMttRYoq8JIv
	1uTzzEFGXoAUYYkktHVRMwR02DruJW2EHWCQjKrmMygM4zk7tyIvLs+jzAe+LhoS
X-Gm-Gg: AY/fxX5186Xxm2G4xD06r7Ea/IEln9tOf8AXfmilFGUg8uhUz0a0sSLIYDMdpCNAyg2
	OmkeeL+Xmjcnv/xL7KFOcc33R4QUHpFbUGmXIdiPt/4qpQvudS2NWzoQsg9Yk6RLPHmH6DYl73P
	ObMsjdhFIgEJJFbDZ81fQGfYPQL2BZfCEiuqZNSc341rqdBR2f8N1NxyjNAVnPYYbxhzbjE9wzc
	7x3haStuZ8sjtdPa4sojOo5DelCI69sjGE/J0JSn5+LiqmUQOjNWXwYtm9H40YO986hh/fj7vu+
	NUm/lIu/lSNov4lwfNB30zG/CjuH7z9p7WboxzQEdV/5WdFp++xhrVdtmmImJvUNeGkooxrlTdB
	+o4sqqAdrEAibUHFMJakThh6epNfjnR6wPv9MTKOPx8XSM6+qhzn1R4ZMYznXBG0rGXQ94+ECxf
	GiEa/fVPpfvowitJpxC7M=
X-Google-Smtp-Source: AGHT+IFV+v4quCSadjrNd40T5S7xwVJFJ2ejHO+t6OFHe5GkttFTuIRWIzFXE5aEtJv3QiHU492dyQ==
X-Received: by 2002:a05:7301:9bc1:b0:2ac:281:4b4a with SMTP id 5a478bee46e88-2b17d229474mr8859080eec.8.1767993956899;
        Fri, 09 Jan 2026 13:25:56 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b21dasm13217428eec.27.2026.01.09.13.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:25:56 -0800 (PST)
Message-ID: <69617264.050a0220.3a2f29.b3ab@mx.google.com>
Date: Fri, 09 Jan 2026 13:25:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1709580922281170039=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dalegaard@gmail.com
Subject: RE: [v2] device: fix memory leak
In-Reply-To: <20260109202925.774809-2-dalegaard@gmail.com>
References: <20260109202925.774809-2-dalegaard@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1709580922281170039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1040617

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      19.78 seconds
BluezMake                     PASS      623.26 seconds
MakeCheck                     PASS      22.20 seconds
MakeDistcheck                 PASS      239.35 seconds
CheckValgrind                 PASS      298.60 seconds
CheckSmatch                   PASS      347.25 seconds
bluezmakeextell               PASS      180.36 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1005.23 seconds

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


--===============1709580922281170039==--
