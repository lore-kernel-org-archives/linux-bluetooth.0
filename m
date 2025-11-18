Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEE31770B
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475482; cv=none; b=cs40gaKCelDnPu8gXhQT9ascwQIcMN3msL0VDEDg5rYBQPD/ToTFdv18HbCB8z7RqwMlas+weAZfBD2Hl9zXDH5aSfbGExxymsD1b0rP2z5gzXd90fdT/dZxsa2oUJfU3qTtpZ520S/uZPHarHhjvHoOcvBXdcitVrawsRDoESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475482; c=relaxed/simple;
	bh=2EiywApB5e2ltqRcjX724yhauXZcHBbJ/Crmy8ZnTic=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PWPGBCd2owe7DbY/hsds8DQmHF3mBscg/56gatBv1v5A9LKYqdP5ujyLeC8e4c3fSTAC1PEqfaZeX7eeuEjSpU5Uc9UzoWV5bYTSiZpz+TtDV/tNP4KHLdIFzKMGU5aFZAM1rcIpncl6ttcPDtEfsRvtvH5jkmZ4JaIAbzIKxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFVLd6BU; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFVLd6BU"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8843ebf2facso32865006d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475479; x=1764080279; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2EiywApB5e2ltqRcjX724yhauXZcHBbJ/Crmy8ZnTic=;
        b=SFVLd6BUHVvbY5GYa41TmQEWVJ1DI9k1UHkaUrbSB40eUbxRSuyEMLBq/Q+gqzYtfa
         2X9fxwCeWre13DPY3rqjcR0lu5OQ78NqlipdgK5FYB/HkrQw1fy1EctOZQee+ns4VM5J
         GKlPJvm96c08jrhy35o4zDm5Zyd+edGffjPXIPQbncIDFr19UTuKWzqDPHxLZw8JFxUX
         SCc6gIsmJgpb2tBR4CuiQFXEkXRGO5N1+cPEDqB+V9tNA22ivF4DUQcIlRJxH2YRnhF0
         pEtppADIzkPImvz1Jkiw/xcldnTE4IRf3gFvKOb/jU2HDYOe7v4mF82icQw6K+Qyf3Li
         w1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475479; x=1764080279;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EiywApB5e2ltqRcjX724yhauXZcHBbJ/Crmy8ZnTic=;
        b=RJvobC+PRX/wXOCpM/TLCQn3FndWwaknWQF/qFmCZQ/oR6kbEwtylnNF8sU+i+49ZQ
         2CVFRGs3jX9UzPc+Zp4yXLQZR8wDPt8s1RZU9pufz5u8rc0yyx0p2+koPWUesoBY8QzO
         DHwadMMwvvYBdMU6hENkXgbFCh5VrvsUE53z6nMNsJKyp/Mj0oZXplyOVmhGNhWd2DM8
         rrAb64y6BuRUJ5uW84k2leJVZ+TZRVJf7meTrDJvZ6urLQxaUfnZ9XLnVLacR5Xlpk3p
         ZSKZ4CjnXPnhm0lmu697Nur66/2K64tECPxTzqnHo7qGo8A0VJ6AUFD8IoNWf5fJwCIA
         2Avg==
X-Gm-Message-State: AOJu0YxX2ZW71zBE1t8hB7L1EYhT1blk9jK2si9P8vFUy7fNYUK8aeYf
	cftxy//t90e+coaLufuuEIAsJKJxEKKaN/uqFnJoNVx/4KZUo5VzgWTaSephWw==
X-Gm-Gg: ASbGncs+RkxdDg7ArA0h+kdi7FzCNRHZCEy4K6EM3mYEzunhP+Sv44mHbPEV6bJAkgl
	zQRcFL5q3cctI2XordQL+VwdDlZ2dExanF88Ena8dylVuqvbWTIFPdHNW3Oy+p1izJ6HvXGer4y
	pK/n86/qWWKhX+1wVVaqk5PLge741PBLJjk23gnUhNPCF5xwa0fAz2toWTJQkoP0XuReOuQQxER
	Pc4K1xMtV42KjRwIcOqVoj1I3ubILFc/RPzxsG52b4JhkUJR27ny4HZctVtb3nuYDVDm5dIFKN4
	aMXq4F4+/focn5Rdm15V3pCQ0krm4qEYJETy9wefkR4uL69lAN1X5i3J6vUVeY3KJa15nOcgjZ9
	lBrdoojfckK5Sd73iEY+GqUrRpZqjs2HyVrg2RnSdrV/ebR9GAzSs7y/yxHiJBJOyA75HGCIkMP
	omzrDcF/ksiBqdx6fO
X-Google-Smtp-Source: AGHT+IFKMcdhEF5tp0KMlQs0gmpCoAqosJsX6gDjADs+57vVfgby5kitqeR2aIdGO9KLkTmA74lGSw==
X-Received: by 2002:a05:6214:268b:b0:882:3b63:f7f5 with SMTP id 6a1803df08f44-8829263b292mr248959496d6.41.1763475479445;
        Tue, 18 Nov 2025 06:17:59 -0800 (PST)
Received: from [172.17.0.2] ([20.161.58.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286531229sm114211266d6.34.2025.11.18.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:17:58 -0800 (PST)
Message-ID: <691c8016.0c0a0220.1bfdc0.b05e@mx.google.com>
Date: Tue, 18 Nov 2025 06:17:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4718879867789465768=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
In-Reply-To: <20251118140406.1551669-2-wei.deng@oss.qualcomm.com>
References: <20251118140406.1551669-2-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4718879867789465768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qcs8300-ride.dts:71
error: arch/arm64/boot/dts/qcom/qcs8300-ride.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4718879867789465768==--
