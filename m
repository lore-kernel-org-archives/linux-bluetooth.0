Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977A1847
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172194; cv=none; b=MCT/xR+E8Vp1Y9NUzkpUDQ9cbV0zlhDyGXHVu2+ni8JpQjNRdFJDooPZfUu+mSpD7P10wYELjQvyt93t8Ed56fukUp72Y/KT6r7r03fxuOmbz/8NBfsKvighdNI6XN8YmyLuUd6p5a+3cPSASZ/Fm3vJx7KkF+vXOhEu8bbbUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172194; c=relaxed/simple;
	bh=/RTlvCgs/t8L6SWG+QrwpNf90ndLM8MINAAE7gc84CA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GhbRn9EDBf2J3dbrK/o8aOsJq68kRe4/8+WDI53/UaCb98YGIzb/3iq7joJRF9ykmlVm4wPh9rXjDYyKUE5ThvJX0FLcPr03duq7k5BugygK47H6KjsfOnKGFmtHgyAWRinFAI6UJeHQDD3yPfDfJ9UdmXfO/GBfDkOtl3gbCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyOs0RIX; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyOs0RIX"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b31f2c6e52so802777eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2024 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716172192; x=1716776992; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/RTlvCgs/t8L6SWG+QrwpNf90ndLM8MINAAE7gc84CA=;
        b=JyOs0RIX+Hksashj/z442/9WlbxoBD503ivEMywI92rahczjU2JIw7wRXcCGfdIe6I
         DRfJNuoLYM/+oPPb86n39Jy6O572lqSi2luR0kgYpYFyJEA+4YA9vevqni2Pg+zrJKl9
         IRVKvhupN1DQGHrw/j9eKkf8rrUqao+6z2yur2OOoEcrBS/veVpKU2RLWCyKOqTsUf+/
         WneoxiF47iFiw6tb9ujqhyxtCjPkrjiTqyi+pqpuif8IW3DD45n8aF63gp9UaS08QpOf
         Avo5xQ/6A4PtAHO62vqyGAhRwUR8wnwRGsSBvHp1cJ/q2iS6jxxZu7ZW8tj7dJLJ8A0d
         irQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716172192; x=1716776992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RTlvCgs/t8L6SWG+QrwpNf90ndLM8MINAAE7gc84CA=;
        b=lg8hfddqyOR6qpw94cPZ3xpu8QGNNizPMx6LoYgV9IpPbOw7u7PKagXTwjFmTWLfta
         oE5sPY8IaFgumfJ+0J3mdLGSao1H0/YjpNHcMy+g7CyHk1Pnvg7az/d8aldUANkU+OTM
         NdKz3fD27Ku7xcSs3yZJUqfKzzftsiQxrZawH8xR5C34tQAaqnw4JFDv4avQkGa08z1H
         UKXjnBTXcNr0unCHgipVfM56IvKnm35/aQAtOucZGEJcZVnw1riV1Dou2NA0F7qPMiac
         F105WXYSgVCgigw460TXIghtAwjOe+DVKRQG9MV/1DtG/UxlrOb592wxaqX0psBE0cut
         HZBw==
X-Gm-Message-State: AOJu0YwKnGFE0cm3YZwzfiBsj4D7h6C/LU00pOAwrbSObxIsJhBPoRrP
	Roq2GsQ3YkTFgpeaXBjeEbQCCVlZU7UljoK4CAyT/B+sIw/I+xq6HOfRDg==
X-Google-Smtp-Source: AGHT+IGZVkf4OC8Ep9hSMvUjPA2HTYH9cHbuCBPt/KrR7fdcQ/xZliV9RUsFY4Vn0P1XtShTNcw8SQ==
X-Received: by 2002:a05:6359:4593:b0:186:131e:822 with SMTP id e5c5f4694b2df-193bb50c2f1mr3158016555d.3.1716172191822;
        Sun, 19 May 2024 19:29:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.5.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-658c79ca62dsm5795655a12.92.2024.05.19.19.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 19:29:51 -0700 (PDT)
Message-ID: <664ab59f.050a0220.4b733.e70c@mx.google.com>
Date: Sun, 19 May 2024 19:29:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1669941453508903916=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suhui@nfschina.com
Subject: RE: [1/2] Bluetooth: btintel: remove useless code in btintel_set_dsm_reset_method
In-Reply-To: <20240520021625.110430-1-suhui@nfschina.com>
References: <20240520021625.110430-1-suhui@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1669941453508903916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel.c:1364
error: drivers/bluetooth/btintel.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1669941453508903916==--
