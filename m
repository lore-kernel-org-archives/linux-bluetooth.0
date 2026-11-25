Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619500;
	b=xgUHgZowqfp0CrQgcycqsuTaSXLgvQ7077G6w5BaqRMTfeuLYfNer52cJll6IX4Ole7A
	 sNTydaaLtoYxx6IulUcq1zniyWrIV9Mh3bBLsnO1OQbyGWBoO4lzN0D9GH89QLpGMiiTK
	 4Sh6/79nGC0+NjmodNbrw6hOHUZMGw9nsMHusyBrojzbiOTQr6YiY9REDJ9Gp4NseW4L3
	 g5Ch4Ueqn/UkElggDqhLn9OkS68PjJ40RE+IykQHVDxxFBMrxpvPKESkKmptVVahOzhoy
	 3OMdv7az1VI0kIGvruSc6MAkZOaqMDp+hIRl4NIkDA6RwHymgO0CfJLLGSBZR19b4QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qW/k2OMv6Cpz2vgRVQ0e9HZvZ+nsOkreG4VHRojQW5M=;
	b=MACRc8E1z6jNyJoIGLKzKcwfQuFzlk22FljrKS9xnp45tyq97uKowwmp1AZ2sw+f/SSC
	 EspKVMyw6r/JrJD9+mk+X5N1m/usZbXSaqIm04LdCwxZLMMRHOLP4hVY2bD3hTeLqN5fM
	 OGClANc70anfpv+BhzSmgnqbIx3ubfYVropfRXOFlgWPPEhjY7hDZUVsTytbKuf2tBtrv
	 Dn/MLcRpRhjPn9xjlDyngTVFQHOvkkT9XA2iLjttJG87pQxFRvREJs9oHhdkxrJ+V5OLP
	 6nBJL5DV9BsSnzzkNslq4Hr59bhFUA0bTrGBb+Lj1NlG1Cb2zu4go5E2rT7sN7p8t8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=STvpwEFy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E90606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E90606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=STvpwEFy
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67583c777abso6173142d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619499; cv=none;
        d=google.com; s=arc-20260327;
        b=hJZ2wQkdXSvgX/B/CQ/WIKEyPTuF9jSBV/Vd50qSJmljdkGHrAtMGBqRWt9y20K136
         ReQ/oQtngcz6pAGwF+A8rMWPxtDI2U+ovLKAOLd7It148MLQM0xGGvCdyYQGYwEN2EJz
         E/hJOBuNoutiuq3duXayWA7iQPSLKZjwfz6f+j5e0vn/v7gblcM5IG+PXGI3/nmnXnLN
         ZWsu6+TTk7QULUf4wV6wyLAkS9/iVA8F3wx9qTXms9sWqicPXzNGQ2Ubp95iXyNYo1hI
         N7MkIYWgjgLI/Kt2YnJgj48cI0xz313AIVl+OsdQKW8bX9PXOYhjfTMQyaWoSzA+2spM
         4qIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qW/k2OMv6Cpz2vgRVQ0e9HZvZ+nsOkreG4VHRojQW5M=;
        fh=XJYgDvkETP4e4OXOI39kHnN3Aa9uPpApAZWb5/OMrns=;
        b=l5tcdlN0NkFKTpWEwGdFUN/6ocZSCiU9j6qdSWQR7DdpGnJI/4tfPuSDL6HhRDg7Qf
         H1nXJrXfXVu9kLzcNdJiiMnP39AR/ux+Jzuj8yo489EtoPe9x+OzZe3cTdkeKz76vuu5
         MbSVhFjMkJU2HoV9HSS5W5RA5OgrjM1YGTyrV3Va90HgGgnVeQk7u7PEZu+fqoLkdqFQ
         RhXw+KWDmHgtvVI2wUfCTfqC/YL77GFC+k3mYZQTE17ssf1kPm7ID2Ot4tmxNKXgpDqV
         jrNMG17rnREupL7aaD9OFDL+bWgDRdrZ/4lVmmKF79G/CprUVHo4FS0DRPRpMQTlgLCl
         mgVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619499; x=1796224299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qW/k2OMv6Cpz2vgRVQ0e9HZvZ+nsOkreG4VHRojQW5M=;
        b=STvpwEFyeJi5Hn2Q2kfMSW/tvN42KJ/cpBmJyg1Mfvb3UV7EiCWaMaRiqGjjH+YfmC
         C/Fp1AeDGenLXv7DHgeksuYUk4G6EvmMf76bcNsBUneE6io75Om1hsIb+HspSbw5RDn9
         54SxkS/AAqEvxyyCJE+UpRRig4IYLZKKx+Kfdr3pt79Gz1ANk1A+QXEBzzDfAyuY05EE
         saU7URwKrcRG+742YVVyq/8n1l8Mme4Ubn0AbYkYgv5D1KoP3Pe87w7MQOsMwnm9PXfZ
         7SEq214eryN2q7AFgzX//K62g7YAVw3nm6hMCGsb3mFC9exa3S3KZn5QJm/Edb/6dFwv
         fpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619499; x=1796224299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qW/k2OMv6Cpz2vgRVQ0e9HZvZ+nsOkreG4VHRojQW5M=;
        b=AqwOvfhUFbOfEIUDY5S/Sq7XThGHaJQWcvq0Ym9nF6mTAsAf9bVrEQa1BpBYlP1YTo
         I9ZpbK4Pw3Fpz3z98ANYJlKA+2zy6JfuN2Hdf2lUq078jdyIWzUx4aBKaglQSPg8hC9O
         6yblf8EakGRNUPW/eDBEAe0ZTV6BHOmoFstCy0EchwWYuCaJCmq9sJ2x3QifWI+bXZ6W
         sI8GfH33OMpn7BI4v25RVzdVgbBZLg52+HhEbH3DI7xqjU7Tt0Uu5/FwFcxOen//IWz5
         Fbjjf9xzEptOQODTTJzsDeGzb+XCWiw1Gv4PUJIDyY8KxDy1OEOgtceUzQc0d7fMFDCC
         zERA==
X-Gm-Message-State: APuU4Z8adc46BzFaqwYkra9Pmb483idq6zqB+SldfmT27l1LXpIXXffU
	GPA9utyFkAEAwfGQNrm9DscqF04FtQXdWSDwXO3fcD2ptwfu4XS2o1rNQFzbsoHZ2WP4Gy2BR2L
	XWHFuKLAM0iX81Q9adWdKUfFBQ2GZpk7ojXV5
X-Gm-Gg: AZFdTZdtcyBB+6B4z2oIt+YlWoG8maSEfcPMYOB3XjXZDWwa+d8RZGwg5sI34fHahwt
	6M/SIcDbOzrdhXzqlHwA3boNeMMyNffEOKyaPuW++C2lAc7nfv2pUwwI1XnexZdy0/QZ7x03e5O
	ktvvA18tMTYkvl0GLZmNBRkhmnWn9J8f4CZwckgNl3QCB6y/JAMNtVBfDPb5cW0WBmkp8uT4Fc+
	g44EbCqbRYY8kLnIZ6WIsjDb5AGw/f9XEgNXIh1TqbzD3fiSEgmn5QdfIp+WFo5XepNJ4bGV+f8
	jaMna4QE3U3e3wFXSmXQOkxY8HJg3qKXgp42vu0jaknZfoj2oRCrDUMmNYffwZwO9w8iECq1yYZ
	YtMqReNkgCTvrg/wjIGz7FIWSEuQdQx1XvepjlkLxeLNJgb77InC7k0PZRa24oQw/4NNDvVj9u9
	KTBeBk4/LBhRZBIMX+IH8Qf86/EXLw6Xjfv7KEycdZ+d0Px07OMl8xccFcMqwmVNsBI7VgjkYzl
	hyM6KJt
X-Received: by 2002:a05:690e:4089:b0:67d:bef9:43c3 with SMTP id
 956f58d0204a3-67dec4dacd8mr7789510d50.48.1795619498950; Wed, 25 Nov 2026
 07:11:38 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124132108.3899705-1-simon.mikuda@streamunlimited.com> <6b05f592.10abdf86.154696.ccd3@mx.google.com>
In-Reply-To: <6b05f592.10abdf86.154696.ccd3@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 10:11:26 -0500
X-Gm-Features: Aa3M54pjGLwYQ6eovrrC4-XfV1eGZunqSWK4KJPDxPlSP46Lm1JYrV5lMD7CzRw
Message-ID: <CABBYNZKmsHgQjwMDFnLjLaf17=1zfg7TPtCw7zcimnrFhkzXjQ@mail.gmail.com>
Subject: Re: [BlueZ] a2dp: Don't suspend a sink stream on our own
To: linux-bluetooth@vger.kernel.org
Cc: simon.mikuda@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 3:37=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1220855/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.20 seconds
> GitLint                       PASS      0.15 seconds
> BuildEll                      PASS      13.29 seconds
> BluezMake                     PASS      202.01 seconds
> MakeCheck                     PASS      2.51 seconds
> MakeDistcheck                 PASS      103.59 seconds
> CheckValgrind                 PASS      107.82 seconds
> CheckSmatch                   PASS      183.57 seconds
> bluezmakeextell               PASS      65.62 seconds
> TestFunctional                PASS      925.41 seconds
> IncrementalBuild              PASS      205.15 seconds
> ScanBuild                     PASS      686.82 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2901

Copilot flagged a problem:

https://github.com/bluez/bluez/pull/2901#pullrequestreview-6046590392

--=20
Luiz Augusto von Dentz
