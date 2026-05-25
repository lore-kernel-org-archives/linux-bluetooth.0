Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E12388390
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719619; cv=none; b=WgMlb2oXOCIHiTha3onsouMd/xfvALswIZ7tVEcjXciL8/UPO9Wjt9UhhqM0l27akhx6Il3VV6sgkAUD4k3EZgoWHjr4iBF7bUqXzx4MFaz2XpSS/wbo3YRwma48Iq2GpelSGCDoxOso1WJ32FBo2ODgTemJrnjtbEUCwOTapD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719619; c=relaxed/simple;
	bh=ptJZF+B4V60zYBCk7Qn3F1gq6LFFKzShcRtTcBzVZRc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M2u0qDaeLFztSnfDxxwgmuGoUDUuOuaLQ9ZdDWEzwXr2MbxjOef/fBKGpSpm+6Ugj+3Q6TGyoyYpDPKPXc+ox2T0gSVQ+rpukUvjsSAfuf5abks1GBcMHu9e7TfYasbELc78stY6TZBXYSxh3IndH3W3Pgtt+AXZ0ykoN+Qnngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et812aot; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et812aot"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3045c195251so2652010eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719618; x=1780324418; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=07+Hyi/6H1N+ZwT8eNXbQAcIkMDO2tb0fnqOmetXYU0=;
        b=Et812aotYd/TYdKG5RkiL0EDLR3GzPHJxi/E0Bmx+wZuyJ1cnc1wMD2BGhoQh4vMvK
         +OLW/s+Yj0Sh4ujo9UdZvTjPiJu5ACRk1oMIFD34edkcqBNqWy5Bfm6Ri5OG2t5LxH7v
         2UXOaQlcxuMnLM2J6e2KaX9fsCtmZshA4kg63C5BhaDPhrOYFXLoEB9/uU+J6v9runKW
         8MCXK0ORYxZilm+SE4oV0n5e9Ghf7i5jbkXwnHkKOYAC+NMd256E3VcBflF4v3UrRjKB
         FoYEay2LYxmjq8lzRMPcMRg8JG2PTlMe+kRt4Lvfs6lM2QdpUL5ImAQkBF4QiNKEO+H/
         yS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719618; x=1780324418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07+Hyi/6H1N+ZwT8eNXbQAcIkMDO2tb0fnqOmetXYU0=;
        b=a3c1x1qJyHvAakbbuAM4nP1YPCKEVG0348E7j37DPpQUpXnGnJxh92YDEpsnas0+d2
         jz4OX7z8RQT4JWUEe/kaFYvP5YGRtD72joiPFHIOz+ZG6wdS3xg+mRDvyIpaHnZX0Mdf
         FA8eq1XFkt32zCOJv6kJxY/twrWHf3LuJYr9wieQubTxwhsJ+H+DvskSP3ZqIaZFZ8ea
         gE8ewRqTgZ3OSwnGOhMY/ky3J3UjsLrLB8IobQYsecu3sfrBFZTBlAHy3gUzyRpBeDAk
         nexIfNITvzZAH9A4ADSJ+U2mNrNsF1/6gEiuwoDGIf3GIT9vdktB4tqUHUatGrlw+IEs
         9wkA==
X-Gm-Message-State: AOJu0Yymens1p5RdfyMfBXv1rwwcX+OWoeOhhYFR+JmOdXWKzOzZNPPc
	ip4ajXU/WvY/fapgqoPDuWQpxFzKPeIXLBSoOZ+Omq8wYff6scgrHBCciqeGnw==
X-Gm-Gg: Acq92OF/xVZfdOP9Dis4nAk3KB8S18S4RlFNw1Yt/YzIw01QlK4B//ByBxZ0eE4Rml3
	0JaaTH7VgMwYYZSBGKoZtSvHwNH0lUpfXXNwY7yQ0wmqPV+VsMl1vKr8EGgOIUc78RuyMJqhFUt
	/8lwqMhlaNmbFk2TeDyivQ4I0PanMpucKValYVKNqmlTmT4pEvCH4lz4ZPPcEHVom8egm7HZllm
	uaxUZ4i4NmNYMhB1WBPXNzeNU66uXpjChceDqh6YxqS+/6Achcyi9UJJkdFGdqgUWsYGEArHULm
	sTMGGaO2R5O+/bs47fNyvECQfPRVsLoNcJo7fiL+I2NnrlsSjQsOPGvl8GqoIrsKEZY6lGfKyrZ
	pFBd+lpdnLBOlQFD5wyHqfQmdYJ90S+AHmCudz5ucdsWnVhilg8fB8tnozq9+sry7KZlytZHPIN
	f8GBO7cdXnWXCsC6D9/r40Wiw0njyjvw==
X-Received: by 2002:a05:7300:8607:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-30448fd64b5mr7896095eec.5.1779719617403;
        Mon, 25 May 2026 07:33:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.141.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef3273sm10778703eec.2.2026.05.25.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:33:36 -0700 (PDT)
Message-ID: <6a145dc0.de8afdfd.4c667.b932@mx.google.com>
Date: Mon, 25 May 2026 07:33:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9010483496986016687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tarjeib@gmail.com
Subject: RE: Add configurable default LE PHY policy
In-Reply-To: <20260525113709.115020-2-tarjeib@gmail.com>
References: <20260525113709.115020-2-tarjeib@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9010483496986016687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100433

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       FAIL      0.21 seconds
BuildEll                      PASS      19.92 seconds
BluezMake                     PASS      646.41 seconds
CheckSmatch                   PASS      354.93 seconds
bluezmakeextell               PASS      182.02 seconds
IncrementalBuild              PASS      665.89 seconds
ScanBuild                     PASS      1045.30 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,1/1] adapter: Add configurable default LE PHYs

18: B3 Line contains hard tab characters (\t): "	avoid the Sparse redefinition warning seen in CI."
22: B3 Line contains hard tab characters (\t): "	configuration commands."


https://github.com/bluez/bluez/pull/2152

---
Regards,
Linux Bluetooth


--===============9010483496986016687==--
