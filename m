Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504110;
	b=igVgJYVwJ5ZV9OQXhTYGazAEpPYNk4Rp8pjHeieDkSRkOlmGCJfNRI+EfVDf+FyovWHz
	 ylTc9qh+6Z7g+MjzzwzGpkZtyU3iEqkyljDmXO9fYri5iCsLqPHHK5hpvREQM/cxkbXWO
	 U98rDDs+PAwGJcuYJH8lPJafSfAf7Jt3pc06sHyMgXzSFGvHeP1UgWHOGuhhYN3OO+YQj
	 o3XL52RLggQmNoSMDbHsaRcMguTvXfc06vViO4iqq6N4FcfVa9cjhjzfMcQwxfS4Lmbsu
	 KFRYim/cXqLAF3B2Ul8pipQNZDIL41yPzB1+bIDt9LUSaZqNNQ/A36XcBbMji2G3pQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3IIqg+uzKAFOY9cc8uWoiQyV7SPyKJD1BSr5A4YjDpk=;
	b=LT57aUn/WadFzvPSJOHbmd8e62/XxkjuumAZMscq/OrHV8tvqXT4wwgxbn7DtzDpPCWb
	 zBhcrc6iEgwCvn8ux2yuZraKLmrh9M9eTYrSk50g39s79foVwy1PsxLeaOUY8wEYWRujH
	 XmRSSpYoHsZmW13c0HBL2PdDEtEhfdh37+R2TNZSDA+yy0A0QWyfN4M0k8IgabojwF6MO
	 W3bat1D4OA+Fnv6FNuvGjJS5O4clysllLoLrVJuqxhPbt15KroM3FYmfjd8WogvVJbXlm
	 5CWndkxAcS6Pby+YzQZjtJfFNSyLdLaivp2/2TuNbOUCxhWko2kikGhvM/XGHJ23Ypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDRnIBTw;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B991606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B991606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDRnIBTw
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71ab5e64742so2528018eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795504109; x=1796108909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3IIqg+uzKAFOY9cc8uWoiQyV7SPyKJD1BSr5A4YjDpk=;
        b=iDRnIBTw7SGnrIftRYeCvHlPy/OgcLdQUreMonlkpiZ30RmsJLy1AMp0b5XHkwE15N
         g/tV8ebnVGOEM1y/G7I1x5cdv7SVuukS3i2z6geVcDy/HZqeLcL25pd5KTNqnOeisdfl
         O013Wt6A20pLj7Yv3e9TkIGTcsB3MNnsVDsrID+X65kf7FwfHMYqn2PpAMLC6DtAiy08
         QWMggYBXuBJlZZX8y9dUnnZoXJZy8ks3cVN9U+GLn/D6bG71RNb7q5uzCxA4ujNjnbhg
         HTtnbU1GYgKt8gxqVDQpIewFSgKWRG2xHI8BfBy8vBn8maKjxm6fSCyIf+qiualafpjK
         lv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795504109; x=1796108909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3IIqg+uzKAFOY9cc8uWoiQyV7SPyKJD1BSr5A4YjDpk=;
        b=nDVMajTnvq3oHuKutFlDoNMCF+OliaPY7kqVwzJkW6toGA+aKDme9K23ZXwxySZXGM
         2Tk4jQ2olsZKacq3PKcxCmyMgdHcBaXCMXl+5Teq90gtpmI8VQ9VPiAG4GckiwQiQQtC
         /bAWQVA0vbAhH7/HNXNu1FPaaAvF/3DW+M8vcaqjQMfosbS+3n83UzSBWxvxNBlO/1/f
         RTIfo7JtDZtxi2ve31if3x09IttyL/bUqwRkHX88WnjS48ANVpLuJInRMZEYZw9+ahCH
         p0DSw4Uc4Pc4ct6bFpDhhafNEF2Sh3x9aYyugVZR2i+eWBJ1kqyEaafNSjlaP21gEhCU
         80cQ==
X-Gm-Message-State: APuU4Z/yR2K5cp7M/ZQR2Fly3bUFrN2DWhDpdlg6daElUD0RrC6BO1Fq
	7IRYdn61nXN+/pfAZBo9QrZoBfSEgA/mHqN/p3IsadEpzerXJNPLZmuNC5RCp/xL
X-Gm-Gg: AZFdTZcDUAE4T6uv8QirvL9iNHsKIdtLJtmDhc892StOQwpu8pxwVKDcGsTxbgr87uq
	9rxOtv5a3oEB2mhvxn7cz4vMkUF5xE068iKtTHKkScqG21vvLFS2ArGoMcigBQovSFj8yIEYYii
	8zEygaRTKM9FennDRMIdkMJQBl49LJimN8sI4+A2AQXwiJDeGf3FxpBtgdDqdKMmUxqqafFhdcb
	4U86MXwohn5Z398quzUwS5XZR5NLmG9TpiePzkx6xmqlJNdZhP3xCQWH4QV9Izvr0KJlGKMZvze
	+m/F7IFaY9YuvRSgb+Sq6vFERhsu1nQrozKxaYyWxE1uN/KJj/PKU1SxLNMhzxYw6lxIGJSsVdi
	6Lzi5UKNvWEeGrzlSiVhGcr62laVKSokFl4RKChTPtbvQ+SoFL5FLCWAlTr/xowmbs2vQvWV27L
	JEfN88y3fH1ADIE/+n7iktAgx84BgzVbBcTe2VjjSuba8d18F3ICiRDwBoU1qMcqRTmjdZ4TsOl
	rqIwetaEr+zM3vMF/hHrrzM58CYrjlY87ItsRx7QjAldZVdR+8OsXOJApe3IyE=
X-Received: by 2002:a05:6820:807:b0:716:e9e0:5440 with SMTP id 006d021491bc7-71b47fe68b6mr8991724eaf.63.1795504109133;
        Mon, 23 Nov 2026 23:08:29 -0800 (PST)
Received: from [172.17.0.2] ([4.151.69.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38058102sm8369963eaf.6.2026.11.23.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:08:28 -0800 (PST)
Message-ID: <6b0537ec.3ae93811.18d4f1.021c@mx.google.com>
Date: Mon, 23 Nov 2026 23:08:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6211755305593298650=="
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
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btusb: Add USB ID 0e8d:e028 for MediaTek MT7928
In-Reply-To: <20261124022318.663787-1-chris.lu@mediatek.com>
References: <20261124022318.663787-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6211755305593298650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220274/

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.19 seconds
CheckAllWarning               PASS      35.36 seconds
CheckSparse                   PASS      37.86 seconds
BuildKernel32                 PASS      31.25 seconds
CheckKernelLLVM               PASS      34.61 seconds
TestRunnerSetup               PASS      755.09 seconds
IncrementalBuild              PASS      29.19 seconds



https://github.com/bluez/bluetooth-next/pull/1208

---
Regards,
Linux Bluetooth


--===============6211755305593298650==--
