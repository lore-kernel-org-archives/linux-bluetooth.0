Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE03D994
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881345; cv=none; b=aX5IKKmeDE7dxewF1z5VlUsutnKbBq94LKiKT7bEfLfbDh5nuztDOmGoNY5RSEfbKS9bYbMLKXT7CrmrcVQElNwIrsmtDHDRGPkQHLFO+9pR8DL3ilu4h3N8N7MKTxQcuQIeAR1dd6Oa8TFIE12M0kZtqWyAhgt+2x+cbGdz8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881345; c=relaxed/simple;
	bh=gUWF7bd9aEaVQ5bojino5541LOxBFdS+21Flso9Vhmk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WAPFPW82+M3lwDl8lo2tSKTxlNCo7egyPFHtqdQoRPPZPGqF5s90lYHoXOapX/E8DbIHTWYLfsfVkUTRW4SloVxTtgz3uK7ix2ea80C94BltQxyPLQoJBerqJsB2dFq0eSpHV5Q/3+N1f/t/zG2iXu240+cHgHUQgR3H2LVxj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7r8NR1k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7r8NR1k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bc2970df5so12350495ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727881343; x=1728486143; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3BRA9hiEyJcG5VChAheFwpCwiXP5oGshq7iRGq0RlcA=;
        b=l7r8NR1kupPMPMdH+CBDpq+087g3Os9UkzDeWJnQtha5D3kSChXhnS1oNtp5CBxg83
         AEjj4wjFQhQ9ERjoZqCLLsLd8XGJdJjAJGmIrZDn0O3HNaAA3A5TxwTGS6BCszkuZar+
         ai3v8PMJtpKZIC7yJ9cMW5wRow6k39P94yjjyYwR8p5ylf4yErdHXPTWMev5CSoGaUj6
         tFGPoKxda0WA30Ua+Tgy8qTPPPxbGhZ3Pq8szTMaP9Aq6WuFm0xhXX71AduKu1ZgQyDX
         HVsoP6GTMB1AHKHwb/L8Q+0jqaTWsa65GPGb0xNVTzpAAjcJRhXjbuXzhH/8PEyT59Tb
         tefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881343; x=1728486143;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BRA9hiEyJcG5VChAheFwpCwiXP5oGshq7iRGq0RlcA=;
        b=ED67xt6vcmcGLa+jZ5Pno8Iv/Ah7VxcqEYRkRfRLniaOTWTYy+214OoXUw2FDmh/iT
         NlGHm7CK3x+T1I/BerU/xLMM64NqqTyadKjRlQ4M65MydG8NKzZkSezXtljUTfc0Ha3a
         VtmzYUsb0z2/KoMC6m2kuEUYCZ6BQh/IVxVTuulLmr5y9TU6BmMVFgSWS/CAhXhyF6hA
         OTBC+VpVNBK2iB4FmK7MaFZ4wmoWAPkOLPTKovRcPF/LfttxK81oZvMatCtT+zGwcMkP
         NjY2lkAqyvLRorADcccxoLXO7kXkCPzPtukVds+YvlNIeoSXBk6XGgaeI0B7mWFP8xo5
         hABA==
X-Gm-Message-State: AOJu0Yz/QxbpO7KCv7KeDtKv4LoZuRdIPzOPGIcqeAr+rDDKdbIaXlwD
	QPi8UJsgx8rbvIlzBpWKLYp5ONAK6OMc/YbQ7eK2YyTYssJ8OA+L7MHDVw==
X-Google-Smtp-Source: AGHT+IGEAeu9HIqFAhdHpO8dYPqwt9VogZ0SwT4Wh//SBu2yZWqy3YkeCTntcMfo+pfM6gZr+LvLLg==
X-Received: by 2002:a17:902:ce87:b0:20b:4ee6:31ef with SMTP id d9443c01a7336-20bc59f3875mr48139695ad.31.1727881342578;
        Wed, 02 Oct 2024 08:02:22 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e63a86sm85062125ad.277.2024.10.02.08.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:02:22 -0700 (PDT)
Message-ID: <66fd607e.170a0220.51ce0.462d@mx.google.com>
Date: Wed, 02 Oct 2024 08:02:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8069680195434815917=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bap: Fix load of misaligned address error
In-Reply-To: <20241002133506.16834-2-iulia.tanasescu@nxp.com>
References: <20241002133506.16834-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8069680195434815917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=894842

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      1505.09 seconds
MakeCheck                     PASS      13.40 seconds
MakeDistcheck                 PASS      175.26 seconds
CheckValgrind                 PASS      248.09 seconds
CheckSmatch                   WARNING   348.90 seconds
bluezmakeextell               PASS      117.56 seconds
IncrementalBuild              PASS      1393.01 seconds
ScanBuild                     PASS      1012.78 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============8069680195434815917==--
