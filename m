Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9A476CCC
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348550; cv=none; b=j4chLmD5yiMUEosJPHfB0+8O3VNXTh08bNthKp2ONTb94Bb59fXVvU8Fb6Y2RFcddnc58UznkJA0fAkuTbo7LAf/NzNJJY65d2ZQ2zN/rOWiKfBp+DRJg6QHIS0Wccx17VIBU7UTQzZxHctOAAdIGML02SDKk/HTUiosOqRJRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348550; c=relaxed/simple;
	bh=y0iJYBpA7vmA8p9lIajhZ0Bmnm3NnlZrCDkXi15VHWs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gGnGEcbv9yF6sD+YX2CYg9gox349LCDxVY47xiYz8Y+g3hhkJIFf7geFFs8MwsXRVfN75AVi6F5bIZJe58vsqrlwGFCw3IaDtdlGE9/tToW6gvxOFQ+vbccF7/Hqi0zBTBj1W/ULfV3VT8KCHehVEuj3RpQYBd43ZDAbelNijPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYZOn1pT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYZOn1pT"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9390dd46b45so66294785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348544; x=1788953344; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y0iJYBpA7vmA8p9lIajhZ0Bmnm3NnlZrCDkXi15VHWs=;
        b=cYZOn1pTHVJS9N/DxwjtFZEFJKGnDHhPoH+RguaEAFfcb9IU11x4MMTx6f00GQ31KQ
         aZepiXTOYyaQ1vnKYCi3j0yaI5D3x710KeBKLC3rDAzUPOEY9/UYCZGTlFT9F6b86Ht7
         3zjZUMmDcI0dRrwCC9bG8Flp4jJQTGZiGlU2VpL+VaZP7ntnqXuzXx37CHWMtFSKTrae
         jCm6tyxqN8oAMQojEabk0p91K/BzmV21ObZkzwLQnvpbTgdiVSd9f6sNNFavEaL9c1W7
         MCEepPoOSTKIkvI5B1Kfgp7BxtZWoj+qLO872SVsd400hImllvzEwhm8L42n3bs6KZWB
         3n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348544; x=1788953344;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y0iJYBpA7vmA8p9lIajhZ0Bmnm3NnlZrCDkXi15VHWs=;
        b=cAoE9NBLLeFWXoLHEv4T3e3sxu2/rcGe2RMc183WTMZCHcn3oQkt8n4p53p9qpgakq
         eX+PM7m7id77sQJkPmidNWj0dgKYkfJUbnmj3e99HqZoYwQNn1+m23MWaeiIQU1PFhpp
         fNkKVOLNs14ZP5G1ZKR2SuvW6NyKucUCEb84EKw86GhT0usYFj46ZBwtc78txxtVyFU0
         81E15Wvh4OQhBHgeU5lngIhUFa6KpABpc7zny/euRsEdlqw1vaK05wU9Y5yYCTHCQObT
         bc1b6YiZ/ck7Ki3+O2J4XBIfBAeewA54PLEJzYV6izHL5C8LOxabTllEbj5YI66erP+4
         dbIA==
X-Gm-Message-State: AFuF++k414ojBdteO9ZuwjSeMtLliOsFRRurjKupmDIHIRx81lyepT4x
	Qf95xffgOBSgkyh3VBuiF5DQXlsfoghY11e0x8ByoykbsHsD31RAFv8jWCKXSg==
X-Gm-Gg: AYBFou1pAbzJGcxjegVnVV+aXtnWCj5Cn1BFFuOGXQBv5DPDahXoXltuSRTS74mKtud
	3hC5FS+3A72tbkwCutL/UzGB4/vNQd1CRucYeF/QhXUzmSySv/Bvr7/LvMd6e/zU4+NzXZQGaHK
	rwzWV/npQsz4P7zGSuJ8kxkJJzNoNiIjR+KlcevOuG0XBn5iYy3pGrAnJk0tQ6Ek0ZAoubFQJbX
	TMM1bVxaeSKuOoaG5CwBow2HW2r/YdqmbfQt+9uwOeoplc5j6FVL4It5hx9dTPdWSNxwhfjNXVI
	RrsDqH/yEBl4NQvzQR7D4jJxDelDcN4oPbe8+9sMzFC86UoFOyzTC8ZOynEg+1PtGCk5AyY64Oc
	9YYAk5lwnc2ZgCOKSNPO9qu3YbxMGotC2/7G/iTudQvfsZZwA95lIVx6Yei2Z6fVeXbkhD9nFuo
	QjbVQGyB+uWzpDzgiLPJWyMz/XPptCFkMu6Kscdk0kssrLoNMVNOK7bvMblzS/NZvzz/A=
X-Received: by 2002:a05:620a:8c17:b0:937:3b26:c9e9 with SMTP id af79cd13be357-93960f30624mr322815685a.25.1788348539012;
        Wed, 02 Sep 2026 04:28:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9396b7ae401sm4353485a.20.2026.09.02.04.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:28:58 -0700 (PDT)
Message-ID: <6a98087a.e9da7a6b.17178e.9e38@mx.google.com>
Date: Wed, 02 Sep 2026 04:28:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0777390126502453704=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nithibert@gmail.com
Subject: RE: Bluetooth: btusb: fix NXP IW610 composite device handling
In-Reply-To: <CAKA8V_90tN2ncH6gAoa_cML4TfCe=21EoJ8RU-v_oQ6gAMT1uQ@mail.gmail.com>
References: <CAKA8V_90tN2ncH6gAoa_cML4TfCe=21EoJ8RU-v_oQ6gAMT1uQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0777390126502453704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 25
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0777390126502453704==--
