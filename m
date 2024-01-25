Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E51CA82
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177630; cv=none; b=FFXdo9XhnkPGZV//xzgv51INI1PkKDG9FPbz3x2CELgH08iu3aM5eGfUU7gM03mTMai/akCZa/ZptK6SadH0n59KfhKnoXjHsPvnHTQRAJFgUYatOEczkjOm9gK1lUU3fGwLsR48HdDY5eXl/6yYs90PMX4+e8Oqn0TeT7J/LTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177630; c=relaxed/simple;
	bh=TNqGeh0kBAqW63IW0wq60AGbg+Xpausg6BD7LytSREo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eFGbIz35C0i1/P+rEdXM8Cu0cYlT9Bmn1hyKsbFNrS8x7O0Jyz9XhnQbKpRRGBVeACarn+iHejAbZR1EFL/ScVfSgq5zEdqkGjuJ/o6HcMgEP4HjPB563vHJ0K1eiJpkjRO9qK9LV1ailqo3MDlAWoMrX6TYM4QG32OPmdddEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8h1mgHY; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8h1mgHY"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0a64d94d1so3900788a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 02:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177628; x=1706782428; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TNqGeh0kBAqW63IW0wq60AGbg+Xpausg6BD7LytSREo=;
        b=E8h1mgHYeDWhmgZ05UDWnDCT8tQaV+PkV/PrQQSJFGQ8IjrmRa5mgIT7Mz3yi8YvB0
         u551r3wrtLsz9nVKQs7Nccrsm5RLlSs2qstQRQXSvNH4JuL/gkM0VdZpCW0aDD16IBp/
         5bElAa/3R/UMsrJNGZkdM3DXxzBJNgcWcAb+o0CLUyUwTYeAF9Rr3zJxOIaHOSbiTMIt
         +b/0M96rJhVYKLsa9XwX56Kg5xYlfcDMux84gfTQ3uhXLmDi6sZLX7yUCA+6Be8Hfaeh
         gq4+NkUI/Ijt5yYKpypS/JFtWxYIsaWHnCooOcvqy2j4iLdTeUVbDJVZ8FgBDIUzSMJA
         m8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177628; x=1706782428;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNqGeh0kBAqW63IW0wq60AGbg+Xpausg6BD7LytSREo=;
        b=pThF8OE2T7sVg4R/2MqdQdnTw9k2RKxDVS/OcOtiaxPKbybgKtA4OHS2INdtxrwZo5
         AWU3bfcC0cb6pRIpcbzBbRF6FaCNDPWVDY5+Z9MedICVJeQmd4mn7H7Opez663/T3U9X
         N0KWvtSiUATSSSljKQJcQlR9XbTaQxzAiguaHmltpeLJljstU+IaZ8/z6H5E1Ea2T0HB
         PpwSitarFwfo4GiLk1NOENJ3rBUQwOa6x1SHmSDt/7+IxB5jwG6JLozXKqpKVuwIA4eI
         h6V/Js9htwRhOBZD3JaGXJA6Vsp1M72ljLbjw6Q34PHDQ5aJ3+ZW4y+6X9wrV/gUjuL8
         DTiA==
X-Gm-Message-State: AOJu0YyMbl/RJtDHisJQokLGY28ehevdZgx1NwQJslVLUvEruR/Zc5UH
	zir/fjJQ1Re6uzZ/MqDXRnTPxiooI7rEbEmVqHCN7tEOluHZvijwYJL9/DJU
X-Google-Smtp-Source: AGHT+IH5fQ1zfbGlK3qOgVm07g0o+hGT7uORQt+B0/hM983l5K1mSewqgWtxwO7jeHDRmNQMCvWIjg==
X-Received: by 2002:a05:6358:889:b0:175:67e3:cb28 with SMTP id m9-20020a056358088900b0017567e3cb28mr597935rwj.12.1706177628315;
        Thu, 25 Jan 2024 02:13:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZaLOQqrJnDbB0GaZFkjhr1TYm1cRVxSEZRG+PXgjwE52SFt5VmB0YXbWTA3/d+hLAWRok/R2hldim2MA6GuHqvHE=
Received: from [172.17.0.2] ([13.86.227.253])
        by smtp.gmail.com with ESMTPSA id f11-20020a056a00238b00b006ddd182bf1csm870960pfc.46.2024.01.25.02.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:13:47 -0800 (PST)
Message-ID: <65b2345b.050a0220.a9278.18c6@mx.google.com>
Date: Thu, 25 Jan 2024 02:13:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5430442705292337591=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wenst@chromium.org
Subject: RE: bluetooth: mt7921s: Add binding and fixup existing dts
In-Reply-To: <20240125095240.2308340-2-wenst@chromium.org>
References: <20240125095240.2308340-2-wenst@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5430442705292337591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5430442705292337591==--
