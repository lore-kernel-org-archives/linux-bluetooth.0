Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC53BB3B
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr06ey7K"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28bc8540299so1906818a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704820926; x=1705425726; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvdv6R8yXoXsbZyPwsbqgZ3h+TqbNBxS+Mm9fVGkYWU=;
        b=Tr06ey7KTDUblpSWYRLstTBE3luoCpySMbkiGB/+10e1CXoCbwO0TjLy1vRhHHlnLO
         6TKq7JgCuB5A1XzaxccYuT5N4ieFMuHEditxom0uPcrif4jQ2OT5JMFd6H6VwlqjHAZt
         6pIdxxPqweKPFWPcfm/zMkcpC1F2yGzNeE3Wq30vGYek8z87XwCcALBKBy5e/kmEneM+
         6DoTBxBfhlDi+bDBU8aXcIrMLH+Vgp7ki5xuKPQeLvYZOVmqPrkxg2LA8/XXO/grolPW
         4/OtpQ2nV0R2wx2zp36/rpmlNEx6ay8ORq96qn7jmX3htI8pr//UucVgfEyPphS84/LH
         hMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820926; x=1705425726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fvdv6R8yXoXsbZyPwsbqgZ3h+TqbNBxS+Mm9fVGkYWU=;
        b=QXs74/l38R8Omv2OJINuhtJHzwZ9QfU9ILc6CASTwzCK9Wm62bVm183r3VX05TZD22
         y9alNmwsUnrnSabzg5Vb8rf9VYIGhUw0PzCL7FmpYxi0ntdpSM4WeIHTJ2y0LSrzZ+OP
         MajzirfjFUMdnexYWrGrpA+29UIplrQEYKKjgchfH98aC0wg1ZQGe6qao8Umjt4WCGFd
         T3eA8+KyNjKlU8qOcBumfwxTgOGH2rHsEUkuI9ceD1XBuYAQHB/6EQKFYgJlcCjSiyVF
         NU7vWtVhfxB2kZ4fRW2fuFHUUrR3IquL9LsSOWp1nfYkQ2MZKxfZT43C4KmE7YvL0kTb
         Od9g==
X-Gm-Message-State: AOJu0YxwtawqtAWDk4lLgd1SAFwf/qwgA6i+m9GuzrWj7PQO/d/4woXF
	RCAdHiH6lWKWBybImIHFG8X8XXQva3w=
X-Google-Smtp-Source: AGHT+IHgtc6l/h/cgJ3VXYIoI9kb4nMi7blUV1NKZM8OZ1Z1IFseP/4/3VXA4P8nXO+3CB6DzRPopg==
X-Received: by 2002:a17:90a:dd95:b0:28c:be8e:ac7c with SMTP id l21-20020a17090add9500b0028cbe8eac7cmr2573935pjv.16.1704820925582;
        Tue, 09 Jan 2024 09:22:05 -0800 (PST)
Received: from [172.17.0.2] ([52.238.28.66])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a5d0400b0028cad653d05sm2229156pji.47.2024.01.09.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:22:05 -0800 (PST)
Message-ID: <659d80bd.170a0220.3610f.8df2@mx.google.com>
Date: Tue, 09 Jan 2024 09:22:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3222836142103931588=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_event: Rework hci_store_wake_reason
In-Reply-To: <20240109165552.430359-1-luiz.dentz@gmail.com>
References: <20240109165552.430359-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3222836142103931588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:7393
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3222836142103931588==--
