Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937439E17C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434666; cv=pass; b=gcjMjFj+XGGWk3Vre2zjZctRMwRvN2FXz0uLbYGcFiYk6v9mqA6M+UGyXzPm5E9eWo3jy+4VtCEBh9nM+OjOn0ZJRdgzd8RfyiDDKjFLc03xYXzHfBygLQfVDtMSAGT2UO4e2i6/X0cRrmJvgGDpYi3COJFlDX6e5AvZmAAGAA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434666; c=relaxed/simple;
	bh=IAWOulyn60q5CU5nFcEIg2txVq35DKFJNgeRnC6hixc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YBgdeP7ACrDknrzLnEd2qZpzzpxCAEC0bNe4KSa+E5y5PjYhaAFFlg8KeljvpUZ8KeMWPc1XQbFQ3xH/W3vcACJqfsNV9DQGnz5cW5+bx6U1pOBAk0fbCElH0ew4baNPy4rcMoGtARMHLw816sVd7DxA78L4tWTxmubOVhecBEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MblmTJTy; arc=pass smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MblmTJTy"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7e615efd7d7so8907374a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780434664; cv=none;
        d=google.com; s=arc-20240605;
        b=ZQeLM+WcsPSJN++55YJ5q8AQomE25GCXioPfjaZNPJMoe7Kfo/TcPJ/bEi5E6U8QQ/
         EAOV4igV42vAOYUcJ+t/gjLp/hdE3oupZDfbDqPnq1ER5cCykAsPA6/h5QVRn8XSfRP+
         8si/vngZWmahATnsxmGzP+F/RTKeV/YPh2C+UoRiDQozi/4MTnnG1R6ucf5pEZ3yZ+bB
         4nvthZycGnwvaGgYc03ECE/WTYpr5xUlsw0h4yvZl6fksQAtQG/nw0EwsW1I7q9c5qks
         Uwqlopiab3rhkg7qGS9NWonaAjo8KuRyh/w9QmLWMI7sLxRDEEpzMZeoktGLZdGR/di1
         eFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RkS7VxSSYQtTbcXAPMSGUiHQM/PKSapt1RSCo5tDvpc=;
        fh=QhYhU9j/WBVHzYnSB3qWVjokyx036cV9orQDjLkbELo=;
        b=cKmdOJNGrt69SsuwOysg59j8lfV7G8t9CBOz3snSCRyexMbxZvLjIV63nqkmyVbths
         PPg4sAoZxcJQnRUxFH6r0HlQ3bxGlfEVuxN9d1vk8Oxvlxgzt4r4OYJkJgxGRWl/ZrTS
         p8YUVdyoUIAlLhgm8pQ4D0tzU0oFFQWupBqOiw8WqvvsTnK+rdt0aRnzRckATzFsUfNq
         l+f2QaYyjAolkk0TM9XlyKJr7Fsc/F7KSSzfmsTJsVFRDyeDqZ+SMPlHP2yBu/+pnZcB
         O2bDnuTK6y8CSK6p0lkvd2ejOzd8wB7duW+nd66hbclQhQz71LABjxzMcwQQX1vGBsJI
         pnkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434664; x=1781039464; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RkS7VxSSYQtTbcXAPMSGUiHQM/PKSapt1RSCo5tDvpc=;
        b=MblmTJTyen99EdWk+Rb9cKyrLa70lf7HqxLKsI+2L4T6rq2RMF/RY6QsyRRpc67Y2x
         4/wMiSmyjC+30fqnzUf8TJXtNZwNQkPKs7pK22hK81L1d80bdI/oW0pNVu3N2shHOHCP
         sHLqJpbqP65u4pVobFp79yL4+ZNoVJ2TJHp5aOcY1gMgkrV0j/Tm4rMu2DCCMcBGTu6O
         O5GfiHwFzfSjyBtnc9SM04TMhNNc6cQryVp33zmqYwJHRKDlSEJPiSmKIbONDcL6GvUp
         fCzhqJCiYWB6oh+zkBe9T+GgzQnBhcDG2QgoJvY1XAqaO4sKEkWhwcQaIidLuRp5UWCj
         L5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434664; x=1781039464;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkS7VxSSYQtTbcXAPMSGUiHQM/PKSapt1RSCo5tDvpc=;
        b=hiTxrdqqxxAMDskEH14D1wNz6OTuy0zj46bRB8rYRtc67wdrRh42OmiFLlbpwelZN9
         S3KFmGOnHmVtOv+VbEYPCY7jSqNIwJEIp7egMvHzapY8fD+K1Ejt2jQ0S+2ardIMg06a
         n/rOAw7h2669imHO932JuWFOzauYOATyAAOtNpBWuzywZpn32JstaHMAdMBJKMWK9FfB
         YXbC3YGGAhEhbUQntvkmtOZraoJLCn0DtnFfsCUvjUGT1mdRqSABZki6Ry0vUMOK2fNp
         dgq/I8unnWfjUitI93hoLLllyJhDB51eyfLE4VDGJATTMQqmQtlepW7bAYEU0JuqCSjE
         pTRw==
X-Gm-Message-State: AOJu0Yz2vVjby95kJDK+eYmOWosBSA60lm3BN+MvaFkwgvUXiZy/hh1q
	RmVKIRCCQjis+LoJHYEaWB5Ytk7iU0qry+3l3ZNXUDc3YULMdyexE0lfddRO9Os9WnhuqHnsnZ3
	4+s7Olfh0yuwPRpDdYK5YkTV2qxeEDBNfr6b3Lpz8
X-Gm-Gg: Acq92OFslnI2SLTh1h6mKxPUme89fEdvbSYiv1x3L+FOt9YqJOapzOqtctMPEIJlJuw
	iEqgLjjq41yY9c+GoBzvVxWTdpRape6/zmzCbrbnKA4E3jGHO/6qT2GqVYeIuNg668YYaAGTsYM
	ni8kMIk8DpZikrmKru0t+gnsH9uFGzieXP5MohOXEIvE2zl6XQGKCo7p97eWPVk0hB7v7r9/Psr
	GDvB5Lfq036mzKJS944uaUVirD7qUPE5b9ulXs0fjpu+u28qDM8lyFrf706plQaNVzp/YmQZd7a
	9KajnRp4SlWCsG5yaP5qMwmuGg94
X-Received: by 2002:a05:6830:640a:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7e6e8fb2c4emr243406a34.0.1780434664207; Tue, 02 Jun 2026
 14:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jordan Walters <jaggyaur@gmail.com>
Date: Tue, 2 Jun 2026 17:10:53 -0400
X-Gm-Features: AVHnY4Jo5j5KsMdE0_CjnH7Dr2uUfnQcjxp_TER95-FV2ehI-A5QpChFeKKfKQo
Message-ID: <CACXZaU6yawhfya+89xnBuaSOZQQm-Vj2+hiFjs92EoHdn77Xnw@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix Use-After-Free in hci_unregister_dev
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hci_unregister_dev() function fails to disable the cmd_timer and ncmd_timer
before freeing the hci_dev structure. If an asynchronous event or timeout occurs
during device teardown, the timer callbacks may execute after the device has
been freed, leading to a KASAN slab-use-after-free panic.

This patch adds the necessary disable_delayed_work_sync() calls to
securely flush
the timers before the teardown sequence proceeds.

Signed-off-by: Jordan Walters <gloambit@gloam.sh>
---
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a1b2c3d4e..f5g6h7i8j 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
     hci_dev_do_close(hdev);

     hci_cancel_cmd_sync(hdev, -ENODEV);
+    disable_delayed_work_sync(&hdev->cmd_timer);
+    disable_delayed_work_sync(&hdev->ncmd_timer);

     /* Sync with hci_rx_work */
     cancel_work_sync(&hdev->rx_work);
