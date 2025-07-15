Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432D2741B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577095; cv=none; b=skAq9FU/iKS3k2i7S7896O25tn3QYId+V3vXr92X1cH/+4gO8jY9buUqpj+RuGChjvKJh5nsOiczLYEuOYCfXEgaFkQfw6pa4Sb4dGl/Wn1aTK6XE5An2yOJ5ULi51QX8hjcB1FsPCwy6HNBbB7crgUPuQRDRc7GIAxoVvUfQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577095; c=relaxed/simple;
	bh=Um81HB/A6aS/OeXq806Bc3VdxD5zOdS5ZlZOMklBOe0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m1/MVpDbjPubmep6dRNrt477181ZRw1zk1S2xkcy5xXrpxT7N8WXvwfQAju94ZZJt3Ogf+vE5ve6lTFnccjLF5dwpJPh32Uwjvu52TWkkgbmcF6ONxau4NyYs+WKbwOT42mmGCIeedf8FR/B+lwSrllOwSxJcNt0Sb1WUbAMHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVRczLSj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVRczLSj"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d9eac11358so520007885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752577092; x=1753181892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MWqpDCYp8Atv2d1/KNZjHwDFXadHoNNnwQPvfP+Gclk=;
        b=ZVRczLSjv5ewCinqwTEfzh5e92ox7oc6gl32+ssNpRMAb4e9fDwoUVCk0i7qtQLkT+
         v/rOC2RLxzQySDNh+tTXoeQ4zQR3uUUD3c9eKwcUGK8mc/I4DdynBE62HZMsaTJ0EsOU
         6gUsBEe0xt8KNMayyCLgItM0ItAKhJ6Bx7wHpuWOARwzOPeGsRqOk7lIAai1Sb7Q5avA
         cmqCVtNbJnvrAogXaKgT47tLr6xKQgXZKnve8FGYFssLY8/xQXQMGq2/OdY7zKIke6LB
         NWNxnnzFi8Ba9aLZWer4IejDTojbPybPPDiHzSj1iIrMfZy8aP1tKtiQwSNKEWldwvMi
         hXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577092; x=1753181892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWqpDCYp8Atv2d1/KNZjHwDFXadHoNNnwQPvfP+Gclk=;
        b=KT0h9cyC5uCZQorOzFC5C3/D/jlvOaa/4zQU6OY8mq7zZDrUQ0lpeJThuY258GdvA+
         EJW21O85C7bsZdIQWPYEArKrybWzo4qO0ThuNcxdpHRZSKQN/MArMN1GxuNyLOXGNX0h
         Ysl6Zsdh2tnWp//X9pbezWNbC9LIgr8/1K2SdQS8+WScvO6nJmqpVtlad1CPPZSa2dv1
         9MRTuei85HOlH4/5lXcIgGBoz1N7SMGmFi52DKUz7ez54u0paPY7/jWoi7YXkwUoUA9i
         zDv6futzTm5dhiZPQ54eU45J0CH1rZy2+cFLuSgMDGGAbEXkz9HxEh9umlRfAKuIURfv
         Z4YA==
X-Gm-Message-State: AOJu0Yy118iqapzlxgnGZGPnu6v8kySTFKVKPKUaIjuKDBuUnjFe7sgd
	/z4+rVeNxI774iZi7PAY+wN8KHhJppa6sEcBXYqOBXxYpBg8OWAz2csi2qnubg==
X-Gm-Gg: ASbGnctsxVxQ4t9EMaXiNBAxhG8JHRkpRJGeyPGQUydcebfhTKqvSoYToWUef3f8w+6
	H9R55vjflWBPX/ybPuEQ9F6cBv0UsonFio0PDRIKbcI1+bcfiIGp5QhS6DiayXo1ytaD8rWmlUc
	91s9OePoAHqWaBXkBY0w2MnUAs9HmVe7474ugxY6WZEwXiQ37u6PB9M3rS3ybTdqj85natfDaD/
	otcvkARCkULMvu1YLCZD7cv5ihBvZL1p2P9GDqW4R51u1Q0TcTLQlV/ESB2Op1xZX28EYDum0Az
	0W/Jy67inlr3tDxsez/KOloYWXVVW4eYPboUzTppFBq9mrhWy5lzwhWXLx5jbJlRamVaq9uK/+b
	FHTxcli50y5mF/A2vmNWpWhwgdGFhv5HEPQG0VjQ=
X-Google-Smtp-Source: AGHT+IFLhkI8VLEC2ygQ/wiR+fbIcJtpmhtZC2vw7ELCZEdKfKb7era2w3TDGCKRLHcjMgT5WrSGhw==
X-Received: by 2002:a05:620a:3704:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7ddea81b3ccmr2544958185a.25.1752577092545;
        Tue, 15 Jul 2025 03:58:12 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e32c2c4f38sm190309585a.58.2025.07.15.03.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:58:11 -0700 (PDT)
Message-ID: <68763443.050a0220.2e0313.7375@mx.google.com>
Date: Tue, 15 Jul 2025 03:58:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7618284794770899508=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez,v2] adapter: Fix RemoveDevice timeout when device already disconnected
In-Reply-To: <20250715-adapter-rm-device-v2-1-f0ab3cc19391@amlogic.com>
References: <20250715-adapter-rm-device-v2-1-f0ab3cc19391@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7618284794770899508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982440

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      2625.96 seconds
MakeCheck                     PASS      20.61 seconds
MakeDistcheck                 PASS      186.19 seconds
CheckValgrind                 PASS      238.98 seconds
CheckSmatch                   PASS      309.33 seconds
bluezmakeextell               PASS      128.85 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      930.39 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7618284794770899508==--
