Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFMRhdoj"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5FB171F
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 14:36:19 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67abd020f40so28817926d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074978; x=1702679778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/2sIooAyAlVsm533GQElRnP/CKc2wYAPUpBT2aETHEY=;
        b=BFMRhdojgS2dXEplfkfstKfsKkso9UknrQ2KY8rRnm/xCgKhU+T4k6vg57WK7oyXdo
         kilTwbhXrv5pC5rnj0kgy3YKljhs+DnWenWbszOYWIwD/NSb9j6wqtfL5YuAMuKvPqwV
         1v9OM7TDer2gBWpMGamaDGWER2vucM5x2/aebOBqISqvufU+kBsfX3MewpaB2ByM4J4z
         w/LPREleT5ZbT2+n5qoCiB5QIHPBmIKXx2eharr0A4ELwPH/vZk7AiQYbnIyoncayzJm
         YmYqJ6LopbwJKIvHwXhTFMDgJSz/wQ20qxA/Q4imeL+JE152WS8XhbBbMY4/4kaMzh/C
         7d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074978; x=1702679778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2sIooAyAlVsm533GQElRnP/CKc2wYAPUpBT2aETHEY=;
        b=reX7xiBzWaxMPzw7VZ/A9FWYYFlxZBfTzHaNO5jGAHc6Qpryu1GYl5kosznwiGDi3e
         oXitdjezutkFMjoH9rX8RCOLB2w20HEe+mz5DOJhgBowkTM6qcq31gSdDmvL9aco9PeF
         fDzGCN8YivEs0XcJq6TftlLScmZ/mMkoe5oODPmDCm63rSFGzl7UIMpDibAaqljMjxJU
         Bpn9f6Azns7G8F8BTPeP7r7QhJgFxPKwhhUwKPUQfnjFlUybkrJw4rSc3lxe7phwjb1b
         GkaFeboFfAyNA8Z1Z/UW3ztJwf8V7eGDfVOv8Pju/Vwc+TS1DgOfHbgnXL8yIH/G9L0Z
         GceA==
X-Gm-Message-State: AOJu0YzbuKtdamXPr0fPcUetFK+otKKeKEVrV44Z9TO3+Ec0eesIC+Qh
	Xtsdx8jslcXpke0F1gd148GvnboTrUE=
X-Google-Smtp-Source: AGHT+IGfojd60LCPIizr8T+5/7DDVllgT32oASshaBRgTS5z1awPAKMQ68/KGbOdU7H6oOcW8mvaGw==
X-Received: by 2002:ad4:5884:0:b0:67a:bde:8898 with SMTP id dz4-20020ad45884000000b0067a0bde8898mr1373072qvb.5.1702074978730;
        Fri, 08 Dec 2023 14:36:18 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.65])
        by smtp.gmail.com with ESMTPSA id dv4-20020a05620a1b8400b0077da476d403sm995622qkb.58.2023.12.08.14.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:36:18 -0800 (PST)
Message-ID: <65739a62.050a0220.a3ca8.5e95@mx.google.com>
Date: Fri, 08 Dec 2023 14:36:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6623229577837580637=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231208221219.54529-2-luiz.dentz@gmail.com>
References: <20231208221219.54529-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6623229577837580637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/bap.c:1902
error: profiles/audio/bap.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6623229577837580637==--
