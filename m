Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8A10E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770956245; cv=none; b=JVKthiPPyBCqhrfeQxeW3BPagy/AeEfg+24X67noE2EWOnoqRgPIIM1SA+gbbkuyHjXB+rMyQ4dHnOjbO7yj7kodbRNbpo/IiLoiBm0sp3egtMv1YfvTogEOONZvmDeOjUAV3QyZnm9O7HfU/TlEaLXxib8p0lYZg18Vff4rY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770956245; c=relaxed/simple;
	bh=TdW0azUKsKS8M48XxbNZgF3mmNCMIRUpYZsoRmlBnJo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z8I9DAztWbpXpU2eI1XvX7zsBGuq6vYhaaA/WbmfZrCJ0/WG7WnsYgsQoAZtYyYmjkoFxBNU2H5ioQdHp4d9mAV6ranbj9sKSiAvJ0l4IZ21xs0G4ux3y3Dwexe9mftHsFdyp35+2NU0AFY0JAhAmMvqrgmMYAw4BnPsmqN18ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM9ctcw2; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM9ctcw2"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-506a297c14bso5448151cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 20:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770956243; x=1771561043; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TdW0azUKsKS8M48XxbNZgF3mmNCMIRUpYZsoRmlBnJo=;
        b=RM9ctcw2ueJLCgTSuNQ1Znns2Xc9VD96ZvZhXalyIdsmg1ZCkx/41wP9rVWyAYbaOS
         uwz2fJ1vXeO5mSnU7++gDNZm7PNrib5CQdVHNUdPlPYlDGi7ErttIkb841UKEKfHTg3R
         JxxWBGTXXxHGK7VK9uuqP/r6LG6bCXgwUMO4rP5vCkA8Gn9ksn6g8UreI7TAMFSHeFVq
         +JwSmxBWf1sYgPgGDjxoyFc8O3ZLqSrd6EC1uxQYS+69Z8qfvV/QTGSkfpxvBrF5283L
         A/Zu2qszH2ZwQZ9JTIQVjo5VDZoM+ySAlDKGB2hGF5dexLWDLd2aZTDMWAgmjLE8Yj07
         DDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770956243; x=1771561043;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdW0azUKsKS8M48XxbNZgF3mmNCMIRUpYZsoRmlBnJo=;
        b=tCwBEcZ/Xj4b1+r4VApnJfG9TrpWldMhgUeU2L2dhAgbNHrrQ0xsqJ4upPw/bFbgTn
         5X2ynGAY5eGKfRStDiOjMwMc966fg4ukKhe3v4T9qpCa56VcGU5+zuYES7Loe+p64+Pw
         /TZ8RQX0WLbFkwoL2EyqburDs5NGazEWZor/LTpeNxv8ESs7bKbeqR9927oUae74apbm
         TLm2g6lOZwnWdwCSEmao/MEYfY+vYFtH16BBhwGN19CIGxy78Wzl8EK59bsq9QlKAXne
         wi5Xe/GE2h2xbVV08Ny5ge2QO7VQZMdYDDaX4wMTQR8mPTcKFULaOGKOQ9RR1pEZf5Hn
         u+Wg==
X-Gm-Message-State: AOJu0YzxdwstTqhkwJ3nTZlHTQD/bvmz8sAtYz2CPycWGX7Izo5oCw5V
	ZWwJ2xlYuDgjx5BrYBj354GRF+EsaTB02fyBBTpD9LuM0J2A3RbHxyRKrgIqhORb
X-Gm-Gg: AZuq6aJqh2SamUbuYuvuFDTx7RuiXRM5FEoHizBdQkanOvAc26lON/Qup6KdkwihOZB
	eT7BXUDAwRLY5htRvBSh8v+WksTLybpxOG4BaFV0l3ee6WfKrRLCPuVt2h/Dm4rIGaMCWWpCkaw
	QsqCIHk/j1utIbgZEZ98iJhpmu5vZh6wzh199Mot89Ju75YVuUfvLDn7S+4HT5LU0UhCQj/0ry4
	kt04bi2F+QnNbtjmDzyzE/E3BS+xIc5iba47URbwel+dqryH5SMtoHUiPkakOVjDTrRb+JUUOP4
	Ru975LkXKha0qCJ6TAz60YkP4mgPsZAICrrFz1yMrql3GoPL/i0ePSNUWqtnHprKTvOSBK0dWlE
	Rc1YprgUz8EvwGuU9MIxR/eczgSf53DR/eKYyPNjdpQXUDwgojiETDXaGDWwDTIMA4bv5vBnrrQ
	oU2sX7Gevp2rV2aFlXQmDE94wM86+z
X-Received: by 2002:a05:622a:189c:b0:501:4fe6:5a5b with SMTP id d75a77b69052e-506a8387d14mr8926681cf.77.1770956243021;
        Thu, 12 Feb 2026 20:17:23 -0800 (PST)
Received: from [172.17.0.2] ([20.109.95.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506a9bfac2asm2707051cf.12.2026.02.12.20.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 20:17:22 -0800 (PST)
Message-ID: <698ea5d2.c80a0220.85a63.f99c@mx.google.com>
Date: Thu, 12 Feb 2026 20:17:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1085130615325180412=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: Bluetooth: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260213030136.5997-2-maiquelpaiva@gmail.com>
References: <20260213030136.5997-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1085130615325180412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt_util.c:413
error: net/bluetooth/mgmt_util.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1085130615325180412==--
