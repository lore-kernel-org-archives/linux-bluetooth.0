Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481372820AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514233; cv=none; b=iYb9JVcw4OeLOP51wEe56iLP9W38Em551Y3ViVIwj2oi6UT9Yy1ULt/HmJc0+PGnVhXpZb0aDKKtmqy+mMNTwBgmInIPNku1FjlDUub5SrL6loDXfZVT1jsefWLBgzjwJhyTYziawqOZyc4QbNvRXKzO2BdgRekWe+jDM6zKjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514233; c=relaxed/simple;
	bh=3KxY+kGG3/NliXysaoYMrHdw+O4LJpPAeYFHH2/vbOw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YTw40d+0j9BboD/obuZUxG6KQL/PwjthXDiZnzEUCXBpBsf/3JRQUs2g9ZvnpJ/oVel2HOhDEoEdfA31pkeDaJXDGbWVM8R1J4o9gRm+10c5dFYojYcKLYEevRO5Re09/hLscbu0shnwQ6WRR9UD3yJMxsPeG1v0b474/RPMYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxl7+mJq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxl7+mJq"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c9376c4bddso147869385a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514231; x=1746119031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=02q73LcqjTCMa5miOjVO2AkgntCtKttbKLaeYEozeHE=;
        b=Bxl7+mJqhovDWig/MJwH30R8LzPGIeEEq98zWq3vHe+yMXrP2wKaw51sEkMXd3v8Jl
         0P7jgiXiDeel96JcqFQ3GRfUCu87xhiACQuZL2xVIe1Ncgw1JgBc45dI0vik83RObtyD
         ++mnpQ3ZRPXQ5XV+1zkx9dSOyRS20qX7rMWUc2P8lBt+T9ZjhVHrxRTSKxMeHx2Rdt+n
         aOXfdnznVnAyKFFE6cchWsSVP2ZToRMBKbznVgibtZjLVzsNJfju7HJJziCz1ThgkQAT
         driLBkcIsCTzkrMqRY+22/9MVeTEGXYhVaYIjDspe9CcxB3iNeiTuI9RPGja94Zxp1lY
         F/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514231; x=1746119031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02q73LcqjTCMa5miOjVO2AkgntCtKttbKLaeYEozeHE=;
        b=Uvs3gtTLxiJqggBNmb3ZZ/rahdhFjzMnsDWLaHCi2YhhuB5SrZVGeiy/2n0/OfZ2v7
         GB2OlRIBz/KlVI2O5xMpj97A0XFASlzhg67ExtLFdbpDhy3dShHMVkRMXY7jzvpSwXkA
         SxP+AgL2jjt5gq2QGAGTQstWY/Ddwh4nqAkHTHx0nPmRUunDHqYqozug5zgbVmK6tQC9
         UHFZru9GXqSTRbiNWDKfIKrhPz0BWDTcMGLAO2mooo5tsiaWhNgLPoyM1FkepbsawPsm
         khPppO3h8yOeTO+WLDzQp1+EiKnVXrsPa77hai7N3QFahQi2qUgv5pxKexjmp8b/M/WS
         bF6w==
X-Gm-Message-State: AOJu0YxKf8F5HWq39hMlB1sPGERCrBtjq+g9FrqR/1t36ZDq08gvRtVE
	vhbix8jVlWzS0ftcr2NfyPio6vAs2ktqr27ph8CLBZ5b04nsVNJ1XAT7Nw==
X-Gm-Gg: ASbGnctc3e4ek2eyMLMriUwh8hGOo+xEXbriuFhc1lZR2Kz37XME9aOtDtN4RcqNhQG
	WZCaCyNNj2V7BldTetViNvmL4L7jEwwZI5HrgoCNwnIJwmEoxheXuyGjkTNTa6lw1e7fzoEL9Nd
	W6fCBuuOqNB0Ejd7CS7HFxA7omqF7Oxs5C7u5zRQDcCUi0Tv05wLZrwBc9Tj80mYfAPUO2ez24q
	DwjtLa6xhL/h5+Xf7qfHupOOkDAf80tpgzSmJQ6zYJsWFxKiP+oDOqcVptJuVtjqqINELIXmDWC
	9rtlDnYYKNDpi9N77DynIBBbDMY50ecEefDuQTbv17AAGQ==
X-Google-Smtp-Source: AGHT+IEHYdvqQ4Ghbg404Z4YSzJYuWvQKkhMolEgk5QQbtzyslimFaANNJ8AQT2fLbWqtFK52BydlQ==
X-Received: by 2002:a05:620a:1a13:b0:7c9:2612:32d6 with SMTP id af79cd13be357-7c95ef629fdmr23026885a.48.1745514230824;
        Thu, 24 Apr 2025 10:03:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cac826sm109313185a.29.2025.04.24.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:03:50 -0700 (PDT)
Message-ID: <680a6ef6.050a0220.3439f1.600e@mx.google.com>
Date: Thu, 24 Apr 2025 10:03:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5156096067175533122=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] tools: add BPF timestamping tests
In-Reply-To: <632807049a6b64e11103b95163ffa5de8f18a4ed.1743846534.git.pav@iki.fi>
References: <632807049a6b64e11103b95163ffa5de8f18a4ed.1743846534.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5156096067175533122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950146

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.69 seconds
BluezMake                     PASS      2758.36 seconds
MakeCheck                     PASS      20.41 seconds
MakeDistcheck                 PASS      200.48 seconds
CheckValgrind                 PASS      287.60 seconds
CheckSmatch                   WARNING   317.38 seconds
bluezmakeextell               PASS      131.62 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      949.34 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5156096067175533122==--
