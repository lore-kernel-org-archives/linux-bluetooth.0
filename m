Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB473644A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152832; cv=none; b=mfMVfNlCk4eNTpb9wOZrOmq5zmVL835fav00A3n8+js4y7IoG6nRls9Riq5nmIswJh7L4bZakMD4vFmaG3trePG+AG/v/cl94jK4+jue6DDXjaH+HrKZLJaKW1aSa74NVTPkizhVcclIprk6LWe0Ik/5rVPf5eSSoR+//XZmiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152832; c=relaxed/simple;
	bh=UVzjG2gXngJ45j8y9wb/pvAZrIkHPHNl9FF0t6NJ9gI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ATWhOSJQmAspoTdynLO4cYIBanYKSBl0oUwUxpdA/7sgl8WVX2mpPQSyaZFoT9wcoaEkAKk4Jqi6AH1t+MU9O2P2Fi0SuG2fRfvZ0HEws61gwTeTp9YzLerNrRqjNhSUxVTnnQQZRhVVh+O9uNqpQkOt64kuJebxiaTIsnB0zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szPbd3Vh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szPbd3Vh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2236505b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787152830; x=1787757630; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UVzjG2gXngJ45j8y9wb/pvAZrIkHPHNl9FF0t6NJ9gI=;
        b=szPbd3VhNpqNmr7ermXC/Bwo+ine5U0/Ww3A47KbUxpmJSFTLaHSqnYINdKlNnYyIq
         kk4bfN+/Hol1Cbx4Sl3D8yZLW5xFfBCECOWiAnZSu2amz82iRmMQnAwuXT+dHTx6KGov
         iJFsK1cI+XJ26lwyrdKBrYUFzHKLf5GCFs+conTVbwOYaLa65UbubBN1eZswIizBiI+G
         O24EIJdaV5R2ihL9pMtCOWQ7vWMX26DacUt4LZECLWOjfMAf3h8zjNbcrE2jLYVpdtYx
         fj6nQohiH/0+J7aWbJy39oYHPcLtC4aU0OdDXB4xBMqHHldj2j+ImP9UX9zV6Yx6Apmv
         gv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152830; x=1787757630;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UVzjG2gXngJ45j8y9wb/pvAZrIkHPHNl9FF0t6NJ9gI=;
        b=p00/vf7tjv9eE8MYn8jio4/ZEDxXOSgzeEDiMKS/UQggCR68qeycA8OtIkj8FN9Em2
         eG0RkphFvUjDPCvUHvkHamcKeQQyoREd21zRIAlEAnKHpo0M6PlZP/vHoJp0qOS6aFMz
         xCdKlzUcE3ncHjdgbaoPQtkHFYRDXu6do2o+pdFxIOFIxT2U5yyvrmzF9Qkipr7s0I/K
         Rq61PurLxpGKEevtT71SISYMsrOpyjt5NAKSuTiKOx6ZZ/1RJ2wkrgL7mdXExgAB/g6M
         mC9dyAjBEw3NJkqxJQJP6x6cTWtUJbcOeUXYPLnmAGZSkp6AB3LyzxPICEn+8CuokQO8
         j0ww==
X-Gm-Message-State: AFuF++ni0+cQZ2OfBKfUXrqZYRKU+nVtNcwRRLKDf1WCG0/TW+XWyxWE
	uLi1XCkYcqvbxKCoH4R7UbH6tJ8f9Pl/jswbTm27CW7SeMrsvJGa2rEhRPd7mg==
X-Gm-Gg: AR+sD12A8PEf5pguNPWzNdkoK8babcYWrkBAfs+1tuUj/m9GfTdScZ2R7t6JS4exjJ4
	taRKuXp0fe7QWHxzYgg5kw+zjoRGV0e1dFnNXhuPpU44E7j5X8VcTJ6eC9LzWfgrzlndB/WJoIz
	mbb4j8NszrevM0q8rvyf6EhuAOF/XaHd/QhX/cPqZsc+ggvkiwcHNi5ZUB5kR6lSHGYx9Jz8dFn
	zoj5XL+lM6CIPeR4BFqhugCRYNnL7MMrizjwqrgytEo1Ik079NLNwDGbzcBcmseUPhRU0Xd9azE
	921FQ5vwNnaT0ID4I3dz4KWawzYfH8zoK6qJyawxQY4i0MFnHxy1nPz03X7F96snW01ezu+1vS7
	93v6/FN9Wk3k4fpy1b2v6KebDh0CWOx/OkPitrIQVTIdlZvLo2TdwOCilBOHywVlbbBXOZ5t8qb
	fKM2+OvEO3RrsawzYgwo/ULd/31oOZzNMUOd1ADqvaqIc2u04PajYRXjBJn4HHjMMjXEdfA88XX
	jx63Bo=
X-Received: by 2002:a17:90b:2e4d:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3957fa11e87mr7875168a91.16.1787152829990;
        Wed, 19 Aug 2026 08:20:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3993dsm7330033eec.5.2026.08.19.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:20:29 -0700 (PDT)
Message-ID: <6a85c9bd.b1b3e0a1.22f0ed.45e1@mx.google.com>
Date: Wed, 19 Aug 2026 08:20:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6122595755668035438=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, weir@nebusec.ai
Subject: RE: Bluetooth: msft: fix vendor event use-after-free during open
In-Reply-To: <2e1dd2754cccae9180551049ff384bd04bbfb0b1.1787048594.git.edragain@163.com>
References: <2e1dd2754cccae9180551049ff384bd04bbfb0b1.1787048594.git.edragain@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6122595755668035438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/msft.c:166
error: net/bluetooth/msft.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6122595755668035438==--
