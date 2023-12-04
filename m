Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA8pT4Vb"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270AF0
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 02:14:30 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso2927608b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 02:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701684870; x=1702289670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uMyndoK5QKkZvKmnW2pp/RNpWFdF79+6m22c26T8oUI=;
        b=UA8pT4Vbvd1cAWExlMBE0LARmxOcpJQDS0cDcw80IbGHXjtaLDCukMVAjPH0aZADlT
         cZ+KQwOZPp6zkPxVZgD2MiFSk9iSLAXvISL1C/tU6wy4a7gRNAqA61BaOc8AZr91Ztbw
         74l4XPpIwj576669bEiprOusaig1SXnK126s/RPv0sOp/u/3513Nhrc4bDHxMCX37xVM
         M3pPtkjT5ZF3c4vo0gwa4ITwi+dAE9FZ0orhZrcJjQLesekEKxwHCMsbrNLGxxdJbcGs
         SBJtrztBTs/07upY1DaIakxXzqi7O3DrdzNAFa8FOgqeslW9O9c4Y8MFvWHFBqYeDjkF
         Wy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684870; x=1702289670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMyndoK5QKkZvKmnW2pp/RNpWFdF79+6m22c26T8oUI=;
        b=sezhaTvqdnjrvCVI/1a2Rp1uFw1Lmc7VlVn5XP7hi2rerSjwLEh2tOqhakaq4df2ZL
         /pmmIPHEoASgTfB5E3N6zR5n4m81bNkhnXJY0dnEvGjWPL5kWmX8Fg7TBBw8B9yC8aSw
         E1a7fWirV08fVzvdytpcFCCVdLURHo125z/7boTMawWV2hqQTUvkTSTMLW+FXKXvd+Xc
         gE/Kcmj1y60YuWGEvfzWxpji6iXTeMvTewZzLgZ9ij6E2XqUbJIFKdYX1jj+0D9eqeQa
         MWUQMp8yORlHK99LmAiIB9J1jrUIMfhN3q72xikfCj/rBMnqVCUIdILBOFo6bdeXOeh1
         ckAw==
X-Gm-Message-State: AOJu0Yw+VDxoOKBDmeYpBFaf/G33aD5PL5yWWaMf0l6KVa/v+efMD5X3
	qUfsEkOGlwLtC5wejE7FsKwrD1Iisus=
X-Google-Smtp-Source: AGHT+IEp37hepUU8/WlkOPPIMhHyCrP++aMZDpy/eXvNB//rfpWbkqxtA2X83CPXBgRxA6uydXu9hw==
X-Received: by 2002:a05:6a00:e16:b0:6cb:a60c:14 with SMTP id bq22-20020a056a000e1600b006cba60c0014mr1810081pfb.18.1701684869771;
        Mon, 04 Dec 2023 02:14:29 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.145])
        by smtp.gmail.com with ESMTPSA id bm16-20020a056a00321000b006ce202eb58csm3943867pfb.132.2023.12.04.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:14:29 -0800 (PST)
Message-ID: <656da685.050a0220.200c8.81dc@mx.google.com>
Date: Mon, 04 Dec 2023 02:14:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2820309596871089407=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mathias.nyman@linux.intel.com
Subject: RE: [1/2] Revert "xhci: Enable RPM on controllers that support low-power states"
In-Reply-To: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
References: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2820309596871089407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/usb/host/xhci-pci.c:695
error: drivers/usb/host/xhci-pci.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2820309596871089407==--
