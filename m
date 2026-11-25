Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619406;
	b=CdloJ6sAfHU7nn87rs7QBvGirl1GFVqbwZ/+nl9ZHIKP1bhI2tB5uYW0sR58qqBpZicg
	 uunGi9X0HQdohZ1oDE1n5Fy5V+F3ioAB6vLlZ5uNDMJv9rN9Qw+gYQuZ2+gUj8zflI+fI
	 WR9xL6gR+CHIM+qaC3UpnssTOWdM+DFIfmmy1npQNg5RtdOpwc+3M9K+V7wCM7VbD1HOk
	 7maTwIwJM89zUtwhQZZL4g/nehcHs6NLfVYWm1+1kzA+k5Q9Z/a+grRInd5J68yrOBOrd
	 0OW8Agbpk8ucoqb9S54dwB1y0cvdZB9JTkBIzKiF9IYnZYEzYLlypk6orOQceS++tOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=h8FmCBCOaHNnUICQoO5LuSozdbBBGSYz7cJ1MevoIaU=;
	b=oMEvarwARD50SephJe0PEpkyjI8Ky0z0OnXNcFYL1lajYWG42goVwNENXYLJBiz7Lmc5
	 4k/Ql1cICkWHxfcD3bi3wOA2uIKEh+lLrg9Hd6iNqOenZcHHYYMj0YCI7QwDFiwln2+o7
	 QkH+kHHb19y8qUcFaL8R9ZiECDJUDF7P1uF8OLMVP5ZS5w7rVhTAyObVwKRiZNZewiDQB
	 3cvYIAcohC5Q2TYLALufMmfWRSYXQob7xxxaHJ9Hz9R4ftVTT5+UUdbwvlfgsGwzu1XMM
	 fKo023meTRX1quwMDK1NC1tC8/Yy9DXx+8Y0e6HuejqOiso2d7wss+55b1AQjE1p93w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbPBrAuy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE831606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE831606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbPBrAuy
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b51389f58cso64282157b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619405; cv=none;
        d=google.com; s=arc-20260327;
        b=NihPBKGshFOUgzimPTPxkOpGxZnzeJLzHL/L/DC4iLQTN2CYvtcI6zlOh65BLjpqkL
         X3ihjHFt5l6o8nlJa4j2TYGE6+kGROCSb3X25388Jq3O3lQDEclmCjfj4vD33bQhM6jh
         wsntWMO5k48Aq34ag2b+Rpdswf2A39UE/+3sPig4sokEsJ0yUFeQMl4PXrktKyBzMmvP
         mfEDEmRgpMxjVOXuZp/pFhsva9i3lFaRytYBxlAPE5AZWv/iS3iXQkhRJpfSVfWNH0ar
         uE3cY0h49ltzOTVq07s22O3pW6+yCzwa2vBlZtMpol8Qc7Jw185/w4adBtStIuF3MdKc
         CouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8FmCBCOaHNnUICQoO5LuSozdbBBGSYz7cJ1MevoIaU=;
        fh=XJYgDvkETP4e4OXOI39kHnN3Aa9uPpApAZWb5/OMrns=;
        b=mINkTpUg2rJiwSFNm0vESMdNOpSUerxei2okT9BBXZ8LMiO9yx4lxgJzu1LHvQB3su
         S+tggW115SaXDcafM8nvujCQFLqm1JbgKcvLgNSyVC/zzD0sSWfY/CXzhHt3fUL0UYxR
         ODrLl0PXYGUB3dOllz0UAIdh+f2lC3lESrlEAM4mt/3v0QbYrmQViSB0fOH/NMO+Yp9c
         LtJzocUFddBXjvxAVWCALdwjDIoKj+EkayWUIPybxaQ01TkxufMLNVOFHC7mVgmxOUCf
         kHCZFv8JYHjE+IyCux6N+oBEO05wytbqnfqSzALFaUyJJGGf8lHZi+Jfr8dAJoyRt2DR
         ot+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619405; x=1796224205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8FmCBCOaHNnUICQoO5LuSozdbBBGSYz7cJ1MevoIaU=;
        b=TbPBrAuyn3HGM7p29ikZZfPCenZBESCFNy72TA1pPgsbiGDhKeFWs2X65AtBqL+9Bq
         LtqhWL+KTNJ06cH/+WVnNb09vIY2T2ICyxhr/wdkfnXcrm2V9QVBA/QoeeNFlATHf09G
         cEhSTGBxPFWwlA8xYYOjAxarUhCe/PZiSZ1ePHTnGrmXzcGq+HyML9w0zemQ22QPjuoY
         VGcm0WrfmGvMyMxwjHt4KS8SgzOZHzvZUrjh5mo4eVF5GZ7M0DnCninpzikFkx0hNDcJ
         eWz1FppSQ/HKiLTgpfAthH+Dj1ggdDTMFH9mmv4cTibOIqZMw9pK22z9QGoK2/e5lncp
         h+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619405; x=1796224205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8FmCBCOaHNnUICQoO5LuSozdbBBGSYz7cJ1MevoIaU=;
        b=a9mmJL/pkgfySjR9PiGiFKGP1VeWHONS8eSEbS5jaVkojbN54loyO27A0FnsjhCCrW
         8uA28VG/9jle3zyrdZVuJCM6Vf6TG8BvU86+xZ0nLHJqfjtYI3E9wMrHoK19K8oww34S
         OqCFEpv7rZNIStp4WODOoVQDJc/09zRpF7xIzd83FvL6FBmSKq9/h4/qWZeuQyjwjBx+
         3DXsy1odTXqsyxZ7BtJm20kAHt+cPkjF9m2eQOJiDhcxn0QEZEWO4Nny9BwPbQJ4UHn7
         a4fqLFOJctTIgwtx9/lCquYoYv9zZrYTmeLONCol9EHfpet+1Gu0tlqARqXCBeo7/Q7q
         7jbw==
X-Gm-Message-State: APuU4Z9ijXleA76P81gGTnGSikY0ZF0vZCW9IsO2vNKwUTLDGO8NFV/u
	sAJr/1mhg54mKbpP1uP40hxA02W2NDbjWBa1UX7Qh+HHTPDIg40uP86AQEESiG1oMOrw0gZ0glD
	lExFkXYQsAYSAsIjSYXj7wBLRN4TZRK5DTbIB
X-Gm-Gg: AZFdTZfVk7js3FIz2UoZhDlcvaE+1YVmy62VEs2xtdo3Y4ZuyMaFQSeoO+hKFmJPFnw
	pGMZbre+KkO+blmQe8E1Eiq3UL4JecNWtVUOKvZ9PAGq3YaWPo45Q+fG2GYMpDkLPrEykZh+Jpd
	TcK7qIG+wGrJldot3h+R0vO2z4rCqjodIItqtr0XITeXJHEmNBT6kuC0pIjhkVBuQEWMCTO17DU
	02sEoS/Hyh0wjd1eotwsqSosYNUODHnwBNblSu30Jo7AV2hUyJxBT+R9KlJ03h6R5DVKZcK+kqw
	aYABzKLkdnaNgLE+o9rsVdniTNscO2OSeTT2SaWaIYkGBFeUoginvVDgnpjg41XVhGe3bAZzqaS
	ZcVYzW6Lpchhhb4BH4PhbTGk5RG30KTn9FNeHCktSnelLuttcEl+KWKyLhHD9gAK/rdlPaoAW11
	7JoSx5qYIEuRhibfRcXA0JKzCv2bGlHVWz8vOSMgHlM3U/Ne/YH1U6h8Ag5F8=
X-Received: by 2002:a05:690c:6b0b:b0:8b4:c35e:5fe3 with SMTP id
 00721157ae682-8b520498199mr71431127b3.46.1795619404799; Wed, 25 Nov 2026
 07:10:04 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com> <6b05fb6e.45417901.4f93f.a144@mx.google.com>
In-Reply-To: <6b05fb6e.45417901.4f93f.a144@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 10:09:53 -0500
X-Gm-Features: Aa3M54pCBGB6JSSoXr_qGRaE4UJNB04HtM52jLAbGVfCrfHQDap_qfcHQ6BAkyo
Message-ID: <CABBYNZJiZQjT7GHqraHXwOsVe53MfQVS4GfcoB74zkNPO5txLA@mail.gmail.com>
Subject: Re: [BlueZ,1/4] doc/org.bluez.MediaTransport: Add Mute property
To: linux-bluetooth@vger.kernel.org
Cc: simon.mikuda@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 4:02=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1220854/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.51 seconds
> GitLint                       PASS      0.87 seconds
> BuildEll                      PASS      20.59 seconds
> BluezMake                     PASS      318.79 seconds
> MakeCheck                     PASS      14.72 seconds
> MakeDistcheck                 PASS      148.94 seconds
> CheckValgrind                 PASS      358.45 seconds
> CheckSmatch                   PASS      319.44 seconds
> bluezmakeextell               PASS      103.55 seconds
> TestFunctional                PASS      1184.52 seconds
> IncrementalBuild              PASS      346.05 seconds
> ScanBuild                     PASS      1191.79 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2900

Copilot flagged a couple of problems:

https://github.com/bluez/bluez/pull/2900#pullrequestreview-6046509783

--=20
Luiz Augusto von Dentz
