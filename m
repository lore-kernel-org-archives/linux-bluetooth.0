Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXmcrHFG"
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B6D3
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 01:13:21 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b88c29a995so3069249b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701767600; x=1702372400; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jl0nJYg1vS75i8hGTUJvhTrlHd4QZsd4/raqiPkuUx8=;
        b=ZXmcrHFG5aHJT6g6HMT0B+W0m+1MBBbi0Nr2v3Mt29XXHoVW+QKjB8ODBs3ywg9+C8
         zAwIGpdU4B0HMWJi9y0+4gVF15GEwWQ1uXYZRnDYwRe89H0ZvHq/nOe0NURGuL4CT3xD
         4Qf98MdQWqSTHeydd8PYKt6MXBg1ke/iDmSJNLrGRpCarZtPQ0GfneKOcoIL9CfDg//K
         wDtQmGPxTwX5IMj5k/4Jt0HfWRwpajzVOZ8BjBYJm6h2AkF2TvFsGE32JFMbF/Lz2lYI
         qck5BfKsEJuajeTLwtwq3FvP3r5bT9ases8loWpkzUVDMSQj3rpLhK4mze/oS3eZN3mX
         jgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767600; x=1702372400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl0nJYg1vS75i8hGTUJvhTrlHd4QZsd4/raqiPkuUx8=;
        b=jPZYQfbDTbpwpNeMAVsr6aoh431rr0CJYnCh911iECpdjpiHrFNhew90FEe/PwiE1W
         4ONdGmkAoFYAd2Y6uCx/VtAE0wSJTL/XnbybEBKy2iJpPsAcU1kkhHJSHLgeZjIIMCmy
         PaYWDxHshoXQruTS7DL6dOyf7g22mvqLlg/OpjcNxRzdrh7jkzxzjJHJtJyPruBeyVqq
         u31yrgbmyUt7QVm4zvrXgUAJVMMuiWgy1OngC+NkZwf3V0NV28yoPcooFime6bl2tJpI
         nd3e7RQUBFWr7PtdcKtmknr9BuSD/udjbfLyPIU4MuLPEdwVUEmKBmhOoDSvXcKR2gQH
         1e5A==
X-Gm-Message-State: AOJu0YxNtjqrF4l5IEso2ilLfWKAEZVJ+NB39uAqn/4NqAmuQLo783O9
	dA1D4SIiQ4XWavM1jcSU69S4Geze8tVj4w==
X-Google-Smtp-Source: AGHT+IEmQBCLs/b980JBS+GkfS81dg1bLDLx6Pevnwmwj248qssOsX9lnWNS31qNQ3KqoMtlAyck+A==
X-Received: by 2002:a05:6808:d49:b0:3ae:5442:ed1b with SMTP id w9-20020a0568080d4900b003ae5442ed1bmr7906112oik.43.1701767600607;
        Tue, 05 Dec 2023 01:13:20 -0800 (PST)
Received: from [172.17.0.2] ([20.97.189.30])
        by smtp.gmail.com with ESMTPSA id t9-20020a05622a180900b004254355d4dcsm3039592qtc.77.2023.12.05.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:13:20 -0800 (PST)
Message-ID: <656ee9b0.050a0220.b2eb2.8c18@mx.google.com>
Date: Tue, 05 Dec 2023 01:13:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4160633021011198719=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mathias.nyman@linux.intel.com
Subject: RE: [v2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
In-Reply-To: <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
References: <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4160633021011198719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/usb/host/xhci-pci.c:535
error: drivers/usb/host/xhci-pci.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4160633021011198719==--
