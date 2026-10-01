Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E652F29A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869495; cv=none; b=f/QJAwfqB2JVIlPVxcWIeQXnYYoxsJhn34asg2vmmQCxmbFUeYri7odRjKemd0VOy02UAcwWuwMxI8RWsOwd3Az7l9Anafho277sLyuu8NhJnV06ykK+4AzjYQU6Fevtmnmy3i5pV2rW79Dx8gJZSusyYtkPrHl++aSPV3YnAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869495; c=relaxed/simple;
	bh=4LM+Xitlaocluffl3siKIiBc2gnkJtbuZj/LUgO0UoQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V/IcTsegnpDQReweHHUKj9cURNSTNKVaizgg2SkDk8RNREcz8cPhKCqwi54mLGAliN1xYDvVi31/Jnh5ahBvzy00+FOYzjTnQvZP/HGmHK5ZIU1MukqA6sIyvBb5SuEWip5KbEf/WztWTCxHgz9lWQiIN2qoibyWax49vG30j1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npssDm4p; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npssDm4p"
Received: by mail-oo2-f35.google.com with SMTP id 46e09a7af769-8212a719d15so682931a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869492; x=1791474292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n/GRPuqTwt2FQ/47+8uqfrRwRd/6afp3+OwLszo3r90=;
        b=npssDm4pNxrca4FObUsNT6gb/jr7qK9Wd7Ww5Pq6jjC1BpFutZCO40S8AdOC+4Rp4q
         ybze1Qc/WkRY1GV/l5LAHRTnr43rrlD8LiPG0ccUQVcVwu4dHw+iumkHPBgBTo3aT1wX
         K05I8pg8vDNtpOrInjNP1Mv4M9VMf5u1evU3ADUsWnniGcMWK2NoqxT9+Q/qmdDCUABj
         faS+0esRKcHWb2oI5qhEIxjbmumSMkbioCGoQMFqw3JYhCvuAWikyCRbgnkvQK0bVjtb
         k7m2iSX/vLmLoeSYv/DMAtBhZa2GDIGwvWjTzCGWhuXjFQ81dq+BNsBdRLYQWVVUCdFD
         B+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869492; x=1791474292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n/GRPuqTwt2FQ/47+8uqfrRwRd/6afp3+OwLszo3r90=;
        b=i85+0yBcTv4p7G5vwDDw1btrDNKJM5xEUq7ByFShxmjSwhxy0Td1M78mKVwR3Zb5ST
         w7X1GFLEZTwjHEIUZoPAzmDKFl0NkZvXezAfcBRO8rEtf2mwzFSEUK1wgVBDlz1g7QQG
         O+jjno/tQvUFCAGq2g/GJAOp5A+exJzo9FndRT+0+xGce9mueF8h8cs6PKPwgW6JZSUl
         ORZzOlVJsyqytTkQLjvle46CVGzi/R9nCwpQifFO5od0G7ADXm0yXBi7NFk7cHRQpYO1
         s//6j+PB/w6R9DHHyyUcWviswh7lJ3ZfaX6XfYk7bz5UVMfJvtM4//wzsTU1Z8pNcZiY
         F2lg==
X-Gm-Message-State: AFuF++lwXbRSCxesq3vtJyyqsDM89TfH0wC7M2kix3EM9CovUFXJAh6x
	TX7hkt3w22fEAW53LfcjKPpLIh6ipXOSGsNWKIO8F6Y6ZOszoBQsCeYBSewvEg==
X-Gm-Gg: AYBFou1c8TWmw8oD5IMjLb9LG/HmxDNvWFzqngQHvy5uf4thdPsRnoWzMfZz9Z22Vxv
	CKgJJFnZ7lC8ClUuukB6J5ICPKiwPU88VPOIeaPjn61YjbJsU2yL6I5ppT5JQNst+VfzY/ftWH0
	cL7CIDh8fT2Q15CGAoGJVMd4N9wSQoHuWLqPzMVOK/uQL7lVaCfDF9V5IeoHmBaz0ypn21XqKWs
	CvC5Wfx+bf/EvoJkkiG1pGfanTk5oSKOSCDAvmFJAR3dL5VscQInA9gqfPqLJhzbUja2gmxUTxI
	IEI8dD+exvghkd1+FWM1FFNfME/VlzX3jzyv+zlcf4H02PZaGaHRe3zJBf7/VtLE5+W2eBzoMrb
	CxHChbIKxcbSOaARnuIgu/n0QR19eY9EqF60TrMyH0uE+EZ7Yr8/rSKXHsYa5y7aGb/+ShBIiIL
	rNb/lzRF4C2i/nuH1hFOJ85yJFl8GfcCp21qGU3Dchh8s4s6Aw5mbNy3/8U5ROzdb5OObDJWTQI
	6ADfv8=
X-Received: by 2002:a05:6830:6214:b0:81f:81d:395 with SMTP id 46e09a7af769-8204eda206dmr5746917a34.30.1790869491879;
        Thu, 01 Oct 2026 08:44:51 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.153.102])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227aa6cdf1sm98565a34.26.2026.10.01.08.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:44:51 -0700 (PDT)
Message-ID: <6abe7ff3.6b931ad5.1d0027.5f4e@mx.google.com>
Date: Thu, 01 Oct 2026 08:44:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0645734445707138825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, derektern@proton.me
Subject: RE: Avoid local metadata Config notifications
In-Reply-To: <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
References: <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0645734445707138825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Avoid local metadata Config notifications
   Pull Request: https://github.com/bluez/bluez/pull/2539
   Created:      2026-09-16 14:22:09+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0645734445707138825==--
