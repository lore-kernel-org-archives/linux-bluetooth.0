Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594266;
	b=kbSBbo2WVSaaiMysWZLdUzESPE9P9ws+YxedfC+QJ+wVz0K73Tj159elykmCYqUU4IOZ
	 XfEtqf5381+Vhr8cQswNOGAv9GtxZFSXaWKmeie0z6RpgRj16/gRGQDWardqnnPJPjrLu
	 MBO7aqiJfdPtY0K/6EmO9Bb9LPoNPQp8yora7sVQx9Io7OLjPMlK0szAHKwbFtjW1el7L
	 7W2ABvUDpH/Qq6mJElmks2+5WRFpGDBCPW0gr5oX9ZqQstuB8dwQtFT4uL+EIqaN/vCXd
	 wcMmeuO5dvZKx2mPgdE7aWYdpUSarDMp13/PrYzEyvula7gZHKYFJaDyh96hA0ckChQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=V6wbKNcgNxxp4lQJR4X6lAwKDB0sOsVN1sPE9CthbL0=;
	b=5MivqUUBz2QceCnM9+rsc2Iu/F5hU4g4jpJl9PQGZVeWMItElSQ5A9emmOHmWCPoIJbf
	 hbprObzoLieUGvSx4DpDog+29lbiLecSNafAMr8I9oKv4gyqljFolQLD07HflBhIYqO63
	 u6E+WzdxD2y+M/TYpcxGlG4UT7K0MplzXY2eUFCaC23IB7f/No5vCxYQm/hCrC9BHIQZc
	 mPSo+WOCphg3iVTd9YLK1SwLtgMAzv47co9xqfXHC1JIB9dHediuM3HpiDi/eyl+EoBsg
	 MjxXb6ZfbcT5hMLsPdCyPQxE5VCbpxUCnZbPpWvKpeZtM0kliWbpNm6qieKtpEY71Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB8xXco2;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3B606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 18:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF3B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB8xXco2
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso1368385a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794594265; x=1795199065; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V6wbKNcgNxxp4lQJR4X6lAwKDB0sOsVN1sPE9CthbL0=;
        b=YB8xXco2Rq9i8oAfJqpYpddDYX0v2zZWY5V74jNBkjNjACQNuXmGk+CkuahYiSMAmv
         NNTXCmI5VjkqcmJ6IOU6vvIIk0aVzMEW+g8lLWHY0V9Tnle1jPV/EwSYrKsBi8k0JQ1M
         bJ3jXtNyO32XgajfSSsBOQB7brOB5XXdFVI3OGnCPPvCT3iTVwSDFBjkkZ7uorhmPLT4
         HwCNhxSfkDLv1a2ELk30MYJ165o97FobQ06rTGHX1BoIq7wSSwi4oPbTPHyrwANezDj+
         q86N8plXMCQJ3uHXZ5QzDMcC758Ar4eYIYXHK7g9zq4inVOJsbfg42F6vMg00GMD1rx6
         0Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794594265; x=1795199065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V6wbKNcgNxxp4lQJR4X6lAwKDB0sOsVN1sPE9CthbL0=;
        b=P/7tgGGSnrADv7PJKFeeMMY0EtxuzHJpkZc1elF1S6wMp7MlziX5OjmroB2QAZdl0e
         FRg0QJYIRCJMi5e0Ap4WicELtq8NrfBL8j4fyze3gjFYcW0/uUqrEP/FYtxYsiWRwZnN
         Eps/sev9IyXkwI+g1ACmPoTJL/pQERZw4jK9MqEtCOB9H6w2tQIUD3Ix/YfnwtIhBKB3
         cQXrVVPVaIBJnbRah31zZG4Cw/Anp3Q6aJn7Lqxy5kNsEk3M6Zh54k6/Ebd95b6t6m2l
         84ZYcoFu3wsa2FHq5jb9xT99g551TGhfq395zN2q5nUjD1JuxTiwqEPq/XkNhdM01PrZ
         x3hg==
X-Gm-Message-State: APuU4Z/WvcoZYIYFIhDcmoGHBL3hAcAcGmo+BkZqsvtDrEQQ8lLJNap+
	7tVtl8jkeuaMj7l3dnxrEo2GKJeEI/AuVFnPI2VLXFV0n053OT/h5asyiMeVAk0/
X-Gm-Gg: AYBFou3EiXiXHSokCirlEMXqwffql7mPM1N0ZMpvbz81A1OYgjdJUvUujj3joTDvSVi
	IEpkl11wYxEt6W0ucmODZbYEV5AUATkkyti0KSwfZAm6SX3xszoR8GckY5MFdZMFEN39xq3Xycg
	PrYJMW2b0L7CdddzbopVftbdlM2Ii2O3D5yNEpn6Uee6aRYYrlFS5OmZYDPxnjlY/INO976OM44
	vud17kUGUk1VXU2RJSz0YUu2NdO9SIbf4dI+RHiJnmiJPEgb1n4P16Xf8Zi5Ey8nhvXv+pVOYyS
	YNOz63ma8aNCJ7+Wf+CDZEH9Q922tfmF5nYfATnecHHHfibbmcdq40j2wSVqr+4AI59epsxFiYj
	7i5ZydELKObi85EXZr76ejMxkd0afV4UNvLXq83oL0bnkBqvDB4ZI53vNWz9K5TT4mF98X1E2/T
	TjuiiWlD4gbLXiPkuOGSXTYrbvblZhp/62x4aaCMo0NpRXx63JgLKReujqaCVrj+F1V5rIiX3e3
	Fd2Ab4FZg8+mD4wRM2hn77jNL2JeZwyLK0p9RbEvme8gdeRwW8M+VVg68X/BkY=
X-Received: by 2002:a17:90a:e515:b0:3b0:96ce:104f with SMTP id 98e67ed59e1d1-3b1b07e1cbbmr2287549a91.5.1794594265180;
        Fri, 13 Nov 2026 10:24:25 -0800 (PST)
Received: from [172.17.0.2] ([20.64.222.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm5573554a91.4.2026.11.13.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 10:24:22 -0800 (PST)
Message-ID: <6af755d6.f25e8e83.2158f6.c1fc@mx.google.com>
Date: Fri, 13 Nov 2026 10:24:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6012084544496082103=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: bap: Release cached ASEs on ClearConfiguration
In-Reply-To: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794586887.git.luiz.von.dentz@intel.com>
References: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794586887.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6012084544496082103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210770/

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      1.12 seconds
BuildEll                      PASS      13.51 seconds
BluezMake                     PASS      182.25 seconds
MakeCheck                     PASS      12.67 seconds
MakeDistcheck                 PASS      107.24 seconds
CheckValgrind                 PASS      240.20 seconds
CheckSmatch                   WARNING   184.84 seconds
bluezmakeextell               PASS      62.87 seconds
TestFunctional                PASS      908.84 seconds
IncrementalBuild              PASS      203.43 seconds
ScanBuild                     PASS      646.75 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2823

---
Regards,
Linux Bluetooth


--===============6012084544496082103==--
