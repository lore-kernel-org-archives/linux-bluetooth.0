Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AE19E7FA
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613634; cv=none; b=H8x/F5VbOi92Nd1N6cQ5c5LSGQTZcm+8+UTqUwYGnJ5poP82j5abb88UHV9836bGVVuqIKjMXcbma1eOojNFKZGF/RfUZIuXl3eV0APUyHbq71FBOP715ra0O4xh4iCpWq5X3w3N2viIi8/QwYmjcYMaFNBvL2e8VfnqVlen6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613634; c=relaxed/simple;
	bh=tUhyggksTzrJlebwdH4GeRMVPJM2q00Vo9jjuD7CUa0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c6hFBiUsADa3vAMxpn/oKNhvpNj1rQbxYgnbSoXvvJu/yzMK7YuiEVJ/8WeT7os69ZhQV8OmpymjdpAA3yJpSTG4PvmdRjDjT4KpNSoo02dZINlWPNe29M0hx1kpN9hSzg7ZOXc9S26Khid6+3ohwMowZQjqkKPtppvpNVs1pZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukcfqvm7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukcfqvm7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c56a3def84so258256685a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745613631; x=1746218431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLE5prQRp52lcD3OK0P8qGUD75xjimFY/d8ngyQxuZ8=;
        b=Ukcfqvm7n244iUZD52mbtWlb2iz4LiOftej40R6ld0gsYEk0FcZosBL/kNfCVHIUZR
         /bvVwVW2DpFDECxeU9Ai5AoeX8wwxJfpZiAw3ZZ9bGuyg3sgTnWJYozhV3e/dwv8wckc
         cvAzLlfnruLx6jG944LARpUbkz+nZEXVsIrByG88mMxjgw/98FWFz89jza+MeQkKqpNn
         fCnPJ63er0EUhFD3oi9AHN1yZuPOBuGKb8TtSOuh8pYFES8VeTW0vEAsnj+0MfkwzJ39
         9ub6mZ9QYIwKCBtGY94anpzg+nDn73l/3b3rePsy+s89RpIz3VL/Bm662iPK47QRqI1n
         eIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745613631; x=1746218431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLE5prQRp52lcD3OK0P8qGUD75xjimFY/d8ngyQxuZ8=;
        b=S7a/Im2sM7Sz+v+R+JsO1DchbtD8KQhfnFWSPPCPfYI8d1DjTP4Co7Goc6A0yHCrco
         8lKU4Op2kVDCSzA3koOdklDjNcF3pOR25TDjYk7HuWHD/1K/zEDEAAgxQ4/vqv3RPKle
         Y0h9jYRS9O1k6HbDXY+hQ7xnHa9mz+2Y67MjSPQeZlKgLwFuTeA2ZIAzJb0Do316BizA
         FI4uBTOtFzeKBoKHaIlF7TE3L9c+yvQMluijhqp78ErLlCXMCj09M8RYK/Kt8782uT4v
         s6ioh/zX14uk1mKpAIjO48RTr0wjUdCnjjhuTJXFj3BjvXsxxCjXCX/t1u3GEKeGxldL
         rijQ==
X-Gm-Message-State: AOJu0Yyx6WHtxS8BImG2zb4GZun7REI1s7vmlBmHQcM+hevZNxp4/8j7
	plm0EnW4agaVXXR7Rl0W4nFf08gqu5zbTuuQopWNzfYK4zSmvg8WIJ6WQVLs
X-Gm-Gg: ASbGncv9CMX5VAepuaM9Xz80zK7SIUIu6sKwPiQComvjgFgEf7mH3y6Tf0Td6pEtpn0
	FHCGbuoNGhV6SZC9dtyNWqoH4iwxYTzp5SA5jkQKihcYKk84TpipOjG7XEv9Cj9i76E47FVFbLb
	MVZkw9SkuLxbAXGzm6UT5h4jy38klfLy90Z8KGhf8DQn9Xw7gUk972MoSoaEq4XQPUZFbDIsAN+
	v6sY59MhIT/ooDVOzbqV4IK+NBs6AgTCI9318yAH0nbYPVsUVJcpohycJVf8jnbK9vJ1EtY1Qup
	2hB4B03OakIGKjNQijhIYWFlldi5/N8tad8NNt5OlQpZzQ==
X-Google-Smtp-Source: AGHT+IHdrVZe3qA0dCP78wIfA1xy3UpVWDs/i3zYIMQmJGX5eCnpskxFSBi29kENAZV5+NpiXB/oYg==
X-Received: by 2002:a05:620a:1a02:b0:7c5:5d4b:e635 with SMTP id af79cd13be357-7c96078776emr535482585a.40.1745613631329;
        Fri, 25 Apr 2025 13:40:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.71.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86bcesm263606885a.70.2025.04.25.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 13:40:30 -0700 (PDT)
Message-ID: <680bf33e.050a0220.1bdf6a.004a@mx.google.com>
Date: Fri, 25 Apr 2025 13:40:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0187267520778937383=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: obexd: unregister profiles when the user is inactive
In-Reply-To: <20250425191846.639039-2-kernel.org@pileofstuff.org>
References: <20250425191846.639039-2-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0187267520778937383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957156

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      2720.64 seconds
MakeCheck                     PASS      20.39 seconds
MakeDistcheck                 PASS      198.41 seconds
CheckValgrind                 PASS      276.15 seconds
CheckSmatch                   PASS      303.09 seconds
bluezmakeextell               PASS      127.63 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      901.86 seconds

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


--===============0187267520778937383==--
