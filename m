Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816413C681
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211820; cv=none; b=fGNs4ryOtz4dhjy5pMTOCP93xLU6YZ0qge7BawFDfOTih1INGdfCT9KMQj/hjk+KtpFdWpapCm44lNIWnekUe9wF20jc68Vq5qPLNYwPD2G8g/aqLvJy/jQX6qqraZPcgOXpZ3eCrwC1U1r0MCyF4qleCE7Jz81pID6Zp1yBYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211820; c=relaxed/simple;
	bh=93JpSzFP165FhuWoHR+VPAp1ORb4qwBhE/lZfODBgb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=icSMeaJPaysTxoFYJqgO9kg9TbyvQWV9AiJgUcMjFZ0vfmHsRYUgPXWECaXKAjB8VMwxNvqaH7Cn3eJBNdvAXJWzVaZ8uknCzdbfDToZqCEWVW+s67ox1qEDJw+YqjNlb8K4Knb2NxbALrFvuDpsqvPadQwvIYAI2N+ifw0DUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgZfuaka; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgZfuaka"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5db7936b3so10221086d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720211818; x=1720816618; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=93JpSzFP165FhuWoHR+VPAp1ORb4qwBhE/lZfODBgb8=;
        b=ZgZfuakaBgEhWyzAskdCr54lleM4lZOUSAX6DN5hM/wWAosFUYjRHgCB+JoVRYVcSm
         IFKxg9eq2ZMN+slTppxAqJstKGtR9pkMddPuOXX7oEuN1aKD8npFf+nyS6RIlQjqypVN
         QmmpmcnuyIqv5nPOyTBaSc2cfbOHw/JlJwUJ40ejabvnmo6Nc6WeyajxPuXPbVBTaTBS
         ExpDb+P2Dupe+rAln0nGEiAoLsEll9XomF6fikwioRjUylbiDP1YtNqd2dba9/oBeWfC
         3Um/jtSTM0noRm9e7FsNabZavYq7sjeC1qpfEbeZrTshxJaMlzlYPyNK71bY9YCOa36B
         /QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720211818; x=1720816618;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93JpSzFP165FhuWoHR+VPAp1ORb4qwBhE/lZfODBgb8=;
        b=iCxWi64Q2mhZel9kMFvQc6JqPo4mf2ghw2j47DVoZz4OGTENnNqSgip5N+THr1rfZP
         euFRDStu7vOhCyBMas6e2W0aBZehk94KYAifNEduyNZoOU/4la9bPGrUYPMYSacJq0SD
         wIAGnkcatW79auGQ3yctrB5g0r/pBuQGwpaMtM7S5COBtOudMHnu9qHrWf9N3Pco3YRu
         sqOAdJgB4atGlYoAVIv/Lfv89DaURY+ecfs/9HJkH/EdS75Os4Nq6hZp2vkx/brPQ3xx
         02Sq1/FAz6Pj/XXN0QPY3ppxd8bznup5wn19WWOMQzybltUP0ZTWWyJEivjz8LDhvp3V
         EAbQ==
X-Gm-Message-State: AOJu0YwmUcii64ZzaursK7szWK5g4Uo7VGgNogSJnGGUSmfbvHDNJTeF
	V08tuttsOXuYhSeWwlffpbJwVgvk3vkQdGvJeDRLuX/5rS/o/re12UGjjg==
X-Google-Smtp-Source: AGHT+IHKfwDzcmjEgACzFCzrkH0/qUa6P7Ta/hWhJMLTpShY+USywoYR2o5D/n9r+iESs/xC/9dpAw==
X-Received: by 2002:a05:6214:20c7:b0:6b5:a702:8c19 with SMTP id 6a1803df08f44-6b5ed02e854mr75492466d6.35.1720211817827;
        Fri, 05 Jul 2024 13:36:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.106.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f1612262sm13721966d6.38.2024.07.05.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:36:57 -0700 (PDT)
Message-ID: <66885969.050a0220.ead1e.5c56@mx.google.com>
Date: Fri, 05 Jul 2024 13:36:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8816922444953628871=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: hci_qca: use the power sequencer for wcn7850
In-Reply-To: <20240705-hci_qca_refactor-v1-1-e2442121c13e@linaro.org>
References: <20240705-hci_qca_refactor-v1-1-e2442121c13e@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8816922444953628871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sm8650-qrd.dts:208
error: arch/arm64/boot/dts/qcom/sm8650-qrd.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8816922444953628871==--
