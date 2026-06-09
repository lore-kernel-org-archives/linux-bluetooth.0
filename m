Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E63F0A85
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046394; cv=none; b=qrSTU3jzU7DxCCq3+nm506woYyBUlJA72AS4YRNieLB+RqS5lJAwpmQLO5/CgRtTAkQiGvJImMzOBsFkdpB17oH6cQCbM/a5VnjySC2ZlfaKsbidfII9KF5LeBkyVMqppAUAehf4zr++kYkKfGjWSgKYH0jtjrvG3HFkT7DJy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046394; c=relaxed/simple;
	bh=eOmCT/xbQ4uKm6UN0/oTAJrQ38oiF0C542PGAxxHOiE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pAtSn59bfukEw+b8QtkxflbmrpcexNRCJJsnmikA57/mrNKq73AFuAGwyfSAzCk+25umR0WyCSM+hJ2sbIBWCrHJK7yYajZxVGsR37jvaFrwjUwb0XTuLFOgB5zdlg+sVQJB7B9VgrKKvsJwTIeRY3wFNpR4rUh2XbGFg/I3VGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au7a0M4d; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au7a0M4d"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5174a3d9598so53094101cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046392; x=1781651192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WYGzWIO6VdEPBEAe3KMxBWXPQTGCKfpIjBJt1RiRke0=;
        b=Au7a0M4druuo4mCY224tIQm2fsfd01aAuc45km1bf5W23FMUTRqC75FGHBn+azQd76
         Tl+e+I/Ck8eOCuByXNlLEHq7/e8L/khrRrFP+vMeGqGxokIAIhXFz3g/LZlam2Z8hJL2
         jySRNryus57qrMmK5QC9RhzEmnt2iPqpaObXxEhgj2iAHeEwipVIfvHTXryHxjJTrmRC
         oV8GJr2ZP0wfVp4WYD8ZHLngxK45P30PRUu+XtJ337xaQpf+oKXl4Wttf33Y68RwZHIX
         ty6fxbthoJwnv+qCmVnaAcP1RpzkelrIvEMs0cBAQDS4uGc66XAH83bneW4A/JGk/PM2
         Zdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046392; x=1781651192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYGzWIO6VdEPBEAe3KMxBWXPQTGCKfpIjBJt1RiRke0=;
        b=PPOzME+tF0IKaoyIhU17JIK1yq33QmCv550GrB/sbCSrvXIeRqXuIR0T581MG7s5JV
         vj0kN67t9TuJi3VA3CRQL27VxEmRzs6m8IEDiyxEsmb5pA+F/FJ1hGiKqF573MsstbI/
         A4FROB2vD3LREFYUcBUOrsiLVEuuSVfOlI50mRa9RAIYTMp6WYIN45nZZ1pVhLbMwqaD
         fnY7Ht5kY32uj0cN47SiZ4IcdYZyQ7E/tlmxxzbPC8s+ph/5SOTPXGfPXrMhRzXlXbqW
         g+cIjaDom36DaEHD/TmiX0Pt+GlcL42MgeuQbqp/I8gexrNrLAUYKP2wN0OeYp6WjEmK
         w0PQ==
X-Gm-Message-State: AOJu0YwOQbf106/+CHQhN+YVXksIbTOwzEcMHOPQFPt3u4YEdch+rDCU
	nuFz6v82EEaJAq7Wj9a3PV82aG3OaHkIddwGaSmhrryt0MZo0RmTbgG2Jm1Ucw==
X-Gm-Gg: Acq92OEsMfMXxEh3KOpnh44Nbq9/V1EnFXlxK16H9vFbvbn01sG7lueIAnACFEM4GbN
	P5FUzgRvj3qFiwFIm+24AIFQ2BmtiQDM4k/mSaXangg7zUQ1iymD5gQ/Xg/WTQG5Fg0OhwzkyoV
	02rFb9Wxn4ESmR2cOQnbq+57pyn+kI9u7yHB4xynmBBsftO/J9COOhsD7oe1kgHaFYREHuBvNRx
	/8Ix2a1gZg9XN9Q/9JbtJPvq/XhZhCzuSqenSFYqz2NkXpe9y1XKP3Jwp6b9/C0UBuq6AZF85Tv
	Oat4zsSpv7zQIEkmJLhQoXKXM8Rm9upsA/3G9g836UnzKzNPXoSKKO+l4s94Kugg6k3dTAFQHUn
	1n2KqGzRQk1R4OOxvbuFWkbDlGw6UWqZ2yecQDgAjOs4+TZFd1xEmytdCzKFX6VAMSzcqhnIWbu
	Z8Za5GH690+IRVuruluWCbYI2Ak+cXvCL9ZfzuJFo/
X-Received: by 2002:a05:622a:1811:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-517959d5454mr320434631cf.11.1781046391777;
        Tue, 09 Jun 2026 16:06:31 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.191.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm204177901cf.23.2026.06.09.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:06:30 -0700 (PDT)
Message-ID: <6a289c76.04ac118e.a66e0.5f53@mx.google.com>
Date: Tue, 09 Jun 2026 16:06:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3353195043607503742=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] avrcp: Abort continuing response on fragmented CT replies
In-Reply-To: <20260609212656.3900190-1-simon.mikuda@streamunlimited.com>
References: <20260609212656.3900190-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3353195043607503742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108830

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      650.26 seconds
MakeCheck                     PASS      3.37 seconds
MakeDistcheck                 PASS      248.95 seconds
CheckValgrind                 PASS      225.60 seconds
CheckSmatch                   PASS      353.04 seconds
bluezmakeextell               PASS      182.32 seconds
IncrementalBuild              PASS      659.64 seconds
ScanBuild                     PASS      1039.95 seconds



https://github.com/bluez/bluez/pull/2211

---
Regards,
Linux Bluetooth


--===============3353195043607503742==--
