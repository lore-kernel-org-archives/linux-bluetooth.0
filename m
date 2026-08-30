Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F228B4FA
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788127197; cv=none; b=J76kRfH41/CkWWR+VwnBiUTmHBVahgPsF/YBVLlJrLmpMIsQfFb6DHClKgof+ofODIwABE6CKupMc96X+kJErkvYcO9/LU/huyhbLmj7fe5Swo5Sizc3dL4QOZ1qcsRFRbCDlPNlgK4HyuvNhFWAzAH7/QwOxC/uetXiVe8KxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788127197; c=relaxed/simple;
	bh=epqPfXJbA3tuCMDVJlhav4w1qOR3g30UBEMZVB7biPI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bdX5DJxZ+0oOU25FGYoaN8kFmSpSJZxgQFbyH1FuEwWXiyJEH50e9sWnXS4+hr9hZPM80Z5afpPa++QkIXNM6LwDo1qHw6xECXGs3UbQFiXYvBVVxzTAwB/1kje/jo3VBSvRiYnrI4F7pxo8dhjE87QsGeBM1GUj9bkW3NCeA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZhrBkcO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZhrBkcO"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936623c6dd3so311696985a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788127195; x=1788731995; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dC28vVStGcJiu08+o8+WVfL4HeJ9+X8E5iJ2hNRPQDA=;
        b=DZhrBkcO82X93tEpUAeOdfm+bx2b6JgkYcOncW7k44ndafNFEmwd4vIGAyfCPn6jBX
         HyyoEZic0tvAfI5E6FbyJarlpNQReSbkgdoDkOM7vy6YzO4eTwoWFsH9qzMUYMLNP0Jh
         LLUKAOMykcVLl2TuaNDtSUDUXUWeSM8S5R70IUfr04Dt3Bsc8Q6li0gY3mXRa491m/7g
         71RzOoVode9qwRrgAdNVPp564zTBh/0K5IAHbaqVw3FLvNksL8g40zBsdiwtmdFnuIIB
         ZxJ2Dp6M97Iy4oDLX2EwdXZ1QAmZ77Nm3QFaybtyQ9wENh1DzK8omNh0RJm+a30CEZxM
         lGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127195; x=1788731995;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dC28vVStGcJiu08+o8+WVfL4HeJ9+X8E5iJ2hNRPQDA=;
        b=OfzGbL+DUvHg40MSEAqmorg0PnTIbDYRUdlU2t8Xwtbgi15etzGGWq+vZVc89k5wcR
         nlZa3KZ5iBKA8kIZqwSECo2zBtaTzd2vt4NOcHr//0Dibzoj0qvjEMGk+JMpRap9lQKD
         Xr4CHU4p7N7BmwWqjmhvEMUjUSJPa5I9YHl1WbpH1IuTE0T9ltGC9coekJmiZxigCaBr
         H1vCz5XeSet5XrBLjAURqtO/VZH4WRbhDmLuyS2wMsTrmGNsjGH0fNZf8btEFiXSUzby
         4mCFh2h0P7AuHj9Ra5SFsJ5/1yfQeNRX9KAFeVVRHG6LnXrkJ59EpUAsf7RdYmpIvCtr
         vs9A==
X-Gm-Message-State: AFuF++keVg4r9atovohqcgpeXU52yf69pErmXqf+IU6S+v0LFg7ZMRe+
	cBAZdSH1d7MdpXTFzWqCFLjUrE54wHlrI1D3waimiA97zjSgGnXew+mnACOsng==
X-Gm-Gg: AR+sD114bhjQQVGITtp7/xNiiPYqwAerItA7l+Z/XdUlEabXB8nvaE/hCIxU6QWPYvd
	L8II2s6KGE0vE+j2+ymFoY+wDTX2hfUo2lPAK4ARLVVPdpVy6bf4sL/QBkWva/5lomEis2AsBuT
	ZjYC6A0mOjjgGGjscOXY/f8cnUB3did5T6bmMjYM9ECQ3t7nNuz/SZ4btHSi7xPRGBRBTmcLIvv
	nTPz5xagSlFN0/NdBYN2d+qlDTMVe7F3m5X3G0MgvihDgLVANAneP44txKWzsogzlw50f/7cWRe
	63bzgnBONxVwee8/yUyu84He9jfobg19Ml6s3zx2dFOeeLTd+TnwVlgheenKUBEXP3E/tLG+6sa
	PnnLgeeYj3kEDD6FbVW8/xql1QluV1cHWu5PQ71wj1o1HN04ozf0iCYLiBIEvOCIhoviAirk7p2
	vDVEwAO9PmmtD/2V5dca+AySVq0Nu+X2Mva/LSeiPF6O0jvc7eRd6KksJlfrmjX3upc6k=
X-Received: by 2002:a05:620a:4441:b0:933:ade:2daf with SMTP id af79cd13be357-93936d05ca2mr420496885a.18.1788127194730;
        Sun, 30 Aug 2026 14:59:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444e6b4sm69730556d6.9.2026.08.30.14.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 14:59:54 -0700 (PDT)
Message-ID: <6a94a7da.36695ec4.1fb870.48d6@mx.google.com>
Date: Sun, 30 Aug 2026 14:59:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3813434732432349105=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/3] emulator: bthost: add function for sending raw L2CAP sig commands
In-Reply-To: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
References: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3813434732432349105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153985

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       FAIL      0.97 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      593.18 seconds
CheckSmatch                   WARNING   312.74 seconds
bluezmakeextell               PASS      102.11 seconds
IncrementalBuild              PASS      595.19 seconds
ScanBuild                     PASS      972.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,2/3] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server

1: T1 Title exceeds max length (86>80): "[BlueZ,v2,2/3] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server"
[BlueZ,v2,3/3] tools/l2cap-tester: test closing sockets with ECRED defer

13: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:957:28: warning: Variable length array is used.emulator/bthost.c:991:28: warning: Variable length array is used.emulator/bthost.c:992:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2458

---
Regards,
Linux Bluetooth


--===============3813434732432349105==--
