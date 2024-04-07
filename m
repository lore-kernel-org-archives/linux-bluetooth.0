Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDB2BAE1
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516008; cv=none; b=rzgEjHTEaWjsbL+V6+4fxDIfRZtHb66DDQwy/Sn5clwPBkos3dwT+ylI8HoPVUl3KJJvn2z9OlVD5NfPOW9r9YamQOTZg+JjV6ak+n5bcU5kF0oP18wP3nlRmLPTU/gMG9jkmFdL76RZMaoqTnn/oIVEq5NSU4YWiou8b283mC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516008; c=relaxed/simple;
	bh=ZVGGjc0CAveXqm2rp5wqAK/tu9K3LV7lDhtPsjiIawg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EcRb/4Axkk1bODa61ezkOcL+1L80o8YA/BCxOw/GPPyFtweo2SCnrmvpcY0JgypWwzVyuFP2zwbntd2efp02Viki0/NXDd4sDJc7zhryz+k9XaGJyil3C03iAnWQIla5YoJPkIsw51zm/4ZBbn1XINmX4+L//d4JJlGFXve72xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpBoMnRu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpBoMnRu"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5aa28cde736so466019eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Apr 2024 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712516005; x=1713120805; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kF4x8T0SLfbdaB2azOh+EIaEqxTu6X7ytsEqAxqGYJ0=;
        b=bpBoMnRubl8s0kkum8MEroRvmN0Ru1cy37qLB8MpXXejvzxI21Wj69zfFEaQtYMyZJ
         JnXHDiLlby8peLbSCN2KvRn4zXfE376bh6Vs5JrTwbxmljIMIDOnrjWIqUrI2awDGcGg
         NSRar6ErWOMZlBq/iCbbTNU7nU9XoNZocQSgNV3mJdY/6gQSNNX76OzoocpmPEHbKluE
         eHZ8jJAXadd2AlufA3x/v/DWqNhunmKtjtv7PsJh7+MLjYLamtngU8mw4JwzisT/GM1h
         AbqNqIL+vKrC5ZSIA1JC8pbluJAc7Nz5T/ZZA60wlpVSVEswITCd8fGCtxySFk87gMbw
         TwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712516005; x=1713120805;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF4x8T0SLfbdaB2azOh+EIaEqxTu6X7ytsEqAxqGYJ0=;
        b=obwszXozXgmnXa4KKh1Ae/uoZbg1UGj1Tx6diO0Xeo51JsdpYsi1B6uZQHSafovCY+
         BvCe3IMV9UMgDXFqDE+jiPvFCTkF3NLIe5ZegUimz6iZncsOYTkMdFJMP0ZmfaZ4rLt5
         Z5I7fhYDvecTgctdM7arNXpSjUMdlB3lmoS9BQ/b92hJ3TVBzxClgzycR9bgQ2FJspw4
         IIwug0sIUyY0ihf53oau3b1w9RxuhfB/JI9k4E9tQ/YDAsWFiMfikmG7V7fj5jssxVPN
         Ylb7CFAtpdEzNEUFMMbsbZYrjsF2uBppBmKMK4ZCgqPnZ+3q8wov7wtnyBmcVo7cE1Zi
         eaUw==
X-Gm-Message-State: AOJu0YzAlVL0njXuiCYGkZNgELiaQ/El/p2XOr2NKHbL3UKwj9h8NvfK
	5KhTSgDksRPjeuKN/VsJ09/IAvHIeOjLENkR8WekS80XJGUwtyoqYq3zmgnd
X-Google-Smtp-Source: AGHT+IFsw2gm5Z3dZLpM6DTjR9LsfDb4onO7m21DnGed83VfoHvhRcrlDK1faAyi0wH11HuoeCUPtA==
X-Received: by 2002:a05:6358:c8e:b0:186:11dc:197b with SMTP id o14-20020a0563580c8e00b0018611dc197bmr4435960rwj.24.1712516004752;
        Sun, 07 Apr 2024 11:53:24 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.99.75])
        by smtp.gmail.com with ESMTPSA id p13-20020a0cf54d000000b0069903766e06sm2448132qvm.124.2024.04.07.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 11:53:24 -0700 (PDT)
Message-ID: <6612eba4.0c0a0220.5c4c.f428@mx.google.com>
Date: Sun, 07 Apr 2024 11:53:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7615284181422629395=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add BT_POLL_ERRQUEUE experimental feature and tests
In-Reply-To: <b6b6d1de2e58ec4fcb8c5265753bdf0bb41796c1.1712503074.git.pav@iki.fi>
References: <b6b6d1de2e58ec4fcb8c5265753bdf0bb41796c1.1712503074.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7615284181422629395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842181

---Test result---

Test Summary:
CheckPatch                    PASS      2.39 seconds
GitLint                       PASS      1.59 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1745.40 seconds
MakeCheck                     PASS      16.42 seconds
MakeDistcheck                 PASS      179.83 seconds
CheckValgrind                 PASS      249.66 seconds
CheckSmatch                   PASS      357.23 seconds
bluezmakeextell               PASS      121.04 seconds
IncrementalBuild              PASS      8023.76 seconds
ScanBuild                     PASS      1012.32 seconds



---
Regards,
Linux Bluetooth


--===============7615284181422629395==--
