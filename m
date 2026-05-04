Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9C3E1CF9
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912115; cv=none; b=MsesRqNbln6wja9npJl3C8nx319bLVDXOFlEeOxeivKxkR3m6HSIaRN9C1QwvjuFyNHM7AGe+UJur/y+cH0C5vo5aIdRiF8M+MIfpg8u5B2cvd7MKBiTp8VD102RRUqG6+ogSoEpBYXCU4dWt/HImFLGTNdVuzlKQumOh465noI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912115; c=relaxed/simple;
	bh=nx0GLva3OW/UFisBMeg/SwMi0VrTr7ctfsXRp8wfjtg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hNYXjXRKJt0aQIFvX1tXczLHm+vG6xHexPyvB/AXXDKBGl/zynKJF3xr2nQw5c2kFUOzEEWBkzYJzsKGtZRJaj0kfsF34WM8B5I7SwZ9w/ECz3sPDK7zqpcKY1UZg2BV9uTKVY4vEPKBc2lAZO1a9TV7SZos+BKQfUyun6o2U9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq5IsIX6; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq5IsIX6"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6967080e6beso1239734eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777912113; x=1778516913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nx0GLva3OW/UFisBMeg/SwMi0VrTr7ctfsXRp8wfjtg=;
        b=Nq5IsIX6DMqsBrQ0QP/N3OboU0j5RJH4QoZR2m5TjIgyr3yC9YjO9zueyE1T/W7jt3
         fCQ5CC+3J6f8RBquTnfcd5GW4EKgFOgNIHXTHNBqq0bCiJhSeXy/OONfZTwXKVqY8zjw
         6r+QFgaGFTBYw3m/Oip9PERdUghK7Dwc1v4DGKaCdIyWrnkeNTKfPVUTyBErYjebWaJw
         x8hhq4WNAASLs5ffzoRPm0VkWkap29K8zN85ZigsmDo7kgtoUXV5UTBrp7PRk1MGvCKw
         4wgeBbv9XOTbKI3IRdf1kaDUJwG1zEuW5sgl4++UIAkGGGkPKwf7QHP2INb/xoSGyPWT
         uCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912113; x=1778516913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx0GLva3OW/UFisBMeg/SwMi0VrTr7ctfsXRp8wfjtg=;
        b=RdFrBaiXUM0GqQK9dW7g1Mtv8j2paMRC1uijOfYAYqPDnG08qT9kRUks26KJ40ikRz
         DvpSLji2OooLifb58jHa3zgyHapA5zzLEAqv/2J9goiM8V7ZoUgSq5aWjPoStWhFlPWK
         zHXjKpDissHoVbIljMJpVqk5d0jFRVVLdQJ8svcwwfvZwor0fXHyV+gS51GLsS79l/H8
         cJ9cE7TcaGKqWFAWw14A64NXMdFlJWy4BXT+xbGgB3gWRS7gY84cLENmXY+cwDTEgsSm
         tocY3p0mWRV3hs2YPvooQpkn0bF7ocl3Ve/NqKv+sDH1L458qTSawl+mzK118pgqMCOC
         KyNw==
X-Gm-Message-State: AOJu0YyaNN17/05iLoKqPHs/zy3Py9BJiCleAHdxR6hF8PwVTdo3PFs1
	dA1ND35WCoFYFRb+ezlLqxTyaG+d7oQHItm+OKhDeMCuk+1Nm4aHRSnBE3kQZg==
X-Gm-Gg: AeBDiev4yOyE6ZHv6xyPxumiP69xgY/DzS3fPE5orx2MXtRfiHKbniCxQmZP9m1VosV
	J+7zYvCTAuENbK/nooqseTm+LEWoHvl2PPmz9vpB9tVoXxkH2ymCZYDe67tFL49mt7w6yRMV725
	QYf4nr2UtbScxf+7BydP4BkK/v06l+rjogNVzwKwVKBCW9KpxIuskWUQd4YwfmOqWVioPKkoLfV
	wiXF7KGKL9F5gXWP/C/ZEkH2gOl3MVdJnJp6iRmWbn2mGFQcTiODOIMYV9HzwDci9nDxQ7yLSna
	l0Ng+rRTBg44vSPSXFSROlqwZB6PuCjKfodzx4dLiKU1cegiiswV7oPLroT9SnwzS44XADClz6b
	qmSt06rUgA4IOrS4dU3SQ2ekScETr4npHOgq8qoSFnPE9EXRCB6yyyhWmt/5PWUDknw5+DExHHI
	HOf4oflRizn14ncwOp73v4eEml5ofSMp2fhQzshJlaxQ==
X-Received: by 2002:a05:6820:824:b0:67e:1be2:59e1 with SMTP id 006d021491bc7-696979f32ecmr5008973eaf.18.1777912112673;
        Mon, 04 May 2026 09:28:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.163.18])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548c1151sm10812263fac.2.2026.05.04.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:28:32 -0700 (PDT)
Message-ID: <69f8c930.050a0220.1ee6cd.de90@mx.google.com>
Date: Mon, 04 May 2026 09:28:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5743137042931104611=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, admin@fluentlogic.org
Subject: RE: [BlueZ] sdp: fix overflow in sdp_extract_seqtype()
In-Reply-To: <0100019df38f8843-ca2935fc-b645-44cf-8018-c7e55f953065-000000@email.amazonses.com>
References: <0100019df38f8843-ca2935fc-b645-44cf-8018-c7e55f953065-000000@email.amazonses.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5743137042931104611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5743137042931104611==--
