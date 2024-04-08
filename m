Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7C15A8
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540882; cv=none; b=jth7qWhVsiT3tUpBSjIplxBrh2ItSRyXYJFtJfKQN1H/okj6mh4aCJ1cgHokEvjDIn5t+rTMrlUYbVF8Hz6C+VR/pBkPMg592GFL49mw/j6qFwaCzxSI9bvPhkD1bcDINN+ldrRC110EJ3pGr2xNi08Xf3u/nvFZaIR7js1hgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540882; c=relaxed/simple;
	bh=EnLTw+dCtMWrr7T1Cu0UznfNDW39BhmypXjEtsw2I0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bQ+W61siKdOOc0+QZH2qnu4n3sDOHaY/r0LDB6QD2ZqM9PlfAGulq1DOKsYjU2o5HvUGWfopbcZtST7GLmZRABZPFTy1ceymCovXbBCkzPQbrizU2288EcOODKdTTQhzjTgCACDKTUFoNiQ6riEGm+8MU3cTQsqTBHIn0W5WqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzwgi9Xf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzwgi9Xf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4347cbdb952so3713301cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Apr 2024 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712540879; x=1713145679; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EnLTw+dCtMWrr7T1Cu0UznfNDW39BhmypXjEtsw2I0U=;
        b=Wzwgi9XfI98NO1ssfDOZbQBb4ur26kYwGxxUYiLiu2INuFLkPAxx9D0ycrj9+2icuf
         zoyVpugFUZ0pDeTjzG8/LPU20pEsigD9nosHNyrEDbfFRGO1OTpzz0WldtvaC+2WpOyK
         cBpqtDCX1tviWwg8mtjlmBVbyEEUSdKIzBlsy5ydKne6Lsq7J1itO3iiW8P3Pg455OWr
         qyAHBR2sWwIZew7LgxNTqtRYAr/HgnRAELkG92x4GuAau6ZbfHHYxSm6ZpaICToQ2QHl
         LYpL3XjlVRQ4HIauegJ3LJwJqnpzoEpl7qfEgrR59WFwuqUydyp/UVvXwZxmUQ9QufND
         Q6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712540879; x=1713145679;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnLTw+dCtMWrr7T1Cu0UznfNDW39BhmypXjEtsw2I0U=;
        b=W38d3Tjy27+QGTyuGGaBofX96Yxqd786+9NrkioN/c00vgGxcn6HqAxj9T7/4y6360
         GmDOooaH772tsSdKUL4iKCisFqhSZGFNC8cBmPTv+zFisBOyptSmHGtTCzaEaQ1ZVC1k
         4GvonUwOYGBzggaheulH0n8tY0Om7C6NnZOAJoD3nh+YOjVKZMhThnYUAfRoBtlzWrUz
         1hwyZQgYa0UjcW/UZLMtmQL6CiHOSendrXkIUVQYSaJT5iAOz/LdOX4eEdVbWm3klrvt
         pXEZpNSSuydXMhLyG370TQ+UI/p+OsDyFxj6rbOfUsTjN1yr5EOIk3Ht+peXVliYJKIZ
         U5WQ==
X-Gm-Message-State: AOJu0YyvyEP+pqmWQd7+uVZ8eelWx9p6hrEP567R7KBG5O7clgzb2E91
	0Cvv40jGBu2c3NvUTl6eAbt9J83Nu/skklTMhZTiMlClRhRj89XllnHJC2iR
X-Google-Smtp-Source: AGHT+IGx/WcDacaD4zXo+rpb7hxBptxHfg6EwQq3fX93FuHTkAxIiA5TinGkHOcjnrdjVTrViT4nXw==
X-Received: by 2002:a05:622a:5c8:b0:432:ccf1:52f8 with SMTP id d8-20020a05622a05c800b00432ccf152f8mr8207267qtb.51.1712540879279;
        Sun, 07 Apr 2024 18:47:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.50.151])
        by smtp.gmail.com with ESMTPSA id g15-20020ac842cf000000b00434b57285f0sm50727qtm.8.2024.04.07.18.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 18:47:59 -0700 (PDT)
Message-ID: <66134ccf.c80a0220.aa00.01c6@mx.google.com>
Date: Sun, 07 Apr 2024 18:47:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4155806347920822196=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v3] Bluetooth: compute LE flow credits based on recvbuf space
In-Reply-To: <20240408005625.57115-1-surban@surban.net>
References: <20240408005625.57115-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4155806347920822196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/l2cap.h:943
error: include/net/bluetooth/l2cap.h: patch does not apply
error: patch failed: net/bluetooth/l2cap_sock.c:1146
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4155806347920822196==--
