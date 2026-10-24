Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820100;
	b=WuW6kVuA/26xf6CQ/wJfsgQ5HXheytDa3tXmZRv7cVx+08QmkCURCan5DCcz2QgxrEtv
	 cYo/qSmRrB/zuv/vW8pvmwgWtCQiYdhC3GMc2/H1NlY3EwnQSJFGO5eq+EpLS0fjlOhHp
	 HbLxpMZeqcAQVlHH+0y83GKxxxSK89sNsMlGr0TF8HHYuwMwA8IpKTgfGX8DcxovL7B6g
	 SojGxPXxkuSxueNg6b0GC2bw5vctI9Qw15Bd4KboHyhXVE4P7wuKjC3M8YQpXAT6QhVbC
	 r3Do4FZclSFTv7LVS4fIPJ/HHPk8GNmDrRxgOukniwq8/oOjFqtaYxQsM9XS6o9evjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=lFfNxrCnCCifxWkCYHfU/dJ+/neKLYXQe2fyjfdc+9k=;
	b=d3U3ohQhy3VuLSwhN1TzO0FKhqPtl9/8lH5/lS+tStoYohfQeFMIaL5dzNw10ZRsr7pM
	 TkBonzM8KHpRUAPW6jSjeB3xq4v6Lv9Zvi21kaQTH5TpME6bHEPHcnzbBQzApnfNofc6P
	 C3LeOqEa+3r9++lx3AQYiUqcVnA4DFIrDvBAzs9b3V8AKFZgsGbWIngNuXydTIy/3zcef
	 R03PltHB79wEdOox9XtQuHqoWt71RZa7URY9s63T09jwem4jD7gZAlQ8Zk5qFkv3ur0Et
	 uqUS8RII4shnXw+xKG5kinRmmOWZlPDv8CTd1nptaM2iiqA9l60N/yeT9eHZdzn724w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sG57AACu;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782860A261F
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 05:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5782860A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sG57AACu
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-51f2e9e6987so1486260b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820099; x=1793424899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lFfNxrCnCCifxWkCYHfU/dJ+/neKLYXQe2fyjfdc+9k=;
        b=sG57AACuoiL0uWa6Rh/ZUzNC6+v/GpRcl+q7frhtvuwf02he4GF4kpl5IM7+4DhIK4
         W4iynaCMdfcU2E3vgpSZ0ZtW5vScd3xtfT8JaVU24gO707UpZWdmBI5SjAMRwA8d/4eT
         0fadMwmtI6CFDBTf2rYSkpN/BGxfNsFUOjVwjgEyTwh1kIf5e5IvBaMIcbycg9t4XdyF
         R974n7WettCn7FnZ9wZ+nptp1mhbCGZMfEgvQGfmaUUeWbizRCyww+dD74c2ld18P89N
         JqtM3Dl4PBQDmDV3P6XSdBxAvCCFk+alG0o+05DzlPloalxcLdmQLILh1Nb7KgHhqYBX
         NFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820099; x=1793424899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lFfNxrCnCCifxWkCYHfU/dJ+/neKLYXQe2fyjfdc+9k=;
        b=PdBTR1tJ0AXvayEDs+Ji9QwL1gzxGvenjTtuLSjCRxMJdqtLoypRqMyLGd7PGS3sSS
         08g7mbsMW4O/nCb8QbwUt8Qr59ATSItg3fxg2cyAsaNcnGM8OkatMtb36dxx2WaN7F+r
         nDUt5lzZB5w2xePtCnAXX0WXjpZNhAONaPRg9exf3C+lGocX4BT5S/6HWDCHKEth59l0
         bw0NLZccuTm7gNRGXblZLcY+deXtcoXKSguxZR+rqHwkeeHmxMqHONSrorjFmdHfoxWJ
         bctsqGfwjlxLk56Nbtg7SnVeJ5rwtWvvZ0Nf/DhTL0nBQnaC6fzgFkaf6r4oEHZROcwU
         liIA==
X-Gm-Message-State: AFq9FYIyE7alh40fJFwV++a7h0q3pMixC2FW5xuiUkeCuy0NHxATB9Az
	kSOgapXY0k30ny05mdSyJ7kx+4tVjFVptRtvhTB/zYqFLzFjTFjJL1pCS7QHcA==
X-Gm-Gg: AYBFou2qhekaSg86L3MdVE+YKDN0yHZ/w4EErfEQcpb0hTjSyKWLAjMaIXHi+XXmjUX
	DkgBhAbdrAe/xql0EeLytuDa1GWsfxv3xPDcHQvyQ6v6/G1M2py3DztyTdLaQQ4gq/JXnyaJA78
	Z89g/6IMCMwyt/igAqmKnitQv6itkp+ex4V7uNQHP6gO7J4dM4jDOrNROnjDL9WuhTHgqS6U566
	M9fkrkwwPeclUo5lARA7BhTBzKf2D5ba5FZZSTz3T8pPC+dlNZIjDDgJGFXOz9wOTxl0m+f7GHA
	Okfk2WRzt5NecLLLUmbclcENlhSZYuwG4sVihHdVSiFKWslrg895GynM4T2zU0qGSQ9T/gHBIbW
	yg9FH7+2bvcu78mGiUReSlLOVKR7E/EB1Pt7ThQJTGcMUASD/JSdx92T2bjTZJ1TlE1ui37s0yU
	ZZ8o8yKR1cDeaq/od35bkzOoIZo23s2yVgrSDfOEFon10fEZEO9+fKfZ5xTYW95k4WGY3lR/i+J
	C+aeWol6ey7JwNCpGqG/qQYq0+4wfMlGCRFeCL3kjXGS48vO8UY203PQdDO0GNTpA==
X-Received: by 2002:a05:6808:1694:b0:55b:f890:7857 with SMTP id 5614622812f47-55c002e3c17mr546524b6e.18.1792820099173;
        Fri, 23 Oct 2026 22:34:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.179.241])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c042d92f7sm705799b6e.12.2026.10.23.22.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:34:58 -0700 (PDT)
Message-ID: <6adc4382.a3c0497f.2bbac3.251e@mx.google.com>
Date: Fri, 23 Oct 2026 22:34:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4899729876078723055=="
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
To: linux-bluetooth@vger.kernel.org, turbine.bmw@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Add LL Privacy tests for a device's changed IRK
In-Reply-To: <20261024004732.57922-1-turbine.bmw@gmail.com>
References: <20261024004732.57922-1-turbine.bmw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4899729876078723055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192482/

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       FAIL      0.25 seconds
BuildEll                      PASS      12.61 seconds
BluezMake                     PASS      166.23 seconds
CheckSmatch                   PASS      164.60 seconds
bluezmakeextell               PASS      56.19 seconds
TestFunctional                PASS      782.51 seconds
IncrementalBuild              PASS      169.82 seconds
ScanBuild                     PASS      629.23 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] mgmt-tester: Add LL Privacy tests for a device's changed IRK

23: B2 Line has trailing whitespace: "    "
29: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluez/pull/2706

---
Regards,
Linux Bluetooth


--===============4899729876078723055==--
