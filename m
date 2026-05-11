Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EA34EF05
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540922; cv=none; b=uSw1klszwG6QDhbSTas6cIiGTaDUxp7xQ9QiXR+AkGdABdNxUnblScR4+aAYaqODjiRwIw5BNUVG6YXZdsOujcQJ7DaL2/qUpRhyIInlSgMOi0btYjNpyhnsQHf8Tah4eRQ/pN1JpiImlElphdPRfC4WGjfTnp8vULki8xXhZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540922; c=relaxed/simple;
	bh=09LPX9aedco0rLsE6v4FzPZ6m4j7yl0RWePqvLD8ia4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CCl7tFiPLGHAJWLsZQEFJhsUeKvIiK1HJb+C3GZy6F+/z6mgMOkzERiEs7clmSJMbt8POWkvv7xzBy9PAW9HT0HWU5vuPEqQ/pLwozto893mZrOoYG/8fIqDkz7bQ5POdUL3N55nmnW+q4qfdKA6nUaneBffuZf80LjmW/i1/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN3+8i37; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN3+8i37"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132d1b2519eso2866559c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540920; x=1779145720; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EGifGYiJLCH3Wv85diUOLCWRRjhVJlOi5/WXKFOAzsA=;
        b=IN3+8i37h9UZy2/c3piyQ+Z2kxuXEFbdKvlMiNdx0OfRinWDDfZjBGLq375xtjM8kD
         KmMxxxNmbo+RhuxmYD5Vnk4xxjBwAQKb9qsYIQ1zjvnsPmGBU8ECueAAU5nHC9AXEdCL
         zmNXCsZqhTNHvpWRJd0RZhceMq49ZXiLKYKVf/nEndmuaFBcTwfdIjKpmI7MVOeX+jxX
         lhCluv5GJpOMYcw9bzWjjtBl9RsB9KN1kWALd4e0ne0Y4dsjZLxyMmpF7L5i//EuZceF
         FBU9DTREcsAihG9/S7BN/w8nyCIaz/jetMTpzcwiFO7Cd0Rw0gfbLWMZzovaVe0kc3Qt
         WQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540920; x=1779145720;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGifGYiJLCH3Wv85diUOLCWRRjhVJlOi5/WXKFOAzsA=;
        b=XRbYYhzjkIGVJdaSyXLZlXm8npgNC8DyDv5mjxMu2yBwI54xhBqmMPUxgzROW1hus3
         7fjJ9miYKXeJfuxw3x0Qo8sASoqRFw74KpBiqdnBs8959N2/OrLZOPYLlI+RGSWx0+ki
         J0vgCkHQ9AJ/wzDwd6p81U4TyRexnJ+GF2IqV7AVgViDpOS7UUE//3nBFFN2p4TyOxoh
         LDDNFI55G40qA59/hFmqH0/DGB8/C7zP3O7u92AuFe0WqVCdGSP5WLxxZfGEFoh9xxqt
         Ycdp0s2MYQcsswCQYDMzQLERzfkhnfZ0YvHoN19WHGzDZKv6cAZTai3LpHDJxRjBp0su
         gc1w==
X-Gm-Message-State: AOJu0YyZCBThF3Ti3kGZD8V13klv/Q6YPjSqr6KvwCTGzqACS+AEBcYi
	b++LF9B++8gv50zJNQ9EsCsV1YrIk4i3VNDxuU0yFdZMWmnLQApBVVKAewt8xg==
X-Gm-Gg: Acq92OGFmbQg+oiR0p28OHvJ5eLw6y6jCJ+Xsk2ZHuyZdrRDbNhVm1p3kbCLkyEwJWn
	3FeUOyzsmWpU8uITxy0OpfpkyHcKZBL7vXORs/qsRKj3cjZlmdMn4bFEof+ggM7X6bB/KCtaCQh
	/EBzgKjGa5uLHfRkBmgLLg39csRC0r1OIsEJftkp+fW6ICKUvYqh6RhbNVgeDAJJex0hi+a3VJm
	GxZjdXQsej8m/oUkF4F8LNIXcK8l2jBHsxHG4B9E1SBszCPcUCsbXMQegCCetNQgeNeuaO272bM
	NXo3c9Ch5Uj34ntb3VSoxRpK5RQewrbtl1e01oYNE6PeQANGF1elnZgU7PkHXI2stqMOuZKWIQ+
	1qAat7ifpUpWjxP55e9r/HsNpRqoqH6iQN+RB9OxPGHMbDRHFgcje9pIOp9IMHkimAykTneOC+o
	fUz6WqDCXutzaAc/2b9Odt4Q10MSLk0gT7
X-Received: by 2002:a05:7300:6da5:b0:2ea:ed3e:13b7 with SMTP id 5a478bee46e88-2f54ad72068mr13171784eec.7.1778540919694;
        Mon, 11 May 2026 16:08:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.134.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b87dsm18716984eec.21.2026.05.11.16.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 16:08:39 -0700 (PDT)
Message-ID: <6a026177.050a0220.3aafd3.3707@mx.google.com>
Date: Mon, 11 May 2026 16:08:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3581741638847686843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] adapter: add BCAA UUID also when seen device is not discoverable
In-Reply-To: <a03d5b481c87d86d2bd2bdb376729ea6c4f992a9.1778535912.git.pav@iki.fi>
References: <a03d5b481c87d86d2bd2bdb376729ea6c4f992a9.1778535912.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3581741638847686843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093117

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       FAIL      0.20 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      655.94 seconds
CheckSmatch                   PASS      355.51 seconds
bluezmakeextell               PASS      183.32 seconds
IncrementalBuild              PASS      658.13 seconds
ScanBuild                     PASS      1044.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] adapter: add BCAA UUID also when seen device is not discoverable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (89>80): "Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2812#note_3467783"


https://github.com/bluez/bluez/pull/2119

---
Regards,
Linux Bluetooth


--===============3581741638847686843==--
