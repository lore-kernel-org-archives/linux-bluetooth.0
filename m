Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6F2E3EE
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433736; cv=none; b=cI0niTo4zSoUd5Bkh8lw5GA8nTtZgdQIQet6O8dYFIPZepRTFxGpYfpWWImmLyOuU+DgEpO3inERotFk33+01YT8gwJI74gJnUUe/DLCtuGUGx2kr/r90ij3qNWsn9i0rk1/ITbCU4A2/9I609iwF8qfmRLv7ZF4VZG8Aft5PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433736; c=relaxed/simple;
	bh=OEPkInZObaTttV+3zZfVBcugIrb77MKLpHorwmmEfXE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s1VoxVUjOPx90dVbaZ079LOmnr7WktQGgK6ibgPm6ncHg7idphVWAk7HGqcmdBRwLBl9Iq18bMhsv/y6wbT7PDd8tC0VMsxzk+iY2TwZlLeZUnWcnbZpw/SQptKLrTjRLBwS1hP5JRuq9z1hFlu3ckTnTz/PqY6xUBXBeogBiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHw22MPG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHw22MPG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b12572bd8so1352335b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720433734; x=1721038534; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OEPkInZObaTttV+3zZfVBcugIrb77MKLpHorwmmEfXE=;
        b=FHw22MPGZ9A1dGM8p6ENoAg+V+y5pMN8B9ihOlZSpEObj1WD7cvWolwxL/CyeHWJZC
         bGkirs48yBjALErULLZEDWEUR2brUM7JL51HQ7DcoBN7sfaUAnP2QIdUoUei8oE47SY9
         R+BixJLEIxxDorqS/CMVK116PnyDmwak61fCEMenILMzx0r0lJHnSplzugG30t6fjyER
         Qq3fxFDu8d2weGbYUkOtiGZxkvmm/wUwz40U14/0WXaSqo0jsqMuqCvYz/xPE9T3SJdC
         4TK6+5fbDeVduShMt1a/je8Zy/SxE5QpaBHu8PzvxtXlUetRT6tGFmVHVcOILA4hve2s
         oswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433734; x=1721038534;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEPkInZObaTttV+3zZfVBcugIrb77MKLpHorwmmEfXE=;
        b=xAQG95UwI2Iu7tQnOsLw7v8YumsXSGqvO32fEwwCgL+FHUIWOpzMWI7L+S4AtiYjdO
         VaFWs7pMd8WkFKMU4pCJ4+tKBSJZCj7eARQZsL1NZG/+8A/uYnT8q+hC0E1ogoLOprQo
         UIKk3eLqeTpPjvxH477/YoDT9tUP0Xdxa0VHe42K3qyjsoo1ZqlwHiAkM5ruyVbSsi4W
         FfEAKxzD2K4emagKTpl+UBl9HM6XQDiUZU+nzF9iwP8W20VfSrJjfBUnw96kZXibw1cX
         NWlokmLf3zkdsEtOinNJYJtuKxIFe0PJu+wWAfBWg2JqXTn9Vis9LRx21tz8mJvV/13/
         xYEg==
X-Gm-Message-State: AOJu0YzZOdZirAhJvp5V0Ks7Gg2Ckk/GV8otMf2i1mqPrK4Obh+qsTGv
	FJkJ8RYMnhy3o9fZ/8w5XssiDUpIl/OdxOXGbNeHJgnuZ8rdUoa6ZA23og==
X-Google-Smtp-Source: AGHT+IEixMHF5sxzCvfYNTPA0OkSBiKollxH/mV2Cx7fODHmTCiKWuLm6Yd9k7sDmNhGAO+KhNgcdA==
X-Received: by 2002:a05:6a00:4f8c:b0:70b:a97:de23 with SMTP id d2e1a72fcca58-70b0a97e129mr8024115b3a.25.1720433733752;
        Mon, 08 Jul 2024 03:15:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.29.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803fc8b84sm18685348b3a.103.2024.07.08.03.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:15:33 -0700 (PDT)
Message-ID: <668bbc45.050a0220.47bfd.ef76@mx.google.com>
Date: Mon, 08 Jul 2024 03:15:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8754137644621255065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: hci_qca: use the power sequencer for wcn7850
In-Reply-To: <20240708-hci_qca_refactor-v2-1-b6e83b3d1ca5@linaro.org>
References: <20240708-hci_qca_refactor-v2-1-b6e83b3d1ca5@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8754137644621255065==
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


--===============8754137644621255065==--
