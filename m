Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794041145;
	b=a9stRmRT2aCwgBwC/7StRMUEojxC4JH8tIQ7YC4q6qtqtBsZAukqEmlbDHOWNdqYClru
	 4vr61iZnHvsW1ybDUHNIiU76xEfhYyCL9ohgcg5Ok1ONzPAVtGMEbKQqepksuVN768a3X
	 pcPL0LmSQ/sVDHGryd+SGTBkPZQaJUoNj25fgidsvFkv8pqHEvgAFu3v5KBJf6IWT6GPz
	 kYgma/JHKoBmkUdo4Bo+dQYfg3/AQX/xbBFvi+ny7tThW3nrX2W0QXrGrbsUBhs/9s4qm
	 3YMWo3IcQDYODqUdc8JS4g5sTEw+u5m7Yv3FQDaGxR0oGd44CyrVWln5UHJBHz4e4Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794041145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=EUD5nc4wAXE1pY1XUtLGLU8OSvjt2V48XNDgfD7NBq0=;
	b=xH4+A5PwuUVyMV5ARTMpBFvDn6AtwKuFvb6vMNwLaro74r76R6mFNyOWKnUREwUA/jbt
	 Z6Cp6qk37zkpdWrgq+waOfVr2c8G81RNhu4nP3lW6Fx2mI8+xhaffBy/Qkrz70+pj8fVE
	 2oGaQlo9LrCIkJ4W7yF/nT7g+nLxtg8XMV5i58LOcxO8+/7OCUAJ9ZK+FU7Tkjsz1ZY8X
	 m4P5cWMH163APiBcv83mAosII2rDWP24aaVN/+gj+5Soj59QTaYW/9RaKyf/YOwCvZ4k2
	 7n3jjNRjbvNPpWrXp4u63y7TGT/R3iyTLSv33E8p2r8+yGEY8fkmY3LOOELVDyN+yVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSIgw40l;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C0606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 08:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSIgw40l
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed39646f04so4458095ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 00:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794041144; x=1794645944; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EUD5nc4wAXE1pY1XUtLGLU8OSvjt2V48XNDgfD7NBq0=;
        b=YSIgw40l1Hp3v8a6POu+zHx1qcOtgFhP0R4/vDjfLh0HP/0gAUIAYrP+cL5PCM0neh
         dDgLlUHkmPhVG/HSTlQJVwUqZCwfHw4c+T+qvzLsMuoq6NTtAoxsXJ9tzKRw0pDvIv5h
         ahjFCTW4OQlfGjwdppZJ78K13R6mr5qReormhvmnADaW8x5zPaUFW2LKbZTn7kzhMRPx
         rXjcdODiMfFL1UEB6n+zx3uDUH44C49kefkOQ+VxGylzd4RtMWIsbwRVp0Z6zoDi2UV2
         pMb+Ao/rD5W2ljdZkk3iUu6JSNRj4daF3rz5OAKbgrS8kuCG9PxPog9skNw9V8QKbjf3
         NARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794041144; x=1794645944;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EUD5nc4wAXE1pY1XUtLGLU8OSvjt2V48XNDgfD7NBq0=;
        b=iy2q5NV5VAfu2c7Rmy4/JaONRIQYTkRQdQ1ZMb+b3vGs1etB1UQT5/oKPepsT0k4Uj
         Lcx9LI0j9eVkmo0p/rJYbvnQiVN57GaMQAz+qN7SMcTQXCFeyTFd0Lfdfl5nopKqashn
         Frqj7S+MwV8sIUuImwCdSuJoB9jBpxFXqwwKrHa/DXYXGawy1o0zJSZJ460viAifDLTy
         2Gd74h7/eQ8+meQCv3ka4eNfns8ucwhQYTZb4t9h7QMnJjFO5TabQ28RDcLE02asKXc2
         xsWGgr8tOtGdXkNlPqalCtkHl05pElb5TDwAMuTSuCynlLw7qf45HzujYa5eouUz7eDz
         VnUA==
X-Gm-Message-State: APuU4Z+gfK9/o4br/9/46L9h+o5fxSSgPZpUHTgcnwbONNdbDeO0/TU8
	4yxFklLX6Fe/E5mu9E3xqZSU0PMbYVai8g598aecNgIjSBTI45brl1dsDtI11A==
X-Gm-Gg: AYBFou2zhoRsR3Mr7bOsH83J6YBuctzNHqU9k9xmY8u1dNuY9YRao+VBQOFiVQXK4Lx
	X+/2v2TJnr4yQoHikSx132whAvE7DqNLAAs1ZuZFef660kZoq1V//upro+WWgqrpuZWkdSIAi3Y
	UuBCEPaszqOeLZM87PiJsFWRkUJ1kdLkr3yqRgiYTfFDcsPI3IEZbcYWIbjV7J7QW5wGgYq177q
	CO9SwIdohVf0ViFutr1b61QFOETFiEzPLojtvOhnC1dQG1e3jdYqgqRF+6i8AZSKLfVpUTSrCKY
	ckBAEAuWHx72yNrd3Brs3o1osw5uhl/ewYgyWBTtUionnTJUjXrfVvDZKLSTPKyWVJI5uxCUN1N
	GKsJWEqun2ztPFLAAryQtEprClCl9yH8LJq7iGQR49aLabPWHBIE3Q+YCCjG8pkSHlcWG69O1SU
	tMkuvaldT+sxEgGX7puJ8ZAvgRAljUNDgpb6JeTh1LPbdJoeXg7HoEQDA1GP4dYlePbINUV8gGt
	ObE5G9XCO0E6eh3Nx5NaPiuw74wcleqlCAerdTkdH4wC+uFUxCgiGQOKnm4MA==
X-Received: by 2002:a17:902:e844:b0:2df:9497:3c89 with SMTP id d9443c01a7336-2ed41e867fcmr58695165ad.59.1794041144455;
        Sat, 07 Nov 2026 00:45:44 -0800 (PST)
Received: from [172.17.0.2] ([13.66.225.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a9403sm11688495ad.12.2026.11.07.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:45:43 -0800 (PST)
Message-ID: <6aeee537.1bdc9ea5.2d1556.20a1@mx.google.com>
Date: Sat, 07 Nov 2026 00:45:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6101768472200206938=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/gatt-client: Cancel discovery read-by-type requests
In-Reply-To: <20261107065854.2147141-1-cochcoder@proton.me>
References: <20261107065854.2147141-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6101768472200206938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204776/

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.77 seconds
BuildEll                      PASS      15.93 seconds
BluezMake                     PASS      223.92 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      114.67 seconds
CheckValgrind                 PASS      276.47 seconds
CheckSmatch                   WARNING   224.41 seconds
bluezmakeextell               PASS      73.86 seconds
TestFunctional                PASS      959.71 seconds
IncrementalBuild              PASS      228.34 seconds
ScanBuild                     PASS      819.69 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-helpers.c:764:31: warning: Variable length array is used.src/shared/gatt-helpers.c:842:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1335:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1367:23: warning: Variable length array is used.src/shared/gatt-helpers.c:764:31: warning: Variable length array is used.src/shared/gatt-helpers.c:842:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1335:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1367:23: warning: Variable length array is used.src/shared/gatt-helpers.c:764:31: warning: Variable length array is used.src/shared/gatt-helpers.c:842:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1335:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1367:23: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2779

---
Regards,
Linux Bluetooth


--===============6101768472200206938==--
