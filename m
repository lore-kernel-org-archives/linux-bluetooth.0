Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038D79C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721010022; cv=none; b=nBvdNWa12pjQJJlOd9m2feWroXtPUJZ+OlVUvHQdVpspkFTwzEFORTupGsdcFi7U1z7IsR/10Au8yYbls4oVmUiTWO4mZzr+NkEuDJoo+TRFVY9Kk2YHfPhBrNDsGqUpkJkaATYFalxZLfRDn734IcF0FnZT4kuyOwEtkhL1OIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721010022; c=relaxed/simple;
	bh=niw5kQhL5FQ64ZDudfitWO0ZNK+Wac8SWIQteKsKnKM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TEGLBVeQJcr4UMN1qIr5zNlbL/mWVAxv4mue32QNf135Dg9gP2bkMR52xHG4AuuvOftHGOAExmZ0cIIKI/Gg1nagNN/Z7LDOhZpjajuKIjDiGHwXEZuu64haKlGN/4U7tvPQ+ogD3o6EnSO/Etdj+K0hHVsf8GyVXYUoT9wOdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuPijDh3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuPijDh3"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b760dc7e08so10370746d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jul 2024 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721010020; x=1721614820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=niw5kQhL5FQ64ZDudfitWO0ZNK+Wac8SWIQteKsKnKM=;
        b=fuPijDh3/m8cckXazPz7KpptmHmlnAbWe17fUAuczvHWlcYxFZS5007/+NwmtUIf/L
         mpIj+CzrywGDw3Pv/j8y2sCK2xtQinpSSMMZXfp19SN4+DFTfLZW2X0kHr8BdfGWxD08
         TS0yn182LS1XLNCTd15PTTCSGUadPgTBeozCwhVQywwXP0OzdbwJMkg5uAu47dHC6mP5
         HT/Am7uOz7HNVo5JT6NAcnqW+L6aa7XDk0gxGVZ2yS3vCkrpmbrf/k2pMFTapYlgirxy
         +Ju8Q+D0q16PjH+GbvcfWBKQv3HJHQGjDr7bsysbfHoW3DMPhXAYGwuiw0cgOrY59Nyu
         /L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721010020; x=1721614820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niw5kQhL5FQ64ZDudfitWO0ZNK+Wac8SWIQteKsKnKM=;
        b=VdW1hZyG+39bymBjo9oUpdNdup5eMbviUI35leP7a30CgzsRceZ13l1vC3aadNcw/U
         gcV6MqPlWL+XQVwgPX4+XLeTGXjfmJEOZ/00H4WOudjHdhKAK1QeZ5EVG/lTUcC33CS2
         OVRCoWIXtsnaE3mrkzMpq5X7aompzzmqHf2mG/yaZv6CTorJWb7X7zePNF5+qMHrq0/y
         nwO520H9VkPBK/9WYeKUngXOVVd97K4OnAt52Xy5fw4MpCjVH4Cih6vwMioyUInh0KN4
         VtDbocgFf0g+Fxk5qq26eD+6vC1P9G6VUjTIOfdOLVS3fx68uNCpOggDZFTyrmgWxIQa
         ZzVg==
X-Gm-Message-State: AOJu0YwkW8ovZtAos+nv/V5A6otZD01Y9apCOoN66Z7EvhsFR6Tme7Qp
	80LhqZF8hLG3/js5HKDhKzdyE/sL1u0SG1hw4BFRS7qCrl7o2ZwObO7G5Q==
X-Google-Smtp-Source: AGHT+IGlPgNfS+EvUNh1ofd/UyvTzAFvGliA+6EFs20T8wa+YbfAqbXVwF1WZv4o7mnu7T6vTkHZyA==
X-Received: by 2002:a05:6214:2a8b:b0:6b5:e3ae:d8e3 with SMTP id 6a1803df08f44-6b61c1c5190mr238869876d6.51.1721010019824;
        Sun, 14 Jul 2024 19:20:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.127.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76198db00sm17405236d6.58.2024.07.14.19.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 19:20:19 -0700 (PDT)
Message-ID: <66948763.050a0220.bedd7.4a99@mx.google.com>
Date: Sun, 14 Jul 2024 19:20:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4776150270363497109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_qca: Fix build error
In-Reply-To: <20240715015109.239742-2-luiz.dentz@gmail.com>
References: <20240715015109.239742-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4776150270363497109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2499
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4776150270363497109==--
