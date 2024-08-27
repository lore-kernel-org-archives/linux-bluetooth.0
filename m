Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E218537F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791146; cv=none; b=E5G+VWZhKo1aZRL7XUsPlb350Bgv1ZrwrGhOHBUGUJV2q4EVDYIKsdjAO8ONnJynqV5kOpowzBfWZnfjDzZAvqpFCaWSCjgWbQAfY2AsX2ozDcIofr5UsHfGoidk+xoVNTevRwuh7dSDPupfXDoWY08t8l2e3wMWUgnPWPxBle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791146; c=relaxed/simple;
	bh=CcKWNvvvCM5ITAIUd8pwFSocRvDZtRZQVqoyAJ4uI3A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W3eaw/PsN4Ys8HcHbwQyzuBpYJ1wyWZVe9mvH4pn91QnrZRccc6nwFChJcOdEDWAXk6fx1xqyX/J421wXcolraRmBcJ2oJUV0ArPLpGddqbeboNi0LR6f1NV4/8hLQT1X9PjFD0Noy+fDUb5TQx7687TGPF+jY+aXQSh5j0+nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Voo1pF0l; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Voo1pF0l"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fdde0c8dcso33665241cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724791143; x=1725395943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9UzkRGa5vffORnC1SvJh5HmqJm1NIHpRQu9GXdc1KvI=;
        b=Voo1pF0lqvFZ5XHlN2csqgmwMZvKN66d0nEBwt0/ufWCrtgJN8pxLSHfjaUA/URNj8
         XNmEXGtUpRcT3Ee19GQg5t7lpjh5zCVHU9x2wuwUDp1AReSs3FxytnHiO0Y1L59pazqZ
         FXcFhHBJZFihOIOBwfj+l0MnFiAoyo9LeF+jL+n+ljW/v/+mLwIgXlhvBl+6Gai0QFii
         c0DU5UpqchNpHQtgIPP4kw0f7tMSdyqctEZe9fn/PyTCRCtBK1kHAbVmVi1sPMjRkD4B
         aSS7fbWvXf33e2UP+R6RBoAcHoAVjpNFnGsQ9bC4WFSXhZKPXpZWBp8wlxwRX6RfXqij
         5haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791143; x=1725395943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UzkRGa5vffORnC1SvJh5HmqJm1NIHpRQu9GXdc1KvI=;
        b=pi8Vr7MqPkeuZSAt2/kF50PUSpFOKs0fWuCzvsfwArPjE/Z1DwYnL4vq13EBv50u8I
         l/0QKhxDBSoL1YSIf7G89S3Bj1g9YnCngJiCnT2PNP2xgQGFj991IHBA8gt8z3aUjbBQ
         6ltcVSXT5KryO+YaV6IlfkZMktPsbFdg2fCfJ4qMnvAEHP59heOlbLP5ntgoVHyxcE2v
         Zd2gHMxlTlTeb6gZJh+VFLLGvnHghZWrR4a4IQMDemxLRivhjewm2MruBTlYgkOUtuc9
         bVdSVHPq2en3Ohvl/LsSJbvZM+DdIecSj2HUedwSBEib37AN8u0geyW1jjNryHlrS2Xo
         gcwA==
X-Gm-Message-State: AOJu0Yzpz/Ymc6zacFXndrRR1SBiyQh/tS4342lfRFaPt3ao5XCekfJ4
	WlInryNEKOyF4FW2cbJXCzOKnbhmve89egGLOPNCjT2e/N/D4yhSJDjdAw==
X-Google-Smtp-Source: AGHT+IF8y5U+w9i6RIYRQZZRJ0HCJFjYZF5GsDHhC2qJ6oT+DjoCcxXUry+36e/qKK/C/Ldh2p2yHw==
X-Received: by 2002:a05:622a:4d43:b0:456:4688:d70b with SMTP id d75a77b69052e-4564688db9fmr139692461cf.61.1724791143163;
        Tue, 27 Aug 2024 13:39:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.94.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfbfa29sm55707061cf.17.2024.08.27.13.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:39:02 -0700 (PDT)
Message-ID: <66ce3966.c80a0220.23dfb0.5945@mx.google.com>
Date: Tue, 27 Aug 2024 13:39:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2022506011673543070=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [v4,BlueZ] Provide GNU basename compatible implementation
In-Reply-To: <20240827185228.3515299-1-raj.khem@gmail.com>
References: <20240827185228.3515299-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2022506011673543070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883958

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.65 seconds
BluezMake                     PASS      1716.84 seconds
MakeCheck                     PASS      13.81 seconds
MakeDistcheck                 PASS      179.04 seconds
CheckValgrind                 PASS      251.42 seconds
CheckSmatch                   WARNING   357.66 seconds
bluezmakeextell               PASS      120.50 seconds
IncrementalBuild              PASS      1467.02 seconds
ScanBuild                     PASS      1010.90 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============2022506011673543070==--
