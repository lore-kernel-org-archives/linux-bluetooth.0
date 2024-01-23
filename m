Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8D64A8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025956; cv=none; b=RqDusknf3oh+xW1XjR0ttSCBQHFNymo/96jH13uDZBKMDceWi5WT5vb/mC2CTmuGvjFp5Vgdl69rGwtt86qY+pFlyXdYKG14+nyA1H98kTJxJhqZM3QvVY6E0CLBnuwoO4CDo8aIi4eYCXld6ghhnfo/TtoqWQ6VdCcMTuptrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025956; c=relaxed/simple;
	bh=U+rrYe8lqnF3dEupvbxLrWvFZ64q1ykwTczjuo+PJk8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J/O3hxEgq7CR7mOAYQgpQy70XF7L+WjzERusIm8PuayMr/5ZoSne7d0QGBuGUwlZwQFCc0pFGJ19ZOR1rhEh/WiGewaonkLZXJuJ8/fdvDfqI20MsnV8byKivBw5Q/dKz/RFjfmy9nqmbhrfhSIrMArtP5xPAl5fZ/UKXafYqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnWvc+kO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnWvc+kO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78394b4e659so204770685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025954; x=1706630754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=btwjnffsEecYH6z2DOmrwmMKCJvoYb963rTA2+ONEko=;
        b=LnWvc+kObFdYXQS0DFadLpE/RZvUHJ7ARyeKiToCOmlUhQoozwWWAvJXBKqL7D7uSE
         wQIMKAyM7YdnPPNhRAkIRqClO/KCwsAg1ivgWja0o2P1BuQeIxI6TKJVebQtkcfKJIYj
         bnfvraEXdUyVbPVHfeGoxjxUoTqovhY8PcF2bD7DQfktmLtUJ6B2v4BOmqPusQEaJUrz
         GMLiSjzIgj6hcOI2A42oHc6LanPfNwk27hVkSQv+WYtYRIrOnGChFm5EaPhl8YHBYelx
         kNDIYBqX7cKmhCRSHFRlhrUtNad9ySGIFwrcaH8TP91BhCuso/EQN1pYqEK2SgxtufpO
         M5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025954; x=1706630754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btwjnffsEecYH6z2DOmrwmMKCJvoYb963rTA2+ONEko=;
        b=I6SQ7wGJvi765vdNbXU6fB8NGcCBQEF6rGzMPEeBolIbVT1n4Vr65VtZsh+SNX15tn
         QsjOnNoDoRgfYnNWXczSx/2H7A5k4+EXzcTWuZF2EB2K6gnlAx9zT4qrIdM5n7QoCKhc
         LZ8/z7u/++jGTbrz58oPC5ySQ7ANe4hlEBWxnnnsx/xYzbZGD+Jb7zacHbNXtKRO3IwY
         hgD79kxgH3lW+t9Ay14VAGZfTOX5SXfhPToFpv/PQ3IDPOSMeRWCIhV+tmDo/O2ZFpCZ
         1Lf6Qth2HxkcU4nqtE3yuS1FXxSr+MCKZzqoKiXhtxfoQXTwFRw+XawmRrq4DcniJAXh
         30LA==
X-Gm-Message-State: AOJu0Yw4ApmW8lDXMiZd8+hmDTJJzeuiFTYmpDtf2O3aM5l1vY9FQIcq
	vXMRjcvTNOEBYkWUysjZgWx6zBE6MC5aG0tm8bYI/61tMnfEaerW5Cf9TrGY
X-Google-Smtp-Source: AGHT+IFWoLN27yEW1Nd1NV8ZEvDmXe3Vsi0+I3Q2OszsdidvhtrO7IqP7WjWjYwucbAlKWWSpIcKCw==
X-Received: by 2002:a05:620a:450e:b0:783:932e:a9a4 with SMTP id t14-20020a05620a450e00b00783932ea9a4mr7130485qkp.6.1706025954148;
        Tue, 23 Jan 2024 08:05:54 -0800 (PST)
Received: from [172.17.0.2] ([172.183.39.72])
        by smtp.gmail.com with ESMTPSA id de32-20020a05620a372000b00783aa2c9a1bsm795403qkb.103.2024.01.23.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:53 -0800 (PST)
Message-ID: <65afe3e1.050a0220.cb338.30cf@mx.google.com>
Date: Tue, 23 Jan 2024 08:05:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9217496461873092081=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Enhance GATT to pass PTS tests
In-Reply-To: <20240123143151.541787-2-frederic.danis@collabora.com>
References: <20240123143151.541787-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9217496461873092081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819132

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      1.16 seconds
BuildEll                      PASS      25.19 seconds
BluezMake                     PASS      728.12 seconds
MakeCheck                     PASS      12.08 seconds
MakeDistcheck                 PASS      164.05 seconds
CheckValgrind                 PASS      227.03 seconds
CheckSmatch                   PASS      328.75 seconds
bluezmakeextell               PASS      107.09 seconds
IncrementalBuild              PASS      2703.46 seconds
ScanBuild                     WARNING   956.97 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/btgatt-client.c:1824:2: warning: Value stored to 'argv' is never read
        argv += optind;
        ^       ~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============9217496461873092081==--
