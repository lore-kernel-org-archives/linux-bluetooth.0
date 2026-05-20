Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976C17D6
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277179; cv=none; b=kFrckv8pt/wMuDyF/lYoJUafobd+4/qq5THU8ExFdbLPN/9jmk9wWonGbgPd6gFLj/Rq4fnyacjPYeGcdoeZRYHChqjUsvnv05ZjXM6JQ7xLzJEUNDfQvJXG/4rWaTE9zSuy7iEHWPymJdnlZ8zFNI9/xxd5Qq6eCgTMQfoBCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277179; c=relaxed/simple;
	bh=8Ufa9SiqfFyB70vg2RMuGwzuJ/vLdIEF9YNTEaEliwo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a+nK71ZKV+0kCBkNnOd7egLquVEm40vHioj+4FhVMqwiiXdCGNqn22725BBWr6lKXuWIXLLSP8uWkGQc5sI0q0F6igI63i7oAQoe5nnv7i7NMPcZNkJnAJtPuV9QnR9bpCwmPkWUxm3kmKHTctUGmNH8ehWshy/SWzjUZSRWp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1TO6tHZ; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1TO6tHZ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132d1b2519eso11318916c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277177; x=1779881977; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ufa9SiqfFyB70vg2RMuGwzuJ/vLdIEF9YNTEaEliwo=;
        b=U1TO6tHZO1+wmvy+IRM1ZX5tKlstQNbL5r+DX/VMV5llJHUuKDJ9spsw7QqQQOFaG8
         P77z5JGiu+AAdsPCVg6Ees8f0AOLRf7FqJvrhESzH7gp2poh1NKOUTK24mnRERZKEt9v
         uRMpRZcoXU7y0eRlCaMO5GHJ39N3Zg3HLw5JbUN//evhk38yeV9nqgDTUhHSzS4D68aZ
         YrzjHfgqoAb8MKgRx/AaPu8De/Ws3EYd51o+OZ6GetudpCY1fU6ZAe3w/5LTp8LxMSEh
         AvpVIHEW20iFSrUfI+7WoU+HXTZlEFZlaLPmUemOAPDIovoiD19D/L1Rv4Nx6vXjv/Ag
         TM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277177; x=1779881977;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ufa9SiqfFyB70vg2RMuGwzuJ/vLdIEF9YNTEaEliwo=;
        b=j9c+av+R9IT5g/pCnBu5tblUrReKnbD28KsV/Dw9js1YkqZ4OUvulYUbMyfyqIViCt
         I7ywjfa1sdJK3XeJEuwZO6zPlRGVYWUb2KTjJj8EreJP7ES+3lu0vsPfQphmbrjZPMyn
         Ivh2W1ihN7tZrYF8NBgMtF/DgCvLbSbxrZaKBSluGmCDF5S0OkWuAHijpG105HZVHdiG
         ASYrKiy+FC48WlyiD3nE4hkL1svdY+5heVX0E3Zq235fNe6AEKBh5+MO02qBxi6wu1QS
         tLKMNESt5XmLGazyjsNMUquHPcVEHp6THAs7XoG5/p7cNEVgWP8Yr1OHHhetYfYoQ1p4
         rLfQ==
X-Gm-Message-State: AOJu0YwR7zwu5wrrRxJ/QpdAHwIY2g+3IFjOOfdysYk+C9iJMfW8DAof
	K0yHvhGpoRlLcXa/cnE2WzKskeuEOZTuITxyqK9+NhS91UJvtVUeJQaBiwhfRA==
X-Gm-Gg: Acq92OF5Pw+IsQnnbyDDoD3c4sf87qs6HS3y3oLgRIZ2KjqA+AqZupK5LZH7dwWBRCr
	mUAV2PjtTA105zU2tjmJflKTv/+qAYadbE1P/QIsoMVVH/daL6dsLv5KL54iToLZpMOySlWwj7T
	HH78hvmjKJ6LvhIo0Cg5q0LCleuTLTVxN8r+yuEllTJjuNaX9ok/sOCZ57MQnD7a1ryl5BNCpHC
	7P0NXmHMGeXmb/qUg+DZllJlqB9HiB9E5cFVjYwNHpJC8VF5eEZHAui6UxgEu5+kFTGx17Jo2Fe
	itu+GruzCYgc0t7QdW/gvQwFWnoHilm9uYx+5BD1ZKcPYhLnb9B3eSjqfvX4rzwMB0X5Wg+9eiN
	tMW6p4qmxfRbv4b5C1hgK2r5Pqoi2UU6FHqEjfAmhs1G1KFyXpva3F9QPs4DbnNsZ+UkOIyIoI3
	jY9KWu0CajxJjrKiwicc2ppD0qa71ucMsm
X-Received: by 2002:a05:7022:e16:b0:12d:de3f:d847 with SMTP id a92af1059eb24-13504952f8bmr10853426c88.42.1779277177180;
        Wed, 20 May 2026 04:39:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.136])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm25370831c88.2.2026.05.20.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:39:36 -0700 (PDT)
Message-ID: <6a0d9d78.8e75e0cb.1e3599.df5d@mx.google.com>
Date: Wed, 20 May 2026 04:39:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8009204729892366306=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Add Synaptics BCM4384 Bluetooth support
In-Reply-To: <20260520090131.3505676-2-kaihsin.chung@synaptics.com>
References: <20260520090131.3505676-2-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8009204729892366306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml:23
error: Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8009204729892366306==--
