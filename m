Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED626ED3C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933277; cv=none; b=Vkr2VEeLGAdi9zFwsxN6VChHLqv7fGEeBn7LShMNU0MEaLDTNbJJI9wChfqzim1/tg18fucYLfzNAzE5I4TLFtxBVL6Hhpuvr0zunPT1+U9nhWeNRH0eMXaA+CqMTGQqr22OJGNTBshzrVu6bykoQc0IE0OnjdfG0+15Qz5B0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933277; c=relaxed/simple;
	bh=ySig0/1uqqTIeC1QW2q5gOiS3AdBvwj8Ge5ZKgR+MFc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JQ0UnSkB3UblkjWwrKIeROpfAgX8zYBi9ViS/lNLTA6L3rs0Tz5NjbgIMLv/E9lbHvjjxLUqT4XRK6gJogpW3xp9HqRq13GZ+T7VDVYLBY6Q3fWdr1q3Rfth8V6nBMkgk+lAxr7OD+8yhNgtcdwxkyQ8wxz+mjF1mtxie6Cbz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdHmO01t; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdHmO01t"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1363e78746eso4779777c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933276; x=1781538076; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XGc3Js2nXRl46JKZQbKJAcc3npp2lCvuFnuqDnJbSdQ=;
        b=qdHmO01t/lps632kNziPzPPK2sc76y0L+bNvDTyNWBpW6h821Fku0gXgE2qsWjQR4A
         9XNMFB0SWNSQbaZ/jRArAnEQPT+e4c2CpJ8Sf8Xek2/Hzuasx0WL9D84nYBf2W7qFm92
         z70iLgiqKaEXhDSiSp/m45qoqIZnNsRNE1ztqBM4b2Y8R+8MG8B7/EI1vFA6MKzIf0nN
         4Xf25RWEErPswUw7k8lKlswxw44pD+k1Ev2qM3XZE/0dVpKxtXtsldPAHqz0IiDKjkme
         3cK83lL2rS70WJcduHgG6Hnjln9tbnRixE5qYYkmUTHVHwwNtUMDtW5BbhS1Af9p2wN1
         d9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933276; x=1781538076;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGc3Js2nXRl46JKZQbKJAcc3npp2lCvuFnuqDnJbSdQ=;
        b=Lyv++f3a11/rct/3Pe/sbLis+/FqWmZ4UYb7L9tMgyNPkasXm0oi6zqFdNkfD35ELc
         V56s4g6OSyUmM96ut7Ws9XYx52vVcaa94ShlekWc+zryVl+fFzHTeWR+aJRvZVx9Ne52
         QF4pB6fptxjAfCGcPNuj51RZUNyPwh4/aM0a+daq8ApXwM9A0sTm6P4YcBWscTZpxxkU
         h+reUwwi0Hb47ydx/o4yPTVCFIx7q+XzKsPEet3TF+jp3rIv5w9PJ4x9qEMIlRXACnT5
         8Clf7xNH1/mXUEx3qA3DMV7NP+5NR/8SM2C6Get1C8shvC43tryBqZ1SE9i5YdjSK5oO
         RhKw==
X-Gm-Message-State: AOJu0YxPXV5c6Hnfl8AnezkB1V1ABq8ZA88LrwIZ0hGbRDF6v1tiaVQE
	wnpCuX9U1zls6+HPQRmErBLVYbtyqet4x8rk71S6gWOMSDGn46YvO9LrbG/MIQ==
X-Gm-Gg: Acq92OG0skRgvxRSxMtqVoFOzEj6n3Bvjrzj2V8qfbEaniO06iojXhOZ7ok6WbAV4ie
	4NIRdBbNc6ZDocSgYZApxnKkq9g5tDGxjkDHWC8Bh65BWRTLj6XZdzf+MLlGXRX9/AcheO7DXgf
	sR/+qTYZgXmWHzMVmPz+lUFT0exmhdcy03Tx+A0qzUcK9uN3qgOpS9Y492ow2mXuQLmwNqUmSds
	D2TyFcpNhQkXy93I8RLPX8N5nxv3nKWSOzJUSp5n3ZWf8DTlAsxselP0Cw1c7BEFTH4e0mvlFTf
	3Vtzbr0d0rcDv+EfZniDSGbeg3Dct0GnuiMtPgiFgtcSaJkBwZFN1UWj1Z/As1A7QLKT/gF0ZVe
	Bmz4IAnbVTymSEpk0JvdAo6hxIeZnXbuWLKr4tTvmx4ul9nZHqA5zWZQla/W/g5fvGAlT4xuixG
	jqR5yMRY5dEQMh9Rmrqw0fatT+uoNTXLxVjSemKg==
X-Received: by 2002:a05:701b:4306:10b0:138:12fa:3794 with SMTP id a92af1059eb24-13812fa38e8mr3308273c88.26.1780933275507;
        Mon, 08 Jun 2026 08:41:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.6.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138173e5b47sm5510472c88.8.2026.06.08.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:41:15 -0700 (PDT)
Message-ID: <6a26e29b.74553e17.cd14a.6fda@mx.google.com>
Date: Mon, 08 Jun 2026 08:41:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8422235832689211005=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] device: Fix cache update on device remove
In-Reply-To: <20260608122713.72681-1-frederic.danis@collabora.com>
References: <20260608122713.72681-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8422235832689211005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107813

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      17.71 seconds
BluezMake                     PASS      653.12 seconds
CheckSmatch                   PASS      313.99 seconds
bluezmakeextell               PASS      166.43 seconds
IncrementalBuild              PASS      616.69 seconds
ScanBuild                     PASS      909.63 seconds



https://github.com/bluez/bluez/pull/2194

---
Regards,
Linux Bluetooth


--===============8422235832689211005==--
