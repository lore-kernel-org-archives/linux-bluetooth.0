Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1739FCD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHCPsWA3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783293278adso108897085a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814628; x=1705419428; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SQJObXKxLMr7BYnXcyjpsuytNDBGjd3tE1IXz3kiYAE=;
        b=BHCPsWA31ow4Aqids7ciYWqvMKahLVLXY+U4uN/Qvm8fIO8AVPxbmc5ZcTNsNPNXlE
         i56osoQXMcAV8Kg6LpzmED7z5cxbz/RurIVKCf8NhDifsIJLrcbrLUdiNp+5j8wl+Etg
         2KyQZZ4QAwAc2Hg1enMDoq5l4SGaMXTs6ypMFiaSUoQmwMjtTfKI+h0gukSMiiLl9fsT
         4rPTBzyBVIZOWvyKiBOlvH2qGCp1hVGQRtNruxFhE/jEcFJxRpUXXslrPbzOqMu0o8kx
         p9zshDI1LYKwlyEmWABPg82v8XyBaxfZ45sznzTemRWKlV403x+9twz4WLE4cJbuCGON
         E6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814628; x=1705419428;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQJObXKxLMr7BYnXcyjpsuytNDBGjd3tE1IXz3kiYAE=;
        b=jqt2hqELVMptLXYwIIgfAjS97Jb4sXXvXcCo5UZ/NXAHlxX1rjCFf0/6xx+lsk0Agw
         Lgp/bKf5V9UkPOeuXX0eBnZYnvaceYWwJwFiK10wtTFWQWv8sgYSGs8LO4sUa3zbleFU
         f4sTM44qjMcLaLUrgqdl9hMVpaiMNco++lpNLNJ+G67sd//S+HjFrv0S0qRZrQWZv8/F
         KsFe4eg8CfB2JDYqJwGrZij+mRTqIFoxpaYhwoNUXEASqYHy+No2tuOAOe+0Qc8ngCEh
         pwubrJSHOKbdONbbC9Bwg8WFwRSXgVKOWQSFILKTZV83bdmXx/6MJ0xlZYjKq4OzSRyS
         h6jQ==
X-Gm-Message-State: AOJu0YzPvlce8axeUV7fGBXm8qNc5b+8sCE3/e7l678/et5xfGbZUkss
	2ptognyP/eG+cnLHiA7onw7K3GJxgVQ=
X-Google-Smtp-Source: AGHT+IF8p3LIOEeLYa2HhvVHYvlxq6OeqmJzMwnUS+W7N9FgirrWy4zZuRvixKd0/TLTyNWAv4I2Jw==
X-Received: by 2002:a05:620a:57b:b0:783:3237:f78f with SMTP id p27-20020a05620a057b00b007833237f78fmr461735qkp.135.1704814627889;
        Tue, 09 Jan 2024 07:37:07 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.217])
        by smtp.gmail.com with ESMTPSA id pj8-20020a05620a1d8800b0078314bb0fc3sm879812qkn.119.2024.01.09.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 07:37:07 -0800 (PST)
Message-ID: <659d6823.050a0220.7ad7a.4304@mx.google.com>
Date: Tue, 09 Jan 2024 07:37:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6456468940691948077=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_event: Rework hci_store_wake_reason
In-Reply-To: <20240109153041.403337-1-luiz.dentz@gmail.com>
References: <20240109153041.403337-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6456468940691948077==
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


--===============6456468940691948077==--
