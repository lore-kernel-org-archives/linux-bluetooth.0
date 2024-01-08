Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B025578B
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzcvEJHv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4299a70d0a7so4204151cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jan 2024 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704741061; x=1705345861; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4w0z7yHF2CYWmjdXqIGTm4lQTjF65/qTwnBwWaxK2Fs=;
        b=NzcvEJHvjKGh1AzTzZnNZ/WWY3g6rSoK4IgmelDoRIj+8anaG/vFOgYjLD1+fWzuw0
         o3u5zTwHbU1VTjO9sfrlIZSyYWZEFv2SRmorD4ifGv/A6phXFsUuACoX2eovwlrqKIhP
         L3+Bz85Ck/WaJjz3pl65cgXzVXr3nmUEz8uBLTNWK4csIVa3KmA+K+G+OW2zpa7547wQ
         rkd/gNif1nHdHsnE1R5S+OYBgFp33kLhRIoVLwQxFUDohnt5Sg4bYdaCWmvAJ+PXGEnM
         5715O/We+BEVFNT012vg4AjKRv9uDy+LfxMsfw+canMvpq2EBqYC3zi60O5eLiTTIhYq
         g7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741061; x=1705345861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w0z7yHF2CYWmjdXqIGTm4lQTjF65/qTwnBwWaxK2Fs=;
        b=DuAg6t6oDv9/VXedd77LgD54DzM0MkvYAs4iULwCVdxKauSK5bPq5m0I1AKlVO3Bay
         aZkYarso/6tKDAag1cAWYA9VQLTGWzg4yJ7Aru9ztOtTuV+C2AQj1c1MEcJkyIMpI4bz
         FbpnqKYYdwjybF3OtrxY4yRM/s6EniJh2M4pP4ZQV3d23e3Rybr1eg1nE2kxqSMS4LfT
         dk14eWej4Jj/PJotkF2t7QQymWa39FRMAhfdmMcByCHqrqSmlUnbT4TciqOFgkRMa3G5
         BrkbdYa9beZZFKnTNv8Tvwb/dC/jYJLMJ+3qEE4nTW/MPrHwrAm0U/BGDC6oWYcSk7re
         ry0g==
X-Gm-Message-State: AOJu0YxU96BamK+Gc385tCLMAbEjAwWk84nbUgMcZ8XeUhdJ2dI72HY+
	zJyIH3ZE3MzNVxR7chr/lMrClA7l2tY=
X-Google-Smtp-Source: AGHT+IFYOSZtykEMbLx1c2mreG6KSXLz/SKlgJjBr5ysCXx/1GCpd1wWTvQVga8FzHMdKffHA7pQUw==
X-Received: by 2002:a05:622a:1a1e:b0:429:9694:795e with SMTP id f30-20020a05622a1a1e00b004299694795emr2405816qtb.93.1704741060683;
        Mon, 08 Jan 2024 11:11:00 -0800 (PST)
Received: from [172.17.0.2] ([172.183.50.148])
        by smtp.gmail.com with ESMTPSA id l1-20020ac84a81000000b004298a09900bsm139817qtq.53.2024.01.08.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:11:00 -0800 (PST)
Message-ID: <659c48c4.c80a0220.78480.1091@mx.google.com>
Date: Mon, 08 Jan 2024 11:11:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8015380658169187573=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Bluetooth: Improve retrying of connection attempts
In-Reply-To: <20240108183938.468426-2-verdre@v0yd.nl>
References: <20240108183938.468426-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8015380658169187573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:229
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8015380658169187573==--
