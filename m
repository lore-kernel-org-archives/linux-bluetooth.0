Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AE1C05
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303510; cv=none; b=oaqbjKcoS6Ro7iyPtJn0TUoKMxDNzWblF6hhsZ7cENX54XixexTnuSJh06DCIUUV8rHaJB7T6AxS4/zcNKP7SYI2YvQ+90sRkANCw/brlcbpdOsuqPXbkjmoaX4qtd5zgQBiF+S2xRBQpM4x+niUabvNYNEzPNAAUGeJyOjmsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303510; c=relaxed/simple;
	bh=ap7Uk6vd1pnKDkARxCbZ2TM/Pbrqts/FVed5Osnn7C0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hFrIAj4+WU28GZHTSD1LbTQP6ctFyx57gZkwhWGlrgNxym47dkoS8TTHu5zMpWG/vkBR+AmSNNmBLfKNfe+7ZqeCP7KQbFL+YMGNN5TwHNAtk4wGgSHL69TLdgsaGsYDIzYbu+IEpYF7f7LghPO8LPKqXn2TDKP8/kNLRDf+MKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlw5WfcP; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlw5WfcP"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68fe8e20259so11154106d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709303508; x=1709908308; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7L8Zud0enqTNQldgkV+OQqkKoUch14A5UAgmKhCs5hY=;
        b=Rlw5WfcPcvAiILIdU5RJ+pgiPLzwWNteo226NUWoqJ5A+HiCGmITLjUfiY2j1wpfNp
         EoFmPl9bx4iHuOxtaPlcPmqofV+SYUaXQjf2eiq+vpTBf/4bzKema7LZjahOOpY5O1sY
         6oWNEusiTg4ETSi/GdZvjVelamq2ehCBRdUuDZdZ7yVVdNg5lD/94YAScU5yf64JbRls
         Qv/7ofpOiQp7x8EikADa8V0NCQST3ADaQa8+zRGYNrwi8ui8RktNpksq0hwO3xAjYPDg
         j3xKsocA/NaY4cySYglatvCtmZvUhKueXvCRTkmY5OSU9adartK1XWazuVHm5OGTTUgA
         +43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303508; x=1709908308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7L8Zud0enqTNQldgkV+OQqkKoUch14A5UAgmKhCs5hY=;
        b=c7dF5jf5Sn+o5jpiLL2rs/6nvIBNcrES7rqBcy6LWZsy8jhNgXLd3hZqFNsaQ/yNrE
         7yI/T5+Pr2qc/6ECcwwvph3CyUGdvuIZaQvnNdzXd73htpzKT+wsZQSVrOjnpMYn5bxF
         uJHlQmD0suF32KsejIypIt4ygltplwGlfzkd7wvBh0QU36oSvUCCla/OLbZjn1yKvFIu
         jn7YjjxfIUmtIJ1uCkVY891RdQI+bvSzL4Wo2B55Qgx60OKDap14Qq4xHwsNPL2WCr0T
         q9m3nOyZUqsHdJa6orp5iaLaXUULFyNgkf2pEOH1ArKc5E77xTvDvhy2izbcuQTpSDU5
         ohgQ==
X-Gm-Message-State: AOJu0YwhhLuAO4ICyU9vMvLdJ7NS4znNWKAzbjpEN2yya1/URtSwmoCV
	+gGki33Z2Osc3eT5SZixakfDKrNwttWXs4B25UpMvtGIvfraTnbmB0eDk80V
X-Google-Smtp-Source: AGHT+IG0bAYsrlLehagzW4UHOKxMdbKVPEuPF9McHijtsby8ElpVioCNQCYA8X61MkJp6/K3p2kjdw==
X-Received: by 2002:a0c:bf0f:0:b0:690:3099:6e21 with SMTP id m15-20020a0cbf0f000000b0069030996e21mr1706255qvi.4.1709303508141;
        Fri, 01 Mar 2024 06:31:48 -0800 (PST)
Received: from [172.17.0.2] ([23.100.70.210])
        by smtp.gmail.com with ESMTPSA id ow1-20020a0562143f8100b0068c8be959a0sm1909347qvb.111.2024.03.01.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:31:48 -0800 (PST)
Message-ID: <65e1e6d4.050a0220.8f323.8e24@mx.google.com>
Date: Fri, 01 Mar 2024 06:31:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3053726172324725826=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: Bluetooth: mgmt: remove useless NULL checks
In-Reply-To: <20240301133916.1268403-2-r.smirnov@omp.ru>
References: <20240301133916.1268403-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3053726172324725826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831524

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      27.82 seconds
CheckAllWarning               PASS      30.33 seconds
CheckSparse                   PASS      36.28 seconds
CheckSmatch                   PASS      97.76 seconds
BuildKernel32                 PASS      26.87 seconds
TestRunnerSetup               PASS      495.91 seconds
TestRunner_l2cap-tester       PASS      18.05 seconds
TestRunner_iso-tester         PASS      28.31 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      111.03 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      32.08 seconds



---
Regards,
Linux Bluetooth


--===============3053726172324725826==--
