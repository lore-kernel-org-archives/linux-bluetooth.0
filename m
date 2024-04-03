Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424F17C98
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164310; cv=none; b=U1lxoHbFGrz3AYcTgmu1USojGvWswKN/ih5CzNymH57uUhfM4NFmDnLPH9QQwwuOSF7gByB+9aRlEPqZ0kTjknSNAga8F+i6xFAGJoMM8Ds3AerU0VR5H1cOL0eV2+9rqXdOa0O+fO/NhxfPV24x3Ygbf4KtzhRXYqH12F0ST9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164310; c=relaxed/simple;
	bh=zAsoqBD+5mOdsWA3M+Mcin0sEPxCDYfrnKouwA+msCU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=leixvZaMiTBPUrer4WYM1qkWIyjxVerFXyk177d8QFQWvGG7XvPzyqSe1MNkgDrs6sMEC3r9aCju/0zoh/8pgpnPHt1ytniro9haE7gFYNz6lxPOJtoWK0bMb+O34Fj8AD6uv1Hnsv3zyWIwRIx/VrGq1EJb4kZnbWm+oIyaYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbKUErxM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbKUErxM"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so49535b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712164308; x=1712769108; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zAsoqBD+5mOdsWA3M+Mcin0sEPxCDYfrnKouwA+msCU=;
        b=XbKUErxMUnoUnKVpDdTZLbnW0rRaslAymChsP1GAwqUVrIY065ycmszUTsdWdkmuUq
         hTa5v+1lHHlOFPr7ipYydXHWrZfZdvjy/VwYpIeK6dsDRrcq45zdQheWrObttytpX3ch
         g2xtucsYgkDaYb+qI940GhaZQ1g42EUTd1pWzyCf0RdprWDeA9BDu//yHJEu+ikZiCjV
         EoQlVnYAGoLTasgb7p5kBD9+LxXhz0NEqORV9T/1x3ikVsf5HVdlwVFB1BlgJIejL2mJ
         7arepZ45vDC+MbLWr7qTjp3Qrjbe/71xvQa3If+phNKvmFXmgTqhTx5dJF7QVsoxPTMa
         4ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164308; x=1712769108;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAsoqBD+5mOdsWA3M+Mcin0sEPxCDYfrnKouwA+msCU=;
        b=Sa9zFve5cvKSC3KIQfX/lq70H5hIDjbQR6i3f2T7XvqY7XW7h9Unon5052XOOcEwc+
         oqbCTMnjC0CHAOv2h41xMpDsUWfwNHHLdTqgNEuVnXqhWIO63Kkl79SUkI7hOo5maonO
         lvjyC2E8DE/hWp5NahbbrhRFFNYTSBJ+yfb6J1oBoHUOxgl8p4egFq4eVnT5ikzHtSMp
         bdCR9BxEvkKgs0EcjiQX9pQFCjANrt9RZpue2tJfq78nv3MuHteLLOWsKf/ICZvOxLRb
         14FW08cEe72rHNgCytUQjqUpdHoyT7bE6L7IV5t1iaDsFVSPvfSUyjD3E0xTHJ6tjkET
         0CNg==
X-Gm-Message-State: AOJu0Yy/3Y8gTYrU1ds9/HqK4vtYSonog6ESHMyI21oiJIFxicxpIwGO
	5kADQ0wJHPNFd21iPbuPCTXe0zCYhuSsH/8AQ4MZOx6cumMxjT+aTJ4JSAyA
X-Google-Smtp-Source: AGHT+IHUspbY7DDDMkH0B8X395nnUksMRYnNWtDmhEtNBBkllw7+fC5HTc/m6qO0Tma32fTCIc9HtA==
X-Received: by 2002:a05:6a00:809:b0:6ea:dff1:5a8f with SMTP id m9-20020a056a00080900b006eadff15a8fmr4170404pfk.16.1712164308192;
        Wed, 03 Apr 2024 10:11:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.210])
        by smtp.gmail.com with ESMTPSA id g21-20020a631115000000b005df58c83e89sm11862261pgl.84.2024.04.03.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 10:11:47 -0700 (PDT)
Message-ID: <660d8dd3.630a0220.f18e4.0633@mx.google.com>
Date: Wed, 03 Apr 2024 10:11:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2040190633862836325=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: tests: add TX timestamping tests
In-Reply-To: <1fd56079e4aa89aa1056a3cf185610a683ee02ba.1712161649.git.pav@iki.fi>
References: <1fd56079e4aa89aa1056a3cf185610a683ee02ba.1712161649.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2040190633862836325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/iso-tester.c:34
error: tools/iso-tester.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2040190633862836325==--
