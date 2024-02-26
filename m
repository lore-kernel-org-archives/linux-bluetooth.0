Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDB14B820
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929070; cv=none; b=ARA36bWrYyAju3/rURcxU7jm8qPrOUtqAwqIgCFmlY/kFsfeR49YNqjMY1NxoVovZNHd2FiVjwaKagefcnXAA4Z/0Qo67UHmH5GHg5sXfEg9E0v1UKBbYJgQq6OjKHv/1FsYXFR5lNZ2nlWTzVUGAmpFYzzTmRtd7zd2+s1fxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929070; c=relaxed/simple;
	bh=lKATcOg229uY7a/kcluHyL5ADuzC2NQaf4+vBuo0um4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y6VKLNZW3mS671ykJfjkLlDLSz0V+t8VH+UztRDXPm0up5IxawiyK4CXK5i5G3qgOHJBEPOHcAryMJgdc3iDPt4HGEGCTRhnkmZDxPnng51hxhq+iU3SG6YFQHtwpVSR469MZ28JF5yNLeYqFXHwPB3NIWOXZ1VHGL9DU5HIzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHKramz2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHKramz2"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42e89610ed8so1306231cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Feb 2024 22:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708929067; x=1709533867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wwGBoM1P5ivA4WObOLO6uNRAzshCoFoR24lTUHS1wk4=;
        b=BHKramz2NmvdpSGw7Qln9tNnlmNcU9kCfZcscQLWUcVhaf5s7ffcjJ8adxA8KVYumN
         MfpKdYg8VFdnXznTiNRgf5Gt+Wrc0fq4eHyVitSYWkow/a0sf7Fzdk7hT+DsW14z8cYn
         IpMqBonKvuSSb/o9yE3QP/NAesQBCwcIhdXovUlsZkzJbeBEpqWL4IzivFx6klUhKX25
         EkRywUa1jwQnOj5iwjFOg5AzAsd6U5NxSlmZHMqIphdrIctgN7w6AxBt2uQHhI5XQoNc
         Mm/4KwV5gIMCCYHXWD0pnUeRAiMO1Z7d90QItZNAb7hLt0Wss5Or3E2ATKQKKLbw5m68
         IF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708929067; x=1709533867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwGBoM1P5ivA4WObOLO6uNRAzshCoFoR24lTUHS1wk4=;
        b=M/JZHjGU6WSMsf3lq81NBPxc2bUp9/moHyD4vlbozjsBXkG1wyFpgfPWMXae3IUhwF
         dC7V8NjAJ6wdxAIMVmTYz521wPDP1NvlQMyz5vB7E8zYLV2Lo0qKQBer2Ya/vib60YEO
         kbj4gffOsQZXoDpjkcfyiRGxipkj6ppj76aA3SF2QPaTQx85YinEcgln9jOF/t/QUGss
         BZaFbY8+hgHRSmCeLfBZf6G2f5pFvQz7Fj/YqxOufKYrI1qB1YStHhgHfGAai4D9QZ8Y
         Q/poCJeWIq1fB9ox5uAL/b6HQvxaWW7RH7BSRjdnncp/dqjD6GG+5Q0/wKEC8HquKLrA
         TORg==
X-Gm-Message-State: AOJu0Yz3FhpdJZK+mjVdMjpGH83j3V1Pqweu5bexUrT/Z0adoiTgncQZ
	QamhSVX9diawPR9bU9Rncav+ypIrmrZ35zCRpTqN7zMiUA1uJz9JJoJ7MhDZ
X-Google-Smtp-Source: AGHT+IEtEZUYE/EIlEbA/j0ZepbdAa2Jc3NBtNBLw9m2QmGCfESpskg+6j89/upZneN4GlMzgBAhdw==
X-Received: by 2002:a05:622a:54b:b0:42e:8962:e4ea with SMTP id m11-20020a05622a054b00b0042e8962e4eamr996412qtx.47.1708929067298;
        Sun, 25 Feb 2024 22:31:07 -0800 (PST)
Received: from [172.17.0.2] ([172.183.53.128])
        by smtp.gmail.com with ESMTPSA id s14-20020a05622a1a8e00b0042e7b5936a5sm1438809qtc.53.2024.02.25.22.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 22:31:07 -0800 (PST)
Message-ID: <65dc302b.050a0220.2cade.3605@mx.google.com>
Date: Sun, 25 Feb 2024 22:31:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8585004989127028525=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] advertising: Fix assigning mgmt callback id when adding advertisement
In-Reply-To: <20240226132201.Bluez.1.I8d368be0c7f86e8a999fccc33f8c9742b405bcea@changeid>
References: <20240226132201.Bluez.1.I8d368be0c7f86e8a999fccc33f8c9742b405bcea@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8585004989127028525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=829696

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.07 seconds
BluezMake                     PASS      733.87 seconds
MakeCheck                     PASS      12.40 seconds
MakeDistcheck                 PASS      165.43 seconds
CheckValgrind                 PASS      228.77 seconds
CheckSmatch                   PASS      331.69 seconds
bluezmakeextell               PASS      108.28 seconds
IncrementalBuild              PASS      689.10 seconds
ScanBuild                     PASS      974.91 seconds



---
Regards,
Linux Bluetooth


--===============8585004989127028525==--
