Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906963DA7E6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021639; cv=none; b=NS02BjJNkRdBKMEaAKE8ZyW+zthNEWMUM8Bfrxus4I4NUb1lh5mUjGvDw/N/aID7dyptwHfNUoRVdUgcGMg70sjrkaZgDAXn4LlKLqm3/BdU6A0umdLspEmW9zwaziosEnu4Q/piO4CLRuFWCotWy4xxRKDVdAY6EEXXPtGYoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021639; c=relaxed/simple;
	bh=U5k5cUZb2o7ykWg0EEjNwh2TQj+iH6OiR7kO9+IK9+s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mxzwaT8W0P5nxu39ME+hr3jC7AAQ9ZkCdx3kLdiVDEIIdozVwOynZONjbFOLgbpcgskuRfJ2HgU59Lx2UcLFXek5IEPOo4lQ/OiL1wYaCm4jWEyY6NGPImPukX5IdMjPa29aIdUdabQ0TtNEw3Dlo8ULBr33MB5IwUztX2O+nr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/vsuKM1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/vsuKM1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0cea8883so6543211cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784021637; x=1784626437; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U5k5cUZb2o7ykWg0EEjNwh2TQj+iH6OiR7kO9+IK9+s=;
        b=R/vsuKM1otVLi2LDo/Q5F1JPWqCeQg8porNFMmds+dA9yQ/TYV9cy41YzixwC9ybXt
         fDESMr5i/lCso74CiZ2AdhXKlsSxwjAR72vrkkGyM8WvQwVWVhqYo1GMufGeD9LyJ9R3
         HD1R3w1G93Mn/8bZc/VHJXx+2ydgnYfhdwTZUFcq9PefGLYZMZHcRIOCUVeSLFLq/U7s
         qCofdZIrpe5yXKPKNBjrjKtyiL0GtUT6WmV9BB6C8TJQtHFI3X6hupFEr19We5/N8lzY
         1KKZkjFtOmxyTllu6gWo9GnH8GX29QmgMXWkc8LqG4RLf/J4mwQLYFbNJekbhFYYzNT/
         i4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021637; x=1784626437;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U5k5cUZb2o7ykWg0EEjNwh2TQj+iH6OiR7kO9+IK9+s=;
        b=A6wmbH0PmzTwLPUtjzKeVP7LW3DUYDtQjwc1g2T3buPTEmXKbLv/Tma8fG+8NlV0Hy
         4kg2dvVAZi8TC94rwYe19i+J52Z/UYZRQkGnF7/8Psv1102yOrnW1V5sEIZUVpIDjAO1
         jNwkLdATbtuuUAzo8LEGpeTjy/XJ6iattbifHbGRmbZ20uavv1KNWw1vyTfNNxxeJoAX
         68AXyJtnBYfQjIWbsga3ZXq2tx7vJgB/tcDRrvYHoUMlpiZwxO96+8iDJO8B3dj3PEl3
         edy3bii+uNPcpWmWnez9mGLQZFgT9OWP2KqBPJFZIwtpO4FWx8KcKKM3k8h+1S6CJoJB
         0xMA==
X-Gm-Message-State: AOJu0YyoDyW9/d8tHdlbQlFiioGD3wTQfTWoRu6/UrDW920fKMLrPFqg
	D6ToYxaLVWWuDJdejQ4Un9FwqkrA0wqGD4asfK3loqHnd9BcFmkIT6yiaOT1TQ==
X-Gm-Gg: AfdE7cmYMQbH+NkY5iVVK5XfQE0b6QAuDl2JR6+RiypbvMIBIUzM/xBnPQ1fAlF2qm+
	/cnOK7NytUI5cSnbcUP5Qyq7Tk6PSfkXRG2DS+mZh0cYY1PVPGMCYPsg+bTaxULFhhYoIaYwOFw
	7DFRSX7pO/98Cml0WbMsZFKVPLdMh6kPlGgkLcaDMKIoDGRdyAiy0bIBO3Pm5Pvv2Idl5HsgdQO
	HFjC1bK6+zSy282eMIb4Y3LaBuiXCO02gwdVBo78Pw1HXGvgXLa2+CMhTuSEPwe98AqDF9JKXGU
	D98Z9gxHCmZw4kJUODRU0ciNQk9AvsY8B4RiqyvNV0xpXUIV3rw8LY9ILFUH47um2CKN40GlKpk
	W/PU/6Mt8xFRwKiaYu/wpRm/Nz5SjOEWQHjgjoJPKk1AwkVPrWUd9GzK+Z30MTlbpnJ4eRbLZ6m
	xzOLLd743BQtZf/8v8gw==
X-Received: by 2002:ac8:5a48:0:b0:51b:fdc0:ddee with SMTP id d75a77b69052e-51caa160372mr171542941cf.30.1784021637400;
        Tue, 14 Jul 2026 02:33:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.23.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cba49439dsm92906341cf.27.2026.07.14.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:33:56 -0700 (PDT)
Message-ID: <6a560284.3e3849ba.1f46c6.61f4@mx.google.com>
Date: Tue, 14 Jul 2026 02:33:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4548462230384552767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
In-Reply-To: <tencent_9EDB39EF4A8A9D6EF645A7DC2F32B25CA209@qq.com>
References: <tencent_9EDB39EF4A8A9D6EF645A7DC2F32B25CA209@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4548462230384552767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2918
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4548462230384552767==--
