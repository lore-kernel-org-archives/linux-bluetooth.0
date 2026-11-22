Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339867;
	b=yJrOSeJrsecRbOJJ1XiLUSkvSHiTLMfB5cwnhkEb1Azg/Us0qzd/o3oSQglybfOZKD8C
	 9YRxlzIhsYYsDNfU10fdVx8RHZ4LnZPdF2+WF+U0du7mOVv+TMvMG9pgmeg9RXV9xhrL8
	 MSBqNhB0ukCYSPWnpekv09zAYsMRILfO2YdPBSMgJ/oHHgaGznQBcCtWkre8zU668SbIv
	 g36qmsY5Sa3Y28CmDWZeyEW34rxEITjOY/SXqBy0GmLqZ38d00lXh47l9/n3PvVa1qi+D
	 yJFNTVJiRAtDQVVY1wmQuLQ4UYvXqeDiELmqx9NEXUxkurvYssved2Mr8DcXTB8y9dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4DNw/kimecgVpSgXGqGa/o9pSbqFztzGux4KuZTiZjY=;
	b=MMasTg8qYg5NXFEto5mBW5Puyd82AlyVR1Tp8ijO71zOzuAkwAwjvMK3zwiDSai3HywP
	 rbjbcTpUVMpMlhLI7cyysPxsIvib5VwfhCZGCMOJQcCDNNbhD+/+D+amsnFw1C3pCfExp
	 AdNiroYvQgiJjq/Wjk/mRi3g1eUcfuEvqV4IJ192THN5SKFAU8INZK9sYr9c6lmG5OF7w
	 VttmvIjBiVMr9lubGbF3GRJ98BfgWLMJN1Hq4K1oj0D/DVsxWScWASwCItg9yR5Bbt7ez
	 Umds53vBK/uuqicrg/+AKV3xCASojaB62tzUkPn0TlJiUwuAqwHh9Jfsajyq9s4CCsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEWDptyt;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6589606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6589606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEWDptyt
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f037bc348dso19361295ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795339866; x=1795944666; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4DNw/kimecgVpSgXGqGa/o9pSbqFztzGux4KuZTiZjY=;
        b=cEWDptyttQb98YKeb74496iwQyB/t8Hc6jzGWUMoD3R50damzavkOCwnlh1Oh5c8fv
         Bni+FNW7V7f7GEejDHbOlVRn16cqkA1Y1ToqFtVTzL4ZFBrYNVq4JlaOCguogN9/ocJG
         0eK35l0apXldL7QXVuIB7nQLkvhzINH6+LNuOMYhN88AX9s6ZilcvCZbAbt6iwGkmfH9
         fhVyI5wJ6KgWjP+jI4Dg+YCJggQEeZnVVpOoEW/eJ4wfmwtCT1c+FowQ5J5iQuW3WVia
         oU2zScyvw/bp9J6XBsZgaVXMwoyZpyyEl3xHPDkxjiDsx14iLVTsrQUa8Y3GYoz9OpEL
         HQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795339866; x=1795944666;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4DNw/kimecgVpSgXGqGa/o9pSbqFztzGux4KuZTiZjY=;
        b=zIW7qIJ/te4+ChCU2H7FYmw420UDZuaNYcrHyLya9CZQFzP0thfQVQGAauks9JJ5+C
         FlUPj0XH7I5AkBYIvwwYKezCZecg5igCQRroKShnYbWXW+/EpVVsgFRQEgSu4gBol1np
         /SoDqdHEaQvF7/VtWP2hP99dpm4QEk/NuxyYr9HdTsoT/UzXi1LXE3eCZk9N0k4D5Xbm
         rxdhaP5qy7g/oasWnhs+otmKJW1Og4G1tnAIgiMhyTfUXmq1GcIPBb60Pu+y2CqwZNRi
         nNuNyd+c/Rbeg0r+1Y3hPtbEir378xHeG7Cjzw299XaFufgUB/CaXjrve/+Jvabjs9R6
         05LA==
X-Gm-Message-State: APuU4Z85XLgkonVgqAGwvtw5yqYgxzRwPFwH+jmQPq9RMtUmakwgg8dM
	CPpGBO3Gu5qPNdSKwJQmd70xxLMIHOO6+WVGF0O+3FkQVv+OUCOkwWCbrTlyrA==
X-Gm-Gg: AZFdTZd4BF/J+Sxd70Abf54o7X+wBtQv+8VVd/V11KMEjj5Yul6xMXtlw00zgsgRfiO
	mRbAZFShwZrmQkIVl8HzOzVORBOOyFv+B88FjpxWklUFvojp59ysgsfNR8xSXa8iLmBle24fBNx
	fB7jdOiNV9VLbHxhGpY5sBlvOLCXc2NGmAp/WA0RkvItjYffqlA3/Vn2TOqPALmjJPicy//yDYY
	BA44O/jFmKeBgvY/zgxPYuj0oawSR6rZzGz9MlzNErAioOk4IJgNuQbjKYw1EPJfl0ggqMVngYV
	CWbekdkXlMI0Q49ip5nEn+AvhyvJKNEqSFHIfg6ZBavxTxS6SbogujkFD2IAbWm6RiRkAYFVZ6S
	8K462y+16lHSHwRvzSkh/vQWx7we2HcrR3fBU7KmSb0GbuLPXITgoEDu9B4wz+mFg6+dnO9gw+1
	tDPwyUmnGM31YhFrxs3A1DHlMl+/tiHboM7K4VK+LqxuiUSe+mqzmuG6ppPF+8jotkd0YeRMQGX
	wn4QuVdIWgU3PuSCAVw7tXjd3zz7uVyeLN8iYYlmCCiAgKcm/jJbKDp3D65bAbW/hP47SaffHWt
	uHBMBJK/Hr6KyH+Qiyvkl/Qag71CMeafl67+dE5guw==
X-Received: by 2002:a17:90b:4c0b:b0:3b0:a38a:6715 with SMTP id 98e67ed59e1d1-3b41c95dd5emr9008352a91.59.1795339866016;
        Sun, 22 Nov 2026 01:31:06 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-109.us-west-2.compute.amazonaws.com. [3.42.157.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc613csm3511654a12.5.2026.11.22.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:31:05 -0800 (PST)
Message-ID: <6b02b659.3b75116a.319588.3631@mx.google.com>
Date: Sun, 22 Nov 2026 01:31:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4601543414647093808=="
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
To: linux-bluetooth@vger.kernel.org, emcp@enser.io
Subject: RE: Bluetooth: hci_ll: download the init script at the operating speed
In-Reply-To: <20261122-b4-hci-ll-oper-speed-v1-1-952a9c1edfde@enser.io>
References: <20261122-b4-hci-ll-oper-speed-v1-1-952a9c1edfde@enser.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4601543414647093808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218434/

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       FAIL      0.16 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      20.00 seconds
CheckAllWarning               PASS      23.75 seconds
CheckSparse                   PASS      25.57 seconds
BuildKernel32                 PASS      20.98 seconds
CheckKernelLLVM               PASS      22.81 seconds
TestRunnerSetup               PASS      495.77 seconds
IncrementalBuild              PASS      19.37 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_ll: download the init script at the operating speed

50: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluetooth-next/pull/1178

---
Regards,
Linux Bluetooth


--===============4601543414647093808==--
