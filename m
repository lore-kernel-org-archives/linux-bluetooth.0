Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A6288DD
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrvpx2Wg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4297596de39so441551cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704389769; x=1704994569; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7LG4inUb3whWGxOKxEht+GJsz6JU9u9OJe+PX20/QQU=;
        b=Vrvpx2WgNwt5HxJ/MJbSiP5/NLGc8lpaUyhqTvq9C6yklDrJpYy9zoztBo681IT2V3
         /wwpaZlbALiQ6Pf3xaoquIcZvjk6jI8d0JAhyHit4c7p59MJhSc5UHwfj5ddrdOyYPry
         LkIOKFrU0NQHsdBf4Lb6zdu4QPI/kauSvcdPv4rEKJ9EBe+zccfHkr0HZTD3ExdSB+Id
         FWcFpPDe38ETMkL/3wB6nbq/euCqD6ncK452sJSJ1wo2hA2bLCSfrieSFJu0UZwZGyeX
         ImOhDgrYqAMFc2rbyYNZPsoGSyIrq0BQsNZU4aErijh6JvVXu70l1RuHrt6NoaRoRay2
         X/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389769; x=1704994569;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LG4inUb3whWGxOKxEht+GJsz6JU9u9OJe+PX20/QQU=;
        b=cVNTd+e0Kqti/SPmQDahQsjJPY63Ub0EzE9sHooJwLkUizLJg8cPCYN73KCJYrYHma
         CAp4RA2N204n3/ovNFL142U4vQNwnAwiwnB2m6iof1UKduwcIID/hhxgHrJMtSNbolxp
         2LRoUXZC/xOfrPkRntCdVmfcaBbkaiYTlFlP4p9JSTiqaHsmFMvJAntW2Xz70zwnDOTb
         jbheor2kgSS1ZCoGfSjwEYkwduNwSpT9ehYJdlMcU0ooIZiAsIFm3WyrR6alhXTCi6n/
         SKT7EudwSi6pxhUWBaLSMQG6cH5Els1G8kSuwLL1ehve+PA0SuaJYTmilc56aGdwlPt3
         Xuaw==
X-Gm-Message-State: AOJu0Yw5OzyjCc+/SfegaioMiEIfX0zC523gjWzf0lU8PGL/Tm0kLVCu
	grPKYEzQ4mIhuWpo3ImEIjPQQ038bqk=
X-Google-Smtp-Source: AGHT+IGYRAHQcyZhaPb/GP0MdObSoByorZ5tfw3ti5+QNVBN9g0BpC9F6yTrPI6VzCDTqIFJzV8PCQ==
X-Received: by 2002:ac8:5a87:0:b0:428:36ba:9554 with SMTP id c7-20020ac85a87000000b0042836ba9554mr1235130qtc.12.1704389769507;
        Thu, 04 Jan 2024 09:36:09 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.134])
        by smtp.gmail.com with ESMTPSA id bq13-20020a05622a1c0d00b00428366695a3sm2162486qtb.44.2024.01.04.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:36:09 -0800 (PST)
Message-ID: <6596ec89.050a0220.92b4b.751e@mx.google.com>
Date: Thu, 04 Jan 2024 09:36:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3320516513449910153=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes
In-Reply-To: <20240104171652.189629-2-silviu.barbulescu@nxp.com>
References: <20240104171652.189629-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3320516513449910153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/transport.c:675
error: profiles/audio/transport.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3320516513449910153==--
