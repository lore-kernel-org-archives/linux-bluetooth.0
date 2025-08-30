Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6514A1E
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756597078; cv=none; b=qO34TuPnCG6XRX31HTiW++UThMGBbPRX6lireHtMwnkP5by9IHIVNHchbImQ6QJ+Ur+W8CLGbZneu3laDYFzLLHoSLJHLOp5FFsooLfaBPspx5Z7FWoN8ggf9Zto4amK5cOZipFI8qB61tfb+Q5M2e73w1qXHgAlvd+VzEIZyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756597078; c=relaxed/simple;
	bh=XX0F1G4NfPBJFQFWzLaes7z2HYqxGRGHZ3qxM08GhxM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IyoIwbvZJwgSTTaExo4zt2NtOkHjVMAfiBEUMftM16NZDrnAeWT1zvd4BYWLkZ+B6vZB0Mer2XLfUhhAwwzaMe2q5WTM33pxyotZOItFHbp7dl7z2ZuWTMupOb+n26yiaqZMyy/9y3G/60mRqUQNi+XmPqJrbUyENJoGMQ5WvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJZz7CJD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJZz7CJD"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3f4d7feef27so2038075ab.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756597075; x=1757201875; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XX0F1G4NfPBJFQFWzLaes7z2HYqxGRGHZ3qxM08GhxM=;
        b=OJZz7CJDJtRZMhwkHioJjENUGjwasJUJDIbZo0JqkFzaXwm4gQi/PPEJsFacV6rDBf
         x6zUUsqJ9A0hHbeosjk/pie5fgBwPKiaaBdbbbbsywIrQBXgxHHK3XFP4/69fCLAfrdO
         HMCaeCRtxI0wejWz03zWQlV6MT3vJFA+h1yrlEzNdrMXA+13TuVZUcSa4w6on5U9aQ33
         mrOJZiOnsRhbB6oFjQwka7l6GLbtIFfoj/UDl5jCPqrgHmMvijO+6hOnHA8H5rzj8Zpk
         sfd4BewnIW6HSKiqEJdagRXpwuaIf4EcmrbPkRc2w9EezoZ3x3klSyNUyLgvfEkQP3hX
         9RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756597075; x=1757201875;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX0F1G4NfPBJFQFWzLaes7z2HYqxGRGHZ3qxM08GhxM=;
        b=VEH0Zz4ir9BilmMFOaB7eM24qNxXQqMLYDlGWiMY5IPWez4ZRNsLuVbbnPmBzvvn4k
         D/pjeH4WM3y7Y2jI+G0YXLTgS2P8JaJv4sxs5WKQ66kqbJyyAKR92nrRr9Ph8Vu7ey4m
         cO2FIt0R/CLPzkOSkTxmN89zFOinV8pX6cAh0ZNiKnRytNT6QNsO/78ornbc/sTQkroK
         qWw4ir356KELJupgdVmkmjPEvIIi1gFBp3nzM4+pv0m+xuNUsGWNBldAYRa/pW0tS53X
         7LQ9CvSGOK7X/d/Sj4ApAlkXllPyrYfOv4Ov1fY4vUrFXWaJsBj3wNVj6n9/8PhwQv81
         60Dg==
X-Gm-Message-State: AOJu0Yz92P4/sJpMCw+/vAPthk6C+xd9pUWIu5X1oK/h68MLn6+QWxVV
	LXotluqjGLpSaS3ZqcrH4/e2yzF9qVuojYpmuoArDq7tfox0v81rEqTrA+NPQA==
X-Gm-Gg: ASbGncukuuqBvlWiY0c0jkBFNU9B5mXrioTKHna3wYoSUm9BByJbFLxT++767cxwW2h
	HYE3Ecptkv/YxlRQ6PGYAVVkMJxOgQs5kc6mn17GkZ572aLTw8TlrqnZle0izTLx9RDWUB2wHWf
	UEOLrTrZY8mvb2mNOP+0KeL8w0lNd2zcORZKfGhTjvpsRtP4T18+Is6Lf5By10qZkdulPiClhFa
	hvV8YqDuRgRHqxmTZ+NeLjrDnUX8XAwjSjgixndH50ZFWR3szTk+8oDK6Mi5fV2ZLRxwq9gd5tD
	nOctO7WdLoMIqCvy44KkRG97jAQO7iXVsIWjRtSZT2sRyrUxmQklhKAYMq5lZRFnTO76/dM6L0X
	nEmyCjK+WT04RMI9bW0GCAT4ifi+EdmSBkfjEkTdarm9sFLbtng==
X-Google-Smtp-Source: AGHT+IHX9X4kIqL3nmyxldt180a7uYBb8iLIrGbnB1ied3spGd6sINtxrK2yojf8qPim/LvlH0XMPQ==
X-Received: by 2002:a05:6e02:144c:b0:3ef:2fe3:9a08 with SMTP id e9e14a558f8ab-3f402ab5f52mr70183605ab.28.1756597075436;
        Sat, 30 Aug 2025 16:37:55 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f39fd0bsm945352173.70.2025.08.30.16.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 16:37:54 -0700 (PDT)
Message-ID: <68b38b52.050a0220.2339e6.1ba1@mx.google.com>
Date: Sat, 30 Aug 2025 16:37:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7327869442603425274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elespink@gmail.com
Subject: RE: Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth adapter
In-Reply-To: <02cf444e-d05f-4af9-89ce-96276e29be14@gmail.com>
References: <02cf444e-d05f-4af9-89ce-96276e29be14@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7327869442603425274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7327869442603425274==--
