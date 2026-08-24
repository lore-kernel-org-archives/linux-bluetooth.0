Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35C282F12
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568591; cv=none; b=iqjYVC8kcZk7m2neri5A5OInyqbmQdpOKC0nKtDscXbqdoFE/O3qqXnNnQ4aTJH936fR82jBxRNukANkyE69ds97n5BDS8Ns4haQBpIsPVWnPNQO4MKDxyFvOr6gKa1UjuSQsWQ8z0ZWOHD5b+CIo6gAv3zdpaNGRZILv0DDrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568591; c=relaxed/simple;
	bh=UoDu3dlVcAlUr0VSqc5ve4+WZxYyyG9sCg1TaUkQuX8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=grn4fsz/p9+BtYlpJ8yswTvi37qHoeR+nVAd1jlfHPUCx+laxbezg8N2KQb9Bq3mCXO/pQugB1MoG7fyokjpVTpNtOkTd762U3H8qjlk2Mps3xWeR6dbFyPkeEY/ramtE9GgF3xReCo6nLa186QrvI2ZXiC5//JNpGbFg+c0naQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMZ/Gzom; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMZ/Gzom"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso51224115ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787568589; x=1788173389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UoDu3dlVcAlUr0VSqc5ve4+WZxYyyG9sCg1TaUkQuX8=;
        b=aMZ/GzomlfCKp0JI+Dg5rDp2kQPYCcmdFPNejJn2oeFtfVIUcVX0S/0GX0kylPOtN8
         gyPOuv+5SeARJikGFz3DsXxOEovNt+YDwWxZF6SDHK4mZpiX3bJgOBqp9AVUgdVnjM48
         rDprikzN0Ce6qelAEcEjCBWirKrmNZWxvY0fZR22AOYROEjgdpWSxKZulFYnPERSjNcN
         XWFu8GGHoYiwAJWyI4CLpNP5kDzygR07Xy2/HFl/WkRUiRCsYevFvUAsyMQMkT7vQCcw
         XH3xCnThlUBOwic681HR74XRp76vTvMOUVXJ+KXUG6TZjiVuY1uKY3O0GvSPq6iXzoSK
         UijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787568589; x=1788173389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UoDu3dlVcAlUr0VSqc5ve4+WZxYyyG9sCg1TaUkQuX8=;
        b=qzzpuM+nd//p5iGVN+2EEwWhx8t+E/GxViSsq9P3Iwg5iE+p85u3ItTAGxLGzCDzaQ
         sV3YDx+9SOYzPFJPGkYW84Zc+t4/Hulho++5kQ4C+Bb8O1cFipKiytMmikiUmS2ZmSXY
         bKZ2qg3yxGEVVfwEEdlwAaL/uKVgp+3B78ytRq9pEEj6D8E/L2sWMfnYkOWj/S/psszI
         QcXNu7nRvC/9oBbBBaAl/e47T9zIK8jKTYiTaCc52nwKxf9G/p/IshnN/7a1nA3X6c41
         B+W29qdJC0PWUEj97yr9SsM+E5Nr57j1pyx3xIIV2UKtHr5oRhkW/y3iHstLyV7bVi63
         HhJA==
X-Gm-Message-State: AFuF++naiSZd2aO0jvl2n3M0CLlraPHJbJeSSHr7Ws1y247CZdCuOieH
	P5A6yCh0RlRV2/mXDL7AJvQyLDNktb3ETLXW+UtHknkkKA/CPDqSttT8tkt4vg==
X-Gm-Gg: AR+sD1383uYIfprEx9Tq5hQeaW7/IXuXhdcRQnGffCKLWYmwAy2B3qMKL+fgSvmdSh/
	7pau2S1o43cRaEbYb20Nm7EVpZ0EwegCp+RMXWu8pq2pLvbKcB5mpPwcYy0PCsm88f0qTWRN1QW
	17qZuej9fLfkdmwPm95SmpqSANORDASz5j8DA3wc2Ftjv79AnIx46lOEAQygh8sCG3zZHqXxrk3
	i1pydZMg1MMHqnRsZxVPq0alp6g6F+thxeXkmeHIuM1EFZndA6yETCIKUUS2EyoPM0lmyDwQNc+
	YEQbDyb35Cg2o03hWS9BQxebOTL1Sm4qjWs8RaiIZEkNbVu5zfiFRMOxXvck08sBbnl+bRQV46c
	xgH7JXevGAMr0W0nLACg6ANo7V2Qp9NgAIYFSXLGua1/soQjy6bq32btLrXvk4f91aSxpELD7l6
	lcx9ZOyh04nHHwNlyIAuNWpVMBWryRAgc9UaKl79N3fzyTHpX0W210yNTshp4zc7nJWntuw1mRx
	u2Zqg==
X-Received: by 2002:a05:6a21:3511:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3cd30060d76mr56176244637.11.1787568589290;
        Mon, 24 Aug 2026 03:49:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.157.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280782f09fsm17591579eec.20.2026.08.24.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:49:48 -0700 (PDT)
Message-ID: <6a8c21cc.d2e28207.1af115.3241@mx.google.com>
Date: Mon, 24 Aug 2026 03:49:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6070662974181324722=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: do not leak an hci_conn when a second LE connect is rejected
In-Reply-To: <8ff19217-3b4e-4081-88a8-4bd26c573f8f@podgorny.cz>
References: <8ff19217-3b4e-4081-88a8-4bd26c573f8f@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6070662974181324722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 12
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6070662974181324722==--
