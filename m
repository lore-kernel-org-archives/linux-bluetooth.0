Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120126;
	b=oCBy0GNeWiTcz54fpoSVop3WaBXP0YnxttRVhqEl8yZI5Lz7AxYTk1DxcFCTzpz4E2m7
	 bZDx2S2OtNB5a1Lixj8ToGuy6mM+zGGuopaZGRR7iKori083VkAKvQlj1XSxCjPC7jCRC
	 Zq0LgF7ta78cg8jukNzjWMWCQJq3HPSDoEP9gwr24tXvuq2JgImQn1xFNSzOqjlprwFdX
	 LNvd9TWktg+CAzbgOxDWnK5dRgcYehsdEa9vgl1KUO+j235AlRTw4a7xqkA+DiJ31WfGk
	 HBnxwol2oCGUIZQcsVl+sMH0zer8FCLB1/RNygdhq5bAum/EROc5e0fKnlf5gTh8w+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=MwjBUK815M5d90NVk69x2m3a/oJVYmd+jG+G+Tua7MI=;
	b=HMBsfmGnT/hwimpV8FeMlE027g4HJYYpnQZPiDzqKPxWTX00JNw8PnnJfgG1BDwhDnvw
	 aoNeZKqbgWD3DgBGE0UqX2RF8RUN3MJfU6X9dvJGR1tpVBNWNRgPIhKXhomP8g79Yoyqj
	 W+QYB/OMJREKOZZGDVG0fhnhfa9MhEgzU+l3EQGwXvsSPdZjt1FdnAwlGC17ubX2ZKBC8
	 Zu9DmULH5R7fPLuBbdM8YxPtzoDewQR7zUINiu3CixE28nKUaAoz+DXRemCRixXEI7vyp
	 1IEmqIKpSXIXyBYNwgfuPuabH2xFYGdd2FV6OUdd95nL4Kv5GSv1yWjDkWRo5bLQq3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6qG7yIQ;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB0606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EEB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6qG7yIQ
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-188406bb948so3609980c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120125; x=1793724925; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MwjBUK815M5d90NVk69x2m3a/oJVYmd+jG+G+Tua7MI=;
        b=Z6qG7yIQtAfBC2vCCnbbiTF9RUSjnkdeZ4dYsmWSpbMDaUty9Ec+xvWk+2v+VqkSvt
         AyKyluTqp8y8mCDiKhBMZvhn9PUC1MV1ygjhT5wgmMT50623wfQetVE60hAoN24jQbyQ
         MI1XPvdxBeZxm/sG0NaoUunQjBzmV2MXGpw9skip/PFlkVEa1oQgVwmAdhvzbyf3p1Ud
         qFgFRQYV5UZHOFrRSzsTDgKC6AghV9z6fmd6Y2aXzfvuAd8Lrm5kobGZFtUQcTxtQK8V
         z+pgfiUnBbStZXBp4LAqELahPGQNXRhYulJXOh+UojmSOMxNv1NkmtoODziOxMu460Da
         fn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120125; x=1793724925;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MwjBUK815M5d90NVk69x2m3a/oJVYmd+jG+G+Tua7MI=;
        b=IGQvxf8CscZvjBLqXh12/4oeDVS81176eVe4WCJiY+Es1bgi5LNAFJUWtHVFl2N24E
         1HjXfTU/phR/J3uRwA0EM6jzKRVGIE/Whziqdg6EmZK3+DigbaqLdJxBcHLllgtf9TAj
         SkjXigfcGL5QEdh1PMIqdna1pMNOk273cg2DreRSK8YZ2lpA91s2AQPR0KWffddeUST7
         7vIlFzqPPKUJ3v/wh4PN3DOv0FQVGFpmwcMNsVoM/gQmbxoOcZvOHl3rBbsuI2ZIQzAu
         WHONeeJLQsGfk/qthd2PMNrEtT/koqB4uue/QE6v07awOHM1qGHH4YqMl06LPYTtZ7Fj
         eeUA==
X-Gm-Message-State: AFq9FYIt9GE+WEXCiMAXfTv5ycunMm/MFPxS0MKfxmYOjffDf4N4/GSG
	11Y3R1jthEIH6FoW5mmbLldRVWOyY3Q1W8Yhx+4oL37scCpXS6nvjezHGqdiDA==
X-Gm-Gg: AYBFou0LA7U4ylYzFMyP8+LdyFa8bipf6d85U8ED1IJKCY/5XIsaQwayg3ZWoHIEEL5
	Hd3QGW3A5egAmf/hKTuIHZKHkzS6toox3MAmmp+6iqUOkp4+k8GRkLiFqObIEgQfQe5WBDsTUva
	cAzWcWa0mKkkNo3o0ZYvUJ8gHfMiwyEHGSVY3BJzwIImbddC6D2nAa4a68wwTbi8Q/6Q+HqJrf3
	m7bwJm97iQG/57JY5bjKj/L1MttoNZ5XrXaObGQp0WBRL3uoZx/Yx/ZU7F/ulNBcTjAio1WCMAt
	hYpEFhrI+oGJP49kqxAPbRknTnsArtm3zNVF0A2rkYJk53QUb+lIyWXU1ytTPhrRv7nDXsLkx5Y
	eK16vSPm+PMYRkY5DoogZ08fM1aiz8QUWfUbT9NMaa3wa9ipwXWbgtsa3oBlslKF12w9iQRfU9x
	Bdk1hBnJ7qV1kYGUlaX9o22mJL/dUkucDmRaLKe9qhV042fgkUV3R/tEyU+BavGCoHyFSUQaXBt
	36QGy7G9z4KCUvJFzGBXMuDnu2KW/e+CGM9wt+tqQD3SBewaFFWnbonr4ZR4Ug=
X-Received: by 2002:a05:7023:d08:b0:190:da74:2c89 with SMTP id a92af1059eb24-19935be8339mr21285344c88.21.1793120125405;
        Tue, 27 Oct 2026 09:55:25 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.160.136])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm34936301c88.12.2026.10.27.09.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:55:24 -0700 (PDT)
Message-ID: <6ae0d77c.5bfb57e8.3be28a.ddd5@mx.google.com>
Date: Tue, 27 Oct 2026 09:55:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1930894386835909718=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v4,1/2] Bluetooth: btintel: Add TOP silent reset hooks
In-Reply-To: <20261027151930.386971-1-chandrashekar.devegowda@intel.com>
References: <20261027151930.386971-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1930894386835909718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194739/

---Test result---

Test Summary:
CheckPatch                    PASS      2.24 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      33.51 seconds
CheckSparse                   PASS      36.18 seconds
BuildKernel32                 PASS      29.70 seconds
CheckKernelLLVM               PASS      35.61 seconds
TestRunnerSetup               PASS      703.71 seconds
IncrementalBuild              PASS      28.91 seconds



https://github.com/bluez/bluetooth-next/pull/1007

---
Regards,
Linux Bluetooth


--===============1930894386835909718==--
