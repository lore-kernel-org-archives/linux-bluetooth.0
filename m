Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37114A92
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705820128; cv=none; b=QKjXaYM2HWz9s8XCnzwsmDPgSxOIsA39UqoyJZcEzNuMVB2OI3SZNxFEyyLR1zFUjiS2qQit872f3ZM7FqotIwJmWozLAPWoNo+RIV4JIxHBupnzeSxVGxeG8xJFzJulxhfsAQsdk5Az3s1PM8vB34qpQNgEKfFG+UinixZ0n0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705820128; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=aM58EwPRyRn3SLzc1c0JAS8Fh7iO18D87kb/lvMRIkCyUYq3x2CchgHPHfBkaNKwfpFzspJ3aCFQY6ey0CfSZ5DGi3UKLmh8KP1w0MqpmH9snHB672a4O4gLEY+z8Eq295V0A4NTDF3nKlBHedcm2191bWQ24k2SJaKGBKQgz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqyaGSL9; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqyaGSL9"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dddc655a60so1678110a34.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jan 2024 22:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705820126; x=1706424926; darn=vger.kernel.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=DqyaGSL99PFXyEnkNwcdTjLKBoUp4egYnXTNCYMgI64PK0CxX5LIg/iCm/8dYHKQ0e
         2NT+79qbK0zIFZAsRBca3knnwDGL0Irs7Jq/edifAMs64J481FchifE55X7B3kRCwImt
         +LLmWjnsy/5SZXomd1twasndd+cGbiUbyBwfE4AMFhiAflRFKJWXx9amCEeDVmKcmk2h
         sPgzaOw7UWSh9FRKrzC2swYKTEdSnWuZbcCURdZ0KVyRocqqb083jeKqhTxstVFKK+BO
         Njf/HWPLoigkuZ9/1ZtQwUodBrovyOMdLjgXEfR9la+IT3Yu3tsfSnyMKPBcEorhnxY2
         jWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705820126; x=1706424926;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=lD/QgV8znuw6kc9GTUFoqLM326CDmLgV4dH2m87ykQ6l3n2iaBkB8cSkYyZQqDaPJo
         DtGMAR6AAVTmAso0/dwmFVxIq7H447QbK/NeKi4/CH549JBOYi2wYacOD3uFoMWIC+A6
         VhFUzhyuK48dDuADbHVGTF3ZSClf2Wr0DRkOowdPEa2JbPg61Kv67n1GWAo0RXRAYmuM
         x7cfQvRYdYcc2AA9M3My91hll3TNtI3BSXmVjOVfpYI1fXkYtDG9dZXJb6Ilc5fhA0RJ
         pvx+9A9OxomnNdGXPbqm2AS0s1eueWpjvG2C6OODTncwl/HdhtDYAZMZTWREJgKk4DbD
         YXCQ==
X-Gm-Message-State: AOJu0YwJjlydtvDDHEaLrKpUaoPIhCs3BcpfK15rdcKLuUsC+JGKgl0L
	vWyVdt0BMcWopQoW5i06p3iJ1SiOOOJp8ONYFLw8Jiohwup7PY/Yb+TWpNkp
X-Google-Smtp-Source: AGHT+IFxImqkeExj++gVACQfSRmYCkE5aP2OvkPFdrVt6z6Ns54yQGKdUUuBIn+fNrgBf1M1eQR09Q==
X-Received: by 2002:a9d:6acb:0:b0:6d9:d8e3:b2ce with SMTP id m11-20020a9d6acb000000b006d9d8e3b2cemr3327368otq.77.1705820125827;
        Sat, 20 Jan 2024 22:55:25 -0800 (PST)
Received: from smtpclient.apple (2603-8080-6500-979d-b11e-200c-b859-4620.res6.spectrum.com. [2603:8080:6500:979d:b11e:200c:b859:4620])
        by smtp.gmail.com with ESMTPSA id g19-20020a056830161300b006ddd897c37bsm1167605otr.37.2024.01.20.22.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 22:55:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: senca Wilson <sencawilson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 21 Jan 2024 00:55:12 -0600
Subject: Re: [PATCH BlueZ 0/9] Initial BAP support
Message-Id: <5C178573-FEF4-470A-8797-AF96E35E8578@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
To: luiz.dentz@gmail.com
X-Mailer: iPhone Mail (21D5044a)


Sent from my iPhone
