Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398E253951
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750795; cv=none; b=f9qZ+MiE3edYAZFhval2jxXbPwv2doh0qrcob9NUiPnpZYfHeHUhcYQp2XJ/4ZP24tnro5vUIC1EcFZi68Nnl/4/YcrtjsWCQuY8zYn7BmjDHeP2mN6ur09nd2BcEahs79BCgUhql7BFtqSCNjomV03gRxJKmfh5pDQimrdjCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750795; c=relaxed/simple;
	bh=R5Q02VsgiHEoNxx9DgWILRvv4trANQM1E77GVpizRGQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HFJ6Sk4uwnwV5djIay8A6T4/I3wVBXZBMWJAYjsvR/uwQGDJ6gPxAWpik49HwmOPa7tjBd8AQXAYkhQUtz8t0wZ9J9de1sBEbH6YzA9sqr2UrcWaZpqOiAIwYrnZr3V5Gvem4NbWlQw1+5zBTRhKy74pCF8uq0LXJD72uXeKI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgIy0crc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgIy0crc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2350fc2591dso43382375ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750750793; x=1751355593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vndS9y65s5slLA38GHuD2QBPQdLnIDM69Rf/uhZmGyY=;
        b=XgIy0crcwqp8uCjdSGC3QrGu+zAI2R3yRFePwv5Q8lS0WKRwMtHedGm+8u+X66Es9s
         ygWQmnJ4INNg5imNofLwzjF0R9dk6MbE4PROlbTTglV4QuHqgk3oRQKuKIOlbxxxUr3B
         p6Qo0EW7SEje/tZ254ZNcQXccp2YJnz0qBKRUKio1WidDh8nPZPjSa52z3kbEble7b2o
         lPvHwgWIcTEPQwFch03jNrwbDlmd/Rw+6EXz7Ut0bNbwoTP5ZIsWjtqqyTcOo62537rt
         4Gk12jKJoh8gzpNqWwJteMGeuzpmNRO8kuZQivXt0j2B826dP30r/br+W8mBknVImGdd
         AhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750750793; x=1751355593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vndS9y65s5slLA38GHuD2QBPQdLnIDM69Rf/uhZmGyY=;
        b=wlfu/oeGKW5teTbKk46vTShBdOOZxmW9IoEaPLemJ6GE0ddnYk1PYsEXUMoekNsRTx
         StCTt5jw+m2MOE3UafKs7WRedd/hzBA0MQ7s5HM/8o+keXy+Nwx2n5Wqdu8Wh3HINyGN
         xtZFWNDON7o84Nk4JFkRNX8nDqVLIOd4mSynhDFFYvCBkfzpZjbJ8GPQrzUhXBOcQuV9
         3dNLYX+g502vGyJDHTbZkMhaMeMUyHtzbHSyb+2fmP1gdUF4KpBH001nwIMDqteEtemV
         G2Yg5hCzPdLWCnKrmdUNdyjBPEDi+mVHDuYAJBkjQiiLmVp809Pjkk49imUU3ls3UQxi
         ZFYQ==
X-Gm-Message-State: AOJu0YzAeu23Nypufwk8mwqMwudnFhnOwrzWkN+6w7YatF0cpu72fWIa
	x0CMOKHhPQMR3RR/x26RJ/26GjfKKPMyTv0/SHhDKWCIZXnUpn2mOBcvjsdDZA==
X-Gm-Gg: ASbGncuFIpr95ZwzsZPaC111HXA1CsePGdwbvlCLZEzEhzsXEY3z39c4PUP0VbPe73R
	LKOSzpKWZmrT1LZ7OSiz4HM8UdS8mb8rm7RJMLS/j6Sd8DZjtb2kU25Sl3O4MLW7G16uDzKYUcZ
	oYsDLiY5j77oISrmAjlFMTSNvyZJUo5TACX0N+Re+PIKsfNTx60Qg6PuAqcnPBszk5hGxd5n7AZ
	Nvy5eBpLVBTng73wdbxKaT10v+STFFWGf2Q1ZsNJJG9u2Da5/agZzV2qHiYWYgVtZb1fdyiU/He
	BWofZ5BOo/hQQbiwEjAbHoxx+Mcq3rJo3vf9mv8vAAbuuIMqMA7Je8xgj5u6MfiY38SD
X-Google-Smtp-Source: AGHT+IEcxGPL2PtwIDA9kjLdHWK+AqF7ENR+epelGL6jH3eyQ1XWaJ9v+2Qv8XXFcg8/BBZ+ApG8Pg==
X-Received: by 2002:a17:903:b8f:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23802471f97mr41358355ad.12.1750750792812;
        Tue, 24 Jun 2025 00:39:52 -0700 (PDT)
Received: from [172.17.0.2] ([13.93.150.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d866b5d3sm103072185ad.164.2025.06.24.00.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 00:39:52 -0700 (PDT)
Message-ID: <685a5648.170a0220.87390.b4c9@mx.google.com>
Date: Tue, 24 Jun 2025 00:39:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6206763613914317000=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] shared/bap: Set stream to idle when I/O is disconnected
In-Reply-To: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
References: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6206763613914317000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975123

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2596.17 seconds
MakeCheck                     PASS      19.83 seconds
MakeDistcheck                 PASS      199.48 seconds
CheckValgrind                 PASS      277.04 seconds
CheckSmatch                   WARNING   306.05 seconds
bluezmakeextell               PASS      128.05 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      908.89 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6206763613914317000==--
