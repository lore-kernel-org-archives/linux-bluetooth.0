Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FB800
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737828335; cv=none; b=A+O9VvDX7ounBzzKOUufJ84JPLmt8FAAkAr7xQmXF03EFnksrY+CU+nfIWjG1amainzm6Ir/xH7OMssut9pEXQ6tKgVzb52PkclA6LqeWOnm38sT8qC9v2eql9MyMhuURMwooEpJXqS4XK2Wz9GxmLVeNj4vGAoUb48lZb4eq/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737828335; c=relaxed/simple;
	bh=q1mS5CuYgV+B6kE+Vuh7+YXBpZI+Khn0r8sdcXva8Y4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sJqejFcIlhQIov2rnkfnPbREpaaWJKcWO9RBjfas+EZ303BCWFwsMmp13Z2w1VhxTtLtyZ9qNvP/ZWXQvfaVnjEpKuYiBM6BcYIDKZKz7fR8jpR5t4lJU2visG9XqnRXfWNZ7BMMUahkw85DuEH4LgVS64NWIZNqVavomUSPuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT7qbI/K; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT7qbI/K"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so16420926d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2025 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737828332; x=1738433132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hIHyhfYL6wm3hstJhZwgb37JAtaZiQOq8j/cUWTIPfU=;
        b=WT7qbI/KQLpqN70vP2tKPrYk0ZWHyU0OgNXyizsocDodgEBH4M6knTpRFDb+yjCnO6
         KxXbUWdsE01zD2BkIkwPjBPBylkWO5hguWbaOb3fMtbvN7pRrv8HvMNZxHoQZPIm47kU
         StpM/I+Mn2pFFFGgiS2MlE/LUYzcaXdPD/jscAFydbSG/5GhqXyHKf4WXeksDzxoWUMk
         CKgpYq4645iyQ71CsVuHREYlJYLVfi/64a0A4TAYI9A96Nj+4AQroUbV8R8XAPkheX92
         YT3lh+Zr90G3DJBHOIoOBD4oSpof2sbSdEgFuGxcaUG3pBF5pwxnWke9xtNDBZie+Whr
         SYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737828332; x=1738433132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIHyhfYL6wm3hstJhZwgb37JAtaZiQOq8j/cUWTIPfU=;
        b=rMVY/wwh6iF/vlLch4NcZeE0IdPopqm9BBYqlfeJ3TLyRL1/rCESdmW9URJX8UvAm6
         L8lutDARUYayum1Yd3CVw82+gU6AjzGUr4xWUi+7znmJPpnbxNuYjros8lBt7Tpm69jY
         /8nglFSW+/8A5x5w/lM81NoBymVHvzVuL2y5OacLUaH22OUUu2xkfMiO2GVUCsQX7HGl
         syMSRDcmmiC9N9nGI8X61nc/5NIIklasm5BVB6p8efnruEPYfJB4R3/DK+mtUu/i3SAy
         XnBJB5jyTDwuaIWxDMk6R+0ER86IFh9n+wEL/o1LoG+qqz5On5xE1+n4aD9Jtwe4fs9f
         0Jsg==
X-Gm-Message-State: AOJu0YxExCexXjX9Hah6aAv8G4cKrQ19TVk8uRN9i0QFzH6yR0/H8LBb
	CvU7LBnciPI1U/8ajtrBi8u98//A/pZ7BFJgRzVAg20SwH9wLJ0HB4Vlqg==
X-Gm-Gg: ASbGncsKkAXbmlT5X2Q4fB5Ok9cLztareq14V/J9KfSPGWCiHYKh9kQj1YfORxYRG66
	+8kkvd6E4Uvvsd8QtnShBnxnl8+Sk5tN08Qdp6WbJ3JevbZSSkoRk+k+dHP4KDoMWhbXKDRqm4g
	Dif0G7Ut20O+uen3n7wOyV1qQIzhsza6TE49oiLf8dnY7yzSKNS6Jp8gRYiRuKEtAc2CbORLbqG
	XcS+SSvvAXd3wV9k4s+GcOuoCkhcRYFpmnAVags10N+EacRW598j9UN27wTZM8gyzOFfB6AndJC
	eUzMHeQVC39H
X-Google-Smtp-Source: AGHT+IENJcOfV1HtnNDSRO5RHbz1Mk9lq64n1slRvs8X12XP+36A8hShGZvPl+b9kQ5mGYM80EJn5w==
X-Received: by 2002:a05:6214:f2a:b0:6d8:a32e:8426 with SMTP id 6a1803df08f44-6e1b2141397mr534998366d6.3.1737828332247;
        Sat, 25 Jan 2025 10:05:32 -0800 (PST)
Received: from [172.17.0.2] ([20.102.199.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2047b333fsm19760186d6.0.2025.01.25.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 10:05:31 -0800 (PST)
Message-ID: <679527eb.0c0a0220.39ea62.8779@mx.google.com>
Date: Sat, 25 Jan 2025 10:05:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8103065907282379602=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: fix issues with BAP volumes > 127
In-Reply-To: <45ff22ec472a18bf3d83355f7e4af24a2b39d68b.1737823112.git.pav@iki.fi>
References: <45ff22ec472a18bf3d83355f7e4af24a2b39d68b.1737823112.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8103065907282379602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928336

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      1497.04 seconds
MakeCheck                     PASS      12.76 seconds
MakeDistcheck                 PASS      158.46 seconds
CheckValgrind                 PASS      214.01 seconds
CheckSmatch                   PASS      270.98 seconds
bluezmakeextell               PASS      98.17 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      858.61 seconds

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


--===============8103065907282379602==--
