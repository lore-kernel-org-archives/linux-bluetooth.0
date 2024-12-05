Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591A1DC04A
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395581; cv=none; b=QYXlNDPX5zQoLo3e0YNdOShOJ+3cRIiN1F87xwaS//AaPavUzDAFgsL+1faMNwGhFAFTRxCwLn9OYBC8JAcakzUl5IV+PCxlSVryH3pMKfn1XLIsyIvct7EdH+LSLA+Xiw/ek6ZSfqqG/Q/NUd4XK6yrMDVHNV9PKxPECwjJV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395581; c=relaxed/simple;
	bh=Xfzf/FXigu03Y/oI3g125LpOVp5OZf9ymO7HAzq0gVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LHZuIVOHBILE/erG7rFRYE/chUWrjVOXvr7IXj03T/PvIWn8m0/zO78EgZYqbozbKKBQRSKeuHxiRmdm6VA5u7mnvFRIauUVWmiHxOhEdtHjVGy0sKcWPYERseDMicIo/YTXyEfMP+Vwy7C9PmhfsgLeMJKN6mzRtXb19YF/MWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twrj9CR+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twrj9CR+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215853ed047so6782065ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733395577; x=1734000377; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfzf/FXigu03Y/oI3g125LpOVp5OZf9ymO7HAzq0gVs=;
        b=Twrj9CR+VyAhHPu5R4H+F4yMnaoEo1xldXlr+QOeMGH3Gso+v0YCI1hEgZXUn5AiPB
         o2tz2SZ/ZWJ7eaUC4E6kA5iQQIRiX2dZ0KbsT3pwx0J/9gY9uzbIK7DngdIqK2BA6/k6
         rdyUuSsctN7tSCJKduE16e3N4z3zM6IcLl8/+vMAC7Ka6ZEcYsj6pCW3DV7xQNH4u/L1
         AMdyx6Sxj09R6rDT+6knwf4Z31j1tBFoYH2aRrojr64ao0LmFcwirYe8SC8pW75iZNqq
         MP/zW139NacLhZp1K/cuxq5uMiHZL8wF49T52XKd7kOzqN1CZO3mELOZ1hmVPx2CC45g
         Pmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395577; x=1734000377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfzf/FXigu03Y/oI3g125LpOVp5OZf9ymO7HAzq0gVs=;
        b=Uou3V9xjSXy5w2UD+qomLZraL4Zl0KT8CEcnhxXssgLzL7w8NJUxiFmNI2F/RPaZuI
         pvH06zlfFZHIPzBhNrK5Np84+IpewUzgxPdTy744czg0MKjetKFQPV8a7+9XZBScT0Xp
         NDuEa20uIA5pGL1yz0cb4geDABQJwGIL89WsoIjXVfEXfNU/onnMkW4KjJj/usQwcbfx
         TW1w0hfI2+HFGAyJU3zToNv65as/xRvvrNWQxMVgBH69VM0MubKvFpjs1RvfjxckXagc
         Hp0o+9+mZtnWIxYwQH1cA2/ML8CJR0yz5JtRjoWwCVQlPd28IkS+txjtQgv9n0yK+AcR
         sEDw==
X-Gm-Message-State: AOJu0YxtRGttYCldGlYyVuQ2r1xw6/jILq47Zp9ngA28OhncOt2C2Qrj
	BXVcV4EZle6LA1I/VTqGMEUWRSZK6pwBdFNn7xQVi7vNtgA58joFOy0Xtw==
X-Gm-Gg: ASbGncsjZFmDHkb2Q0wpEKa3aUhx8gIRN2iKY323HvG9YUX5aDUWRvxEzIyylqjNSgU
	pJasmIKGgqjOQ11ln86Ah7FjE9E0WSc6W+uOsEttBxK7DJ+kYkOUraNv6edtgHhKYZFffnEVUTw
	76VRjRSm8iGGbW0PExyE21KT/LZ/7YASpTPBggRjkp05Y0KulJA/41E5SeOzfpfvAl7MButX0QQ
	/68v7pXl5VYB4XCiCvVf5Y5pONUTMnI8wnbBOszuwDYKpx18K84qg==
X-Google-Smtp-Source: AGHT+IFHQf7L61x5eQtziftkZx5j1DH5qa/NZ89Ykaf+PJTDp+UWFefEELwSokzD+2DekeVp0D6fYA==
X-Received: by 2002:a17:902:e74d:b0:215:6cb2:787e with SMTP id d9443c01a7336-215bcfc4c89mr115878975ad.9.1733395577037;
        Thu, 05 Dec 2024 02:46:17 -0800 (PST)
Received: from [172.17.0.2] ([20.172.0.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09259sm9827175ad.195.2024.12.05.02.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:46:16 -0800 (PST)
Message-ID: <67518478.170a0220.de6f7.272e@mx.google.com>
Date: Thu, 05 Dec 2024 02:46:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3726822453322406801=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: Expand firmware-name property to load specific
In-Reply-To: <20241205102213.1281865-2-quic_chejiang@quicinc.com>
References: <20241205102213.1281865-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3726822453322406801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi:857
error: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3726822453322406801==--
