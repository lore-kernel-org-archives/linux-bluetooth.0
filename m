Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7D172761
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357275; cv=none; b=ZQRZFFSFBQqR76/DTxuLoYHXF93KFsQWrCDMZTPdsoPLdCHJCFNKrP4mZ9+lWuFpC/FZjrV0pqiJuyDC9mwsK5pSDdMhEvfWbVzwjCaVEfqQlLZxRsKYpA4BP5RbrkVuA4N1AaPK475LuB55LI56fFXXoG/uvQPW73u/gqGIva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357275; c=relaxed/simple;
	bh=5rg76CG8la8TsIAaKq7zxGWfSuJABhKi3Xi2MatBqY0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TvAzz8PkQTHUBlak+IrpKPwoWDbwWRlHjJjvpQrHdl+HKm3KKp1QrHlD8BhNeFMHlrAfQEIRjqeTfJOC3qyxHImEe7tOzyQDiylapXnJO9uQ1YkAxA5eQIfbee29KfoEIiso5DUC0u1UXrPuIr0HEXrejt1InYNLYHBeengLbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjCMi8PF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjCMi8PF"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8d31702so148860085a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715357273; x=1715962073; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5SAJ2nPNWckVsbrPyZqyF1TEKHJG1Ry052MECKLQmaQ=;
        b=DjCMi8PF+ixY9YuIdz2R0W50wJQiZvGwb8SLyuy1uxYQtTHTdAISja2FduVIXCriA4
         JOHY03Sf/LuEKieKPfz11XUSXclP+OIdt3n8vk29xw4emQ5pG79ZOF3pyCwP0r74n+Tl
         tmkEMVK/tPGEHN+rP6XrWFnt7icjjQ2QOJzkMACoopTORWNn1J5iAQ6I4P5caIuV+3aX
         rjtcDPFeSgw/7gpS0SE4XwrtjSi1GNPFmIEuIBYRETtFgIzb2nEQD9O4kXSRlO9Ulw4J
         f/pt2KvHun+3KOzP1sfcXc34/k3pyn8K5t0jR5imz4CRrlEhi4AKEq8v+B7Vvyh6QEvZ
         7Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715357273; x=1715962073;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SAJ2nPNWckVsbrPyZqyF1TEKHJG1Ry052MECKLQmaQ=;
        b=WiYwAIPqA8kNRt3RCNB3ClnwhpAsmC5xmRKT/GwkXpTTHdTofizhAdSu12LGat9J6A
         wJQ9kVMv6we0eQU3nxSOYpqJyqWol9IR1jJeVJANyuvZskMuUdUjWVJhscz25SmhwpPN
         3ulqqJORVuquouk7sSDXIaFiN7fw/WYDFpcMumEWHG1Y9CsSPSTcSRj9/S4QUJ6F4h/M
         bEGD0JgjTMOl6RBGEljQjN0xj/PAhWIaYItcvYSw5OPBT2sACL/VTzvfercUXa2ph4LM
         PNkQeZBuiL1AJeImiPct9wHJMNMLKSWD1Apu9VOsm/1HiJDsY7iWGWN8q4arA7LoLec6
         k0dQ==
X-Gm-Message-State: AOJu0Yz3HZLjrOYicPdwwShMjensOWfkRP4g+teybmMv0DJVITrQbnJi
	mhMZqHFf6jeutcCWTJdglRPsBJU9PiFvaabEsrqCQDmGupKzrsrLeN9lkA==
X-Google-Smtp-Source: AGHT+IGj92yM3iX+KswAPIHJyABAuLuKHW4ZzABhIh4YTthNR+yj4lUTkaeMIGE75INoV9pxVp6GKw==
X-Received: by 2002:a05:620a:3882:b0:792:8fe0:5df0 with SMTP id af79cd13be357-792c75741abmr271781185a.7.1715357273339;
        Fri, 10 May 2024 09:07:53 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.174.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf340b32sm193145785a.126.2024.05.10.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:07:53 -0700 (PDT)
Message-ID: <663e4659.370a0220.f89b8.5df8@mx.google.com>
Date: Fri, 10 May 2024 09:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2044277330375959324=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Create transports for matching BISes
In-Reply-To: <20240510133504.26047-2-andrei.istodorescu@nxp.com>
References: <20240510133504.26047-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2044277330375959324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852298

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      24.98 seconds
BluezMake                     PASS      1732.41 seconds
MakeCheck                     PASS      12.82 seconds
MakeDistcheck                 PASS      176.66 seconds
CheckValgrind                 PASS      246.76 seconds
CheckSmatch                   WARNING   358.33 seconds
bluezmakeextell               PASS      125.08 seconds
IncrementalBuild              PASS      3178.06 seconds
ScanBuild                     WARNING   995.02 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:6522:22: warning: Value stored to 'match_data' during its initialization is never read
        struct bt_ltv_match match_data = {0};
                            ^~~~~~~~~~   ~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2044277330375959324==--
