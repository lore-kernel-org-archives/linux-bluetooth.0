Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06894A01
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405336; cv=none; b=LNnhzD9VVimaIP9eRUE/il2MSD/yIXDvTTM/IMDVWZn7kBIh2TAIIVn0GPB9P3wsx0T1u+LJ3sLUEbgUgfVzQ3lAxBgV58GP6xdaY03SapOz/QSyJAL6eEU9XbsLP90d5hQ5dXZxwhcM1+/bQGTvlK78H7AnwpJ0RB92O7yIFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405336; c=relaxed/simple;
	bh=8Zchf3rOtInBGtBy8P2V5SBa2FSQVa0hvrXCFpN9NEc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oSfOy3HpnzfPOiQFGKxOErlUa09LTIeefIztbLrts5vhasbEIhOAy+dpT3GugeCdP6F10Xoizpbxy6fpx9qgbYQ4BcpnxfEAXAJS6tU0V6nr4KhZ2e46zLXC46/nPrUQJ2YMW1t6TDYnrc+NqE97vyZ0KTWuwFfvV4YHttivQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCUdHGcn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCUdHGcn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be3d681e74so23479485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739405333; x=1740010133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KDoWdPoZvorWLnWdvF2zLCxeiwW2bl9eQHOkHEgtBys=;
        b=ZCUdHGcnIVz9drCqXNX3Nn2B543auiR9YviRdkiQG0PqnQJO93lgUPTgGXIKOFdEZ9
         buH/cXFD5TVx+N4jgIyGL08SkaOMPEOgwPAx8b1JCGG5bgOicLb6ts5eAwW5ptAbKnyp
         njT35d0jo2Mvqse90FMsnpB+Pe43Hgu/2f6m34JD3L2Q2MJDjytTeichXqeQ35mHu/l+
         +RlwYg4jU3cCnz81ky8E2QB5boE1m4IisnzGjDK9XMJXsQ8XzxNQqUmYt6TJXmTwmvcs
         JqYfXIH8f7MqF2g9H17FxGDaW5SX0DOiOtjuyHPQLgQkgr+v1MO0Y7HrjAYyjsbgSL+W
         p3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405333; x=1740010133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDoWdPoZvorWLnWdvF2zLCxeiwW2bl9eQHOkHEgtBys=;
        b=i48ZUmDrl9+csC9wZ56z37pKBnIhaCpj1o4E/qUfUpBJpHn+T2OSGBB0RnDZn7ganZ
         dondOaPSvuODyyCL4iHonffNWgiL7fQECo5q/HB121zae/iY2vT76wfIkv6DIaRTT1Hx
         2HAwtuwntS+ucIbqePoPZjsc2UTT68J3X6JnCc4QlbcH3+XdtnWL19OEmfZYyp28cxhF
         yNqVXzn1cvW8C4k5SwJ5VvXK8gNQZwieBoFsPlxHf/PCplD3luqTMh2DXGatphoZF0No
         U6ArJZEJp8zHYK0EBOu/RQfNaz4b6PKfgQoZubz85syM9qblmbujOCchYRpgMZEmDqYp
         6HBQ==
X-Gm-Message-State: AOJu0Yx1t9t9k6ewPYx+cOMsAaBX+nsBGpLYuu5By8MebSqXMmdQFp3w
	mi3MfKnl7E5xNMeAMHW64HO9yPHj04yeiW/cV3EMjZOx1ZJZB/0bCqtqqA==
X-Gm-Gg: ASbGnctRsxSKa4mDybDtS5ownxh9dXeEIqFSe3P5aB30fKIeXBxTHoDHztp9R9zAf4E
	jYTA0TS0dtI1kIiIceAj9E3D1BPLccFwcl8I6HmKZU8cY8c0wImnJehmdmNFtaZTQdy3IfkclPS
	GcsTg2dahezPVJZtXPzCeKtVaYk1zfxH8vc117sBRkkNXWGbI6HueylKfQ5OX0N6dC825xbjk6Y
	j1NhYuGMHcmEzKZc7v3XTiYe6h/krAs9wp2yjs0+1dTkkPaxj4eqgfGgZsMKN1fjRHT/nrrbDiy
	s8J0XRI91Rucg7khm6ok08c=
X-Google-Smtp-Source: AGHT+IFHl3eIIJX16uOpKglhDEJVkwzGJCI/pCYaCm3/uri/jmsnlaUXniyyBi30KPzv+63JI1UGew==
X-Received: by 2002:a05:6214:2488:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6e46f8c85bemr61434776d6.29.1739405332114;
        Wed, 12 Feb 2025 16:08:52 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcedf28sm1032286d6.117.2025.02.12.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:08:51 -0800 (PST)
Message-ID: <67ad3813.0c0a0220.2d0734.0360@mx.google.com>
Date: Wed, 12 Feb 2025 16:08:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4824920213468899965=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] btdev: Broadcast EXT_ADV packets based on its interval
In-Reply-To: <20250212224444.508659-1-luiz.dentz@gmail.com>
References: <20250212224444.508659-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4824920213468899965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933394

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.60 seconds
BluezMake                     PASS      1550.74 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      159.60 seconds
CheckValgrind                 PASS      215.43 seconds
CheckSmatch                   WARNING   285.01 seconds
bluezmakeextell               PASS      98.44 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      871.70 seconds

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
emulator/btdev.c:450:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4824920213468899965==--
