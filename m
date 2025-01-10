Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB533987
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496528; cv=none; b=YDu7nvZWKrCbEh1EMyNen3v9FvGSeuRdi6h69THHgvTpZXjLvXANyI3btK9n81WWzFnLC/54K4SYbh3J5JUDtqNIdjG9oMY/O1DNyBQVfbf+pBv0wll+YIIbsY62QjaTZbmI/m1At3rEcMlANVJgPmJPsXf1YKcS/yvwof7zTj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496528; c=relaxed/simple;
	bh=93ey2kCHSGifZ6zGb0ISiofbQp0yhSy9asAU1th2S84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kgctrz59gGN0qGA1nEWh5lg8mFIG7EO5NM5IlneoaVgP0nM6imTXV8mXk38ehwNgtvEEttN83PAbh0GPzbKOo3eHXcQ8wYb8wltkJ6DjZXUJqNgFxy4hh8nSfwGt4m6MjqlrNyQRX/QHpQdsSw+7wl4Nd+d5UpWZN6LdRsCGdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmeYd85J; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmeYd85J"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso144185485a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 00:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736496526; x=1737101326; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0fZ3RGKt/rkE3nrCclWOQBg0ww+XJSH5i1YeTbyO7IM=;
        b=BmeYd85J9ZCOKS7UhWDrknUyjOWpiKMofb9QII7ve0dZEFDBxtn1Lle1ciyxDxIQ4v
         y6wlv3Uz8HBdGpGoVN/rCUzU4+9X8800qw2GjSOyCnpw55utvD/AiZ7Ahg5QxrQbC0qp
         40/oYj8/PSILMEZqNRIs+wXu8BluvDq+L5wQ9PpCV131hlXrjMI4znpn8hlsjmIZYhqQ
         2hJoObQlhgkseXGahojlF5MCWxayqUaBOzzjV/iVYM+OGEat5asWm3cUEDnKRJjjestO
         UfLcT8Zw3Lwg/DJffY0U1FsYFEwvbs6om6n01eS+kkufY9S4KrWJIHrwmjA55VKmZTYs
         1Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736496526; x=1737101326;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fZ3RGKt/rkE3nrCclWOQBg0ww+XJSH5i1YeTbyO7IM=;
        b=AdWLxE8Hv1/l2Weg8t44ZI1Xap1ThUObvikGASFRh3mXFhNOtmcQjP+t2voCXG2OHC
         5/NfMSiAMomx4SZSIwx7FDX+Czv8NvCl7PlAOR1OaypMn9C8hUjZNhNy95iHqvW+aE07
         0e1iqTUWle+Cp1ePg+pkYpf3bC9eMDT/2Ekh2mIqPpFQMLXj35DhRNB+LT2jJYjndwpq
         e/aRsb2ZMLjqeP/4Pjbo18cSBYI0LRzpDhSE2j6GvTmbcffi01VCLIPKnBnKO6nfFD7A
         IDU2ZypDjUPFSMuSY9G2LB9uBdHKPJ7rhoW16woyiaVd4yu6ygT+FpRPpx/FlN+W8zx4
         Fa5A==
X-Gm-Message-State: AOJu0Yx1Sg6ohwuPT4kx/byf+yIdN9EU2U2fQhCLGRAj2IU68LmJFiMk
	TtKMpMOP3s1f4kn0Dsq+EWoUrN7nzbD+L0I9KIYOLKDEeLjRk8iR0rYwPCC8
X-Gm-Gg: ASbGncv17aDJYlUKentiYGHavVmvmBTDsjZbPoGfDaPO0RIJy58BJwFvIOS+mMAKylK
	TlmL7QMQfZMbbrq/wWCdqnh6mPwoY/0uxGYDZ9dVvhtP0sYPJOmU87oMTvAV6kkaCM/NEocNZQ0
	EaN7NY4bUo8TMltgfLS8Z/hFo3fQ/EWS4AYYv/0s/mFoXYHeS43Dgyibt6tn1onuUaNf6Yw+c+C
	ncfNHOnMH2Me3idDll7jwbQMMqfiX6NO2ThO/Z/O8K+acFXaS7+Kbt8x3NVHoVO
X-Google-Smtp-Source: AGHT+IFCTwgoPbr/NRlv1kFhdkVmKBIT9zlHHNNmo4OOdBhIPnyxfRtKOvVlycLIn4RmZa0uS0QUuA==
X-Received: by 2002:a05:620a:2684:b0:7a9:a883:e22b with SMTP id af79cd13be357-7bcd96e5806mr1548805385a.7.1736496525649;
        Fri, 10 Jan 2025 00:08:45 -0800 (PST)
Received: from [172.17.0.2] ([172.183.229.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248304sm150438685a.31.2025.01.10.00.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:08:45 -0800 (PST)
Message-ID: <6780d58d.050a0220.a6314.67c0@mx.google.com>
Date: Fri, 10 Jan 2025 00:08:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2022935190767534721=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] BNEP: Fix the BNEP Unknown Control Message in PTS testing:
In-Reply-To: <20250110065444.3192525-1-quic_shuaz@quicinc.com>
References: <20250110065444.3192525-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2022935190767534721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924035

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      1480.81 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      158.69 seconds
CheckValgrind                 PASS      214.87 seconds
CheckSmatch                   PASS      271.32 seconds
bluezmakeextell               PASS      97.94 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      872.10 seconds

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


--===============2022935190767534721==--
