Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C91A9FAA
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Feb 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771165021; cv=none; b=mCgwTWUAFdXNYCj4h/wBTBv6W1nw0snx2RDOVH00GX9MbltubS+YaaO3w6VF7yqXQB58VgFD3+IgRclkhI7HETETqmsAUAKm9eFE1SuXpfs89GlPE+GOx/3gZYNuMG+0w9VahU7lbh+BhQjoOnPtvvnkDFrWjz7AG4R4ZgJykmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771165021; c=relaxed/simple;
	bh=s0XL6KcxU2VGw6ynqXVX8UjUJnT4XKyVF6J9FN2GwSY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XDQ0FbKsxYfn1bs4x2mBkWLoywkvPtPLSjgfsm3Q+8rfKgy4YlbcJJrA/gZkT5jB/LXr0Wu97WJJ5U1HXjvuVY/qyVOkbRGyjRn7ge7Zlus7VA691rVOJQWnZq7zzHaQmXcTDRJPXoG7HbRgpLSSOMZ5djBhFj9KPNJhgyr/mUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St85vv7F; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St85vv7F"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12732165d1eso2645225c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Feb 2026 06:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771165020; x=1771769820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fnCk//8to/nXRdguzT366iWKKaPHp7Yfg10Q+iBa034=;
        b=St85vv7FwfrOrazIlDB9T03tb8UVD50BDfVITUZ1mz/EHJySUh4aBuVPFm7VtQ/zSv
         LIgnPyXvhIYQN72rUvLi4nbkcER88EABxMpqZqAOpCVt8fqz8cMZV8vRaeW4a8hdZFbD
         gImQDu5Uh50tuKpYAAGLQLH14b0xsN4dzZMBMsNh+kPMNxhDDyt9qDzItVll2spG9Ext
         Wp3Qk0xjXAcwGzoy8GOkQ4VS4LWlfDe5kyO7K9y9cOfL3eTMRD1LMOuyRJhq2KeESylw
         R7+zTbXaTkw6T/aZX5Ixs0ZxU5b+qe09NVmnHEeinx8JTAO9A6wBF3USBsZAoWneqNHG
         v4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771165020; x=1771769820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnCk//8to/nXRdguzT366iWKKaPHp7Yfg10Q+iBa034=;
        b=d/eiP+XVzSUT5vH5jRsU8BX5dsdDwO1kfdAd7nG/jc2lWwxNTMvmehIHkRVO3XVd4i
         4YbPh214ixXOGpTZ+fuqQx2hDsh+7AaqiNoZWcAhxNdkaRf2WGp5XGKZDPevTDkVuvBS
         2PSKJ24+HQiL5TDVF6CIjgVg6Fcz4k3fIEKnrUdJVLE2yeK12mrkpAi3b2O/NVlazC3V
         gy0liAgizBICvFv77em8h27oCgHuZei3dqpR4qoUDGGo3xaqfI0FUmd7TtftFP//UfDP
         pFCg+UYOuS79GtAbI4UtVoR0hYmzo+2Qau4NCOtnzC4mJFty1FoVdoPMWoe7gJC8nK+q
         AVsg==
X-Gm-Message-State: AOJu0YwUm4H9UeVeoENxN8IFGoa1LO6ml9pNNVt00oXps2PxhIMzEPv1
	s2SBXhdSKAQeAvAv93e+aI8CNhHaK245rQXPkiOzZwWHtyA0MDResVj8Xt02AY4t
X-Gm-Gg: AZuq6aKJbKCPf+Axw4B7rgvOW0rFjlRuZxxJpRWHDZumVGJgrwnbcoWY2RnPARYVG+1
	KTSKLnahVDAxDavFgsRB2Gr3kEydb6TKK4NQ0vGZukLSOgFSCYXG8viHKXgjIz34R5i6MIoW2Go
	G1uUcfQKwFsyb/ouZJV+LY26fI2+3bao3Y/bPxIAxxYxc+aT67BAfumfBQwrXJ4JaaZNvdmatFn
	JzVGQPXTSqUdq2UXZCBNzdxoMBB3BycqLiNrXjoVoOYYFRnyzsgx57ONFPEX83SgHNVm11+NSCy
	QFRGbzikDdzdBhsZAHmDbTxNZ/flkeTq/xUwmoSFRc20gW+SjhyJzqxC2LVllavWz8y+iPeWqvb
	dSKPcwmarpC5aGu6sbPHzLdQvsR3sjLxe3MeXH7c5dXKaUdYnba7v3u6fp0a22VS6lzrcPLIINv
	k+HQ4oVVBTF9Tbr0Ao0TmGz7hr/1Xx
X-Received: by 2002:a05:7022:4186:b0:127:392f:27f with SMTP id a92af1059eb24-1273ae02245mr2873595c88.12.1771165019582;
        Sun, 15 Feb 2026 06:16:59 -0800 (PST)
Received: from [172.17.0.2] ([20.169.77.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm7229576c88.5.2026.02.15.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:16:59 -0800 (PST)
Message-ID: <6991d55b.050a0220.613f6.6157@mx.google.com>
Date: Sun, 15 Feb 2026 06:16:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2500829361934644203=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] a2dp: start connecting sink profile before source
In-Reply-To: <0b3d55690ff2f0ed72271f2760ace8f76a81fb43.1771160059.git.pav@iki.fi>
References: <0b3d55690ff2f0ed72271f2760ace8f76a81fb43.1771160059.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2500829361934644203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054282

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      18.19 seconds
BluezMake                     PASS      633.13 seconds
MakeCheck                     PASS      18.43 seconds
MakeDistcheck                 PASS      222.94 seconds
CheckValgrind                 PASS      282.52 seconds
CheckSmatch                   PASS      318.41 seconds
bluezmakeextell               PASS      169.93 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      930.13 seconds

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


--===============2500829361934644203==--
