Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866856;
	b=pVmEF4ns1x+tIcD/SBjmB3cUxHBwIV3Udd0/SFxXRDt+xm9Vcq761a9mZircVgwDk4GM
	 dhmlVGDtOBS2MNDyuwg0k/JJnOy72uQtGz4sJuRoY5JKX/9GlcL2Vz44eQKHFTI7ky9Om
	 bzzobRimx99kzaoJ5n7JMO3ZRBY5ngfUHJhZhzrsKAS5uYRnni+6BVF4Io1kfeFNlQoYR
	 bOhu3wsILFhDKKSIlh202XacTyeDLUgx4PCtso5s4EvRA57adHoThXSrwTBXt3nqjBbvZ
	 eIybDZxJLquLj3n3i2L1ijCcx2VLcF9ktJUOHKmw5Qaz2CGNW3gzdOq9eUAHbsf2SKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PE0+UqYhnylhrzciaNIbmgI1UtjSSF5tlLOYDZTpFhE=;
	b=dmtrRyvF1YOhZvhWT0+5m1iuEmPCZiMtvNQHQEw7FhGbeWEoDG98jBRLZkB97u1Cx/ZT
	 K+zNLTKsgOxczwFogQNOvi7ZxdctndQi+pEWX8NN93XOGsUohOypdXOUrKKqyCB3nxQho
	 xvxMtb/WjFpMaTMOZU22oiAWsPV0gSouK7U8cAw2a5969HObNHQ+ZPSxahazV7v9aOrfB
	 3S16XqBfr1DnexTHLJkQxKFdQsZFfAy9zZDEqUEpI/vBVriR//M8G36imtdt3k8xn7xYF
	 rYVZ2tMyIpm/B/b1+QNgm5DAQ73IA9vHgGJAHHhxaznEfYmy0p9goZQuFhqvqG91GbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QsSlsMXq;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1E606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 22:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QsSlsMXq
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4778074c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 14:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794866855; x=1795471655; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PE0+UqYhnylhrzciaNIbmgI1UtjSSF5tlLOYDZTpFhE=;
        b=QsSlsMXqeJiweSyQItly2uUtJRaaY0ADIaixp/P5G9fdffo1AjI1Bcjc7/UawwGSku
         QzH+0vkxUBMPtDt+hHU4FWUcpT0n12WN0Bwxd2Zssa4vH9v7gRhyq8JsMtFoRrsI4PgJ
         G92qOaREbEHMR2s1g7W/TJkNeVsaKpds1z5UhIKCGW9kf5iDgqHuXW5406CZZcESsvao
         75FhITlr9trHHxMtOGquxSTjgSGapPaixP/NeUfUmUFevG7u7T/RkQ3tYMROZcq9LFnN
         dGG9KpihrGALV9eiOM5j5JgywzJVhCvFnoMgq+BuFaWGgH4VLykYEE3h80h1l9wRayiO
         TkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866855; x=1795471655;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PE0+UqYhnylhrzciaNIbmgI1UtjSSF5tlLOYDZTpFhE=;
        b=vRp3A/dcByQLYN1Z6JjaUfXeR20+dLKiUmJ5qaABmzvAy9eKI3eRFpc0GlydtfH+kJ
         3w9k1gHhtTQTs1ghOffV5TNE+Wv6XVsBVGstlsM33x6xqssHMaGPV4BaSEOrW2LoGPWj
         fF2hiJiecY8kr3ST2Uj1ew20M8zC1Jw/qUzpWgC2GLhqeIV5PWciyQ97MUsJ7E6iGK+b
         DFu5eKZB7R4Pgjcrgm9sjmy3rZV+SjGaTpBW5bV8XiMlWlyHLSD96v90LJyrFAhku6vr
         iW7RiBJbSiWGxcW5VPHDFpM/Th9HABdTAiYLUxaxaXkoDBPG6earwXMnEiOy2j7wzYsp
         fEPQ==
X-Gm-Message-State: APuU4Z9fIi8+1r0gtFmt8X705SiWTVcgdqJBF8Hry5WeYOFtaDXcKLo5
	xr9xNA7/X7UviRdpDokhAUDgFFWAaHt1O5EInbI3Jrwu7x7G2PjQ06G4ziOlZw==
X-Gm-Gg: AYBFou2ee5mjwDEV35ae1cwzkiFhMpyrgLYGosX+yMBdNRGG1C62Ve0DqXnGlrd963F
	liGYX+NtlaA4fZkEPrtg7rPnATiQX+WiGonfGy5k0NBnqL8ud3hHoFsvOxaMXyqxPlnOzr8BMqk
	dNNZKCGiuhm8DATB6Zq6LI5SkhQXxLJ/X9B0AizgWwDKQIGuyQ8f8PeU8j5w0uxJItrvrZybEUL
	vq0T6ODEL9ArEq3lZgiF1UJ5qqLFP3zlS35V4RGS/0XGM9Lsot95WZqJGjJwlQCxvZ2dXHCBO0F
	IIPDtobf8d7oX6wIGDF4HngyFYDd1lb73Er1dMaqfAaTXML21XghhMN6v2BEoHZWvYgw67z2FmQ
	Nt3po6ZIGEQuqoomd1PEDHywyzeoHS4zjTRQRqasonabmuSEWTMcAv2oiQ7mUUtQg6AwXhHAaDY
	wCkcPSPMm7WMdwqBvx1xgTSHMTavj9+3uf/IIMTaWxIkRG64H34YkUenxu8XWvY2WGm1Xuf36vw
	NX/ExGbsaXcPbI7cVyZqoJIwaDHCK366qY/wKhLjfcofHUWxlbGPAWPp8Fg7s02ChiBR5FD8wOd
	ySoeiCr97A==
X-Received: by 2002:a05:701a:cc97:20b0:1b5:2dce:1b88 with SMTP id a92af1059eb24-1b52dce1e79mr3779791c88.45.1794866855164;
        Mon, 16 Nov 2026 14:07:35 -0800 (PST)
Received: from [172.17.0.2] ([172.185.33.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm39830967c88.8.2026.11.16.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:07:34 -0800 (PST)
Message-ID: <6afb7ea6.45417901.16cddf.c92a@mx.google.com>
Date: Mon, 16 Nov 2026 14:07:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5835618794857510921=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
In-Reply-To: <20261116090634.1222593-2-jinwang.li@oss.qualcomm.com>
References: <20261116090634.1222593-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5835618794857510921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1212472/

---Test result---

Test Summary:
CheckPatch                    PASS      9.25 seconds
GitLint                       PASS      4.64 seconds
BuildEll                      PASS      20.90 seconds
BluezMake                     PASS      311.34 seconds
MakeCheck                     PASS      14.75 seconds
MakeDistcheck                 PASS      147.90 seconds
CheckValgrind                 PASS      358.40 seconds
CheckSmatch                   PASS      320.83 seconds
bluezmakeextell               PASS      101.98 seconds
TestFunctional                PASS      1245.33 seconds
IncrementalBuild              PASS      362.22 seconds
ScanBuild                     PASS      1194.97 seconds



https://github.com/bluez/bluez/pull/2833

---
Regards,
Linux Bluetooth


--===============5835618794857510921==--
