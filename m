Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6F364B9
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705835217; cv=none; b=O7eAWY78Bs2TUX54/S52bwI68Ne7DNWfl1ZSPf8ghAnBBBvZQKcqnVFOaSee+I/X/zSKVskp1ujNDJoxJUCyE75nNvNw7B/FR9DBji87DNrviUfmA11ZFgEXsPzUCnVJPhWkBfk7isFefL/7sMFHp4lYCJO1vwjJK4IuCPgOppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705835217; c=relaxed/simple;
	bh=2eWrmRooe7eVA6C1/sHzz48/XDAColU0IMD/BAlHCUo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z3LoeWlYJS4YqNSfMCTLz2mVHOtjI6kb0ENtAzvbpQrD9gGAmsflGXFPOPTGvoUjR3kJmW9wdK6M+7/oQU1i447XZo1PJoDCiAUuq3s9CTB2/LdjaY5K8xUXPluTc3+3qTDZUktN7DYpL5GdOwZ8j0/p7JE95kTn0CvrbKThsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKfwkyM2; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKfwkyM2"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2c21d77afso1865366241.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jan 2024 03:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705835214; x=1706440014; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DgzQ32TmjeFSa4bm8B2jXlzI0TRz9p4zFpFnl4aYW+w=;
        b=hKfwkyM2yw1Oc9e/oCqOSWw+V+16cDnW+ID01dF+ZUloAJNvypYY1h2yDxQdHoTPvG
         9NomIZvTGlAUYXF/Uk7dheOEV5VR8DvDZbv8yxdjf7DyPZ48si6s1Pj4Y/M6Gi4Nyw0d
         hr1PcZXfr4yWS24sjNr6kq2wy7OMXOlZXFvjhVfnhShFJM0cTWJON3N3nEXO2bOXPuOs
         YdBzKPBH56RVRttBiE71RIEGUi09TKWP5T2yXpociHcTpX8Qbf61Hmgn/CbFtUijPoL6
         3vbF3py1mqTIeLPuF56E4SbBL03U98ECnXryAtIGcgE08v7z+MoR/RsnelTvSy0oy+Pa
         iqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705835214; x=1706440014;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgzQ32TmjeFSa4bm8B2jXlzI0TRz9p4zFpFnl4aYW+w=;
        b=Mo8kwnLEtRZDQSWLNG+EmnxomHwlkcGF1Fip19oagZiYhxHbab80JQ1JT5OMmCLH/c
         wQqpjHUOtd/OSjxrmeJAFRsWOC/t/y5PW8U8fs6BRuOfrRdfD4PJXB+eJ6cw6Ej45nx9
         Cff/gZuDSvt3X3rbftPsjiU1pgdG3cJFwIakZ7jDAY+gY2zKb2WO70MG4vnX0eynOeZM
         3vV/YsReYPDaCEGGD9a29jk1OYH5EVV/KD6scP9ont48tS3MsNlR66aPkMvjQOuSlvDJ
         yGWrLz4CbLGjkXzURceDJXnx/oPPL/xpCvnjqo3XjR81wUF/vquFd6vLlNj5u8IZy6pD
         IS4Q==
X-Gm-Message-State: AOJu0YycWhegjgZS9M3x+YkaJ5wuIvBmS2Wyi3YSLnc2mNBw6Edp0s8N
	bn5hp378sNf6PoQ14npXKotqEs+6LM1lUDbEfei3mC7huxxczSPDNkZdweZO
X-Google-Smtp-Source: AGHT+IGXStyOoxltGcpSDwleceNZXdVOVhd/Qg//XBV7d/bw8eYLzUFeR9steHhozNoWAHeiiL0JbQ==
X-Received: by 2002:a1f:c6c4:0:b0:4b7:2248:e1a9 with SMTP id w187-20020a1fc6c4000000b004b72248e1a9mr1439605vkf.5.1705835214559;
        Sun, 21 Jan 2024 03:06:54 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.99])
        by smtp.gmail.com with ESMTPSA id s71-20020a1ff44a000000b004b73b2abff0sm1965478vkh.38.2024.01.21.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 03:06:54 -0800 (PST)
Message-ID: <65acface.1f0a0220.4155b.ac32@mx.google.com>
Date: Sun, 21 Jan 2024 03:06:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3139318758631853493=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mk@lab.zgora.pl
Subject: RE: [BlueZ] btmon-logger: Fix stack corruption
In-Reply-To: <20240121100328.1200839-1-mk@lab.zgora.pl>
References: <20240121100328.1200839-1-mk@lab.zgora.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3139318758631853493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818351

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      23.70 seconds
BluezMake                     PASS      693.93 seconds
MakeCheck                     PASS      12.21 seconds
MakeDistcheck                 PASS      157.89 seconds
CheckValgrind                 PASS      220.46 seconds
CheckSmatch                   PASS      324.72 seconds
bluezmakeextell               PASS      105.36 seconds
IncrementalBuild              PASS      649.47 seconds
ScanBuild                     PASS      937.56 seconds



---
Regards,
Linux Bluetooth


--===============3139318758631853493==--
