Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4136DCE8
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250902; cv=none; b=a79NuuhZkFDPdqTpVLkTchRydIoFRmLQiTel2w+1cffNpZfV7gmWpCLJhBY5valK434gzjRkAu6RclGRKp1z2GyNRPU5Pn8VpxWMJEpYt7Joo7MNaSgtKyffq/8loRZgKjBovS/FV9tntYjVzrIlCRwMnfee9r9Yd1gGlt7PSjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250902; c=relaxed/simple;
	bh=W2SJpAHspBss5LFuN3L7HoSJ805DHdMJ22p3u56OJVU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Aiw364qTPvnnqAIzkzb81cW+t4zu3EVSB4iF7MEFQBBs4/egF12Nvc/quSyvAl2kNy7jP+RB7LjFHydGPAtHv2cSKuVbpRlxjU1WfS2h4gzO/ozY/BqupH2B83h8sGLVbBwwxVrL+Cj43qgA9pzUTH8Mid5jr3B86h033DN4zjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTzfHgYU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTzfHgYU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso3751970b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713250900; x=1713855700; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VaFPna1NrclNYF2ovFQUZ/CvoJf8g5o2zWUoXWgYGrY=;
        b=MTzfHgYUqogn++kJl4PzOLzSH35MWc2DynCfNtpGwWG0kfQ1YgAcmiSpweQw2DpXqP
         2SbsyuZV4TZOGD6zGEBs4Ev+UQErvQI8CDW3cWdYpO/l03VTgW2JxY7HrJ+hlRslBAQt
         YClOXSfMrkS8n5nWMrJ4PpbTEsN7ubsVzFvCdajupJuGqj0OvFaeWQoZhRe7GOhdSKGr
         dZlednBwTMzJrw0st67icOlL+olDqQH5LBFNRxA4g4gj8MVydjY2WaxqG+7Xao3bWNvu
         MkjTd6XZKOtlNnnf3Z0qr/Z+9+2tBviBty1bf2FrIKkujpy7R1RhTblODGb9+yFX+i0M
         lYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713250900; x=1713855700;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaFPna1NrclNYF2ovFQUZ/CvoJf8g5o2zWUoXWgYGrY=;
        b=TLxJZTanVtYWToooQPXgu5IXuZklgXhnZJC/IF1ugxBeIpKfgx265dK73+Hcy/47Ko
         IxorhdfI79fvLKeEp41+hNUXzyjiXl6phB247BR8n2wYRLNVFp5gbMuUjX8WcSG5jEd7
         pMYumzB2JM/jRg57wAjppTg6TEJd/CNgjGKbUqgo4H1kna4hHWT9ZMHSzhtVD+A1ib3S
         Qoq4RaUVOMA9c3y0+hHR3vgsHhluNl6XZ/Jr8vwWVGhLw7B+djmE3J/Ab+F1ciWygJ9l
         1FjZ44weYQaYHq+y/vGNdMTLZEdxZVzvwFs6LWc3NHOMAAa6YGlNqTTuIncW39b5nTXx
         UN6w==
X-Gm-Message-State: AOJu0YxAflHUhDroNmpDg4Co+uYL5zyJCsA0HeszfU6oQurhdo8pBEF0
	1lRVUy73+/KoeE3sXwBNB3yhpuEwgHKZPpMN3RmEGrivsLMZhBgAMLpjmQ==
X-Google-Smtp-Source: AGHT+IEvVt4HK6QnKJsWtvwL7APvv5OCotjf0fWqTlKWuHgCVneBxZ3VeqllTrcWAyJHk9k0IAqNfw==
X-Received: by 2002:a05:6a20:1044:b0:1a9:5963:e58b with SMTP id gt4-20020a056a20104400b001a95963e58bmr12974149pzc.35.1713250899948;
        Tue, 16 Apr 2024 00:01:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.5.226])
        by smtp.gmail.com with ESMTPSA id z3-20020aa78883000000b006e5571be110sm8256343pfe.214.2024.04.16.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:01:39 -0700 (PDT)
Message-ID: <661e2253.a70a0220.a530d.865b@mx.google.com>
Date: Tue, 16 Apr 2024 00:01:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6472996504315202920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, polynomial-c@gmx.de
Subject: RE: [bluez/bluez] configure.ac: Fix --disable-cups
In-Reply-To: <20240416052603.4373-2-polynomial-c@gmx.de>
References: <20240416052603.4373-2-polynomial-c@gmx.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6472996504315202920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844910

---Test result---

Test Summary:
CheckPatch                    PASS      0.23 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.48 seconds
BluezMake                     PASS      1689.88 seconds
MakeCheck                     PASS      12.81 seconds
MakeDistcheck                 PASS      178.27 seconds
CheckValgrind                 PASS      248.88 seconds
CheckSmatch                   PASS      352.63 seconds
bluezmakeextell               PASS      119.54 seconds
IncrementalBuild              PASS      1451.34 seconds
ScanBuild                     PASS      1022.03 seconds



---
Regards,
Linux Bluetooth


--===============6472996504315202920==--
