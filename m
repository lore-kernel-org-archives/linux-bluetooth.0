Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B42FFDC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715285; cv=none; b=HrLeSwT9vc1xofXNzJyS70OY6hQvAjZywpLfMp8TeiPOT2VzOEqZlM4gRBs3x7OcEf0/xvSMpSkwL1pzJKHjIxeOsYW8+/NJiQNx0z+lZDkOjZfSXlyDxB+vtoZRH9DY0rMAZ42USFCdXCSfYCQPGDbCmbLsQ2ulfsFUKM/WFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715285; c=relaxed/simple;
	bh=56ADU/Huw4y50eyhOODiO2KxjxOtZZ2aVubmhU42CcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKARaeGYcOJc23HKD0si/joeb63Liow56hsaKiRy6UKTyRh+0WhDA/W0m5mo/bCfxa+FOoiz+PWi4UB1miqVr87vkOlkm/G+H//q9IKAdcBsF/yRE3iQ5aMdCSwFmQvsopFn6kLYfVsstUryvjCJKqJItdEzX8mBo+4PiDM714E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdEaWwJG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdEaWwJG"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d6083cc69so68791657b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715278; x=1759320078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGVqKhEE+BMtFH8cMl1+mQUXbSkvGH7kkBhcJ3WHkpI=;
        b=UdEaWwJGyMF1XJhhdyEX42UC57qCxpWCMuYv3BKgvIbRgsprzIE4NHMAoEpg8aOnSg
         tLdbnyiMgaW4jzehjm1A6dPznGiAZKvreTgz1LeH65fD86r8//Ew7ZWX8Og/m6Plo+Ux
         78NNE5tOAQeA4ESxlVq2+vUq/wRCBm/uWBLhC634skyvpD2aisqCB/OoQOJeDbKXVtJv
         DQI//lxjONsQZQ6U1EwmSajdh246hmc07E9Z0rQO0c6c5EBzdZiN7cwSm/lY0QStsRPj
         7tBENE2WLdxi2NDZLEwcqln5Phf+1di/O3dFAWQobqGut/Qfq73tXxsUp7D1NpTeaTJp
         42WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715278; x=1759320078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGVqKhEE+BMtFH8cMl1+mQUXbSkvGH7kkBhcJ3WHkpI=;
        b=vLeicGumKRw+SUlgCQx0ihVRv1+DSNclxKkcrPzAZNGjMrO2stX4Ph8EB6gy+xUnmo
         KkKzJZxfDnitty3biTrhvE+wLt9Ard6PH0ay14DIeUOV3GcZtsIRU+ZpU6gnhyafIGMa
         pchvhWWcy7eEEjjBvzkMYaqpW8uUgvRo5hD67H2u/lqo4bZq2L2l6qq91GUajqPTwMUQ
         vdNC4Lk9PIe3Q6y6zBFrSvKo5Bo/dAcsQ9ib7NzQcqv0F474MF63iBeGi/HoeXHYLY/J
         4RCDT9M+Buabno/qgkBDb2qG84XVHEFrSon5KvzNhDaR26KzhznWK1VguBJj39/hiYsf
         MjVw==
X-Forwarded-Encrypted: i=1; AJvYcCXEna+fotggWrwuONbzHdIzKqU6mYg4QGmh5vr9Wb5hLKiY54eoOmaNP6uu//Ly6mNhh6QGWx3KwKWs6B3//EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHyk0wF/71AYmQ9h9aR3YS8AAKiG3dqfXMx/WTz1/S+RaQxKi
	HbpmGuQHutXTNi/YQ+EbyhVgMCvdoQJWG7JYks0zNFGqKICpMbENz/sI9d3bVX2qqnReodxphnq
	OusBOGkJ8wkaqw0mNZH1pfIOz6jkBUHM=
X-Gm-Gg: ASbGnctYQvAYoHCKvjntnLTh+jec5vQUSH4VjnCe/zWKfOFQCIAqQZZN/vPHWCdBYfl
	NhFJccXva/3GpJbw1RTzvQtclTt2FK9WZea9+b6oaoCkZB8GRl7arOHsAsQemQqF1mCOVIftzpv
	LtQtesxyQpblV/JccIjsR3zSN8vzs9Ho01WNaggmQnextziWm9/QEjS8EHIlF5Us4MAhHGVZZlO
	zRO+aCjIYnIwhtD
X-Google-Smtp-Source: AGHT+IFdBM117VVOYGK90475Oc9X0RPGZs9aXyBHkSYL5pNl1nbRTk4X8rR+GskXSt8yyA0SxJH8Es0QDHvgzR/KM5I=
X-Received: by 2002:a05:690c:64c7:b0:728:ec0b:bfe9 with SMTP id
 00721157ae682-758a2d01e0cmr42373017b3.28.1758715277707; Wed, 24 Sep 2025
 05:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUm4M2HTQuO7ORXVE4tScuSTjhjeAVek-7JTBgb9i3wrQ@mail.gmail.com>
 <CAFRLqsVNSj=MCNWVsoXA335LAhvz=oELZi8kg+yFnwWW9A3jrg@mail.gmail.com>
In-Reply-To: <CAFRLqsVNSj=MCNWVsoXA335LAhvz=oELZi8kg+yFnwWW9A3jrg@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 24 Sep 2025 20:01:06 +0800
X-Gm-Features: AS18NWBkHXOfpyMQ7UyFRfVmdEHP0oHP_6EggeaZRosVlhLhuwIYwc4LfxoPOVE
Message-ID: <CAFRLqsWNtG5pMC+9_HeFSO0uqB4z4a2Eej+rVHAF3EUKcG0U=w@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: hci_sync: Fix race in hci_cmd_sync_dequeue_once
 causing list corruption GPF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-bluetooth@vger.kernel.org, 
	"gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I have send a new  bug report:
https://lore.kernel.org/linux-bluetooth/CAFRLqsVv0R282+xQE4sRM+Tkb0=J_s4Xi0N0K2Cvz++T9fHAPw@mail.gmail.com/T/#u
Sorry again for the noise, and thanks for your patience.

Best regards,
Cen Zhang
