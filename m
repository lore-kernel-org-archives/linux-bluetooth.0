Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DAF1865EE
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690384; cv=none; b=XBatsNNkQwqO55LXm9uiTEGotVM/eBmzr8fQEnI5AkZSy86JDtm/+WvSYrV8FfDO4tF8uHe+DHu7GOlDMnUQPzGF7RR8fcoXiNZA6nleSV2vSJa/RVM31s7jQygtuEvKCLlDJBsgtY3vf83f+nOmo967omrw0hoyUOR2qvvllV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690384; c=relaxed/simple;
	bh=7u3h1nwSscFDy/+nkHVsfkk9PEEku0XZ+n4uBAZEgDM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M61eltVH33OjAuMc3OiOuorJ0gXZdBDRmKjKrr6LFq6WOzNTKyxgdBc+QpFI64ZU16eNpsR8DGDf4xZO3qF8eIlw4XXdBsAcTTm8LCmUxEXqDVdxHGljFjFAcFFIGmC5TqbEsv5TUNQpT1vajv/GUMbufGZrDYQcgCxnEAdu/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXRaSRFJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXRaSRFJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4679d366adeso27751cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738690381; x=1739295181; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qBkIlsZPIv6DPI12T36VJ+IE+tK26fuJlifTHO7TLWs=;
        b=jXRaSRFJCWZuoSR1awf9QW5lBLOIXXw9dBBLi4fIzE3r79ReZNXjQyWq9131Ms25hD
         s+FS+JjBr5k6vkKTNULCmL/zCSzanpxim7lXHZGwQpCrUsrxFCIEFvm8DrCH1P5DXaaX
         hQGBl5eaFHX3VNNL6Fo2kV9PywBjf5DNgF779oVyJhU7915e36NEUxxCkKIaZEMG9hbT
         lfkkLVpcFDN65JAVO75v6xYcovuMkQir1yOOHlhyYHHd8VsLVkX7rHFmXMdLPlsEbJRu
         VIkKF9xpUrXxOj06KRxvg0T0wGzbOqOgkinKp89vdgLyzfrczqVlI700jPu3c0tKrSyP
         XrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690381; x=1739295181;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBkIlsZPIv6DPI12T36VJ+IE+tK26fuJlifTHO7TLWs=;
        b=HKJ2mS57/mrRuksd9E0fOAZ3ap6jgCOBE4jGk5XFyAhO7Tgoes7g/2Th+U1S3cmGvy
         hhe5rp9epoqQPA0ouNZj3HnbNVvIyt/oaZdtfJbr02hAJnpJC62H+RWb0qwwqT/2QJoR
         e+gNEHj8X6tuV/SNQHIXw3npCenMfON8qdyvZ1Qm0ypZcEMR4/z1blRMqgbee0J3a0mB
         J3z3l/HbqpI277tHIsn72x3OJNwiZtlQQ32+kIGBEMrrTLkoswxmw5OC0RwdE3TNzCFQ
         lb6gmkTfdqekLoKZKUEuuA8uWjzmuHmuYQ/J/r++gN4IHc4ZMiEXKg6sD0xipdYGrWdr
         WH4w==
X-Gm-Message-State: AOJu0YzJi6w7Bb7Df3XoJ//tWZhCLP5rweYAs7Oq+AOatGAkC4LV68dj
	LpVIDlzpWLfmFbMME9bnJzRK7dbsbtxLZULnDX50PUf9cUMGrzfdo5pF9A==
X-Gm-Gg: ASbGnctjjxkSwLTbI2FSG9gfbU/EPxqkhbjhAubFDIzdavcPLynFVRAXlSWYKJr+yn5
	yy6CiH46MCHlsGKjLKMIpee+eCE9qsjLr2IQJLpK/bKhEH53S7Fyhz5C8NkQQA9MjO0ZuVp754D
	b8Wy0djWyo7Yx9rz6n7Ka3h9mpoFoijZmI2N5opjhLczNXWKQYzkwjMZ7odp6Nu+ATfb9Q8pCog
	ODp/qqhNNQsRKwwFPusKwOCPUvww75sP33Q4EPo5GQq0yFa8MlYBcheR+BP/C8lQZfctg9zftJ8
	5CKPouSlIegPmvMP6GRDsw==
X-Google-Smtp-Source: AGHT+IHVjQHll9S6z94aH1uxH6Yz5u9phWdVxwTF6uVYorlreWM5v1rHYhDlF3DKhRsrQQVSs65zBw==
X-Received: by 2002:a05:622a:90:b0:46e:549b:3e66 with SMTP id d75a77b69052e-470186d2de1mr70529011cf.13.1738690381541;
        Tue, 04 Feb 2025 09:33:01 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf1728efsm61589131cf.62.2025.02.04.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:33:01 -0800 (PST)
Message-ID: <67a24f4d.050a0220.23b249.5533@mx.google.com>
Date: Tue, 04 Feb 2025 09:33:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4306646547573336574=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] build: Enable -Wstringop-overflow and -D_FORTIFY_SOURCE=3
In-Reply-To: <20250204164927.2839802-1-luiz.dentz@gmail.com>
References: <20250204164927.2839802-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4306646547573336574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=930511

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     FAIL      9.10 seconds
MakeCheck                     FAIL      1.23 seconds
MakeDistcheck                 PASS      159.54 seconds
CheckValgrind                 FAIL      8.91 seconds
CheckSmatch                   FAIL      9.41 seconds
bluezmakeextell               FAIL      10.21 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      858.19 seconds

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
Test: BluezMake - FAIL
Desc: Build BlueZ
Output:

<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8491: src/shared/libshared_mainloop_la-queue.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8498: src/shared/libshared_mainloop_la-util.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8512: src/shared/libshared_mainloop_la-crypto.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8505: src/shared/libshared_mainloop_la-mgmt.lo] Error 1
make: *** [Makefile:4682: all] Error 2
##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
cc1: all warnings being treated as errors
make[1]: *** [Makefile:7851: client/main.o] Error 1
make: *** [Makefile:12320: check] Error 2
##############################
Test: CheckValgrind - FAIL
Desc: Run Bluez Make Check with Valgrind
Output:

<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8491: src/shared/libshared_mainloop_la-queue.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8512: src/shared/libshared_mainloop_la-crypto.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8505: src/shared/libshared_mainloop_la-mgmt.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8498: src/shared/libshared_mainloop_la-util.lo] Error 1
make: *** [Makefile:12320: check] Error 2
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

src/shared/crypto.c:271:21: warning: Variable length array is used.
src/shared/crypto.c:272:23: warning: Variable length array is used.
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8491: src/shared/libshared_mainloop_la-queue.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8512: src/shared/libshared_mainloop_la-crypto.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8505: src/shared/libshared_mainloop_la-mgmt.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8498: src/shared/libshared_mainloop_la-util.lo] Error 1
make: *** [Makefile:4682: all] Error 2
##############################
Test: bluezmakeextell - FAIL
Desc: Build Bluez with External ELL
Output:

<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8491: src/shared/libshared_mainloop_la-queue.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8512: src/shared/libshared_mainloop_la-crypto.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8498: src/shared/libshared_mainloop_la-util.lo] Error 1
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8505: src/shared/libshared_mainloop_la-mgmt.lo] Error 1
make: *** [Makefile:4682: all] Error 2
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4306646547573336574==--
