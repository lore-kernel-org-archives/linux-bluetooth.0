Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836E483BE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963519; cv=none; b=S1RZ/4amsNk6lMNHOX+gYyAi6Tn+iWvhF0UMZt6nh3oeocwdRWxVXQ3Lr1BZM55Qmx/Dkt6ANp9SFjwqwR6j94sGvBR6dNE6U6pGBAuAZtatwzT6bNK0Xoc6Fxo7fUOxdRzuq2proqmQ8t3/pj+oz86OqxPAUtln1rFMt7nJ2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963519; c=relaxed/simple;
	bh=/IqhumwQkG2JliXPJzV9aSqkxoBUbJmFAYhAvkTFuAo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SGU6xz1dDnGHvWnX38L2BgRDerO5m1f6UmFuf++mhOIByjtjAt88sMQ7TBAA6Mu4uDSgxeIouNOIjaH66RMLb0SVdcGbEciI7k81Y0pOKgkrK26CwnyEYmqqdNO4EP/d4OZLaP6sHPE9yWVqu5rzNVUJv/T3wjNSYiYyHCzRUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm/Din0Y; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm/Din0Y"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35834f72d94so6884623eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791963516; x=1792568316; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1TmMB/z+OsWAEnkslvUxL4l9idMuZ3dWZ0GBjrf6yLI=;
        b=Wm/Din0YuKy0zcsow6RQCiz/wlNffXHH5qY0Hl/0zR9JvR7RTdwisZJtgPYA8uniJX
         CkooGzoS0RKKdx6ZhWcd5xN4kwT5XMGyrPQcjrwKYy+aOyvUsXaNI6DIB4SgHneHTNLH
         vLfME2Qi5bqy50a3eJ2x3xDhhux2vwgFRjd2OdXUJ3g4Cm3mfP/kDQHxxAmNz7DBgRAG
         NP3imWw0Mwi3l0g++agG3DWjQtyLchQ/lfSjlipM8zYwcXKqr5Kimg8B2YPipadLF27x
         l0ClT6Toh1qcR9LNor6GxmeGpp/sXFSvJ6mEDh6Xvvz54hnYKI/n66mcnYW9hEduFjo0
         Lh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791963516; x=1792568316;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1TmMB/z+OsWAEnkslvUxL4l9idMuZ3dWZ0GBjrf6yLI=;
        b=0eSdOfIquWhUKz2JDcMZ6Gx7pFOnmpqpCo9Hi+iVi2jNqhSSb9eYYQOWjVnwrMLLTd
         iXqvs4pI/ONJvZ46f0XTMfwSiXimNeeFBb6ZA8qrts2VlZNN/pgpx1aJvALyAUflStGk
         ilZwWOJqkq9Vpm+vpkxt0jPis08Ecu2MCJIO1inzri7blAMJzZ15gezmbPTQANuaIS3T
         os/lKKmVY6ZA66xLCOLE9vbLpFVNPX7vvXCnejHl+QL3N6QLCsYDGw5/1g/3S/+vdsSB
         0O7+NZidqvKIITkWWU3Cp9KWe9mx4/Drr2EIsH1aXjwjBQqXlE1kLj8SEZ9USUvrSO5e
         kDog==
X-Gm-Message-State: AFq9FYKFHEbBReZx9OQR0T/ycQ1Qq3rbqZzopWQp6bJDcCko6ZUfEe6E
	LlTV/E9rRABaa3txO+gZmgw5nxDSFX5ICpnV4zSzNAQBtX+9mjjGrqW7315Kxg==
X-Gm-Gg: AYBFou2F/r1nSFEb+tb06T5KToXMQw4pOqJCYzTys1m+yE2nWtXaqvpf4oqzgRTVcUb
	YitRyTjYE9lkwNkByQ0IZQ1BZ5HFoxuq6Phx1IaTbxGH82dPMu29hJ45JDZW9cmUXIL/Acbs6xz
	t1L9AsuHM+5u44wEnZrMS7ThfIj6o+TqE/9zrc4sXn0mLOcClJMdwZI3u2d0PjA/9OoXawpFfZL
	lKfXj0N/gU7Hwtxb1EWKfUafeYBhNrnU/W45zrlcoNPRlYVZ3r4X2SAnGnf+SDz2bEtNCPLjuhR
	GJn77vKWShCuXwSvKr6ucr7TXyFcja6Aud1GKG4Jme+DfD9FTh6cWz8DgYKVZnt31ywVHvnY/sV
	c4XWofGe6Hp24Wzm2EAz5iKHs3gk1Zu9X3AEtPDo4B/u8W6dTcUwx/2gCNyCZy6HRIhiJd8juoW
	ac9l8Ilb3LIB8QiD1fqfJdme6NPgbUFdYWUgtVDLKKibUiWWgATOC5i52yfYpOmTJGv+PAW2rof
	Dmr
X-Received: by 2002:a05:693c:2a0e:b0:34e:9923:e372 with SMTP id 5a478bee46e88-3537dff9325mr21143186eec.29.1791963515628;
        Wed, 14 Oct 2026 00:38:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.36.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm56776836eec.3.2026.10.14.00.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:38:35 -0700 (PDT)
Message-ID: <6acf317b.a5690e37.2bee02.bcb8@mx.google.com>
Date: Wed, 14 Oct 2026 00:38:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8688872683866733248=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] mgmt-tester: Add host-resolved RPA scan checks
In-Reply-To: <20261014052008.413209-1-cochcoder@proton.me>
References: <20261014052008.413209-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8688872683866733248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185254/

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      17.37 seconds
BluezMake                     PASS      259.90 seconds
CheckSmatch                   PASS      245.53 seconds
bluezmakeextell               PASS      88.14 seconds
TestFunctional                PASS      1025.63 seconds
IncrementalBuild              PASS      266.77 seconds
ScanBuild                     PASS      992.30 seconds



https://github.com/bluez/bluez/pull/2676

---
Regards,
Linux Bluetooth


--===============8688872683866733248==--
