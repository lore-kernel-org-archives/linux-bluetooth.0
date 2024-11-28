Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CF156661
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796894; cv=none; b=odgI+T7LbeJXsnDbhiDbnv6mH/gp9iK5Dn+CCa8FPcSboK/8y7D31/RG9/bnG46lEI1FT2iH4QDUf+0eX/U3ctRjCd0W0Heq/HRaiiYg7CqPAGVvsfUagHVsDUmEXNSFATzqBKAtSq5Dgm785Gxne161jz6K1a5nvSfg15Oslqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796894; c=relaxed/simple;
	bh=UilNR+Iuaj7EuW/qEGOkUgWimA/ZJ/bEAmxQ5KQY4Lk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fXnj7GoKz0kAU0PWQvdkAitf1Vk1TRYCI4VsrsemUJsSfjG2V3r9f3qF3aG06YOlXHNhr4PbJQZAg9Hq2AMv9nQF/ttlDZwVxM2JGxQdq/o4iwOcYG78NfpFan5dF0IaPQ19DtlJElkNQo0oH5LlB+ucwn2r8XYAd0oraayrNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmN8VtdJ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmN8VtdJ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4668d7d40f2so5859791cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 04:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732796891; x=1733401691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UilNR+Iuaj7EuW/qEGOkUgWimA/ZJ/bEAmxQ5KQY4Lk=;
        b=jmN8VtdJpv+DVWnez8853VUOt4y4i4Zu7LVlEzwPUxAJm4AAwnBaVstidhiBB1TFrR
         mShAmRoANoL7zY3WXXvpLKCrG3ZREc5TFOxi1gWXf1rf1E+hSzQQpMAS40jn4Ygdjw3q
         lF//wyOVH+AeE/lKHsJSasB+TfocgerglGdTC7g6OFxFrKJYvzIut0vPxxJ26B5/Zose
         Wltc7DjHGdQRbtnSSODlAfchKZe9EQpsl9zdgp1cGgC0uNYKzNZc7yQilynp3wqyt9Ue
         zwshMCCArbFJdjvEySfhWr07RcpTnNalDL3UOEBJXQaPVDTo51wDVpVxBqb5jxUrfrvT
         zAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796891; x=1733401691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UilNR+Iuaj7EuW/qEGOkUgWimA/ZJ/bEAmxQ5KQY4Lk=;
        b=RcYWNYLCcz8otY3LQ1XJwigSf3GpqxO2ir+o4LQ8G+5tD+wbCTeEF9pv5cKw1/JcJX
         Dt/wmC5M1n1Gvmzab2k+F0cWbOR7xou1fQs9y4hyKjCrsU0KcWFV+0c64YA4bmgjYY72
         FTT5qDHkEXLXRQEo6Lvh5aEynos7o+lgzV7m1Xx8zOTkVMjxzCeFVKevkyE+NU5gKFDn
         XIJiU8By3G9yt5gnrOU6ysinPzvvd2+ZLpDPL0KO80sQ2HIhIZylFK/6eNwpxuyOHO3P
         nkil5zh19AjnFFTBQBWm3+Y+oNLgGGsoM3+tmgsZnP/b5nJfjdZz7xT7BZFwv5NcRntK
         Viqg==
X-Gm-Message-State: AOJu0YzeaPPV/BMCcwOxJF/QrQW6ZAYufYbzA8S+hPBMojiazKGwqR1J
	pHlBIhFZ0PfvM6iNwu9dPENRkgAG5NJsegeqIUjUGWMxnjBoYORyAmPFIQ==
X-Gm-Gg: ASbGnctKFhl7ic5CdjK475Ra2zObrIxc5U7UWD+ctLJfuU69dobmj+lBHIpnyhnMY6T
	9aaQf3PGIVNAlcI805PwmiHaImOXlyc4HpqArFcvO3304zzvp2PVm+mX0fJ5x2rKDzlfhDLdzg7
	dZzlF3l2jAaha6QDszKkgWzKoTtlkSTLeOf8T9A68zi0k5YBwraExElv30M+paVkxw1fnLtaQQC
	Jv8acVtNiywJxVnjskztmRDiR0rxQWcIxWRgPUHeX5IkhPja809Gg==
X-Google-Smtp-Source: AGHT+IEatiDbhg9YXx+Uf/cACmT7iXbqBLt+g9UWYWW3Q7g9AWFn981ta0cvuK6zanBjWWWv/xZ6UQ==
X-Received: by 2002:ac8:5f14:0:b0:466:a9e6:6d6b with SMTP id d75a77b69052e-466b3516260mr89911861cf.15.1732796891636;
        Thu, 28 Nov 2024 04:28:11 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aaaf9sm52799085a.79.2024.11.28.04.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:28:11 -0800 (PST)
Message-ID: <674861db.050a0220.1166e7.17b9@mx.google.com>
Date: Thu, 28 Nov 2024 04:28:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8925242875521801870=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: bluetooth: qca: Add QCA6698 Bluetooth chip
In-Reply-To: <20241128120922.3518582-2-quic_chejiang@quicinc.com>
References: <20241128120922.3518582-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8925242875521801870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi:856
error: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8925242875521801870==--
