Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443042144AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391703; cv=none; b=o+yeipDlBU2qtxCrd6/VDi9qc/f9iMKf7iFU7yGSMsfBC/K2F5s8xiarRoy5IqovMVS5sZ3M2yi0S0UMdeJJ6CYR851o+BoaY8f6p96BJyBB7M39IfflwtYKVdMjC5KLEioM+g8u7GfMH7YlLtJhGIS3nw8vvVqxrZNSMli6nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391703; c=relaxed/simple;
	bh=p9VcTzOmsjgRVlPMZCVdabeiDEBsK0rqjB0CzopemFk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HUdHMdEOve3Pt1g7C98P4bMbk21dto7zEemxt6YJdyYim15PibA0qeBv2FcL2++nzkhAn1n8uJZWS3NCaBODFBkqPjXc5tqbVinPK/8R3mZL2b9xbjw+VZwOIujTjUKRAkQC+MsTAwGKRbW5txBJ7fBqPvrEB2u1nkiTmsZOoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP/foZTe; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP/foZTe"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476b89782c3so23006411cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391700; x=1744996500; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p9VcTzOmsjgRVlPMZCVdabeiDEBsK0rqjB0CzopemFk=;
        b=nP/foZTeggz2d3WklsWGQZmT8y0BpqwxndqGTAN2L4uVsDMcjIRc1RGMi3kh1cYhM8
         2WJZiGib1Ky3pQfOU/kVhLZlQY3mHBDD/9oNuZ/Y79LI6mMWmyEzXaEilQLgR6wfNrr5
         7vzkukJDo85qX6ndsVWC0Xuphbr4UQhXR94Xjed/6znDu41sM/7MiEsGRcPaH/BTHd6x
         R1qhAexyr3XSb2BWOTXSJYhiuFRGd89VLOL/icJNbQ7G+E9OASWBOMQf2nJiF29qSC1J
         Mv9HdDv+HZ42NyzpGAgpTAiLETm1qoVUuB0n3iK0cOcAfJw4TlfwqcEr/18KIsYaLMN3
         9jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391700; x=1744996500;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9VcTzOmsjgRVlPMZCVdabeiDEBsK0rqjB0CzopemFk=;
        b=daICug/+41Bzq3sbLk9GGCWyHrSiWv3nqqbfTC/iYYZsuRFlLhKqpVkKHMp+k4ajOi
         tyVzuyolXK8CxOi3PD6EijvFWsZEvZyPu+0NzTHdQD08bvVeHF0nr2EW/8CCTeHrubEZ
         bxDKLnr3D7eDj0UioMSI/lgX2YWtF3ulR89jm6P3cDy1mWj3sY6c55pLWQljCX6iKHsj
         SLY4uGh9aTdiuZFwiqpgYskZIOwMpew+VC4HeEL8/5v+AnG13tz5+KrBcGKVzQctTU/o
         FhSdWSS217q/HP1egOmUOV39IRBIgALENkCOWz+nRcLFFrhB4MvtgTzjwD6IJJ3IgVwU
         +1Mw==
X-Gm-Message-State: AOJu0YxdETPOQg3qqWAmedLPBInLn4SFchGKSVTUDLi3FcfW0RRYdv9q
	+eexUKlUEzB27wqT+prMvUXDpNF9423Hk19HpJM59BICIposoSYJC+tPeQ==
X-Gm-Gg: ASbGncsEse4FHaEa98q5BfxpehDad0xuWxQYQa9b3w/KwGaYV/RhUyYJyN9BGXx4iMl
	F9feGv1HxXfzCHyTpdOHnXHoPcj0B9aRc/JcgxmvJ8RoKIXOqxIQP7rNK3cYcgXcEfVckDfXi4i
	zmgK/pIEp8HU+JdWIvAZT9gzUct+JZ5YgfPYIRCH8Ye0jEr0V18K1kF+PlBGPA8fzQx88hJe0EY
	b1n7xDbRrsaHhSFN3O+ODklZzPN6RMp89uStcE009onlVfpB16tf3tD6cJp55QeoaeRsykDAV66
	0lsvrkNXgEcJXHhma34o8IsOpZLTVWlbEefky1nMRJJjYjPSWVyOkuAwyPWn
X-Google-Smtp-Source: AGHT+IGjzxSeCr9+JMc6BV/yQ6nZbZC5ax4ta3VFf9NZ1bJQlmrBI3xHTEBWepLq0xJmAqCsyriInA==
X-Received: by 2002:ac8:5983:0:b0:476:980c:10a4 with SMTP id d75a77b69052e-4797756dddcmr48052591cf.23.1744391700529;
        Fri, 11 Apr 2025 10:15:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.175.205])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2c177sm29200351cf.45.2025.04.11.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:15:00 -0700 (PDT)
Message-ID: <67f94e14.050a0220.23c618.821f@mx.google.com>
Date: Fri, 11 Apr 2025 10:15:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4618852761074174693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [GIT,PULL] bluetooth 2025-04-10
In-Reply-To: <20250411165608.871089-1-luiz.dentz@gmail.com>
References: <20250411165608.871089-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4618852761074174693==
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


--===============4618852761074174693==--
