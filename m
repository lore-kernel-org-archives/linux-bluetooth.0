Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDE020126A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173841; cv=none; b=iHtR08uM1gz4ZTyqXMAdQEsVa8okN1vYoj2pHzOtfrFYgUmb0uA1b+FiHGncBh00MbSLYcvmtZAti/OgsKbWm9+gEyW98tNxUV2vmg7Vk8GEu+v3weTLgtC9cqwMx6Pb4Waf9zq9aOKWZBlJ22dYe7LuT/EP0bFwQhpacImSoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173841; c=relaxed/simple;
	bh=6mC5l7NeiBFx58Jiz9Pni8ljzvZFGvGepcb24iRiivE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PLxdsyH9w+HoR9Dg95qHwTPqVQwBbdGHP04QeoQkaJTH+5nWTxKT+nFLAI9GZACc9Tr7MUJrQ7+qLLGGeWKBD5IYoBz57ww+pTsRB2ZrPbYkMEQrgCFoWj16186+sFuEudBZHuw6msJ+hBJ4RkQd79FbaUxwBWfwy43eKiMgXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcu/J1Sb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcu/J1Sb"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0a159ded2so247828485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 13:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740173838; x=1740778638; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6mC5l7NeiBFx58Jiz9Pni8ljzvZFGvGepcb24iRiivE=;
        b=dcu/J1SbukHBfZlwixpWM8/LkAilPx/fEP2EIdQyS8wiRTsRQ8ahYMTSDqjpE+OchC
         BQtFMKqhCQSI4cdm3Su3NhjCHpsB18d0WF21uOpF6/VHOrdUTQys6JaLbGhrtUjBE90D
         1Fn8eq5cin2D5UZx6TQvgj/kQ3rMvsTQzGFDvNxpYRe50BDRljmfLjy/XNUC6+hlbp9W
         TAhX98FbVKlmkma8XnC2H2kitRIA4ryo6VqOX/1CbVq5V4zVa0XuZWALfQj7M8t13kKM
         v+MQ+Z69bPwfpkvakWYAnZJ7P+0wqu6LCiaUrxxS8LaLl/m91yyRdsaYevaI1YsQTQnh
         p8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740173838; x=1740778638;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mC5l7NeiBFx58Jiz9Pni8ljzvZFGvGepcb24iRiivE=;
        b=JLpKI3zpRl4B578AoHM5+dL0cIqYC99WNLHYer8q397ef1g1srriAB98AicEh36hwr
         KHeFO+xbtyMRgqRmdgepsoxa+KesDDlAPB87T4/oe8el7tdj90CbQMWvr/JhRRS924BM
         JrgI93/xk5ePfdpkTJ6yikIVrd/ZX/n1Emm9HcecUPio+sr4+pzL1cQ3YibUh8Ot99wQ
         KUoKuSN53nm+Jpv8F4zFDUhbq9qDn9RPT4ERgsjbOJaN7eqi+c/ynxnHdtajkRooCzEU
         Lgwk3dDBVgw5ZXD0FH18VpSYX1TBsdjiwOlSCZjrc16a+Xvi6tyj+cDVh7O778oeRtno
         pq+g==
X-Gm-Message-State: AOJu0YzaMsHMvpcXc8uFOaqOzKKO1NCE7afWkYys1PE6utK+vm7Lcy6Y
	w8UN6Ue8VTEG5VocW03TxprNflqfIsR/JOxmW1dRNKMbzUZaFIUuieKCTQ==
X-Gm-Gg: ASbGncs9uV9opQLTJSXFy7D3df3saypviM+GOvFIxEVsYCejAsQJIivy3cx6GjG3s/1
	pQYc+MIEmEW2Jxm7h4p91K/4hCyrCOzQtfN/KTz4rMgyTLEgwEjpWHzP2fcUz04RIHYAlDSfMDV
	9ZFKBrlP6wihuezFGRJuJ9LVb3y5zIkZhTwisopgiDoQ8FCnZT72Q3bSS+d/YCTwv7ppN+LPt6r
	xoeuJ49jtLMRt/GS77fSnDvcLve8qiovtKkrxDUY2k/jbpKI0EccVUAv1VIgRrNd3DnxMZMNT39
	WbTKepwtvzzDPlG3EGvW6j4/yc+VgQ==
X-Google-Smtp-Source: AGHT+IGq5e79dGSUU8bYvjlDlkzEqTNRJc1jlnyJ/mb5WsKCXdQCjArBdNwT65puF0MdVN+6j5bzTw==
X-Received: by 2002:a05:620a:45ac:b0:7c0:7833:cbb7 with SMTP id af79cd13be357-7c0cef6ce6amr788836785a.47.1740173837680;
        Fri, 21 Feb 2025 13:37:17 -0800 (PST)
Received: from [172.17.0.2] ([20.42.14.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77c878sm102991156d6.20.2025.02.21.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 13:37:17 -0800 (PST)
Message-ID: <67b8f20d.050a0220.3d45d.bf24@mx.google.com>
Date: Fri, 21 Feb 2025 13:37:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7650141066950934898=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250221204916.2217628-1-luiz.dentz@gmail.com>
References: <20250221204916.2217628-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7650141066950934898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci.h:432
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: include/net/bluetooth/hci_core.h:1857
error: include/net/bluetooth/hci_core.h: patch does not apply
error: patch failed: net/bluetooth/hci_core.c:3564
error: net/bluetooth/hci_core.c: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:3766
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7650141066950934898==--
