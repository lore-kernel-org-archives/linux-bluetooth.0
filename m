Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0701FAC29
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714079; cv=none; b=LWtEZmM1FF24Bz241jUfDJDDVc7DL1ccXhyZo9jlbJdbixadpuIHBbPgQ0ur+FcSl09PqhU+EMPxh+HCtvBWGPJw6+0TO/+7WGA5zyaKmO9OCAPq00tY/KByK5CjBJSUD5JwF0Z7tgb7JtxGy7BNMt+1ci88ZaXHyixNfXqwm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714079; c=relaxed/simple;
	bh=HV12CCQ/FDWQ0wH25Bl3gMjail8YW/tyTxoSnXqJSRc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pRdocm7m0iwl8PNgLUAXwDrKe28yvNzWPXun6Kos6k1zcXAtheDnv3CHTyLRshScO3RfyAZQq6ZqObu7t9N+ih39xed7CNbvUDxWfKjnPCMgHlrLadbqcH2kx9iB9WbOEvMWXI4EyJqpu2gJqHUJAMYtHV9L6ALMKpl6mFytqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFG0k/nk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFG0k/nk"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b676152a86so71390385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 05:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732714076; x=1733318876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hkQDkDilot62g4e5EXguLI1RKPiL1jDVGYw9AAyk69E=;
        b=kFG0k/nkoGiztWj64Pzt0sI6x4HC+4AexfOuHnV2kvnMJut+4Z/ZGyWbyuMr4JGcLb
         m01fDDIOFR8wHCn89hd76OZMtW/Pw5+rhF3C5S89cw6dqdBB+kajQE0dkRTOXsMEvjfN
         bTJCynk9mSdLuH7j7h+n7/4KmtT7j0eGoSnp2DnSp+GWsvWSqriNkntSJJWVtETYqOV8
         RyCyMocooyEYhY2LjAt4rSwq9hTEFG+p1B8Q2Nll+jQ8OvuHE7CgBVnrO42z8pEftje8
         lnWbEp5iA/hiMIHdjeUW8z7oRVTHloTH2tKHLKn1mJwEMYAwqsdn0uBTklnxNO+yoggB
         0qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714076; x=1733318876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkQDkDilot62g4e5EXguLI1RKPiL1jDVGYw9AAyk69E=;
        b=neVoWbk1oyG+Q5BTi1zIoaT6P5voLDxzvumF/PiznEcqR1ffI7U4hQtM6QPg4nCtUB
         reXjIjOFZ/zKTTgrq6GA5sW6WfECAPeeTUQN77mFbpK3KX/Ti2ve61ktjkRRahPqO7bw
         5L9QLspxvnhyF81izUnwCCStK3/tKwvbQq6jaeM37BGcTzkYJaa3Luwp0ZCDky4uasD5
         HqNESWHy/uG8M3gQe4YzyVJxCYDHKhTJFg3lesv03iPbsWAknzIXDOuomAMxNTD1Sgfu
         KcvJHaTFdDiAJkHB3uENKXxVpJOphf6kVQpXbyYEqeb0eDMNUQ5HGYtso4BNDCvXhRfz
         xGZw==
X-Gm-Message-State: AOJu0YyrL0XrSTiY8bRtRfD9ts0YUw4sXRU7mcnIRVoosgOkpSI3lRO8
	GbRZBsRt0icM5OYdMnuVKZrm/YtjZMd+zkNTcRiS2axroG+XnD32XqyxsA==
X-Gm-Gg: ASbGncvZS3/g4Lw+byYa+MGAFChbfdaYLDKuMkuWYV95CDF74J0kBs08r1eeebstlXh
	Hhzutyim6bWfP/nqSnmwfHCz0Y6TtXKXe8Yoh9yD2F2H3LJ5BWEappFsLKT46OjuEKYVhIlGJJ/
	Yl16jlmnpvo1aqrJFMZENE3+ZugyQIzJx6F0Xu59M8IWEjQbLOG5pzHwq9X/kWbr//F8gJAFs7h
	ePNg+wyjUWCY+QizmRLh7KT4+Vm0Qkng16CtcVHdviaxxYunxPloVo=
X-Google-Smtp-Source: AGHT+IEn3PfENN5YyOOKYs+0XtaLIqM/4nDyrMKheOHnylZ+p6G/FXkMVgzSNAqpbjPKMJH3dYHnRg==
X-Received: by 2002:a05:620a:17a5:b0:7b1:ab32:b71e with SMTP id af79cd13be357-7b67c2413f9mr558903685a.0.1732714076322;
        Wed, 27 Nov 2024 05:27:56 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b666db6a75sm345194485a.18.2024.11.27.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:27:55 -0800 (PST)
Message-ID: <67471e5b.050a0220.2be997.aa7e@mx.google.com>
Date: Wed, 27 Nov 2024 05:27:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4727685901798659550=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] profiles/audio: Quiet plug-in warnings
In-Reply-To: <20241127115007.1303616-1-hadess@hadess.net>
References: <20241127115007.1303616-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4727685901798659550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=912795

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      1559.79 seconds
MakeCheck                     PASS      13.46 seconds
MakeDistcheck                 PASS      158.91 seconds
CheckValgrind                 PASS      214.05 seconds
CheckSmatch                   PASS      271.16 seconds
bluezmakeextell               PASS      98.57 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      840.46 seconds

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


--===============4727685901798659550==--
