Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD01A9B4C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514178; cv=none; b=omJa7TpZ/v4HU6IlNgjMfIIdMv5aZmG7S0AkRcCQrTOzoUrX2UwjuG5Rm5yHhcauQvotvFw1epiy8bkwqQO7A3g0f7enMJ6/kkv6D2R4PWSMC2GWWs7UHQVnkgHZqtzvh02tauKc0N03VPBwtGn46dFVSh6/7O4hE9kFyJlYTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514178; c=relaxed/simple;
	bh=Tb0ETPgqOf29rjrwVxtrsa9VARTVKCfUwbupVtc8ZvE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Aho+mK8MDw74iR5nRw935BMhlT0LtScuEfeCHsXOYP7+0Sf76kRYCjEbSaufwxGXXaRM+hIsGHR5mBgwsF821DNgxKIkTvUKQkrAhtWotv6Gi+yokEm32BX34gfBRzV7T2q8uufzkzdsoYILWjK6HzTUBWB+xgzcWYV/JGnrLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amnlJViQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amnlJViQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4772f48f516so26426181cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514174; x=1746118974; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BPXedR7oX2dEBBJQPwwI96cdJRxXqb6hJ6EZunYItmI=;
        b=amnlJViQhsb8H7iZb4pXI9aFdS5hu0D+43mZJUSFptOuVwjl8dX1O5OZ9vALHg9BBX
         /j2JxYxN/Us4ZD6gN+rQD0NhUGFz3AvFghhKmLy42grm0iBAiYKKgeA2eq+iX6lFypoK
         RtGR/Qcv1DfYvBlsOpEBo41KSXaZ6YrLnZdZoBGp7f8zKsIH3W00LdK7mpAo6IO1Nxlh
         zO9MRzsr6LgD/cMHlEkIiTO6lSCQmtDPw5qYAhoPTePAYahgyNS3ZMRXbhV5w/YQMSAB
         D+cAcMOu08pUTgONyJk8WDhVlyoT9XYGEYROIs1cm5RBs5VzPWLK9xlxbSQ+L5xQFtlp
         br+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514174; x=1746118974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPXedR7oX2dEBBJQPwwI96cdJRxXqb6hJ6EZunYItmI=;
        b=IcQWKIv0lN2pux2bss+8V64Q/vlYxT52towrWeXHy8Xp4zCyCeRdGPwvQuVJnc6/x3
         kjq29T06lODh9r3dtSkCBnSvo/n0/Uc8RFLTITIMj9yDY1rxl6WjcJfMFuf+zcLXJOWI
         dqI0bxI8Xierj/7L+ay5gGuvIk5lSvVtZoU3ScahzFgx+6gPGmiarCyGcKnCxvJpcHFr
         ROeiUtDLv90jTD0FLDdDr9YYEiGOYWeC5oDrhZ9PEl/uvJQ0UvMhhbnYMmVy7DBog2X0
         u8Gy9aK85deqAeo5f3BL9wdBTyfrSxSy3+jD7y9Ez9HuDL3SHAaq6uRj3+L0IlrNY1Yu
         ywow==
X-Gm-Message-State: AOJu0Yz+FjKsNePOupId0Cr6LLgDmw8m3fBEqlAbZUkrg5IHfqVLgXLe
	jkohSlqIjyi38xqzUaX6s+N4VVN4dRyN3oCLmBkbOdTyvTvPzTqaBYPaig==
X-Gm-Gg: ASbGncu8DdtoxNmJKyciTk6b3a96dCQG13+Ve22Xdvio/bmy541TkHZCqN3+XWTFUct
	Gqjw92l+1WiHM+0EbR6CS66KiCw84yU6TFUZn4rNd9laT3G8b4lA/YgQvSber7iNK4lckavFK5N
	z7aFzAXXoCDdWx1D6NjmHajQyfVdjLHL6k9A+4F7eahATj35IRk3doCgVWtPQ1GGC6zGeAf7t4k
	UiXa5snMjzm65mnop+UyU6THfd51/30TpnmR+rIxfkYsbbgnDwygg6X4y03qQKBjlhAEOW+uZ3i
	31mhek0Ca1lDOGwIenUnmkuNSyg/h8POi9kfgl0BEugI9w/H
X-Google-Smtp-Source: AGHT+IEiwlJ5umytKImjlcqEonoRG6dGj4+Rq0FMHU6jxuRTyhfWF5hEgNONOu1OOyQ15G095lSqiw==
X-Received: by 2002:a05:622a:229d:b0:477:1126:5a33 with SMTP id d75a77b69052e-47ec2b56ba6mr45536091cf.1.1745514174131;
        Thu, 24 Apr 2025 10:02:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.174.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf2086sm13781541cf.8.2025.04.24.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:02:53 -0700 (PDT)
Message-ID: <680a6ebd.050a0220.1a699b.6d6e@mx.google.com>
Date: Thu, 24 Apr 2025 10:02:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2525643549735369294=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO
In-Reply-To: <34c98b16c31ff4e5eb1a6d23326e7e2d7763a0ee.1745272994.git.pav@iki.fi>
References: <34c98b16c31ff4e5eb1a6d23326e7e2d7763a0ee.1745272994.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2525643549735369294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955480

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      2759.66 seconds
MakeCheck                     PASS      20.49 seconds
MakeDistcheck                 PASS      200.85 seconds
CheckValgrind                 PASS      275.06 seconds
CheckSmatch                   WARNING   302.45 seconds
bluezmakeextell               PASS      128.56 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      910.19 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2525643549735369294==--
