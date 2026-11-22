Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373878;
	b=y7iSC/Cgo0VtqeVkR3g/bRZmDb/E+70gXfrsApiZ8Jwt1dMsEcweYnfjxsB54wpgdMXB
	 tGSa8t6roZHkjZ/mb/P1E0T7c/sOuOV6KbCsQJV3+PpOt/7UXWlqjIQ0o7K/knFpQxKJc
	 n1jfO9UV8YK2TPYRSuauyfHdL6D4iuVcF/TMZN1c0z+NyhFMo1Be85VvnP7+XpbcMw7rb
	 vBILJVob6FYUE26qfDEEaQZJkZg33ahLtYj7PCQpMgzycd24BfYvjz5zh22tB1525G4v7
	 DfvJrnVg82U3aNGGn/JjryGtfn+IlprQhAujowr5xA/Zde3HXD4RNx3/L6Qil2hnQ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=eLNy8PWXpAhcBJoix1zzsDDBNpAFTj0B6ISncnN2T5I=;
	b=sME0RhV8oypVkGe/UTKwnsdPdInNIoiNfbhY1ntEh6+PzdtmXxwNIONLGomOpHcvId0u
	 KiWUtTWP6muFrjhdQy8HP+rmx3E0myTY2A/oRDe/kCiEfBAVrmoNAgmQcY9PsWCVSSo/q
	 8rgpkumMdczLKkDSol7HmRbpf+7daRqDzxRVpO7W3XPcXA7bnGzTFvjti++NBc53RrMJo
	 gATMeeD30LumPN4Zgco+nuETOsP3WHRtVKT5z/hd0NxgcTD5jHfrj/cVzr4udba+7qhiQ
	 3Wg0q8svyhsbGBrVKKTEjCZ8LhXHgZwAJ/kJzY0EHoYrfSM6qwIDQCS8dsh7MU+L/0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXJPczzm;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8194606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8194606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXJPczzm
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38699cf08dfso2079586eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795373877; x=1795978677; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eLNy8PWXpAhcBJoix1zzsDDBNpAFTj0B6ISncnN2T5I=;
        b=IXJPczzmCFzznZhQ4fMKWN4WaPGN+RDR3X+cHJEGmWeWKhN3vlooiiYX3iU0VzCTbD
         mbryyDIDUabSvN+uvUNk3X4YXugqw1wNvABFjDIPCLjEmzSbYxi00y2W/hTtI3gsmrPO
         iKwkKUfmPOsALGspUaMsHLblqOrZSJNc4hw+KftQgMt2E9/NAj+uwBe8+DrNAVKoUFKN
         eu55okNk7V5w+FTIizWwKwsmNUCJY/wib1LFuIX505393mvYfvVNFBl6MG7sc/ANwe7+
         NncPJILW1GQlX5RzWPIToySnBMaws+1biI7Qj/84DCbjcX83x1UC6sBneuU8ZOz7wOsl
         0jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373877; x=1795978677;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eLNy8PWXpAhcBJoix1zzsDDBNpAFTj0B6ISncnN2T5I=;
        b=RXH3CwiieUyRMJt75CzkTcXNgRkAaTyjKYpooW6AMH7ehV1539HvvFuirXu4woNiLE
         wxsbGKr+i+uTiibFCV7h1aSeviozCNkmYNNUrVBnaaK1JU4QfJdk31WctpsOOm6Y9JDk
         Tup4+d8aaeIo2rwTGzm0WLjO8z5xR17UmplbsklR6UITeQe77M3ePlV5mbzlduBJVvD9
         nkb46lpMJ6iVKeKZXdchmuhc/EKd15Ro9co2y8a9GWRiy8QA8/8jxZ4YwCeFA37ZCf95
         5jvgUKmMNxq9FLjbrqLryqRau9/wQ+dBqJ0zDl6lBQ8cJaDoehH/KELh8RbSCrK6XIhm
         yLHw==
X-Gm-Message-State: APuU4Z+XkstL4eH4LpihzxpSKFFD871ooxogvVjuL6lBVVy4sbjbC6zZ
	a75liDPtaabOEUqJ875ad9KbQ+QpJsHssqjrPGeklI3kh+DO6C1MNQ9S0HpsW1cc
X-Gm-Gg: AZFdTZd7sCqP6rMQj5/+1B6QnhA6VHmK+JWGa9luFV+PLoT2dRwnxDEgij9U/hFFFaf
	/NlgLYcQor5U7NtTF61DZYsQkgRqj52hi+9MibRjKYpsDpN8GSL4X5lYbSoP4ZSOC5ZMHZ/ndUK
	wdAIaBYEGJ+7EuTNiEqXaYB5DML4mLyIcotxGoyybW0cKGjdFEwvBvHL6wMIPaqRq6roz+o2IbR
	TvYkqa6f9da0qw6srw1mSt77sffl45zeYPxOkF0EI4lzVlo82jd/E6igRQw1XllsMcT7iFq6Jit
	k2OJPO8RZmmXDONhYWyR9QxqeX5vTnoFDpCiPyA4W9Ry/26fu4/EiprJd2KMRYPCid9cp86erCK
	AFfeaK57Yx2+VYGs5ki+cwuyWkjbYWaKSqkBK8uxtMJfmdro76tG/Ifn4tJDp31ELpnQ+DUx3zY
	7MlUTDNUaKvJKXiVtmdIH7vqWGaPAni2M9UeuJGb2PYvE3IsOJc+nR8Ws9G//jifIwnLbnxH5SO
	55WDCAfBL213oPdDjgGQq8hVn9e3kSLtmdJkxYqfxCu6P3yBtTSKDOzYoucM3rxKj5nhq3AlhTR
	BXfOAeQ=
X-Received: by 2002:a05:693c:41cf:10b0:386:ac97:f656 with SMTP id 5a478bee46e88-386ac97f9ffmr1640364eec.19.1795373876928;
        Sun, 22 Nov 2026 10:57:56 -0800 (PST)
Received: from [172.17.0.2] ([52.159.140.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm31393125eec.14.2026.11.22.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:57:56 -0800 (PST)
Message-ID: <6b033b34.f2313814.3bef54.8e80@mx.google.com>
Date: Sun, 22 Nov 2026 10:57:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1122578291565343438=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: AVRCP browsing fixes, and browsing and cover art in the target role
In-Reply-To: <20261122105731.799090-2-simon.mikuda@streamunlimited.com>
References: <20261122105731.799090-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1122578291565343438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218578/

---Test result---

Test Summary:
CheckPatch                    PASS      2.72 seconds
GitLint                       PASS      1.84 seconds
BuildEll                      PASS      20.84 seconds
BluezMake                     PASS      322.32 seconds
MakeCheck                     PASS      3.41 seconds
MakeDistcheck                 PASS      156.39 seconds
CheckValgrind                 PASS      167.46 seconds
CheckSmatch                   PASS      320.06 seconds
bluezmakeextell               PASS      103.13 seconds
TestFunctional                FAIL      1305.24 seconds
IncrementalBuild              PASS      345.38 seconds
ScanBuild                     PASS      1261.30 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2871

---
Regards,
Linux Bluetooth


--===============1122578291565343438==--
