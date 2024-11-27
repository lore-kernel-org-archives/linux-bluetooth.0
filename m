Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA91FAC34
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710487; cv=none; b=L5pc2WzVmZ6e+VglIvUo0ATIudTYxvyvAZsTF9EFY4v4tR4dmG44e5vvF6+/tc5C6zndKZVtnmre6Hd5tH6JXVZHzYoND/qlxNUj55DlMGj88uDTHMq6y//fYBX8XXEFWHcr9xJ2PBH92MZhWvvjimoBhlGV79zUFbQyNm5IXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710487; c=relaxed/simple;
	bh=vLvueAcDu30q/e3BhYvc2/zhHSsCzTLMFpHPeMHZg28=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OB4UvRQPj42+cUJMsbU7/5KtxsJZmkpigqJ0nWQBqOxDuB4mfc617IAsRw5SpfsZuS/8QG+lOX/2zz4+M7gqiHKf/Qc2koHu5QGKK7C22y0Oro6olI2d+BniTQl0sfyX5u0z6Df/NcLxpR3fqIs+4kWEhTrbG0eNK8lLLAgj2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGE7SYhC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGE7SYhC"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so1597731a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2024 04:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732710485; x=1733315285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vLvueAcDu30q/e3BhYvc2/zhHSsCzTLMFpHPeMHZg28=;
        b=eGE7SYhCgGDPMHgRs/9WKFmYmfQoxS8JmH9uYvL40D639jzCblFO/IvGhn/Hk8cEcT
         qwxUzHbBL2AMkHjPFJcnpe9d2haeFHVwZO6xXZStiKvFr3Dd7zoYGfIUXcKxtrFCD/hV
         YvAXakhypY84EyqAhV1USlw+eApvhog08ElhzCz4Kw8cre2QDQtPVxTQK4aeVZvS3DmH
         RxZuKdPn69FzpgLK7+jIIXBv1Z/4nKQHl6wIUP5RqORiovbPvmFKYmHUIVVz4VVUddBi
         wQSZDxkqrsAtBw+kOOB+6YEml7/63h4+AOC39ot4impXc3VPsYq2n889/na4bQAsdfmF
         kvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710485; x=1733315285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLvueAcDu30q/e3BhYvc2/zhHSsCzTLMFpHPeMHZg28=;
        b=sicZA/16Hi8h7PTu0lcIvl+zrDkwEMBwfWGsHWjOvF/KNVV3xjSCSkSA10THoTE0/1
         hikdG0fRd9kInRRhvfLoRM8abRmaqxLCMSevsei7lR9fvUYRE/WmdsKSuuNxXwe52hsU
         axqURaX+gxWJm94rWs8nHRocVlSp1ZhZtsA0tH1VkN67A5ECZu+NneaoJAIGL+5FlqeG
         7t7U7HD2Z8pTe9FAjsXD9CifZyTZfZmzGFbpI3NdCAm6OQtCO5x0hBP8ByW5rrzzmYt3
         4SiQ7OlScDjNf40z5Uf/yT3HrYPu0ajE5NYxPdYEzi3WlbgiaXwzYXEt1p+nuqvrnyVo
         MutQ==
X-Gm-Message-State: AOJu0YyXQNLDsnHvQ/Ry4avDBU+773IKmv4BZlLI3frJQfbnIed5SPm3
	MOB/3pmDLWMjq17GLBjs9EdbdhdqC439ca9cbJpzkXTMQehUnDTG5nnVAA==
X-Gm-Gg: ASbGncsE+DWMe4J7JhrViInqNCLBzq4vnL7C2lYHKSOP9qiRG7bHSExB5u+sasamLXX
	iUoed1G2zROpQQ+QrmOW/J04NlEJmVx7pKBWxbMkii8qfPDPN5bbCu8hKmoOaY03r3ZYYXOUUvN
	hwmleDzXTeQBKyHM4VmylqxVTDoyhm/ocsDqgHFqTpm/YSZjFMqAQDYvT+2G6zNC2cQsI4t2kL6
	JSax6cZtDjT/bVNK+T9FcMRhBtY+8b8mALckGoH7bnFUDnNXtRBYSwe
X-Google-Smtp-Source: AGHT+IG4tFBYM7rD21nkKkFg2zfa/FplmTLVywD0w+LZElov3RAeF3yrYoVOk7fqFVJVIn+eAMJsYQ==
X-Received: by 2002:a05:6a21:3289:b0:1e0:d557:2818 with SMTP id adf61e73a8af0-1e0e0aa8fc0mr4804934637.2.1732710484728;
        Wed, 27 Nov 2024 04:28:04 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5346basm10397029b3a.108.2024.11.27.04.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:28:04 -0800 (PST)
Message-ID: <67471054.050a0220.2c2570.cd94@mx.google.com>
Date: Wed, 27 Nov 2024 04:28:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0086609937589858813=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20241127115107.11549-2-quic_janathot@quicinc.com>
References: <20241127115107.11549-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0086609937589858813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/pwrseq-qcom-wcn.c:293
error: drivers/power/sequencing/pwrseq-qcom-wcn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0086609937589858813==--
