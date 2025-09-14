Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E91D7E4A
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757887120; cv=none; b=uMyz/MvowtLIPM8aH3HNMDXYtNYYbadxWrTOaePSO6AELFJ3Qk++fhO7Jjd3XJOy9nYVqZ8R8WH2N8rA5akdLnTCoR2dn2ckgqf/hWy7AB2imS3Bz2E/FX1LzYQQ1ZcEp/4c3CK/q9ynr4md9lK1jDNnHqwkPhd5s4NzzEsvw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757887120; c=relaxed/simple;
	bh=UvlnF3+rZz7CGVddl4X2mUUMuAsV5q8sTkJuxRu3p44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Won3vec36+ho8mPyfxD9XcD5XzGA2sXwulXn5AUHsK19g/jvRQdfSjiJ7hxMRGG9t7feJqjBbkxqJxkEUTdy5g3OS7SDBqExxgPTJSzHVicMD67jGWAi10MqMuGNR9H/hB0RuxEw1nyQKwGFwUz4v2rzU4mhH/lwoL0flPevB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI78MIiM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI78MIiM"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-571a58b385aso2333699e87.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757887117; x=1758491917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvlnF3+rZz7CGVddl4X2mUUMuAsV5q8sTkJuxRu3p44=;
        b=gI78MIiMihqNMc5KRkhSZXVuP1iwXxdB6RxcguLrlNKvSMfpaKh98hNY0oLek1EF54
         vGddofVSbiaJ8IGt71N3Abh6EwbM5ykJQ124lNDcpdKEbVLGFw/QganH0dHuC5koOL13
         a5+gGpi1N73O4i+FWAWLU96qs0X/jmcCRvxXEudfqntyG5EN2OFYkkyL3gGcWM/1gjXF
         iI8Io+lYQv5ke8MsOYWsm7VRs2EQttQ1LZDXGdx24rSKD7wWNpDasXV+q0xH0NNyC6Re
         qu4gor64gcbXeV+B1lduS8LxYjb0R4MzPetGnj69+le7wuTq5zJPjfwvM10YUhgkoxX/
         OZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757887117; x=1758491917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvlnF3+rZz7CGVddl4X2mUUMuAsV5q8sTkJuxRu3p44=;
        b=a1Zw9Myzmfy/wLEQvx3aEcV1HNEqgL6w9Joxkbzuag8GsH27J0EBoMSCy7IsIGDOBR
         45AKdpirK0uCs23d2D92W+udGYnIG96IQxwl5z/7qCK5M538UgvfpczxmMSmdJXdOnBw
         SxuXQQ1FoUpyOafkwmK7MH97rdlZ4sk7YHiRFKNnZ8jGSeI06vyHBa7H40paiQ+ihlA2
         9Q5wNQ22ArZoo83vgUOhAnX4IQ3seOyAZUKoGQlsEi5xNQRu2kv7egBxQUwoiriu64dC
         AtsW9BkJpSlEaCHNK66Uap3P9K8Xh7e1Fy7Kg9I/wBcm7U3ozfdpjmYbwAFtdDv0ZkEq
         EnWw==
X-Gm-Message-State: AOJu0Yy0R+34AMbAcmJgGD/0NcgoJZheg2a+L9HQ+4ZZyO6e9FZaIX3+
	hSy2P35obBtsx77vd16iEpx2yk+hWQ8Th7rV9esdcmFPD7hPDhOJOJSb
X-Gm-Gg: ASbGnctre6lAqUTFP2uRyxEHmweeAgqVPvPcH1mdm3eWM41TfRfRlC9/Tg4Z1nWoIJ9
	H1sHuNkAYWY2+fIcbEVxxv/qKq8kSh3b2V6ZLnctnRHw39Qs1vBXKxX+Eqjgxi8IEoN6GzlX/9Y
	g8dtqtm4R8ZYqNjXc1WidMMZdgh6viG8paHaRHnLBm2oDWmzC3Xat+TftMdMUhyo8WijGAmO5q/
	ogvhoIZoyZQIPNUlmLjbIpPzPnzFzIOncFpIKb1tIrn9dVwqK/p8BV5vuILLpcff3tM+lAgKoWt
	bg6mePjPe3/iT6gA8KmJOmKZEGaUpH+A7X6NOolD/y3gWtcaZXCLeOcQ4y5gUQs17wZFU2iikto
	Q3QSAW/+zcu4zxWz/N/3j44KkcJwKvbfU4VXX0IjWoUm0dDd0dREvIW+QaYiiLX1oXokIFimzRw
	hPjXN46Dry9qJsQ2mVks6B4S0cttCW
X-Google-Smtp-Source: AGHT+IGJtiArclfpnZR/AYL+TYQgdfD2ZZbK1HnYr9bqm1J9zEm/Ss0m5DcAFiEQjl3Wm9UdoMD6DA==
X-Received: by 2002:a05:6512:130f:b0:55f:3e8f:ac0b with SMTP id 2adb3069b0e04-57048beb359mr2700163e87.6.1757887116346;
        Sun, 14 Sep 2025 14:58:36 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.168.nat.ftth.dynamic.t-mobile.pl. [46.205.200.168])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460d65asm3115501e87.100.2025.09.14.14.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 14:58:35 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: pwaago@cisco.com
Cc: linux-bluetooth@vger.kernel.org,
	Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2 2/2] doc: Document error codes for A2DP MediaEndpoints
Date: Sun, 14 Sep 2025 23:57:51 +0200
Message-ID: <20250914215751.73206-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911151930.1632922-2-pwaago@cisco.com>
References: <20250911151930.1632922-2-pwaago@cisco.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> :org.bluez.Error.A2DP.InvalidInvalidLayer:

It seems that there is a typo (duplicated "Invalid") in the error name.

Regards,
Arek
