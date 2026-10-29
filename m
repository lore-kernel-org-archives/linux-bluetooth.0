Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255523;
	b=zVihDIg2/r/FWXy3h9WDycPrJv423LQiPUgrF4A9s728Uj3ubLOyRgbj+gxUDZ8ZqyHe
	 YZ7Tc+fuhZmTPva2tezlC9nYBZ2aNrbz5ZAvRMC4RArphhbb+bmsRZkU0FqHwy4uHHbFt
	 NMDOXEFuxHUlUON1yzmZHuuN2X3O/AXf08T9u5qhP4dL/DG1GLj9dL6Vvz2mUdzVYwTis
	 TJVPWYBZPYirng0kML6XG/DzgRlfRK+9Qejcz0NHeH1BVnpFJpb9jpfIsJ02WJdELYxLK
	 svCHHw/JXdcArNWlqhdnh8Hj64Qg1Lzi1PKD2ms7TnucbZgmMOchhuLU8QfU+40/onw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4l2Shb7pAzzXXI3vKiUZ8TphLZSHEV28u7NFjHr3bOA=;
	b=trh5eYuSA6lcMZecqgNkMpro2s+682WyF+0zJoXTsS+MApMZ7O9mjN+Nb1zJhafkJor1
	 jbcTwEIF7pl4/8hW2yMNf8h8GggljH/vmDbohLVKTYSLxWHghaTF2Hy/Bhu13FbbMww3R
	 2fTrlG/VxegfGB40zVT1HotyQXUV2nL3QYz+jRki74KdPXV18YA5m5+Yxd/xx/MiX/u6G
	 wzQKHCDHLsQiRO5XBjtWZTefOBcPSrpdg+xdD0vix7Esm9CCUoCo2IdmlF4YAVy3p7vn6
	 WIiT+bnAERrYpilx8t8AnQcEtSzV046GQ1tr7teTcS3qPUosWpxHtdqFcfg93g7cjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WAx6vmyl;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD739606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 06:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD739606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WAx6vmyl
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3624672eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793255522; x=1793860322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4l2Shb7pAzzXXI3vKiUZ8TphLZSHEV28u7NFjHr3bOA=;
        b=WAx6vmylAM58LfcOWITr/O2Sxu42wbmlEKn7u84te1IcN7BlXe9hzv75Ff5tv8Ly4l
         vKXcczFbE5tvlvuYeCL1qbsIbxwld+3UI05NgeC5ZkhPqb/voXbOdYSYZ5pM0oU+9/SG
         jKZ7NGrkIAaWNcvE1T7Dcm0zCr/FiJBNRaLsHHjol2OpUaEfdk6aSpnbu5xgrNPmjneS
         KJdBWcYLjigVXGpf1ujrs6KC7PZb3EiW4L1W3iznczh8gJAv4rjAT0a0nyfBu263EdHU
         3s6ErT4an+8+mt7a2XgHZhf6jkA2OP7FjpkJOCMuQ/aS6DVye+L7rthH4igi1rZQZYXY
         rQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255522; x=1793860322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4l2Shb7pAzzXXI3vKiUZ8TphLZSHEV28u7NFjHr3bOA=;
        b=bXaK8cuAKWH3rR8iXu0PGCGmL5stOfJgycqIsvT4Cfuo6/exv6ovURXWoKdkhJgg2O
         mmPaCJa5/yfXPN+0qY/Q9Ty7ThlYmGCFa8Obpr6fEi1ta8aTLS/qlOtaGCgHBHOBCBnL
         neQ4GYWU7iywgLpPtdhk0Tghv9HXfhtPdGyi57I5LhsMhBp5taQWGaFbsJnzExZ9C0nC
         Lc4bJMoyNSH/SV0JvSTqrmBF8TVaBYGvFMURxRaY9Kk4lVN3XsBChTlZWaIM4g4JR9Zm
         Kn3Fm266f32pZaOx2G376XYsCZtWE9LloPrqBp+FBjnheELAjRef28R9/7264x1usQiE
         p+NQ==
X-Gm-Message-State: AFq9FYKogSZX/qXUeiKW8i5alHUQq1Ulp8Bbh5rNZ45Kkrjkh0zU2gj8
	42fdRpVtfL7bIPlAHMKc1HIzZaw6IAOQgNn6QJ1lrjbWiuwij9lG6hLWDeTgcg==
X-Gm-Gg: AYBFou0vJbZfMOCBz4xs0ImzPbCNB2I6ficrRsQIXUlACk3gY3A08EvnboeYKooPA3t
	XkzwLOYtueD1hxgnLM60gfnhc3SYe0XYF+/pqPJ+av34ff1F/ePOAGBCdTdeZjbhxKWxcTSuWlf
	pgrM/JlZrhbthBEQ1gwSFfhaw2PEXaBFKqlIqT5I8+Cj/OaW4Dpvo4esbaQFE7alR+FQ9u5CTkN
	gvHAgalT96UkZlU1sujLAk7XCC3UiYUIq8pCHVendpyG45EHC3uWD/lyvjLmxRO/6ULnO+P4jWa
	hjq3K+A/WNiL6YKfYSlvwpNXDfWoYlt+gOtgPQk8cCx+TuZLNd9d9FM0gCjlmjUaJZV2/eDys3t
	5Z1I4j87pVYe/z6LGBfjJNIKy0chAYYwHqcXmO58MN0A55hbEdfmYn0VesnEgQ4EfkfoZlPLtbR
	wLm4WPkqG6nnaob92jS1oucgv6sK8zkcAn1jaeMWQjDPzKa8F+rQG8bHa5pbDOnx3Z5V5WzvJYB
	9bZ8OUHfcTJXPaucQ89WzzEEtZ/Iy/vyO/Jtk/GvyX1ea4Tf7HLqZbTe/Fx4kg=
X-Received: by 2002:a05:693c:401a:b0:369:f05d:6c5c with SMTP id 5a478bee46e88-36a20477909mr6681996eec.28.1793255521641;
        Wed, 28 Oct 2026 23:32:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.103.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bc445sm12873272eec.1.2026.10.28.23.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:32:01 -0700 (PDT)
Message-ID: <6ae2e861.a8e1b8b4.220193.0d51@mx.google.com>
Date: Wed, 28 Oct 2026 23:32:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7721785230641076431=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,RESEND,v2] asha: Notify connection interval changes
In-Reply-To: <20261029002158.1036153-1-cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7721785230641076431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195805/

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      16.24 seconds
BluezMake                     PASS      232.23 seconds
MakeCheck                     PASS      13.77 seconds
MakeDistcheck                 PASS      121.26 seconds
CheckValgrind                 PASS      191.06 seconds
CheckSmatch                   PASS      224.01 seconds
bluezmakeextell               PASS      76.37 seconds
TestFunctional                PASS      952.36 seconds
IncrementalBuild              PASS      234.42 seconds
ScanBuild                     PASS      829.04 seconds



https://github.com/bluez/bluez/pull/2733

---
Regards,
Linux Bluetooth


--===============7721785230641076431==--
