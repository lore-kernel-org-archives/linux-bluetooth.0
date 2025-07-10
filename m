Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8FA28C5A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135804; cv=none; b=FQeFTtwf/6awXs/HDH3wgkHjt8RhWpEoLMZAF1vLGalGpXnXz3ZacPdwYEeJxjDD3KWPnRJ7mj7jAPMFQWLBSFMoUQebVEGkMBR2Ims42n9kOTxrPLKekXZlnqjmcImcPVcowwhWfD9G1qwKvNMC2uSRWRUC6tZQ3DH3y8WzOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135804; c=relaxed/simple;
	bh=TAWvv+TOv0yOHPp73BanFR4HETFhc5HzGzA/XAJzljY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M0vYiEpGhtxkF1ABaikscLn+ML6o1Y15PaMf6YlGMGc3ZHHlXN9kaBfv93J1r7bmnVIRG9quYeSOg9XMUvgDJ9F/t5AaC0eQhlxWzhrfxDLwqkIUMVmgRhSJDjCYvRgwssPbUI50eS2BA2lzNqYAsRtz+3BqUu4YNE26dVxiRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdc0Pl/+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdc0Pl/+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d467a1d9e4so160942185a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752135801; x=1752740601; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TAWvv+TOv0yOHPp73BanFR4HETFhc5HzGzA/XAJzljY=;
        b=Qdc0Pl/+i9odSODNG0FvIFFeVA2aXvBW6r+GRfllBGVId75e1f3upCj2zDC/q48kUD
         nv/lqPWXooTstwoDFMfsUb4gIcu4ZL3hJ4ReR8zV7dBUvSj9m2Ydl4jWy4jn/x6EPzRf
         vLRLhAnPgMKeAhyHZaLGeHR0de7p3E6vuY1eLyUcyvmNT2FSoua0rH4HJf2ZatxpOEzH
         r/3NugBxWuMlbY7hxZTOOME7g1lo3PrV/4B+s6GqmTrOLz0VTbDDOTGJqrBDgmgZzGTw
         AT3ZGUdcj3+sjTpSB1ZjXyi3x+lKIfbpfYKQTV6h8pUvodB/nzhLDxAN5qtnT87LqRXY
         CJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752135801; x=1752740601;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAWvv+TOv0yOHPp73BanFR4HETFhc5HzGzA/XAJzljY=;
        b=Pdm7TOZZtuKjxdUiyBssZcCAyu2yWdffB2mAx5XeCpdgCqLLR3tiaFi91k8ykONYqR
         TfrZhPfN916TTFmrnMsNWq1dnKHRiV3u6kInqj+YrWdWklxlGLtupD74t7oDLV15DjVG
         MfCSzUI/o9SZHgNGTaSpEBfE0C60D0L1otKlTDqFkTNZ/JljIlBnqI8H9ypfV4PC29es
         8+Y1esN6vqmn9cQFZWp11tUJ4O9bH4T0I+hlRQU8vP4tGPGEAdOpJwnroWPST01bycgp
         ZQ4fNvdiU/5mJcEdEYg+w8wNy2aO11yNJGVnceSuY5Q5e2AqLBbIbozMdlVpDYHM4X1T
         qyTA==
X-Gm-Message-State: AOJu0YwjeIAw0hRFWlfMlRLp2K1M37+zrpU/a+od/S8wc10AYx8KLX7F
	3/Zkh8gYNariSV/he8Y7L1sQEF27mQ9lLaZdC2UceLPGyPIQZ2U4H9QEkwtGv0c2
X-Gm-Gg: ASbGncty26oztN1s+k6UjaQsG4SJ7BmGFDC1e3A8Y51FI7CTbL9+5/6BWdpQKEXIhG0
	9w/yMMBbP2CYn4O+esFsmJ+nbhuwRFTzDEPSxgyZDmjAWg39MRDIKzVSaaCfgXY5RtpJxP/lCWS
	Okm8GVXLMjZGWrE3qvbj1vVqOmYo929CQFAn0tJDcjmFwYLWsCS5sSLb+2XYFahElVo7LSUcfQ+
	9sZn9bkH/pvM9vKYHg0F7dMvRFOJcUt+LoXLfVtdxgJgUV2axEeEGcSVmEnYmpbI+/KC0i2/v16
	7+rAGOPGGcq6H3WK2dIau+0fNasmQxUP2ZnWTndq1N8av0urSk4zCuQkyoA89LB3prM=
X-Google-Smtp-Source: AGHT+IGEbNmXKjqPMg4N/y0iJMdLWhTexqd02f3OAKYUNBhx0arKWDFEa2wLBRd4YAxgRaLVFDuOWQ==
X-Received: by 2002:a05:620a:4891:b0:7d4:3c38:7da5 with SMTP id af79cd13be357-7dc992eea64mr362738885a.14.1752135801055;
        Thu, 10 Jul 2025 01:23:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.73.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f705fsm75827985a.33.2025.07.10.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:23:20 -0700 (PDT)
Message-ID: <686f7878.050a0220.756f0.10f9@mx.google.com>
Date: Thu, 10 Jul 2025 01:23:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3855242170256451696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: Bluetooth: btusb: Add RTL8851BE device 0x13d3:0x3601
In-Reply-To: <5D4383E66D4177F3+20250710080028.177664-1-wangyuli@uniontech.com>
References: <5D4383E66D4177F3+20250710080028.177664-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3855242170256451696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:515
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3855242170256451696==--
