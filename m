Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9131F9A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400671; cv=none; b=fOQXdoVhZTg7KQgZMfBxyIwtrH9yVX0j7NToB02J4/SqPi6V6P0MYaB7S1/CJzSWXdbmy+KaXBZP+4Ew62hY3KV5tusyr8LDEPbQYntzP0ihnNOzcepAzX+rlv3jbRjzdQpEAile1NvvYCwg54JXpTPj6E7pG18aTOF8GHbbuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400671; c=relaxed/simple;
	bh=/hO3HYQMcexGe15VyzU9YMmSTuSeGQw6eQ0Wm1+FV1g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZHjIpm1ZkuIaVjN1tC3OlrAI3B1fYPrYmk1rUFOOANsbTPkXxM3eQkqrRV0zn5hUQ12Rxwnxg1v8tzzGImas2d9pyVbXwURgq4YEEUicpjpi5gtoroJXr93WjaTW8Jqd1XwCKF3FbbgpdbcPt4SnLgcVE/6VPas3GghwZqTgsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gixl0aFD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gixl0aFD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-505a1789a27so11332571cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773400669; x=1774005469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jFZ8fXeBcWy2LfM6iJRuyI2ikmNdQOEK62O1kBbdLA4=;
        b=gixl0aFDzIT2Ud3rVwHUWPu5aNdE8O2E0pZx2lmpsJdYYkEeBGxXzuX9iWdpualO3k
         RTs3R6kID7MqK8FN8kjbsLkGBxTdMjP4Vf0YpyGIs2F8ISeaoXF2cCpEnp1Jqg/zWYYx
         Qdg5f9VE4WFu4uZob0YYU2yFDIIslRYUEpVd00nfxDl+6m22SWHJw0MVDDcWDX0ei8er
         cbfQ+kFQGVy69gtzZ4SRfaH8avynF85cKe4kR93x3iUCoScwcimSjdk1aUAQmCSxpCKY
         NvE+0A14q05OZd5XaUjfvHsQVfRJLZ2JuyOQHoF7rUSMOYTx3jUoQk/pIUrGOOP7eLlW
         1NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773400669; x=1774005469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFZ8fXeBcWy2LfM6iJRuyI2ikmNdQOEK62O1kBbdLA4=;
        b=QstFS+GecUw38fhMoOBSmYCWVBaSvqv4nvPfvvXht5x+hLq0Gh4Mz2Yp6I4DY1Thlj
         m/dBBY0m1LUhsGb4keVR9bzBzKzsrg8O2zg+iVvdDNO4ODNH0IK1i03BfizFhWQWgFzk
         0qQEkbfVP0ut839/lgC/mCRi0hx/etG13EtOF/axmmPKZIdYnXE3bukhWXFDfuwralkb
         w0GAbgfq9PwyZp2j6kTLc1A8NSCJXjMwMW/D2AkcIS2VCFtrQ6FzrlS1f+wHhj0lDkHb
         4layQCiMln2jvZnSoBKwLJS8TRACplIpvlrWcgVllhiBg1lsdS7IRk5wOWiwXx91Lem3
         WwLA==
X-Gm-Message-State: AOJu0YwKMxvlZS/TDork3jyWnRDQZ/vVL1E5CTLkXzSAPdpvBoB6y/Do
	zZina9lNtD7BTumHw4sehiNds3rFoB7UTGcpzPEs3L/r0OmLirrihvC+Yw+XVQ==
X-Gm-Gg: ATEYQzzP3BRigE2On1Y3MoCYd9B6hPdpHPvARbFTC8asAM62nNpJjDd0B9CZFQEWpfJ
	kpxlvrs+WLsikhC7a/cTNId/2hFcKxskHOTbyYqXzHrgmBKFyeBnTlEyHs8G0Vh8HaA3DF1tLUu
	QdZPH1uoAjneM5Ux5Y2pPPDCIVtVDUMTwvwC8iCJnlWSLCGeXiNUGDyaf3w/dIwEvPZoDBYWd45
	lt81rBOZ8od2LkBJqEeTG8Jf54PqIbyqzZKZEgFWASRRQ6D4hIG2DDwF6MuAeMtTy0VZXlUf4Zi
	iGbnFw9vunNYqY0qkjs1kRB3t4BLeYX6UfwRWeiNYlVOwougxX+yoi68dOwkvEZL/mgWshVMK95
	d8bj4vVpfAJ/qLEnG5RobUi0wzrJrVqTJBIBKsTVKJZ9H6CgWIGiUpCJAf4Lzjp6ZF/DW5ZOy+u
	kd1XH5WgqoLtc7vNkhv5EROber+mj/Wg==
X-Received: by 2002:a05:622a:60b:b0:509:45fc:c88c with SMTP id d75a77b69052e-50957d09944mr35294771cf.19.1773400669296;
        Fri, 13 Mar 2026 04:17:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.162.137.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfc409sm54987776d6.35.2026.03.13.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:17:48 -0700 (PDT)
Message-ID: <69b3f25c.d40a0220.24ca0b.7b64@mx.google.com>
Date: Fri, 13 Mar 2026 04:17:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1950178520944332981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: client: add bluetoothctl broadcast-name helper
In-Reply-To: <20260313101805.46784-2-raghavendra.rao@collabora.com>
References: <20260313101805.46784-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1950178520944332981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1066232

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      21.33 seconds
BluezMake                     PASS      650.00 seconds
MakeCheck                     PASS      18.82 seconds
MakeDistcheck                 PASS      252.05 seconds
CheckValgrind                 PASS      299.86 seconds
CheckSmatch                   PASS      363.83 seconds
bluezmakeextell               PASS      185.51 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      1046.56 seconds

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



https://github.com/bluez/bluez/pull/1961/checks

---
Regards,
Linux Bluetooth


--===============1950178520944332981==--
