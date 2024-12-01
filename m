Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56071D5CE8
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Dec 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733080479; cv=none; b=e6b7EHI85eEStVvXLnBxmXyNAH0L/u+/LHv/qePSY1u56i4GJDyIzH7hyunuCLb5KQwBmf6x6h4lldtfDjEanv0CcNHEyUPcB1gJI5ok4dSWfN0GxC60k0xRpKohT3zVbYzBcre4i5f2OKeGbyN9Tkru33e6YbC9vpe0Hrz5LWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733080479; c=relaxed/simple;
	bh=1N78DNIl+ed1XDP/lYCCDhCyTyOMKf4yX6b0KquIuOA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=duBorKDy40ygdmyDVKey2ds9cR1tYAGLo08VVqCXQRH3wK6hJQ8cUxrviwNWe0afk+VosSlY8fMea6QymeSKrEAVrr8TguFSsptIab6jCta+98/aeixPvAJumvlIOZIRq51CVVM+vMOb9SHccY8akDrFwij6X94VQdKzdk0eQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys2S5AfA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys2S5AfA"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so633647766b.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Dec 2024 11:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733080476; x=1733685276; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0cBgN0DXc0e/15sj0e0kTs7/C+rgSCSYUT4C/Y1b9U=;
        b=Ys2S5AfAJc8/8uG9eRsDa/++CeKSNdSev1yGdsdEqEy2X6NINj0MQK2I3ZAfiqfOC9
         +n8sdyPdRSVjuEseRVnwlHZX8MUemIXDoro7AFC8/t+vSMKM8OBufC2KigEjH5Ad0kUc
         sRbbXw6iy50qQ/nwat5bLEgtaxYJ0yKq0etLG6iJ+UQaiUzVLWPF0j42DABP9r7kpFb1
         0gcEH9VFG3SkGerApmvxFLyHCRkzF0alToj57DIpi5QmpMT2cFzg4etxvWlWAmwbBOCF
         /AdbdiHAyNvuyoOZmS61ZnMoxkgBdQEERxX//tHl7mv4DHs0nvEBdvDY0P7IuN+8fyry
         kNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733080476; x=1733685276;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q0cBgN0DXc0e/15sj0e0kTs7/C+rgSCSYUT4C/Y1b9U=;
        b=D6Enzrs6U2fV849PzIOleyHNEBgSu6mOviMCuM18rmTXNM4ElZeEl2inXXcvEmXVvw
         kp7Po4kHiDxRKkDwfm4grxB/UDygBmjL94hNwyGAC/k1NlArlUQlB2n8iQAohP0E3JnI
         HaJdfeDjxXwR2QRjVB0mp9ufujkUymLgcjPJjRYve/GV4hFH08DisZLz1VeuL/09c+1q
         PuajC7FfLFKYfOTUCah7+iuWfSG06p7qaWks1EwCvYxP4vHZ7vGWAMwSKNx3Z+6zKm8L
         j6yV898iVwYpKcg4QYzDH/VaqmKQrM5y1xFtTiJdoxvlmvJUOAq5qCBUr8d3B2vbq7Fc
         cmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf/qC2Usv3NsictEOp34lssan0a0sgGKz7SmN2sVvZHUSJlRO9sNIIFFYxtwu8/cXloyqxy3cIROedj5WbeYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGkFCbNyKZVZ8vdeiZ5FBPlO5ESAbaHIQ9nNPfRVbyPkncOPa
	f3L4Wk9d0J1KVU7OCiOwZKrals3seF62k1jV4Rfmspoq/inJzyFC
X-Gm-Gg: ASbGncvgyzGnkt6wn0lBDY1fdtdTJpY/+aCZJ8zXzlqYX4zwxmBqIXfMyXtzoxpByW2
	jvWveDy3OfXrW3mEPGxlC4zijyysPTPH00aU07XSgMkASz089jamW0igCZC/1sYW91K/pFTwmLi
	a+ADQmA3rOtQgxtBXAkMAbVLtMtsfnzOhlXpkWRgKbuBXrEGirl2raxECSC/74MQYdUiyl8uqCM
	Z/vEMG0BdeXD8rhGK7BfVB27YHtfa56ycYQdeSn57l693bFJid18UrzuZTDyhScB7c9cPEAqdgG
	udkV1K2REdZWGGELRr+qzqGfGicXpTDZ
X-Google-Smtp-Source: AGHT+IEbMH6bMLy/g7Dm2xw13TYYMh/jY8UDMMiPwK5FFCOEneUVCpf0MzU+CyGIYBN52X5AJpQ3pA==
X-Received: by 2002:a17:906:23e1:b0:a9e:b5d0:4714 with SMTP id a640c23a62f3a-aa5945fb940mr1627560466b.21.1733080475702;
        Sun, 01 Dec 2024 11:14:35 -0800 (PST)
Received: from [192.168.10.116] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a8f0sm423109066b.160.2024.12.01.11.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 11:14:34 -0800 (PST)
Message-ID: <d64d354a-4787-4836-a45a-0e7f5b3e6c64@gmail.com>
Date: Sun, 1 Dec 2024 20:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergio Callegari <sergio.callegari@gmail.com>
To: nicholas@rothemail.net
Cc: hao.qin@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, marc.payne@mdpsys.co.uk,
 Linux Regressions <regressions@lists.linux.dev>, sean.wang@mediatek.com
Content-Language: it
Subject: Re: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And
 Hibernate
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> On 20.10.24 20:04, Nicholas Roth wrote:
>> > #regzbot introduced: v6.10..v6.11
>> >
>> > My Framework 16 laptop (Ryzen™ 7 7840HS + AMD Radeon™ RX 7700S)
>> > recently started hanging when I open the lid after resuming from
>> > hibernation on the very-lightly-patched 6.11.4 kernel that Arch ships
>> > as `linux`.

I am seeing a similar problem with a Zephyrus ROG G14 (2022) that has a 
not quite unsimilar hardware to the Framework 16 laptop from the 
original reporter (AMD graphics - internal and dGPU, MT7921 wireless).

I am observing the issue with the Manjaro kernel that is also quite 
similar to the arch one from the reporter.

The last kernel that is fine is 6.10.x (tested with 6.10.13). Both 6.11 
and 6.12 hang on resuming from hibernation (tested lightly patched 
6.11.10 and 6.12.1)

Blocking bluetooth (rfkill block bluetooth) before hibernation seems to 
work around the issue.

Interestingly, in my case the updated mediatek firmware (241106...) does 
not appear to be enough to solve the issue on kernels 6.11 and 6.12.

Sergio

