Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8E3C819D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301761; cv=none; b=O01OEi8B6ZBF9eLy542Mm9OJSR21FC+61nUkE/Ad1F1Kg4SRFilR7j61I3wJeXVIE2hfiQaQA1MkK6jcaFuV4/SLbbrrz72U249r6jtO+LlsMh/+vSYPar2wDJVhd43i23gtvU986164eeahBtLubCgWfz6/eFoNtydX7qdE3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301761; c=relaxed/simple;
	bh=0Zq0rAi78QNEffkMd2lkqPWKp/rt1vsMEBKxHFyVCRs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QmyJ5BEiyTTT9ioMEDPJTZxu1XZ8yVXsZwmIuFZlKXqNzTnBDvoKRkEBeFS3BnjXZHL4WuEWvugvlxf3P+OFA/0x5uTS7tgky7e4HGusWDd7aJGh9Gh49X3Pj3O0+U0y/JvTZ6E4tafgg78S8ZLsOZHTnMflKGSKKadS44ekjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmZ94pmi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmZ94pmi"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-527e352a167so4408101cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787301759; x=1787906559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6mVNyfOHAClC+V9CB8bgPx1FWa2xxKDoaGuHX1Z/cwA=;
        b=AmZ94pmiXaaUXNJaHuxMLNcKKjokWBAcIiFg3z9svuV7M4U8+rPXSYLqO2Nt/4tAJz
         e/ivn/j5s7uk/l9X5kK72pAYRxalmsDeLn33JJ6xPJVZOLTfOdJGPLmG1LL6eVaUQQLp
         aXwLcFUteuPAVhIWbzdBHX8QeDq6g6fAHMt9VYMGw/EKyMu9+IoHQ28UuOv3qKbS4Ot8
         ELA+2G+X6n8C1aXoWkLrp9bFeTHjSxRcNT0GOtqGk2keWwluVsFP0QYRRPnX2wlo8lLj
         I+Z3JnXgXFz7q+kX0nn9h39xZWKPOW7sKmQjNhd4d0h/pbOHtU/fqjeedE+8mEx95E/O
         xq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301759; x=1787906559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6mVNyfOHAClC+V9CB8bgPx1FWa2xxKDoaGuHX1Z/cwA=;
        b=ptct3j9BQWm5nvgWjSnxDHiP2vC+/EjyY09WegT/sw0Pgw0oq00y+JEDtM9dQGJBzE
         1C7Zj3+sqxxCfEx9/4jRwJKbSZIwWAtq8auACunaJiABoW0Vz1IXmRpfjdXXAPtWVooj
         OuJGMj5134ZRj8uTVqsbauIcUw1Bn6MM677D9t9EaT6iDOqZ5ZwTUsD7qI+l/2MjBYtM
         mWFfddPqOg9k7hmmXFI+Di/b/UcrWqI4pc2JiSnEUuR3fznL49EsGDeQQeBaeKMeiJ3L
         fh7WRQ3MbzVbG6RLkAzLua+KBlnydfAWuzLFD2/Iuy128Yr5yWkiBFm2dwwj1qUPjRQU
         yGmg==
X-Gm-Message-State: AOJu0YyOrJx5FhP+vtnYFfwo+D7q0XN/2+xL9cl2moXfO2pEuoazbwIw
	GeeN5KVxt/3+O7MLpNlCnQR7kVbYMkgT7WbokOLDF7DJd0biVM6UEca4XeUeiXXv
X-Gm-Gg: AR+sD131L3pBClGL6ec2uBE4fgA3YOB0UcW/Ht1qymcv0CioCeCxrOWyTLBdmklqhtt
	H1P3gZcAAq2cZZMvQuMncVHrXXlWOi9lI3SM5+vGdzPnCHZB0ugktLCpvsxnNymJMv48KEToWNV
	DKGApJ/vANjwsCSwH3NArlzJ1Gn2h6azL3nZW0S4aDRnVyuO0wc7flz7L/njcF854xC7iJsF2ul
	wcIpDUOarEI57U0p2fh/lWHtxdw9Mxy1U4GrkotsUy3w3xAUXgwvZLYVjllCxYLqO5xhsdXTWjK
	YYSYMheU/UZw0aCX+PZTHl1Hpc6ni3/TUNaiFtxb9s6B182otzQgI1SpbQs9Xp/nG/c4ISNoqaR
	8LsDT0MbzNBBgmTBYz2U3uKjIef1XzELuTIWpOeBezy5/0UE4Y1PMO6c3eP9gk8OGkad2Ug2toT
	IdQCLYE5BMybEFp2eMUTR8pCSJt2EBT3SY4cR05NhWnN4IRmw5ifeuA1MRNtpU7F7YjKQ=
X-Received: by 2002:a05:620a:46a8:b0:937:3b26:c9e9 with SMTP id af79cd13be357-9373b26cad7mr225982085a.25.1787301759220;
        Fri, 21 Aug 2026 01:42:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.102.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937205998ddsm543633385a.44.2026.08.21.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:42:38 -0700 (PDT)
Message-ID: <6a880f7e.98ff5233.202ae9.c75f@mx.google.com>
Date: Fri, 21 Aug 2026 01:42:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4561152867967970837=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [v3] gatt-server: Fix integer overflow and 3 CI VLA wanings
In-Reply-To: <20260821073850.118299-1-zuohongsheng@kylinos.cn>
References: <20260821073850.118299-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4561152867967970837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149533

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       FAIL      0.32 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      575.47 seconds
MakeCheck                     PASS      1.09 seconds
MakeDistcheck                 PASS      154.83 seconds
CheckValgrind                 PASS      156.52 seconds
CheckSmatch                   PASS      307.18 seconds
bluezmakeextell               PASS      100.11 seconds
IncrementalBuild              PASS      579.53 seconds
ScanBuild                     PASS      952.04 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] gatt-server: Fix integer overflow and 3 CI VLA wanings

14: B1 Line exceeds max length (677>80): "2026-08-21T04:46:41.2241065Z src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used."


https://github.com/bluez/bluez/pull/2423

---
Regards,
Linux Bluetooth


--===============4561152867967970837==--
