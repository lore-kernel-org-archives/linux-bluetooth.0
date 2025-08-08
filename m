Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2781DA3D
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677884; cv=none; b=sLWXHRMzp60lkRvazozuRUQtdetuqY/+iEkwCB+9KzAInwb7OnZlKNxyWHssDZEuaLTuHA5SaRmm4YXlCm7KRgG/vGo4Bs7T8Mdux01L9v+Fu1kt8fPML4NS5sJxoEglKu0FyKVUBrkxBdv+rcb2A6XmzlJpvvTSEOUwO1PJgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677884; c=relaxed/simple;
	bh=iOlCGwCo3rZlZpcsSFQBsRu0nInzEkJUvYD08RE5rUo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GYbHIiKh97ECbh2rR0kGag3Omtcv8s25U/3lJpYN3cL2aWs4OPJ2yUIGwhDjwGmmXxqd9YlEQewTYah9Cy80qFds+N61g/auldfzslGLmjn1t5bPT7v1bimbNDCkKHn7/vkfVJxTscMnfQt53SoVpGHltPUwI8n0O6tS15tdBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dV9EO9PL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV9EO9PL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e62773cab8so274856985a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754677881; x=1755282681; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUcQJ4WuwIk3vSjoSXxLXqeX0TZQomkTs+xG9LUv/E=;
        b=dV9EO9PLyTD4jTbr7jhnai9OceR6sJbosyRCLnhL6Epeu0vKnDfPGwkYbTx7LCzOnp
         be+/UP/hNMgbpHlYYMqHrzxW0mxKToNZg2A9xpalD4Y2hZkMrGZz3h298BdET7b2aiIl
         +SJ4pnLDrTQAvBUiSCA6WLOAWeTZ+cJERd9YCbiNkyyrcANM3QExriUakIi7ukm6Acqc
         BcPWjNwFsfkzwRLFInKQpricBCJ01Amsh/hHUO5sUxR7X379RBusj5CH3JA6oe+/VRmT
         3YmZQmTrbJOHgpzOx3ydnPKbcaYyn/a2WlVUIoLIE5RPM3wFgW99RXbpsY5Sj4tTOc2Q
         R2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754677881; x=1755282681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMUcQJ4WuwIk3vSjoSXxLXqeX0TZQomkTs+xG9LUv/E=;
        b=U3z+sbYxwt8WbfJUwuTFd+0pzoZUjEileEr92hdSkNmUG+0GvWtAY8roexRivGZKos
         u3hTdame4qjF5V5RblG/qEuuzEbIN1z6SX4r0uTwnh2BKZTvjzp1/1nSkX5KLVF4fEyQ
         IJBBrhoQyTdJuGINavBWxwEJjrGlWQirzswgs0oZwQCtjvIbcAF7KHDahtFUJMNRS5UZ
         TTR3AeO2l9SwMxyrCGny8LhWRuINo4AX9lY0PYg0+GsMg0PwwECcASjSznFZhkRZbYYs
         Fuz2JVL+QABmkQzbeSk3/hbne2GE5FfZpPp2phOpr33VLT7TN4WRI07Io49ajO7sF7aP
         q5og==
X-Gm-Message-State: AOJu0YyRQFCkBb+ts58B9XA06szKR4snNk7fETuQVoMiap1J0jLjHvuF
	zOgEfaQUdhigoXpp9qioB+Byj57mMxwiW53v9CmPBHx6GHfmrI0hOpjXSprnNQ==
X-Gm-Gg: ASbGnct9hSmSpEGA1dOela/kTReBG9MRBEiednADIXljlrmY2dbVCnL8ylA0qT0juPA
	ZWfNnk2TV7IVfWBs9Ah/bMcnX71K9K7YltegIHi5rtu5MDK41E6qS7fqreaWJfWoz0idIcI7kLn
	4zb0VGYI+eP3nrWDrpeq+sW+Mnvc2pKCFuFSb3L1o84CfBy80+agxbm4yMsxGjQdbfBwrJhtDbH
	K6mKZyAT8qCjqxI+Dlh4uc7eUcs+K/JwOB2CPal0CxVakOI+ntcpxHZNLqXZBrXpGtPlh/BZyBn
	3Y357KQ14mebsFWSATalWcPFDqk0zVdykmZcEnf0wSLB6nLw17R6u1VUleo35aEAMFLQ88Yt9V2
	LXQ4eOYq7GO2qreQhwkDQY9li4VY=
X-Google-Smtp-Source: AGHT+IFkAfsAdIxfi/AHrY0ZnQyMYxFl0Cb5+2DJ2yjeI+f52BvJsK5a2r9IhjALKd+O39G+v42Xmg==
X-Received: by 2002:a05:620a:3943:b0:7e3:404d:8dd9 with SMTP id af79cd13be357-7e82c673495mr525325685a.23.1754677881020;
        Fri, 08 Aug 2025 11:31:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.183.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e695e69ed5sm935125885a.46.2025.08.08.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:31:20 -0700 (PDT)
Message-ID: <68964278.050a0220.cd0d8.8a09@mx.google.com>
Date: Fri, 08 Aug 2025 11:31:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8148485544535802375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: lib/uuid: Do not use mixed-case letters in UUIDs
In-Reply-To: <20250808170630.202336-1-arkadiusz.bokowy@gmail.com>
References: <20250808170630.202336-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8148485544535802375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989478

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      19.92 seconds
BluezMake                     PASS      2632.49 seconds
MakeCheck                     PASS      20.07 seconds
MakeDistcheck                 PASS      188.20 seconds
CheckValgrind                 PASS      238.35 seconds
CheckSmatch                   PASS      306.96 seconds
bluezmakeextell               PASS      129.55 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      924.13 seconds

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


--===============8148485544535802375==--
