Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953432;
	b=TAtGoe9ysVgy5/zLPDMwRsOv4HNAqnt51G2p0sZzQBVRupbTYkfqaHqUofWhJmMfUvZM
	 XIbM0G7ba8nq5JodukzqL09qG7DmFNkBamgVyNxSRKSs4ivKQScjqH1Qd1pvOHYkInJqK
	 BTFOvrFFnsEI7hjQsENMuZv2yEIrQkS2OScVmgJbpnjSULn4D6pZA5uPNDLejeIYSOGDf
	 wsyFkA55XVX2JtLaiV8yHM7ZQ9GQIFGZqBvgrdEdNXTtxmNNDlLzzyRGU7s9YyGVmaLFh
	 STB0aci9FfULhkum01A9N4iVhjH7JZoQat88n+4i6dpP8J6WMQ9kPS3kjqva6ND+yng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tevPNpbLUtGzuRTTREPKimnUj1hX7z+s0TkWFyFrOaI=;
	b=5SkmtDl+wPYjoNOiBsubFFRqWWhjl+Vv0tepX+X/sRKvZcKlL58fUk5XKDXUL068Pnln
	 JtYKJQtXttimfPekm+ZlZfk3OrC9C3I338qekBV/SOPgrgiqfOxJsDLeZj4q/sfFP4wEt
	 4HFhtLunB8XM7LMX5bOGavXXlvJ5SIDR0UEwbfzip/RAQb2qR1lqGwpdMD4jST964Dksb
	 rvrbqKAiliM1/4MNJSl8o4xiWrVBAG8U+/WKO/FYfaG8BGcxvPuRyMukB5YSxC/geV5Ps
	 CYAbGNuC8hf4Vjf4tVBLnXBw4OMT2/WuJhbyvu87LcnInE++C/kuv6iaV4zH49kewVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ya2sesyX;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56D606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 22:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B56D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ya2sesyX
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3704d30b84fso626883eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794953431; x=1795558231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tevPNpbLUtGzuRTTREPKimnUj1hX7z+s0TkWFyFrOaI=;
        b=Ya2sesyXxLcrv58BRtonv8jTH8JSXrjfktHhQAb6DzgPPJpSsKqanAofBtRpqf+67C
         BZ0k1kyFKOziUPsneNlpWHd5UJTdMnu+MFmyjRQOs1p/2qgQRPMnsjxDp9/KBfQAOlx0
         usDIbdnRBYVssOZEnXiAb/5XcY+b0/W/hVk3dleO+iUw8YBvpGrmVQo0KxuWi7HLyohn
         60lwvunmWHF8YXEsi9AhcO+Y3NwwLPASTJES2aDRwON2N3XpuojUpuIkEkqthbXsoCXu
         pzedy+1n3m+Td99eRvz7ItfhjkyQqbcWz++jv/3T3Wasuo7omnI4NbCh+iGHUGR8JpEY
         RH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953431; x=1795558231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tevPNpbLUtGzuRTTREPKimnUj1hX7z+s0TkWFyFrOaI=;
        b=bw2H9VQi1pYOtBCtAfmqWhf5D9uQx+yoSoKOyucPd7fe4O76y3WHZ239nJY10q3gKe
         aekqK+BDzQbThTZZH63tvYKiZQdykf8tP8gsMbtx7G824uYQlvq93EkXqI6agG8EyNS0
         r1ysZ3fWa1wi4VKmXCoehnVZvzF+/6bJDq7jq7ScU0J766J9Eoz3wbRg4IiRMjFikYd7
         MiadBaxp5sFcInM+xDV0LDsllO0VH8d0rhLEQl5FaVYtW4I1frqTvHT/JDOnDl4IFM8H
         pFSE6LY8GiozZmgFoyLwbvHN3pnwxzRaazwRQXUYjl04kfbNHNmiD+jq41e95018j/oM
         g2mQ==
X-Gm-Message-State: APuU4Z9Dy7DutPj8HjUODNj2fu1moIMvUVlScV4Ie4KGitbH2pvezScn
	zSn4OjKSbI6BstlvcakKOlhn/4mB8gbnjc1DiuUwctXKnc9Buc56yib1Cvtwcg==
X-Gm-Gg: AZFdTZfrYzM2FtNcFZ892EA4h06nc3mxf0F2/UsHldIK+m5bPqbLHe6TNrPSZOSFJzZ
	n5WSyYVzqWpzhMDmMIZU/n5Jouj5RbU+VirQDtN+mGKISPL4OJdR1sAmjIe9syX+PhaP7xHJe0G
	jM4RV0jmpIF1zXRb/TkgS1Wb6gviaePnwX0sbXfijExT2f1giUiHQBXGaLH15lWVEPpwo/uWrJW
	BB5PW/UVy/fDdMQuWjdPUbD55M3Fffg4H/Udq6FTdlnUjzggH+HGeO4qavUueUlIC7PKd0HKHLs
	vM1UchyyX9ZeG+iar90h79pjpSC9cgV22gcpA6uw9FtR8tgQB8vAB1C5aj3p4yeZvFZG4uVqE7Y
	GIyvzOJtADpCESp1H/bqMZaHAkbj3ZiRgILzTzUAAkrM95LVUNX+9sBU6Y6qtbML+6IksOrEcYQ
	xrX434zkmccx+DRloWwWN86aRhdrrUStYDK23ipRPi5RDz6kD4tjohllPGKmnNKYU07iXRiwnMk
	UPlMXARVMqu3zIqBzT42HfdtC2Ex9Ns3t/E/0oxs63XUnZSHg8o6PUcPG5z
X-Received: by 2002:a05:693c:87c5:10b0:369:d8e1:7bb6 with SMTP id 5a478bee46e88-38281427766mr661322eec.25.1794953430519;
        Tue, 17 Nov 2026 14:10:30 -0800 (PST)
Received: from [172.17.0.2] ([4.236.88.118])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm869746eec.8.2026.11.17.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:10:29 -0800 (PST)
Message-ID: <6afcd0d5.e5646aef.317ab9.d0da@mx.google.com>
Date: Tue, 17 Nov 2026 14:10:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2938008888875114968=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bearer.LE1: Add ReadRSSI
In-Reply-To: <20261117182151.73722-2-kevin@simpleble.org>
References: <20261117182151.73722-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2938008888875114968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1214175/

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      299.11 seconds
MakeCheck                     PASS      14.27 seconds
MakeDistcheck                 PASS      151.49 seconds
CheckValgrind                 PASS      366.42 seconds
CheckSmatch                   PASS      303.24 seconds
bluezmakeextell               PASS      102.59 seconds
TestFunctional                PASS      1228.02 seconds
IncrementalBuild              PASS      331.98 seconds
ScanBuild                     PASS      1143.51 seconds



https://github.com/bluez/bluez/pull/2843

---
Regards,
Linux Bluetooth


--===============2938008888875114968==--
