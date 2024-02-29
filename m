Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4704AEF8
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224265; cv=none; b=j/EYY6xq9uJ0pE7rrID26Ji2Yp5rH1qiQnoLDxeeqfcGdWSGJHUGIyzCpLsAH2/o3kC/cFrozFqJaOsnThWmlVdAEmUGVrYCi2nZIWI/VvuqfE/83rrXGoxRHelavgLf1mk26VfiNg4FjvlO8rlXjnQIJa+yZgHX+lLfQhOyrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224265; c=relaxed/simple;
	bh=MaFu1Fg0ObL6gWlE4kFys/9SUipteVOwHBiKMsA4sjo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H5cbccN6eIstJNEfbEsw7V7gIkKzbMnx2Qc6vJA2+l8Sg+NYj0oCcPYocLlKv6K5dkSbeRt1HWnq7aAIxk+bwG6MBrhUSjYe/x6KTJiSyL8m6lDALaPK33lK+lk12yaVgfWP9oiLrg2KX8apGVTu+bbKtjziN51M7qQ3x0fnbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgwUiYTZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgwUiYTZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so791421b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709224261; x=1709829061; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBOGhlEngIAmW7Dz4nebCD5z9cZVZe2pIRB/WyU6cno=;
        b=HgwUiYTZ+6DAw2Y5mVJmPoNaLz4KZtLqROEalghN1anIxwVTEG9egxWOQzGtZqyTzX
         3rWb8xUaliHTRtGdvU56sX5C7xwlgNFFRfsegAnwpFn8a/pdlNX7xMiV3QrStMA798uF
         qrtqcKuULweadcoHX5WaaOmWQmciqauMq0EvDyFwVPhUzYpJ7JAxZrhDlTSAYweNNgSV
         OArg9KNUXW7heGlaNJCczAGw7bt9UPjIv0LmiUlywLyTG6HzLhiz3DODDpx/lMmXBFuJ
         JynpfiK4IpTGNUstx9RgU/J0Rnl0aRmdj5H72mEi0e4fYvIkwUUn/w2+rDiW4igDi6oZ
         pLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709224261; x=1709829061;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBOGhlEngIAmW7Dz4nebCD5z9cZVZe2pIRB/WyU6cno=;
        b=wRTFeG3phufKn9xWGiDoMsAJxWGoWUO5hhi0gktWUn99WFoUtM45kt7L6NCG/ktLr2
         7X9vNDlMwnD2MUlQkFOICKkLzmFBEE3twEbbS+UX+rkg9qDcVrgtDNTECuf/5PZP/sV+
         PtyTlu9fD2Sa85DVkwKVGxYVtvhibVpQfOmyPXZjy2oQ6Z9xJt/f4f4rt9cRjYOjqk5W
         JDo6dFLf51UAMN4jyzy/Cs6FXl2Xy+8P4+GI7inqCUGNu7XO1kdBEeRuiEWoGrp+3Nmw
         ryA4oTszp9am8pWaz2TrtJ0adYM5i0Q4nSRAfgqStjfxGOInrUAdwyglYz8GAOB6uHux
         HnBQ==
X-Gm-Message-State: AOJu0YzYXORjo5QhQcnfh7wXO7EwuQ44OHm0WP/zpSa/KwrPcEDkbgdP
	nKBMd29x9Zwz5FKg+AtKSBkzAxQ/B+VjL/QSv6W5+Az+cu09N06rvUuUzkmD
X-Google-Smtp-Source: AGHT+IFxC0b0wJ//nrKuA3Hrz5KnrrasbsmFr44rxJplNBw+dbi6cU+fRdhAROpCCfXNpBzIDZMZzQ==
X-Received: by 2002:a05:6358:93a7:b0:17b:57a6:888e with SMTP id h39-20020a05635893a700b0017b57a6888emr2997918rwb.2.1709224261491;
        Thu, 29 Feb 2024 08:31:01 -0800 (PST)
Received: from [172.17.0.2] ([20.55.222.111])
        by smtp.gmail.com with ESMTPSA id mu4-20020a056214328400b0068fd10638c0sm883819qvb.20.2024.02.29.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:31:01 -0800 (PST)
Message-ID: <65e0b145.050a0220.a8acd.4292@mx.google.com>
Date: Thu, 29 Feb 2024 08:31:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9164300088644873148=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Remove bt_bap_stream_bcast_new
In-Reply-To: <20240229151755.2589489-1-luiz.dentz@gmail.com>
References: <20240229151755.2589489-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9164300088644873148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831152

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      23.78 seconds
BluezMake                     PASS      724.51 seconds
MakeCheck                     PASS      12.30 seconds
MakeDistcheck                 PASS      162.73 seconds
CheckValgrind                 PASS      228.64 seconds
CheckSmatch                   PASS      330.72 seconds
bluezmakeextell               PASS      107.48 seconds
IncrementalBuild              PASS      677.84 seconds
ScanBuild                     PASS      942.33 seconds



---
Regards,
Linux Bluetooth


--===============9164300088644873148==--
