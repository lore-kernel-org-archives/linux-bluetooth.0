Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0E2DECDE
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784367350; cv=none; b=eDu3En5DqGY1cbmhWkygSWF4H1qWaSXgjdykl9OYll53T3zI7Rf68/ekY44/CeYWEawvY8j8fmaQclsOAvwmn+EUHpMs/LQc6y1olbNrmixXzWXW1KIHcgsCxJlZlcYfk7JQUbAOiz/S3TXpdck5spmRcMBt+ZvhU5LVpBSVrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784367350; c=relaxed/simple;
	bh=7CGDMG+TOJpmCZfRhs5VYQ8DthglGo2fs9wGBtT5UQc=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=CM/ODnzknkJeBj6S3ngJfu5x3ug5gPkbqxdE63XQQtaT3EEvwjFKBFI6RddUrxFJaed4TbqrdzLjW+OXeT3v0dDWyGKiCXXYgPuS29XljWOcAMuVGShBLJNsvXlQRy4wVhr3a+dpdpQD90jKD80us0RXT3EvNLU64K2Y5GKBhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ottIFvr+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ottIFvr+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so7502135e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784367347; x=1784972147; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CGDMG+TOJpmCZfRhs5VYQ8DthglGo2fs9wGBtT5UQc=;
        b=ottIFvr+INZYOQ3Sgtc31LOePmg2mY05B0d1DTz3kbzlfWts1E3weROFJMt6yO5Rbn
         XnYtPMhaQz1nkLaddA5BZRLLg2MsijdmHulOSXkh5hEDEAS5nskSWngG2RrWMR2Zpaey
         2fbcFq+WwmWPm/dQzRDFc6ylfG0dpDiIBxT9OiybqikDVuZT6uKfowgg6XKwGrM/RaDD
         xnx6wW7S5aDgoGwIE65hEiqq5p07Hk4p+2wsvPnx0WVBB0vioA717QS3o1ukCZDo6Oql
         udoNezceV96hJt3jjYTrlsV11Ovxc9Ii9tPexS21a7wOvq2nAWOJajQf3NFpxvzRcBGg
         JYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784367347; x=1784972147;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:content-type:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CGDMG+TOJpmCZfRhs5VYQ8DthglGo2fs9wGBtT5UQc=;
        b=cXlqQZcOHdwP27293rmJX76/1dp7WJFfRrUUQ7Meosl2O8fTQAfyzNXvUGMFRUDzMt
         5HJCBiFLfnAxJalKtvg3eOh1j/WAUZxlEFOl54cia5LzDZ/mzbLjze7Kd9ZQ6EvAipqP
         L6TRWCrO0E9UlYDGYxnqdB5iIhiq95xAI7TGQzr2TetqYtQCQiycbrOJTBOjKbKPLLuN
         q3h2bKozNA9t3aENG0yj//GNoxFwk5bQaMZ28aM4OFB+7aFSbyS+jSbsQFJ76XlI4ecR
         T0VlL0jpiV7mnVZYPslbCi/J7CHsot0UXZQRv/ieVRw3PoOJS6poVyLFg3/ZtdAa4ebh
         b3lw==
X-Forwarded-Encrypted: i=1; AHgh+Rq02jc8WH1vnNwzbd0q0a5b9bSK68KSm9AVTuRgePZo/xyuzJDourWn/mrmOM6IIh15pm0o51kuX6RIf0HHjbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJgi67K2erOp4A+rwh26x4plrR9y7vf4dMxaF4E4fphzfqeJe
	ZU/+7WuyXWP6MC8el4ntLEJNZxRK54ZzOCx/vRLwgqn54ybJGPY7+tbI
X-Gm-Gg: AfdE7cmxo7+/6qOR/+0rtZAfRqPz8DfEYHf6lV/bmFJg/h8ApyrX0QTjm9BVBIzqJrG
	p4I9M+Ahv/hd/AYwNuueJoMZoJrNMHWRX5CAw5GPfBUHjCDdpXx4SBrlqBA3czBQkT5f5zuym1l
	0+seQ1m5+zrKbTuYkNldR0YGN8tUXOhooWv1TrLQzdT2YvReOCpyo2+bajovDO6Hd6fjJmYHm/e
	Ztc2GPIXKpK/wJiqlE8dlrn2prsDeD+ZanUxJcbUQu3hLZOMoX7Zrs02Ei4B/q3cmuHGkKJzvrL
	KoWX31ybTwKvMqLeuNtuJmkhVio2hJ1xdsQdMkov0Urv/kWAO9yLurCV499NSYn+p2kzyVLxMDj
	htGn+BvRNUmvhpParqV/ic1hRSrCEgb/MV8plqM+SeKHoaPzwGjAcuerPuA/1oGYBh41jJbRsnN
	eJviJHAvbGV2D4qInqJqxhXWstJH+6ZplFK8frbw==
X-Received: by 2002:a05:600c:4453:b0:495:4f62:1ff7 with SMTP id 5b1f17b1804b1-4954f622066mr30952595e9.17.1784367347077;
        Sat, 18 Jul 2026 02:35:47 -0700 (PDT)
Received: from smtpclient.apple ([102.89.46.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954c0a81f7sm70392385e9.1.2026.07.18.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:35:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Chinedu Mmadu <mmaduchinedu98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: SIG-Qualification: Problems with setting TSPC_L2CAP_4_3
Message-Id: <1CF5B312-1EC0-405A-8122-5E6C1AB56FBB@gmail.com>
Date: Sat, 18 Jul 2026 12:34:58 +0300
Cc: frederic.danis@collabora.com, linux-bluetooth@vger.kernel.org,
 luiz.von.dentz@intel.com
To: ceggers@arri.de
X-Mailer: iPhone Mail (23F84)

=EF=BB=BF
Sent from my iPhone
