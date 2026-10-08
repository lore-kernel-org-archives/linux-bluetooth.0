Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C34DDB48
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473318; cv=none; b=r3vTWBZhChPL2umdyNxzyb8vvmeAqsmbnaJuKCU+rLg2+PTOou2zPnfuq0tCe6Q82+KP9Abgiw1XK4Eb9g+cryzTlDtBeucNg/gbkHZWzy348MRbHOcv2/FYjrdfUF33kpNxTIUI6nCWJaUIEEFK9e26/wQBHsYo+kFIsZlIifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473318; c=relaxed/simple;
	bh=UduWFgcjFx26dvXZQ3b0k6+6sEMJYiOkZDWzbru0lGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpVdYNX+2vXVrK7RyR1GZ1zSLDcReoQue0ioEvL2UnxMXWeQQoXOIDTWRjVn41OixZ3H67fuVFAQ0oB1rqlOFj66y63HlSdja97LgT1B4S7diYW/c46hlNChsPdV0jqbn1b8pMjoVIT28wjqrfOjHEVfF1z7x7G1ns6Ds7hdE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmlQxgqG; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmlQxgqG"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6def0c340caso71774eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791473313; x=1792078113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLr72W86SUjY28bGb0k99cY9z9+6T4+Be+J7c8ckVoQ=;
        b=GmlQxgqGUAgc2nGM35eQn3YWUUeoAgKOpSVyWkdRK11IV7f+ZSaGpP6v9a8QspEdCm
         /cto1t/QC1J4P2G9zvXYegtWtgZt9IXpiOG4S895T3o3qTpLjbhK3Z2oEZGSoNeR4t/w
         dZTWbsqnc4ZQ2M5cw4oTqDnCDMs89/IYXve6jPX4RU2LZY6rHuuknX++3QrTdNhAIShE
         lKEzJ13zaYdLXZzvBZFgqrnLZJ+Dzr3u8OOYUn9TNhkwKVwTjkgi03Oogmrx7wCozXPe
         Vvp0e367Nw8f/8w9xVwVeFxu/InblRGP/6W5TJiDzB3ELnEaQdibbQXyWLBnYOqbTZCu
         mKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473313; x=1792078113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLr72W86SUjY28bGb0k99cY9z9+6T4+Be+J7c8ckVoQ=;
        b=1fky9+1jnqWi1b+FO5dYq3sfW4XZYCOojcTv+ydmhRrh1mQeZF4SLSa+UCDw9F68Eu
         eNPGkKCk7SWTTbWqxgeUkUDagYJGV+6eyjh3PJ5FNcDZ92FGGPPRsxJHfD8S9EigooeS
         iVjnUYEV9jVzBnr4DqthXNju+9k/HJ5t/svXbtRl6phYl/CFIKww//6XQxu7QD4nvOQH
         6cAcFSyNt76aVoMe6kNi2LWuiQMwJprP5d7QB8/efnJTc0wPm7nfMa35Vg1xJc7KS0Qd
         blYT1MzDkfiuS0BVsEHPwqQU/O7C15q8vVnWauerktvohmZOHtFdI2XAExHZluzD6b4p
         geTw==
X-Gm-Message-State: AFuF++k2ghSmwoe3quPg+PyJVVbHDlBHaoGqYQOLvgHuqEeRfAppcX36
	BheXJRwPvKCYLEkHoRxh+c7wAsa0zwknJ4D+MDPr0DlWo2wiciUNiy/b
X-Gm-Gg: AYBFou0NjI+fwosSc81dzQXxgTP14QcZz5An9IoI9we+xAzrREtlwHn/oO1yz8Gzpgd
	7DCPRbECaRQAxA+Sz9ucO+0kRyExxiSTbnolRMRr0ffUQSNPb/YXr6LhTypn7TpjdKTP6AzlSou
	eI/FsN/dBGZ0b+KKe7DH7BNJxR2mEfFNbSYP6IF9O2+NFAmxeEbeURVuit2hMh6HWDDq6wM4ZNu
	/sqsGdLn5EVUJv45gkG6PNNqAUKYgx11icjkRttChgMFxnrpRRtOMqVUEwSUC5sMoPaN+vK9ASE
	vGaBjfWSWkVtnSMl0mQhpPGO09WM5N3B4SXiss9xSF/o27BOcr4aJpa+OdUp175hBcrKGnFpPtA
	5L5JYPs7hcIUx/EKTWNhfI/UJYif/Py7hr2ekpzz8PTCgYF9m5Y1CPO6uAkfLrBplL0ySNSTrts
	NsNZKhZnOSR/nMTf+FZyzUXp/jYVtBL/69yi5SzBOr7tVUM6qmobq/BSauZEGmwfQeTBdfWk7Ih
	m9hPL+zdaZgO0v+rwNlSXjiweuCFXo47KtNBV3m
X-Received: by 2002:a4a:d1b5:0:b0:6d4:8158:8d67 with SMTP id 006d021491bc7-6eaba1f4dbemr2277016eaf.0.1791473313150;
        Thu, 08 Oct 2026 08:28:33 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a274aff8eesm3216671fac.5.2026.10.08.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:28:32 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Don't leave abandoned SCO links up in the controller
Date: Thu,  8 Oct 2026 11:28:26 -0400
Message-ID: <20261008152826.2162209-1-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABBYNZKoSV1_cVJRrdonHT=gKtS6pgoWDM3R5nj5aR0D17SqRg@mail.gmail.com>
References: <20261007154353.148223-1-enghitalo@gmail.com> <20261007154353.148223-4-enghitalo@gmail.com> <CABBYNZKoSV1_cVJRrdonHT=gKtS6pgoWDM3R5nj5aR0D17SqRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

On Wed, Oct 7, 2026 at 2:15 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Sashiko flagged quite a few problems:
>
> https://sashiko.dev/#/patchset/20261007154353.148223-1-enghitalo%40gmail.com
>
> We need to check if the logic of hci_sco_disconnect_orphan couldn't be
> made more generically, so in case the connection was aborted but we
> received the connection complete that shall always result in
> HCI_OP_DISCONNECT so the handle don't stay active in the controller.

Thanks, agreed. v2 does that in two patches:

- when hci_conn_set_handle() refuses the handle because the connection
  is being aborted, the Connection Complete, Synchronous Connection
  Complete and LE Connection Complete handlers now disconnect the link,
  with the abort reason;
- an ACL link that completes after its connection was already aborted
  and deleted (an incoming connection, where Create Connection Cancel
  fails at once) is disconnected too, as SCO links already are.

Both reproduce in an emulator (ACL outgoing and incoming, and LE):
without them the link stays up. The SCO patch now uses the same helper.

The other two Sashiko findings are addressed as well: the legacy
Connection Complete path in the SCO patch, and the air mode
notification of a SCO link that failed in a separate patch, as it
predates this series (1f8330ea1692).

v2 is here:
https://lore.kernel.org/linux-bluetooth/20261008151238.2138665-1-enghitalo@gmail.com/

Hitalo
