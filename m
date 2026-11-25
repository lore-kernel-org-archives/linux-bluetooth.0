Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607493;
	b=VSg6bk1ZfRej9B8mDmGs735YNhx4cFHNEdM9DCuMiNuT2Ur6HpYIQed3F5jegIbFoMbM
	 e4vdRaVER0XM9YB7y3vKlv+qUNoD+yXkj3qkT5A98UeHs8aVbYFTwt00NznzAQe9xSFjK
	 dbio/bzHwIMhbFEEP7ctkM6kTsPlFlfigxHhBp2iuqJapfVGzgdfzVh01MTLQucXxBMwp
	 A6zgfVSTapGtEba4GzDNmL2s/fIp4ZN7HIaX9jnD7tliCOBlQdhp7jY+6tekCg055aMLl
	 Wh8R/v8CSRO8caPQ+2YB81ldibgqswvVyIPXDW1j1e1jzngwXymvhtBdWGNBnMyKOsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3kCEfW7iTm/jxyOlDkgmOUuIwNMT1aLBZYpYL3bBN6Y=;
	b=d/P7NF5Y4QlCX0absZ6lwHrKt+ufJ9ZAmumD+OrdeLr5RHlRfO0Tqn36ZtzfAVurx4ps
	 4EOypchf3P3wBwW917f0/2vVu1P9VKQeoBVHGX4mpezqYI/Sec0G5YqS4J1mW2mwOQEmm
	 /D8Vd/58QC7VNqEWEVxoQc353AUUUwt3Nrybow8IkWca5l72sRlVbwdtP+d8hGpJgOcsr
	 M9OWpC2a1c40DXHGjuWC16yXgv28tGXfzD19K1BAiSpLNUZq2vwSWJZxUp6yNjmRWRa8x
	 b68PZKaJkc4v/NNjaJNMZpQd/ylNh5g7Lk8xcsBvsKW/9mpKsfKPSt62COcfITqXusQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CSCZWn5j;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E638606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E638606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CSCZWn5j
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso5374711a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 03:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607492; x=1796212292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3kCEfW7iTm/jxyOlDkgmOUuIwNMT1aLBZYpYL3bBN6Y=;
        b=CSCZWn5jxgJUWscrlRgIFmiwNo5PDo7f12l49+uDidh6sM9aDD+QEISEFFW7OGYA9/
         uIKGPmh/cWWpQ2yIKzO42/1AI5l1Z4XjB3escQaevdoRcyKcRI6q4Ov1rlfjYXL5aUh9
         hVZK5I1r3ZHXtW/MI05bJgre8JBIuRGZU8FC6bJJmsS/2xZsYPDMUbgwsIQUSfja5ne8
         Lr17IzRsb5aO8LHA4U5sSvx6BttRazvk4IsELDUnRqGj5DUbQzzctZro3yYgrz2bBR6H
         G/xtPyCJ7RNyiSRnWevBelLtAuMFOSUH3LoADPdBw5IafAz6+Pjl67Em01r9vmHcO2u3
         TRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607492; x=1796212292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3kCEfW7iTm/jxyOlDkgmOUuIwNMT1aLBZYpYL3bBN6Y=;
        b=aGpf5gza2V+R6X/oV8H6g593I7cbpNbD3gSiF/lypuU/KlSen+aRF/wHUu6GhxTFQ7
         T3TGHikU0s4scBrvzxWdTe57IPsSn/va+ExESnxze8vXwKbNOnYQdy9e7wCn7FBQPYDF
         KOjDYJ7am6vLErxIpNt39STk/0yHaq+piDcWHi+PKqjs9xiuQ+ArxJIOFXh83ZNLum48
         s4AdJrvCeVVyGREYn4wb/0WgRCE8nQ0SyvrBZ+VHNRT+964f6fnYY1w8xTJdLDGzZByD
         g9x5p75/P2M+lfUwPS7BhLk6JYX8RMg158I+NXwEDntjj0I78afe67JaUsf70ljKQ55N
         idtw==
X-Gm-Message-State: APuU4Z99wg55PXWOdHe/KLwq4eZr9Q3ag41aWSKKBhF/m/bNbM8h74yK
	cbZ0Fsxq1RLSO9KFnjoKd4QR/fZLkSbLaFiXjfFCZ9GGH7aUTSeN4t6vbu+urQ==
X-Gm-Gg: AZFdTZd1F9y5ACiFJezWut7WusSvTuWOptjovCubYLLcNTOptvJ2m71d+hwYOAtBOEl
	y61RXewFuCt7UgEoQquN4R3uC/9J9ZpyOSicJRL1Lv8ZyTdtuoxXk0sUlKikXhkgkgB2256UIWn
	sNuyjCRy3A7Li0E0imlh8f9+WzhxRIHeBJh0Cwd6a4O65iG6pfT+hjeMlfgGarfJo34yl2qYBiw
	jVnn6dvMmc40tphgB1TUOhgO1sUdXrhvgzC/TZDTp5mqw1shWLTrSi6eGfEzD/Ru2zncIXEtaMd
	4Sfbgt/y/VPLxtmlY/tbLxS07+luvvHpWpq2aoniv47CtG0GMoVQyN5uigoZNua4/mjjEwDpa7D
	OFC+oVbbDoIfW16bRfKt2X31y7BSKkEHY+wjYkpuNOXLpPqwmpSqpEGUnhabW+z7RvN764D94wI
	k8IETRiikQjOxI/8mh6A7JJ3ifWMJw6oxUJmYV8MrVwnuzgvb27s3h9zp/YiTOVTaD1efJi8sz4
	silcamM6Zm2xz+bIIgRXmJ5Z5S1KgrhN+hdpl5E1ly+7tJnV4x0pDebU0w/Ym6/ZLIlX6+acnoT
	XB9fXsqK95UaXsqo+Z+LnHsUCQFPBMhzS83scDCqdw==
X-Received: by 2002:a17:90b:390b:b0:3b1:d40:2c4e with SMTP id 98e67ed59e1d1-3b41c56f34amr11158596a91.0.1795607492325;
        Wed, 25 Nov 2026 03:51:32 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-111.us-west-2.compute.amazonaws.com. [3.42.157.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm17390374a91.9.2026.11.25.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:51:31 -0800 (PST)
Message-ID: <6b06cbc3.3b92418b.348c27.ceab@mx.google.com>
Date: Wed, 25 Nov 2026 03:51:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0196401946315960159=="
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
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btrtl: Add firmware format v3 support and RTL8922D
In-Reply-To: <20261125084703.1578601-2-hildawu@realtek.com>
References: <20261125084703.1578601-2-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0196401946315960159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221822/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.01 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.83 seconds
CheckAllWarning               PASS      23.66 seconds
CheckSparse                   PASS      25.25 seconds
BuildKernel32                 PASS      20.88 seconds
CheckKernelLLVM               PASS      20.93 seconds
TestRunnerSetup               PASS      486.45 seconds
IncrementalBuild              PASS      20.53 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v11,1/2] Bluetooth: btrtl: Add firmware format v3 support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#296: 
 drivers/bluetooth/{btrtl.c => btrtl_main.c} | 215 ++++--

total: 0 errors, 1 warnings, 1416 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15021100.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1223

---
Regards,
Linux Bluetooth


--===============0196401946315960159==--
