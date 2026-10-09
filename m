Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6F3F3289
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553392; cv=pass; b=QrmO1XSwK6tXlngrpqGshBLH6RvrxT4EDrndr62Ds7FD/oK/6dFfeG91+3tn+zZ/7PqP7uKrUdgMLNhBjvYHcLl744F3ewy8+THVvtknUHFKZUQdP0gKE7CsX/UeMwD8O7jrq6EqeoWm1p4BJ3fW1K6C7k3Y1cyTIFdEThRS2kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553392; c=relaxed/simple;
	bh=jmMHYh5+puDektBWsaAAoA9FTSEyHLK+MbeBVeVZ28I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siN9P1NlAs50SQFnkLu+uJzI9fUwsjUm8+uzdpyFAe6Bw6K2DtKK/ciTD7kMe/yBre0TkMwFUFFwZF9hPDyuYMoKcSBQHzZvESe6EYkqRKCW7YuYcyLW8v4QvmQAyWgru45g/er/6Q1V+278EbPi9Nc2o6pT5NDzBZtWnHLwLw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neeQ/Mvm; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neeQ/Mvm"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67694513f2fso4030661d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 06:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791553390; cv=none;
        d=google.com; s=arc-20260327;
        b=iw2H00FlXQTSr71hxBJYYGpLIeYG73eAMUcMl3+K3n1xd+t2LDMEwVDxCZDGdq8i71
         huSKfxaj0hgV+k16BxlS6q9lXjl01nsgOGcoQ8JQcZ4SFr2s1fnkBLny11CQNNqlhJfY
         07z3JnJuY1MO1INCAiWVe7fGFvS7QViysC2Lk7HVmVAeCB9De6Mru6rDlA1tZNbuo6yY
         nGQWJg0PrHlHAsMfFhBevQzoLU8gE8b+P2rqIxU2UsKI0v7E3dKi+xfyp3lFiiSSO4e9
         eUe8/k7WcLDZLQV4iqdJb5vv8NZqeuIMMtaOHYc3VPf+I11z3pMDDPUM1vBaHPP9NquT
         SFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jmMHYh5+puDektBWsaAAoA9FTSEyHLK+MbeBVeVZ28I=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=aJKirVmlNMV62y69oJZOhPT4M01TcvaySyxOUKuZ19rw7w27Vyz2s2sTwD4m3m5GkA
         BFK6jNQKqhl7CVm9fjkx+jfGXeFb2OJlbSZPe9RUB/Ww26ZPXxHgCBpTVtsPzcODV0a+
         24isJf+xL/kDGsJ7NjoQwG/mMXMngwWZifbmzNh7DJREdAEw3fBmRlqhfN4UdpmSvV/L
         OINnuDznKue2bdl+7ffgGixB/ISGeE4FidkLtE3mjBytY0mhUakz8uYzIb8PeLBDQE5e
         RMjuTChiGafV4D2kBNcnGnx3BdBTEj6Iw4zzfxHs4LtFgXoe4Htp/biwLhBGAHtc+yuu
         DbjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553390; x=1792158190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jmMHYh5+puDektBWsaAAoA9FTSEyHLK+MbeBVeVZ28I=;
        b=neeQ/Mvmdp1UEPqIEPmJ/RmXLNmcfc8NCblJQh59AmUPLH9I9v6XtouYz9+GVJJPHX
         YL7u2uV9CnQ08Alx3uggviCWD1ruwq6yWU7cJJO450R+YI1jV76l0XjU/cNzLkfm7Jrg
         sQo5li+K7Yvh3PKhoWuA8xv2eSTzTBVePFFML13PPWwbnQmXTwumTK3oJiG6n+TIIk20
         U6ul8CiGtw3ERH1INWa80txFvtKll1Ci0LDW/z6F6UVCMtQmjrVqckc2ThqMqB3jBvey
         uP/OZCaITkxvUlCvgZc7GO2JpUcu1QLX2AQhx3yHAkLtgZysFgu1ePg8Iq05GOzvZ3Kx
         NJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553390; x=1792158190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmMHYh5+puDektBWsaAAoA9FTSEyHLK+MbeBVeVZ28I=;
        b=OPCaE4QljsjfZtAfomZKcRa1iMocntwHvJbna9QoOlxNOtlsOc+vCqnaI/Nr38DiJz
         9utmcEZ7Ek3KTdN2NQ/3VcmHYD/a8mhVB6XJlSrBmjibrSNa664lEEN0RZIU7fNefEI0
         xDei7gJxUERDEpb3fkbFRt4iLNPe/DlDLy1oemGQlx666ZE0p8AIMu00auj/SNjPgib8
         ma6sYBuKxSHlohx45HmhhIpIn9fM9khUPMhReHrt5ZSui8cRq8sP0ZDA/BoqYT6xYv6T
         duuVRfDHG19WR8O1xFIMG2iUImIBV/SkBSRmei5zWwrIYI+qFs6trkssq1lUNLUdm5Ud
         Cs6A==
X-Gm-Message-State: AFq9FYIdxNNHa9iLXUeXUAriuYCis2b/g2MQmySXQAF77yMqPuwQYiKd
	QzA/a494K4Bg7ieFucudAYkKCJiMeFjjJZWHqimtBPb7ZHzSxLEEoBCmw0917SAKoLqB3yPhudn
	Q3FYdw1j50dv+QJvGW9r6d3GZsCAxqkGlZQ==
X-Gm-Gg: AYBFou3pjQ0N/SdF3or3/G3uBgbHXsO15GEH/tyILA9dtqil0cMhI5pFeojt6EsFSei
	282x9MbTaby4mnQP8vM9RbQ1OC/dqxJjkB0F+9F3Na4dEWP87wDDyuKRdcoLrV8dZSu3FV8qk3S
	eRQx9GNk85xQRgYYevv7LBiQsEg/ysfkagqX99z7mJyKgsgyus3aEVBiMI0hLLEjP266kskSw48
	Re9ikiGWnSqmpYkzGDGBFCQYSdfoMbXXavTexDIIS//RFRct6wWApIxRJq+b7d08wYELal0wlcl
	MXvUHldYIFl8oSZsrfYInE9ZoysOA9FHgFHEaN6GgQOpCr3R/hWa5/+0IhJMXx70xO2Jut/WpwN
	Zc+e7iV8RuqLFOtiH+1yQVtv0qbfO2TKaocv82ZE=
X-Received: by 2002:a05:690e:14cd:b0:677:cf5e:f58f with SMTP id
 956f58d0204a3-67936331bbamr470845d50.143.1791553389881; Fri, 09 Oct 2026
 06:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLS93hEBfkomBjisijsJWucuxJjz0oCsHsxJ9Cw=DDBww@mail.gmail.com>
 <20261009034543.54898-1-kevin@simpleble.org>
In-Reply-To: <20261009034543.54898-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Oct 2026 09:42:57 -0400
X-Gm-Features: AclHuK8epGtxEU50eMEUZ2DxC0U0Bi9vDgOB9CSfN0dTV3se7AIu_3UWyeu3YSc
Message-ID: <CABBYNZLqUTAR_=jb2CNEG1-7jJ+B_YyoFYopS1Tf=khSWcXRSQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Add Role property to org.bluez.Bearer.LE1
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Thu, Oct 8, 2026 at 11:45=E2=80=AFPM Kevin Dewald <kevin@simpleble.org> =
wrote:
>
> Hi Luiz,
>
> On Thu, Oct 8, 2026, Luiz Augusto von Dentz wrote:
> > Good question. Perhaps we should consider marking them stable, but
> > first we need to implement test automation using test-functional to
> > ensure they are truly stable.
> >
> > For this type of testing we can use the test-functional framework
> > nowadays, so we just have to create a few tests to validate our
> > expectations. Prototyping something like doc/functional-bearer.rst for
> > testing the interfaces.
>
> I can write those: a test/functional/test_bearer.py with a matching
> doc/functional-bearer.rst, covering Connect and Disconnect, Connected
> and the Disconnected signal, Paired and Bonded on both bearers,
> Connectable, and Role.
>
> Would you like them added to this series as a v3, or sent separately so
> this one can go in as it is?

Either approach works; we only recommend splitting the series if it
grows too large (20+ commits).

> Kevin



--=20
Luiz Augusto von Dentz
