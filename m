Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD821A08A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497295; cv=none; b=ZTHj9a48SGcpDlKZMOl3PbAknCnSUX4NsHgeFEsWObPrPhh2+a6mgZgsZaH8/su5eF9BfELtCQugxRil/bIjdAyAvIst7dphVKM9VXsf1/r7U932qJkIa4U5wTVpw5H6EKaC6dx5EQT7W/vDLzcHK2NkkIOfrFHeN2N++a3mteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497295; c=relaxed/simple;
	bh=j8cuuMrtDB4Kz3gw6dPRrjIkHKhc0OqsY7fM1tpgOSU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ifUevSuwLAklW651zIYKfpY92S5/3i08uSDyoGJyzHbAetPJ+fkgUMiYlaG7iIPsd+S0TcHqPuFzU3EhBMGHyWkv+3sJKw4D03oswXLfTnIvr0BTICxDHC1k4fodBcoOe9QmlBYHYNZ2clc6klISj2Ypo4D5KEDOsPvyAY7JKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oon8WZJ1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oon8WZJ1"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d68f702851so465941185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778497292; x=1779102092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j8cuuMrtDB4Kz3gw6dPRrjIkHKhc0OqsY7fM1tpgOSU=;
        b=oon8WZJ1UXmbgy6KfqhZ/ih1VnpKRwQbjdUlM5uy9yb4YkVqQ4HHe8ed7vIxxJjSie
         d7AAuZjnq2Gcsc0vaqs0E7puxzhA/zcN2fAm8P8Mp53m9yQkXTIePRsZI3yGERhJ5718
         QC5Yk1cZYn+FrajrNZzSygynftT+0DNMaIdlBvDog/NoJmY+XHIxAlYSfOnWo6jofMsO
         TBcCwViprRqyDBSsilImglpqGUn4ybjygPe0nJicgGUh+zCjwEFkfpLC0y5NFxS0ZUy6
         cDJsvxPchuRTG8wZ7Gh8SaG+oKqHZAu5ZklcFWAaNA7Kl9+Klk0yLD67cx48Ac1ndBZy
         mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497292; x=1779102092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cuuMrtDB4Kz3gw6dPRrjIkHKhc0OqsY7fM1tpgOSU=;
        b=QBL1nZU7SBs77bE8ZgT1k2B1U2ClbnGqZrHoP1CUhsaHDxirQgxpG6yDnaTV1w/DYY
         4pBLdF1UAIbpPyjT7fBBvlMnBgX99+fXVhZZA4sMU3dtsIUx3FyTk8U5AD1zemC0lZr+
         dCxSsGXQazRcodkbuifZP9WfeCeip+Yk10HpN9G3PrVjyLzmLSG3U20x9lNm15SaTPuu
         z55WiOpSH1mbBYlQG+mPFeJFOZHSHZRyUHwC518JVK4au21ZJhSmhsepYx1hoRYdAQ6c
         88rAKz8VDlXoV0oOGBGU+i5unq2pMRK7rF4f0Ft+iemPngGq5xaRgh/mhT4RAt+Wxu99
         MyQA==
X-Gm-Message-State: AOJu0Yyl49rtmjAWNOccxr9NdbhKShhGyoI9DbcIJ/7D1hXgsLpeTNru
	hejGm0HBtFh/YVdAUp9qDjpruAz3iNGs2eftFfyscIK6l3z79WXFC/bsp1ygJA==
X-Gm-Gg: Acq92OF/KBX7xf5LdC9NWsB8ymF2V6sR7wgq+BZctIb/ZnITewQbDqMo0tKkGGAOJBC
	jPFlEhqxRKgbAz6GgPiYO4TWFmsu2fdPbW6zd4lyXf69NS0jeqchnOqcVo1pWyDuP55DHzdhRFN
	urLkrX8N/1zFHODMOuhD+TvWIbjEdPvKyjtdo82TvZtUG0AIRCegBfszG7NhUIUxlgIHUW29PiI
	zeDIkHBRk+kFw3kQ+jMDCzIljs0gWeaZqaccnwHWqErZ6gu1nzoDsmTX3tWAeKzBnjtjDxrBt4J
	AtUNTPwWLqPjSlygP68jS9sBWyQ9LtbWqEBhSwglqGmL1xGYMk7ksU169y5/ovF/lWLpf+TMtgG
	sgg8z524myjnG07UKzTajUPr/5/GMCxD/1oeUhpzljO6etg1tTwXyAPhcYWI52Gt5jboNZ3lO7+
	g9FckoWTTjR2ZP2yB66qOWP4OucerUDw==
X-Received: by 2002:a05:620a:46a3:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-909102445cfmr1292101085a.28.1778497292353;
        Mon, 11 May 2026 04:01:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.23.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04de9sm3118760385a.44.2026.05.11.04.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:01:31 -0700 (PDT)
Message-ID: <6a01b70b.050a0220.366c6d.5746@mx.google.com>
Date: Mon, 11 May 2026 04:01:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1315178485933073250=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, leitao@debian.org
Subject: RE: net: convert remaining bluetooth socket families to getsockopt_iter
In-Reply-To: <20260511-getsock_three-v1-1-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-1-1461fa8786ab@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1315178485933073250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/testing/selftests/net/getsockopt_iter.c:297
error: tools/testing/selftests/net/getsockopt_iter.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1315178485933073250==--
