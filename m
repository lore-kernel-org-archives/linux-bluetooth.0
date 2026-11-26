Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706040;
	b=Rp2xCtYqhD/gKfdvtBlNMMeG9rmAADynhp3vw/9LzDn4iVlgLn0cHOBBwutwQR2isL4E
	 4xSRs1X6GIJV6iBp3eHMkWnA5fzCLt3ObCGwo5lobmoe33xwj6mCalsFBXIdjRKr2AFtm
	 wLBCfjuk1Oluv8qxcTgo9aHlxit3JbmjVtS7S7x6NX/D+Tsx+Zq25ojWPUyG9d/Fmartj
	 BjQvN2UAJiToDiOlSJa5IZEb5w72c0f4nMA6pd+qcbuVq+ZGlKEfPZiBFL1FtLu8ycGNJ
	 LF1C+cOiEYfKX1hFyAdmi8MXvzmpZNTShMI15rVpNZR5/bIk8rrKXuXXjxpqiQjk9jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=KPtesF2ZpxZPwjHFF3ie6s7gFddOIfvkZCWklHApmQk=;
	b=YQADyq2IRlc41SMHSbPTBMWtATcy7Bd4P+leDFwhonn3hOxiodktABi0HXDvArIwwv5I
	 lVhOUOw8iGYTx8R2dZfaTfGA1bR2InLTurTsVr3+XZnabY0VwdcF44i5Mjy+at+A4u4AA
	 5AhSUkJDd6+ojxXkaROnCTGyI2cimBICmvrzKBEudtX6vy3+vZFoxHoeOVtQbW8mE/79T
	 KfUDB7ZXZbXkZc2fXniUGJaT2ZN9IO8pBMWdexchc7Th8cJmdotDLrNFLvFrKcB6DXon0
	 S3FBsE8wLId0+xTVvTxu6wYTBwIPNvln+bFVRkaIsvWTTl2qEs1bpXAtKSMv2v5+Ncg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOe41pCL;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABC606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 15:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FABC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOe41pCL
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b546061d58so16357708c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795706039; x=1796310839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KPtesF2ZpxZPwjHFF3ie6s7gFddOIfvkZCWklHApmQk=;
        b=aOe41pCLl0YD+r/nk+T3SgWYwkN1FZSgy7OYunKw1UD8wnK/26JiO8gwwd0w5aDrMS
         EJmBoed/uIMoBKOJZ6eOoTbDvhvAeYl2khuiGgRpVeI3mE1gAEOIPJJFHgX0e4qnndyb
         DEn0qlqTiYg+FMq+waeduLzpTIRzQ3Tmt+h2SmUS0gDA1vonTToilKMFeRWNT8fU84eM
         5TM5DzHWmnOfrPtnf68jJl6wiEUZ8cAT53gX6OKTFZa1EGsa5G73FbrCXhrfilKApjMG
         xwOPAWQgG+6PSMDqGHnbO+irBf2tDU1KGdiY3FSDSS38L5SHXdURo/6Wbx67tqGimmRc
         Ijtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706039; x=1796310839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KPtesF2ZpxZPwjHFF3ie6s7gFddOIfvkZCWklHApmQk=;
        b=UJGnrDnGwW70Z8R1eQLaiRU3o26Gsvihz4hVZ6NStjT5b7y7L0P8FoB2rVclb+Ofi7
         d9n6AfsEHMCa7p3pGHxTl/epkY+xjX3sAk5Ou59mz3pLh+3isU/sVgZAr0MJQiUbRUgv
         DOrL7aGCPyOBpNFS0coFh+F4Z33i2r1utfiOBUJG+06gBzgnl16aaj0bBMEh6KKBF4JM
         oZC8zDDpRNlq674bDdYyLwTjiW/Hx1LruhYSQpr7KyPRno1N0pIGGjt9nsUtGX/8qUNF
         ajEspU8rSjyPn9ipOOvM8SJEhbaJZoQV5MF56HwXnNxSAVzUHHoqltJDNpdnHKivDbOo
         To3w==
X-Gm-Message-State: APuU4Z9mJTWFy8nY2WwIPYvF0Y2t6qCzx5HFs/OZIO+WbuIlfU73MyQw
	qhFja2vhbZ6XM02FYrRioY9a+eUFddcOzoEwcLNqKmeBUtpoVzP+/jmhaIsj7A==
X-Gm-Gg: AZFdTZfWi/ZoAeO5xS0lb3LbIEhFAnZD2na/nK1aq7iBtc/AFzGBkrtLYdrQdlqCwvP
	/myq7+riCuMkaB0Dd59dJq/ZO/h52mZVJG3cacCtEYxMF57SWASTp8Q1Tg9VHGgjXbVPPG9Jcan
	+spzh8pyX/7i0pbjBEgrfKqbJJEgpuR1MjpNohD1MWpK2yzhb77JoRg8xG1e7PT0WbNzxCY8gRs
	FWWD5/FdhgMTszQJ0TwS1m0E1DxRK1n+QJdahSdj31oAs4QvEISJk+IZ/kMu8ROWeap7DKUNvQQ
	M9mQqwT/dK82qi0AMDwcdaSrv2SfdBkAdlegnguzrt2R9NYs1UCoCJEw8i8zkK12yio2SvFji9x
	9wOcONaySiHikudLDHls3cV+CauVgfTWUFdqRQZ8Mxq5ljfxRD1BNLG5yNRw8y9RJl4E6Qo4I+J
	d1sxDb//mktxLBFQYPqiEJGhaVYaou7LMqvWoNrcfj9JOK0ySJd5NfwkfKF4wRrJd+XbaHFs6pY
	CP4ZaYANNC63NEGUU7iauH9J4hHDnl/WjRIua7IwR9vepmXGHjkDwyMZNrX
X-Received: by 2002:a05:7022:5f08:b0:1b5:23eb:530b with SMTP id a92af1059eb24-1b5568de6e7mr23717017c88.23.1795706039552;
        Thu, 26 Nov 2026 07:13:59 -0800 (PST)
Received: from [172.17.0.2] ([4.249.21.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm114187293eec.3.2026.11.26.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:13:59 -0800 (PST)
Message-ID: <6b084cb7.a5690e37.19a5c8.8670@mx.google.com>
Date: Thu, 26 Nov 2026 07:13:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2789738104846570313=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Security Level reporting
In-Reply-To: <20261126085211.80204-2-frederic.danis@collabora.com>
References: <20261126085211.80204-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2789738104846570313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223119/

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      1.14 seconds
BuildEll                      PASS      16.45 seconds
BluezMake                     PASS      235.44 seconds
MakeCheck                     PASS      13.84 seconds
MakeDistcheck                 PASS      121.04 seconds
CheckValgrind                 PASS      292.44 seconds
CheckSmatch                   PASS      242.94 seconds
bluezmakeextell               PASS      79.17 seconds
TestFunctional                PASS      1023.06 seconds
IncrementalBuild              PASS      248.46 seconds
ScanBuild                     PASS      880.04 seconds



https://github.com/bluez/bluez/pull/2933

---
Regards,
Linux Bluetooth


--===============2789738104846570313==--
