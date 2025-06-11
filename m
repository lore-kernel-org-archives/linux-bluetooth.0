Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20729271A9D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637958; cv=none; b=NL3G8j8kX8T/Co3EJHpi69lgdobCIeMXCkuQpgIdsh6aEqMo13n5hu2glt9o0hnl5GrR/Lyu0hUSgETR51iHN8/lF6AmJkk09siKf6XndS+fD9uUyQRaMf1IwkfZjWwdv+6q+S0oXYOqnAlDB9D6fBZg1lfufYk+DFO4+UfOv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637958; c=relaxed/simple;
	bh=Gy5zNe1kOSHcPu6sBy8hURoJx4CngNWArR7Yz8v4jBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b/Euhi3s3gxORQqleJJ7CP3Fq/lUG7rLhNi/MmFHB/ju9QtY35wcm8KyhnGtHo9bN7hjNvwpWmtxts4rVVrLrknMLXnnVbJbCKLe6JDKTdrp9kxmlvUMw9Zb7hBVMp2gEFI0h/dRT+a9JGon8ZAKV4HIVjdqisDL2EmKu5BQB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhUEZp7o; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhUEZp7o"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86cf3a3d4ccso578910839f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637956; x=1750242756; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NLNBwTu/FG+bWw88ieq946HVnGtIuj0kZe16lcQX4uo=;
        b=hhUEZp7omD3HVKBoWP/lUJaI7QfDJ85847ZR3IKjgH1GE8iJaxcGTWEdWcG4k87R8I
         esdv7m3+6KSU2nEizCnkiaWGbyCWetdxabVAI3VqA8EEnL9eOHLEl2ax9O9cCr9b0NFh
         7ypRVSL7JWKOGVeVYzSsW2i/2WI5HEh0/vdOvtvrUeQn3p4ZeSdBUyHuOjE/a8G/Zur2
         Ur8XGva4wrTi2mknWT0W+r9ICjqlyyRIEU2p0jZBM+22LFLeG82iuTvDeiw0YtNbhmUo
         PKHm+MEjmj8hPae4jFZcPsNB2ceWr0KqFWymIcUGeFiNwAOt//eKvzu3ibVFpA5wCeFd
         hG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637956; x=1750242756;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLNBwTu/FG+bWw88ieq946HVnGtIuj0kZe16lcQX4uo=;
        b=C5JZQj/hb2OcLnSEPS7+DnFjwRaEFluAJtS2BiVM1AbD/fME+woP4Mmpe7ohJS/SVk
         XSyJU7L3wvXPev5hvAUo4+zIrXoRq9+66OYri4WTXw8uri1qmJ9h1o89O8y5u7US++GR
         Nqqm3VGZaw7willxSpu2CLMJ2D0si7VxT6R+1ax5umPLsgwTI2dgNlnPCWwcC9RtSFfM
         0GLiYt23nC6MdCC5fFvxJkNPM3geEHVlCn7S9q64aGejSX/UJziYLGCnCIlzxUXcW6Qy
         957DCx7j3utiDEB6G2EVXkjDTaJThpt6cEqk/6BFI2jkpS5weTWiX2ZKyyEcMN32zUxe
         JScg==
X-Gm-Message-State: AOJu0Yy9ASSrb6P37YO87FlfZujLEo2nHdYt09DSdmwLmVxmdlzJ68ee
	3EJNTPWpK69CSsbf07NsdRpi7l4nCGxGJyIiooWDe9wsKWxXvTuDkCaZthQ/jw==
X-Gm-Gg: ASbGncuQFUlsnTjZ8OTawagVzI7iMaO/lkJI6+dcrK+Nuj2beTBxhfi9YsId05dbIIq
	zd6Pm98tzKa8q3ARBqEGxnyRXBL1VmS+ZlnL0eqNHg0BNmzUmFBydLiILV8hwja1R7P8Jd8hQ7D
	Wsu6XKg1po9RYOMOI6YDoiE8u+iVMqg57PP2qlfdqriubtw3EJDnx6jUI5CE1YJe9r2Cs4i9s6R
	mq45Yk9CPH2zv+X0qmOX8e6we7NB0Pg874Zj8XdnhEjOln7yDQ+Gmk8M5oum1h8C6Iisp0qtm/G
	3bxdqubUw8OFojQ8bXkDXzaDag7OHVo9uOlXlA20TX30ES/nSaeN2nHM56cKhKOrc0sU
X-Google-Smtp-Source: AGHT+IF766cTCGwFKEZHWsswlDSDKT1RToNjeXyxwP6EgIpO0N6oxnHf/vMzEjOS7XWnn97ukOxtuw==
X-Received: by 2002:a05:6602:3805:b0:867:8ef:69e8 with SMTP id ca18e2360f4ac-875bc42334cmr354553739f.3.1749637955841;
        Wed, 11 Jun 2025 03:32:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.78.129.163])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc5b0998sm34699039f.11.2025.06.11.03.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:32:35 -0700 (PDT)
Message-ID: <68495b43.050a0220.327805.0761@mx.google.com>
Date: Wed, 11 Jun 2025 03:32:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4208397450546098793=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] BASS: support for encrypted broadcast source
In-Reply-To: <20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com>
References: <20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4208397450546098793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970719

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      2890.44 seconds
MakeCheck                     PASS      20.50 seconds
MakeDistcheck                 PASS      200.93 seconds
CheckValgrind                 PASS      278.59 seconds
CheckSmatch                   PASS      307.60 seconds
bluezmakeextell               PASS      129.13 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      927.82 seconds

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


--===============4208397450546098793==--
