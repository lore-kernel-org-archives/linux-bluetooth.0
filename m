Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FB36495B
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958946; cv=none; b=eH+r7NZIb1D9R2eVFkeYtfVhtg9Ha8KU96AJKuADtnrNTZepnUXxoa1cJhldXnq0m516FSUbQFdlcOLjxiVNuh71eLGkB8fWQYFJDnJR8nDws1g7W7eDO3maf9+KZ4XqWQRQaCELJSjSUImVKNOkUksAqGu/yBnE00PChv7vgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958946; c=relaxed/simple;
	bh=s/Ooxzr6FEZjkJX+l+du1+RJ2WQpB3zFWntZewkgHGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVeWTDdSCkhc4fq0oVih7ln8AVG0AVmZVJVY0zdDqAy68lOWvZtLmK2pIdV2EN3hxp991r/RgH9MwTjoVpWnL+Stc0b0IX1Bwa5Kp2zsaYhMxkpkZ4T69VJkB6eHKfi2zSbz5bQU4YP8HXIp7Nw8mTDNqryHomUom5LYLOBrcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQfe2kkI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQfe2kkI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so4905315e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778958944; x=1779563744; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/Ooxzr6FEZjkJX+l+du1+RJ2WQpB3zFWntZewkgHGM=;
        b=UQfe2kkIXonQiMeAIwR+RaRaiSLUdOENX0iC8E++wD63I7zNGzyrJHcTrKXfWoLqBK
         8kmYgUXXNBNSkZoDlCKe9RKvMbolPVqGYSGJFyQU9Siq2d2maQZ3wcJFArHqYLcwLbJT
         9ZZsv5qnfNL6ggjJNLjM0kBNhpLKnm+lcVghvgMeMxPlWLMSzZKlDA3jygEK+VKyU+mT
         PWXQRkQXa38cFEs6ArR9mGvEoebwqZG0rh0gaLsDUy6djjakgA/0yECAhBCASHMt0yi9
         oEGVEibgoVZeAJZMOE/o6IXLdQCjoxaIydZPtMfS9IpEByIcqwn6E8TUklVeaORrhBrK
         U/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958944; x=1779563744;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/Ooxzr6FEZjkJX+l+du1+RJ2WQpB3zFWntZewkgHGM=;
        b=HpV3KglnWOne1b7iLLOS63u2a1DWZgZ6fJCMO9FGLVFYVt0G42ZTGJiIlyfMZTLAqq
         Adw+v85jx1dXqcrUn2RFU6Cvi4DDWGu+6KG63Oo3rZSsvRnAkv1iK8BkzncqulkutJJH
         7U4LiTmxpDwkTYakLDTvRpGNkenuys8e2y+V0a7tWE9t9/BtTLoDQaKy5W2qef03LisC
         sfvh3evaSTbYXCXVb9nkZgVrm3DwDqBZ+n9L9hibLDV8Y9gd9885LYBlD8Glpx6dm6Pu
         CInNf6gNb2ARrJtgkOyVXoA3FQFGpXkjvXdULCTuRT0agoR0KfMOL0rTIg0yxrGs/F/r
         qU7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Tpe9Gev9XRx5b0LKmkxZYkRYqReB15KXXcgHxR70dTbI+X84VAIpEhesZ902XYDsWeaFD7o/Q39PXTJJ8vMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6vJ8gwDkdi74aNnCkI79Cn6GH6y6ZGYVO7YxyxuGX8dsrOGw
	Tqh78oVzZo8s7NFEzZ4nW6OAiIC6iBQXsk7nRg7b6OptMRCNB2VUFtw=
X-Gm-Gg: Acq92OGXh4eEveteRj3951ffn3BRCnVv2Z7JMep+H51+47d2Oiiau9LAOE99/qe64fr
	Yn4KbW5ylXrWiNmT008TFaqQhGZYV3V2grEkg18ZqlCJWtRgT1/6ZMKrVnj2I1ZE7tkAIJ0rqd7
	YrmzHXdFmQ+72oea8Z88vaP45UkrP28v6xLyCt/fyibxersEUsYmCQXQNtzB9tnSeHmfKe1XX7c
	eAhAWT3vO1SyMTqOG9Y2VRLpLp9iKuY5v/c17n22txyI46S2jMWqDFvPGLRTp3NlbTuKwO55j+i
	nc99hq3vX4BbIBaiELuMDc9W6Oti1cTrr+yjH6z2VuaI+L04hED0rADkCZcSGAdNRl0sBFakmAK
	X5EchxD83mQQasVMiRBSHKHGo2wd8CT1vfycxeraat1uCMqiWCfD/2WDbMjlulH872w==
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:c3f9 with SMTP id 5b1f17b1804b1-48fe661df4dmr117083015e9.31.1778958943323;
        Sat, 16 May 2026 12:15:43 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm23663118f8f.20.2026.05.16.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:15:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: shivamkalra98@zohomail.in
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btmtk: Fix FUNC_CTRL parsing for devices with
 zero-length payloads
Date: Sat, 16 May 2026 19:15:42 -0000
Message-ID: <177895894204.2999813.16690091301048694150@gmail.com>
In-Reply-To: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
References: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 14 May 2026 23:18:13 +0530, Shivam Kalra wrote:
> Fix this by making skb_pull_data() conditional: if the status payload is
> present, parse it as before; if omitted, default to BTMTK_WMT_ON_UNDONE.

Makes sense. The original check was too strict for devices that
legitimately omit the status field on FUNC_CTRL responses.

Reviewed-by: Tristan Madani <tristan@talencesecurity.com>
