Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF13264D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140758; cv=none; b=EuGkfmrTt/6o62LfilgVqERvCJ1gPWfHchU2thtM1WM9vnpEZRllt/WfcHGFe4XMoMTAqMsLwNy+q9hdE4qGoCXdg56Eau2MyVlQUiTNGUjX7qgGQ3+nocCT33QKK6rhMzrQblwzfYJ7rpSB6MZqssR+7pMkWwWULu/ktQe6MCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140758; c=relaxed/simple;
	bh=Ng8QGe57Sg63l+SO46izFL3Z4Io2JHJ4knrV0F0jQX0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OC+8lzApCu9iNLh0ctVUNxhbbpNvfuslKAPUdclUAyDAlv94pB3gVrkzvvAF0mHmnGd6YRWDx27pyvnGS7hb196JbtLpD6eQvfvtZXu+VPIT2DvF046EOotecIwaR1S9SPZl/hoZ7N4MhaBKH8/VsSkMKlIvmrRzSZoflqb2qM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6xUKdlv; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6xUKdlv"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso53309666d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779140756; x=1779745556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekyl0TN2+NRRjeS1gEQdV65SduAJzFKhkVl6SkWQ0oM=;
        b=U6xUKdlvTT1ONqVpfcS07kMHAkrOpLwHR5W8tkMGRGEiq/QwFHudvPgAgVAEejBa3D
         XCQNrQfolJ9/CvuycyGEmrD8c91SASrSF5GNuIFxg/WTrrWwDy3PJ7PGHsgaE4xm7tD/
         A3jJGbAKHeNOoELzYGEf8RBoGbUQ0FRI+STGkHjRxoUxaIKe74Gig/LIOBK/qna/HnBr
         fluM4hygtJjfncCn6bGQ2emyqtLsiy/J/uepJX8zxNtNZNajmSZwIt8cKUFRaSIGZoDq
         XTLuSY8wVBjnH5m7pn3QQDJXWAwE5T8O8YtivQzawg1DMLUhvTwmLAYeZwAFCBcEE+X7
         NpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140756; x=1779745556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ekyl0TN2+NRRjeS1gEQdV65SduAJzFKhkVl6SkWQ0oM=;
        b=mgAnuN9B/WRlRAkSo51BVoO0GbJofi9C9qQJ7Rm9KFFoTo5Io8oC6PyYAL5yAGNc4K
         QddPVrYAiGJjql6Lauk57k1eVINYiQnnjbCgEEAat5kEHWDEqjVBFWtAN2CaS3JZI47q
         adGUendpXwxM6UCCWaYHw6jDyg9uYHlnfLKmSg3ED8T4l11oKw8D9l2D6fRqYI76vieA
         Y9qN/QKzIu08PTz0Q9SrPIW4eBmSjpzs7Fvyq9SUAOyGy7/Dis/HdyxIt0ScOBVBIWNP
         ipAxfdzavYdQ9p77jf4sSs3/Lpa6J2nlYWasTQy0DVziza0hZ6DmmfXlWmX3PoeNX3XT
         WpBQ==
X-Gm-Message-State: AOJu0YxJLAqWWClKWgVrkgSWaO5MzkHwk25jodJvEVQlO2rgmc4LVO0Z
	WpI+OJ9TTxnSf3ggzpRIDMXivcVJhvtjC6Gw3X6u/7lmVekeG4KmliB+CZBrww==
X-Gm-Gg: Acq92OE6hLOa6tWGT+OxNXWl37CMo9jMDydRIfRazIOn1zavtLpSnCzz3/NXxLANzgl
	Wuz/uqqvM3xuxNCG/P8b7bt8HOumjWenbLmSLdPziyRQH+2HUH9JeNPbzjyG6mMIb8m7I9ZU2vH
	Gy6rSq30qeGkgwRnnTY/0vqGuLVXdO/DhV3AFBBpRinXaHxjSdfa190dTIHDDjpdi6xlb02P060
	JmIBQdiWOi3Pn9lC/uIAHwQIvKeiId0VJ3UrHTjc3GlpsbDWxJdsUTDvFYd4cUVeClxsujIytw+
	/R+TzkGVvxfczqMhi488ZXNuJwzFiMPXP7UvHoBSpbGnTZP6qy1IsLzr6m7q/ncwpODrX0zYDbe
	ShG57BxtV/sx8oL8grwJK/DGX8bq76qS2AOAG/TQL95eGBCq7ZDmJake93Hpg/xwjr51D6ZgZf5
	cc+A7F2VLEuPJ/pMMw9q6fiPhv3lrWNok1FKwOp9zu+C8=
X-Received: by 2002:a05:6214:2a4d:b0:8c6:2245:3f49 with SMTP id 6a1803df08f44-8ca0f6a898cmr279706456d6.32.1779140756282;
        Mon, 18 May 2026 14:45:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.254.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360b362fsm70230516d6.22.2026.05.18.14.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:45:55 -0700 (PDT)
Message-ID: <6a0b8893.9d661370.37768f.3273@mx.google.com>
Date: Mon, 18 May 2026 14:45:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9104009976007353630=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jarys.cz@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add Realtek RTL8852BE BT 0x04c5/0x1670 (Fujitsu)
In-Reply-To: <20260518210335.1105068-1-jarys.cz@gmail.com>
References: <20260518210335.1105068-1-jarys.cz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9104009976007353630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096857

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.13 seconds
CheckAllWarning               PASS      27.49 seconds
CheckSparse                   PASS      26.45 seconds
BuildKernel32                 PASS      24.51 seconds
TestRunnerSetup               PASS      520.86 seconds
IncrementalBuild              PASS      24.00 seconds



https://github.com/bluez/bluetooth-next/pull/211

---
Regards,
Linux Bluetooth


--===============9104009976007353630==--
