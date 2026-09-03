Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D52368D77
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479678; cv=none; b=gFMZFgZtXjCHd6ay8El7+kLxWw3sfE7yRnqUTAoS5OJ/0LVpgfx7C/UujfAUJx6r0u7qmZXsWEf6o9INmUTgdMXkBxr6Ia41y1gb1vWcQIomGr7h/aSBf4A3RpErS3TFJ6YemVOkkXo5CJJiXDItVzup6u2dFyNxuEtvkHRIAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479678; c=relaxed/simple;
	bh=fVYKqIytBPyf+Y9ugXDP5abmwWXuphC9u5xSBu2VCvs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c/hX+vgMLLOxPhk0u/cGaeZyLgeBD/+MUkARpOo9YYbqq64Ma9uYI5ooijAR65QgVXR2RgFKILJNFDmFtxzp8h3TP7Vf57R1YDOcrjL4sx2P7NztEsC7NbfTRAEBnL5hrnYlnlI+Mp7CV/q9ov0476GYTKpZ55wi0ZFiB1yYVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMaE63KP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMaE63KP"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9103228ef53so5352196d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788479676; x=1789084476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kkuGxhRcbhGgGQ2gdvFbx2xPWQqJQhsBg4DLHkDm71I=;
        b=GMaE63KPH9s8KTJfZEbDIQE4eixNqymfjS/aY4Xein041aEgXu1QCuENUVqpoBMLOa
         GFsglDBoemKjwS7PxVepqjGUG3ZXDYTnXvxDtBsQzmrP9u9YJOPzoa81BMFm4IytWuu8
         +m8gPT9zWOnfkMhZwqrJv1/sY0T4/nR0jPFsiEMaCo5khUGRjxTfEvnTviTOguC/n/Ys
         M+eR2pglHB5PvT7mANqvnMVDyce6+YntMOsvirX4JxAkINN7ZHkQjnkTQeJ0BRvmhsVx
         YNT3PYaNs4nQOrqelVPFOLrBBeqaFlT6D229LNXiAvSwT0gdwowmCQ7p+iBAZVkpJyyU
         3keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788479676; x=1789084476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kkuGxhRcbhGgGQ2gdvFbx2xPWQqJQhsBg4DLHkDm71I=;
        b=bCKGPj6ZQAZdL5yHqRUj1U4aENnGMKvICeq0W0Cd67a+A/E3Jf5Agolu0zTbMeEJZK
         WnEtkUdmJYO21TWt5Ptt7+kZRvzfms2ptkqqjRRxzxOK6XLk3QW2cPJHe1XBVEqbl5vx
         R1rtFxKDfmY1x3TDcet1fzfntNrbTfRj/U1AOC1fNRwvuU1EJr0ShmoPdN5WW3POwAWW
         f0J4GqlZJ3qyfkS6iiO/YlrtYTlFPHBbfWz+NUKZ+7hoH/3rv0sS7c5aB1+Kdo4jNoMj
         /myrSO4RPUAW2wHp6M8qdmXgh2JsuJ0gVdoo9S4Jxm68JrLmsq02XaBWE9FHyIs7NutZ
         JHuw==
X-Gm-Message-State: AFuF++lhaROjekxRWDisnYJvGvzyJElgeImBj+HG1tjWEJtngsyJ20AQ
	r2DlSeOiSEujPQ+bn81vnLngzy6TynL0E54k/nw2fk7xbSsBHPoh1bAhK87BOQ==
X-Gm-Gg: AYBFou0KpZg6qCvj+aQew5dqgvyPf1BTv02CcQDkqCk15jpM1dr0k9Hr99VhNZQ6KaS
	Jg629X2/H6f+IcON7VNeN6knf5Pfn2a175DZ7KohuaA0xucAbf8g2sy8SocpxNDQhiBE84xyTMm
	cXPQps39pagJglQXXBWbXqGJD8dwGCfCZ5Bm2ziAI0pNCqkM0T81tU5wpmZw3Qv5DjJCCJFs3s0
	xhyXqcNXoXqaXDjDKo0+6GxRQg4fqbDr3wH5swejrnc3iWRi89IQXMyF/thWNoliLn6lFl9THAR
	8dXrl99yLnwxRkhD6HJh11DlQEGlBUSgVrR+7lFdjqrEDJv6eMkey/WFKHb+roThZcuFnpl9BB+
	SJEkvVBDxPlxBwksE5Az/wE06GritSZaro3Ta3hoTWo9HZJ91BHHdqXXInhzbjssgx+qDOMjDra
	eIMtsE58mcUlwxKfSU++GugJtrvfPG8nvNo8mtTUQJZxzGcvdu/zZrrmiKnsVgr241Vu0H7g==
X-Received: by 2002:a05:6214:449b:b0:90c:d296:2ab5 with SMTP id 6a1803df08f44-9103f08be1emr32772906d6.18.1788479675729;
        Thu, 03 Sep 2026 16:54:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040595f81sm6994756d6.2.2026.09.03.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 16:54:35 -0700 (PDT)
Message-ID: <6a9a08bb.f8a8063e.18a22.b2f3@mx.google.com>
Date: Thu, 03 Sep 2026 16:54:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6435336987424115585=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] adapter: clear discovery_found list before discovery_cleanup()
In-Reply-To: <3a496bd2c05e7e7f9f8285d155837208485b7a0b.1788471489.git.pav@iki.fi>
References: <3a496bd2c05e7e7f9f8285d155837208485b7a0b.1788471489.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6435336987424115585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157432

---Test result---

Test Summary:
CheckPatch                    FAIL      0.46 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      569.77 seconds
CheckSmatch                   PASS      298.68 seconds
bluezmakeextell               PASS      97.69 seconds
IncrementalBuild              PASS      553.61 seconds
ScanBuild                     PASS      887.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] adapter: clear discovery_found list before discovery_cleanup()
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#95: 
    #4 0x7feb5a355b56 in g_slist_free_full (/lib64/libglib-2.0.so.0+0x62b56)

/github/workspace/src/patch/14788726.patch total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14788726.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2489

---
Regards,
Linux Bluetooth


--===============6435336987424115585==--
