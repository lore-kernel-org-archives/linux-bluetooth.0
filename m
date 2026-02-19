Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD334D902
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521649; cv=none; b=NL61vukMaBL0S6zjs8PiQYYaSvkpQZk+xSuClO+YGPQxyI7e5GqwHPTBm2YF+dYpvJXSxVFdeJvlpy+69balPf5vRaDha9IHBWVOXGwwQAEdFjXzwgnpTLFB7n0DERJHiKYy1uclJk1pDvloDpzLKxqpYtNbZPgAbLqQiusWId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521649; c=relaxed/simple;
	bh=lekjK2uDe1uc2MOBlhTLaMsslRhlHPGMvLZlub2P4xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYf+bmDob5MEcCiSASlSGRYXnKJjY+Z3sNzbJSaLES2rIXT1iZZcqzRHISoYoFRHgh4X55gHalE2oDOr6diBjO+Dhbd4ogPo1ZEh/p70IrSG+7m4mjMvBCXbwxVPALNKBQzLgcsY/SdZ98MPtMJIf6QVPNToJOPqS5+OXNBVOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+FB16ou; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+FB16ou"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5673891928cso586140e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521647; x=1772126447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftM1GiA8R6+DU2AcQGUrMykwGQspULtym9L6NUVqUXc=;
        b=l+FB16ouM9lmKfY0fG4Csj7g6/I8S4xWTuzfjrBXdHYxSfXzQJ0/lXbRH7sDULcOn1
         GtXl+5eLkgS1fUInh6TfoK85Wj+UQ0nxzaKC/pgurE5aMNcqNNDh+Clc3h2fNWFcNvP3
         VWs0sZQN35ZW0bgHKY5HxaxIwMEeXLM1rIx4ycR+5DaVn6bSye5F/7h7+ZFNMcsaxwVs
         PY6XcytLc0mkdjbWhTyuxcCeb69eUzN8NAgwOm3yweAi/Fyww5FyTe4Bx0u2JwqKSRry
         t+/LiBiF/97d8WRvBicCASEGW5lwCjwx7UoFdqj6MWn/c2M06fsbh3lWT+1x5R/MmtWS
         PzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521647; x=1772126447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftM1GiA8R6+DU2AcQGUrMykwGQspULtym9L6NUVqUXc=;
        b=hjLNOylzV5ecwnHPcmJKMgMJraPII7SmcIBZKfv7lUnBDeXqqGLH8iccpE3uVaPtWR
         5OrbgeDvHQjSomDcm2ZUolglR7bay8ySlc3B13fiJY9xSwpvGFwbFGG77A/8HCiysAiS
         4nD82Cbx1XlV8R9VoBV4Za7RhM8ByjhLus6Kj2VkIQBR+x3Bm76oXasTALDvh3rw8owv
         +SwFuXTLwykROd/xbtb07Cqw47aos1yXRrvcS2hPGs6hom12Bg2eLFqCNe9U9gc+M+Ay
         ewMnVIu6UDFx7ty+asMjNo3fMnXGoV8JyPKFt473kbjyMqn1XXaVfPlEFhqVs9gTygid
         G5IA==
X-Gm-Message-State: AOJu0Yz0L/rubwLG0JAT4iz/cva4q8Z9zyW+f4K8pzQGpRdhu2OljJMg
	MbnisuT9Dcho6Y6wsE09UbFZjv+vHxjKzXyUzJ14jJgghEQ5KnCuTs7k
X-Gm-Gg: AZuq6aL9ZvmaVLFJlyYaxQVIVJw1S1372/qyzz+JSZ97eGy/eJqPz8W3Uz1FUDmO4o+
	OwTc88urIp/PWKcEFbR/sejBCMVm5vIf9P7NF+395uuAXlubLmry7nJv9y0ekPeU1V8rDYgCDnr
	lrdTkA/ZsXEehhFbShSXptnbb3zLkMuyslTORmV2kZrH3cP/KiZ0R5eJiUz6pYtiiZ7ULuz+xMH
	t7/rXhnixHm6FS5vjNKLBhAPXI/vli74P5fTEC5iwNmnS2g9u2czas6zulryZA2Kufed6X9gi6z
	1WXZYJm0PHjgmHApxqssCw+nMEwjdW1HTRUExix4rNfKri6lqAWe9LWF7JTKJburhxmKRUWyWxR
	N3SH8gf33vEfUx4tat2A6rNc1BeemDOJLiccsu0FCAkClMoMuFIbQLI3GhJMQpXA6hV8+UgdX+U
	GxgQVpUU71AMUYpFE9D8VTyBgTJN+xPki9dxO41aGUlrdegoIyEV0m0Mfvtw8SLUd/SvBfASoLc
	MTUR6JmOv670SDShtH4q6WIWsc=
X-Received: by 2002:a05:6122:17a0:b0:567:3d65:1eb6 with SMTP id 71dfb90a1353d-56889c435c6mr6358561e0c.20.1771521647365;
        Thu, 19 Feb 2026 09:20:47 -0800 (PST)
Received: from kernel.. ([2804:4ae8:bde0:7200:7790:b0e3:f0ba:ac3f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568d702405bsm587672e0c.17.2026.02.19.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:20:47 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: luiz.dentz@gmail.com,
	me@celes.in,
	insidetf2@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Thu, 19 Feb 2026 14:19:53 -0300
Message-ID: <20260219171953.712517-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
References: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the detailed follow-up. 
The explanation about EXPORT_SYMBOL makes perfect sense.

I was analyzing the function's limits in complete isolation,
and didn't realize the context of the trust limit within the module itself.

I will certainly use this as a great learning experience,
(it's never too late to learn!)

I fully agree with reverting commit ac0c6f1b6a58
("Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add")
to avoid confusion and unnecessary code changes,
since the function that calls mesh_send already handles sanitization.

Just to confirm: what will happen to the other commit in this series that addresses the blocking problem
(003ca042a386)? The handling of the mesh_pending list was indeed unprotected
that's exactly what guard(mutex) is for.

Thank you for the review.

Thanks,
Maiquel Paiva
