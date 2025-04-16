Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538123959E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803348; cv=none; b=gdfLZScwhdzlTYl20iCQbUZx5blPTaQNj5YfrEOIUBCf0a7OJibn6AWtlRiKpBrNoLH5rtGlkiJtLsgmlst+Q01spi+WrP/suMGecCrWQZOFlpZiLHsaQMNe8SUkEt5JjkeHnJDbfEgjfH58ECwahf2eO2+yfpRfRJKavnLVNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803348; c=relaxed/simple;
	bh=sO05Dkvwy6HHXLqgts0XJ7xs7l6+ietJiBuJ1fHB4Cs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VC/jUtltjh8BA+trKG29iwPzx3W5feJ0KRoyQaaQSGUrwtVKLBXPBtrUPeYQir/wg1kBpEn3n3YbYAt+8cvBrMa56lyLri3yFjtWQJS/aw7x2HsHPzHtw7SHccnafRM7DXOloCN6nuIoexNuLXwdxMmoud5mKZquobJOM+LqcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5nVXGF8; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5nVXGF8"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b7a53ceb6so377060a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744803344; x=1745408144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sQwz75Wi8p4d3woNycsz624pynnJtobRBnQwx6E8tQ=;
        b=d5nVXGF8ulz73sjQMmCBr4OfS4AlnWa+PxLVOl6m7wxypUc54Z7OtImoFtsHvaN5b0
         2WUDT20EcJMYqnzDUDvb+U7I53o45GHau37SH14lxf5qkqizH0zgDecXzNMEmQbjKsn9
         kWx+uBgreHwHVxox2MwErMPDatZp/gpY8k99IVkHgcruqZuZicq+3gEPDtLbcBf808t3
         /Vntk5NdmpPhJofj472/nSW7J34FeGFlnOfVymX8ZuWXtoN6YWnE/d/kO1TWGGW+lz6G
         06jIigs5i8S4C/AMjMEJ8LoGeIce6gZlAU6igLLUTDf1YYCA/AoeGND9hkW8MavGyNgx
         +3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744803344; x=1745408144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sQwz75Wi8p4d3woNycsz624pynnJtobRBnQwx6E8tQ=;
        b=IY/HAVtRpQyzdg9/VEhyUEvyLYx90Tdc21896TKOeZtIBYdd+kvETLv0yP9qiQYEic
         Ozhf2sUVzVxgMGiVzYvReg207jwbweexhL4bSfgZ9qtKfwCTyzSDHw0vDYmdrrO1b6t3
         ixMhrI+XF7yp3YXqyf98Cpv+1IMgHXQS+smyTjjSzG0UNH/QHylc0hBB53cDtH5Z6fKm
         D6p7DMpfAvJuduG1XAlDcvs6um+DIbNiafZSyUkf0o95FJlRX8XVtGRB0lrl+ynHsJGO
         wa4YkMtRAHlO9dnWQW6b/0JAp7z0xqtp3sM4xYGgStIXjaAMVhVULCirRZIwBsrle8+R
         HJTw==
X-Gm-Message-State: AOJu0Ywqp+Cb//P2mIh2Pb1+6DTcuvLBj91tviarVhZgGh3xTE3t7ZTw
	pEmNARAlGpikFpMSbdARLXtu2LlNHSNXY0qOlJKh34K0wv0CITjOBup7OA==
X-Gm-Gg: ASbGncuZwlwJBo9KwRzHbih2vRKwpJ7UJITdYtRSu1itTdiAvPIA2QdcpOzHLpnd6HP
	8U/6j8byTnRZRvyn9lztbMg1h0kV9CT7mDf0J48FV9YF/yhMGZGgHExaSDVtgBtIF5O3sj85dQ1
	X36lAtvyP4WBwDkI56WTNvOE/sGuAZRpKdF77dwdedrcGR37wA+VPJHe5AKDLV0e1xPDoM5iW4/
	xIQe8xndYnBLaeQaFG5PZENo4Xjjyef7iw62GYmtQYqgh0oDSze1xE9Byxj516nJanSu1+JK73L
	P7uRvDcs31SWOZFeHnzTQufu1rdkumMS6kFyFT2ak36yxMg=
X-Google-Smtp-Source: AGHT+IEs0o4dej66cTIrAOwOzgJkHtZYTTh2xpx23eE9qHxbE2Aefth8ryjAWecOQH3uaU3OhSDjpQ==
X-Received: by 2002:a05:6830:6513:b0:727:3587:fd1 with SMTP id 46e09a7af769-72ec65679a0mr724900a34.3.1744803343843;
        Wed, 16 Apr 2025 04:35:43 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.188.160])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d52c8bsm2786332a34.11.2025.04.16.04.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:35:43 -0700 (PDT)
Message-ID: <67ff960f.9d0a0220.26c685.6db8@mx.google.com>
Date: Wed, 16 Apr 2025 04:35:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6664810628862078347=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bass: remove the device of BIS source when modify operation.
In-Reply-To: <20250416-bass_modify-v1-1-6f4a85c2c7e4@amlogic.com>
References: <20250416-bass_modify-v1-1-6f4a85c2c7e4@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6664810628862078347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953925

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      2619.23 seconds
MakeCheck                     PASS      20.29 seconds
MakeDistcheck                 PASS      199.27 seconds
CheckValgrind                 PASS      276.10 seconds
CheckSmatch                   PASS      326.07 seconds
bluezmakeextell               PASS      130.09 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      906.75 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6664810628862078347==--
