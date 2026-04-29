Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150BF38CFF6
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485398; cv=none; b=F52arcHiYZ8VjHHLpbCRoiqFWXXhmRcPir5drQC4hGSYZ6axUdFKxjIdAq61LhfwI49AXi4kL8lnap+D1T62Hmq0zd0OOOKeVDPw4/LaUn954+hrmt2gktBnlZ2Y+y44y92ftelIxDbxXRGlHeJBYFFMfPOr2zdIEU0PQMl6uzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485398; c=relaxed/simple;
	bh=Mw2J1h1YCl0TWPIWoHyLqRuPBoJ720Nu7ZDk5AalqMY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C0zykXuWpudpcxni5Fr5omjf+6fc+nZ2gCH99oG8E2P8GsYzEX7THfB85WCkaOP5v44bhoY7iuZn4Qnopgyz4kykfI9dUrjUZj/6b6CEnoG7F1JbRQEmr5SQYRrsToN1iZLEDYM5OV9HB1U7Bg6L/9KDBJRPIO+UplZp3bCwqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFxyINAb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFxyINAb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ee7ffd738dso111337285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485396; x=1778090196; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rIwYB85fqSBGobME3eI3ZW3WztC9erXyopXAGZ9fBjk=;
        b=EFxyINAbProOyeg+oYTP8zcd5/Q4puoQy+xwqMhj10WnLHY8TZSirtfLcGfcEJ0Jze
         q6d04gTRbkKb/mMlJclkithA+azG22gdOULTu4ClDpQ8QawXXAJgwOuWWj3W1/vlrPVu
         EgcqKO3Je+qVa+wUGAuE/PL8yb8Hil8wSeL5ixD9oq4sD3A+ErAa+xViyVmZmJsFDBaB
         VuUkaYkMfPLjhP1qvb0HehR8hmQkyXod52ZmuzJxo32e53HFCOr055DuLbFTY7I0aE1h
         CIvweLCc1YOJeuPRgSQOG6ZVhf5ZqX+ncljbEKgku4jbc6/+2AfM5vOzW0/KPtqUW+j/
         Wz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485396; x=1778090196;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIwYB85fqSBGobME3eI3ZW3WztC9erXyopXAGZ9fBjk=;
        b=YddyPI/S9NDoOgByFG/Nz2Ag4JSCNKgO1WdzZ/t10ZPPgk9M48HJYdqHkXXakOusIU
         8IBRz8vy/QNyXVkehVNXJSrHh+vzoNW7lUNCYR15I9/6my3aTvDwXYPNJUugxAD2W3Ud
         OE3EwuQiqciHfUxx6q2WZKU5MA5PLSlWUWJXW1qtO9BIUU4SMDHae0dHPQpquHE0Lxls
         L/McNa3SPXGE6qB2EnjNAGhZc1PWNKc1BYvDUAF9Kl5YYMHGXb+Yj+rmj2V7XpekvqCl
         NTyTMLwWV9NARDbjeHVojacKuxYV3UvBcjrwhqjBcZ35z8zQU2PeEAPBeoZ9MxJdYoWm
         k5TA==
X-Gm-Message-State: AOJu0YwMNu2EXq1gio9mtKvWPXrGCl5j/G00IiNRFgI65bAQaM/rAsYZ
	U93m9EWU5Dyufxf6WxsCC4AEl5PIEKm8ELZN2zx/AuXVGtkCQt5FtFvVDUuOXH2j
X-Gm-Gg: AeBDiet6sYGf3sqg0Fh79+QylDaybjwtsatAtZnc0pE5Y5bvp/is6ZxQsPzMuJE/0Il
	HEYfnePfxE7dnjuU2EI7ra8E5kv6xTsICLnAwAAXcnsviOgRk/TOiAsygszWpVnPBcLXic3vezM
	RbBFyk8gSHTYCuOwoX3FnTnS8OToccALI4KkUGO2YdH+arWfgLV6Bm7CY+nyOne/I+MOWx/eB6K
	SWLk46llzGga5WKOmM2dQpJ+zscSCo6E9SoDBdWvyM17htDx2HiUkRulSOtkZTF9nDyPX5TCrl3
	XekldCkfIcwi26UwjakQ1m8CylBfSFahtRTd2RMOEM21eh14ewU86td3N4UTN4KWGmT9sA3hCR5
	C+fCE/b9wvGo1kGwQCXTOpYBdCBHEclicfEOpKui6TzV2wDUMcoQQpiLohgwSR6NsVgIoROa3E+
	v86q2mT0DJdnoSG94ict4OdIaXDHFKRA5yueKq9E2f
X-Received: by 2002:ae9:f712:0:b0:8f1:9e59:21fa with SMTP id af79cd13be357-8f91ec69735mr389998985a.5.1777485395769;
        Wed, 29 Apr 2026 10:56:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f94014bd1csm237892685a.43.2026.04.29.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:56:35 -0700 (PDT)
Message-ID: <69f24653.e90a0220.1b978e.1aa1@mx.google.com>
Date: Wed, 29 Apr 2026 10:56:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0602386573059067894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Add RAS Packet format and Notification support
In-Reply-To: <20260429152942.2940978-2-prathm@qti.qualcomm.com>
References: <20260429152942.2940978-2-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0602386573059067894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087593

---Test result---

Test Summary:
CheckPatch                    PASS      2.88 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      633.33 seconds
MakeCheck                     PASS      1.04 seconds
MakeDistcheck                 PASS      244.49 seconds
CheckValgrind                 PASS      221.27 seconds
CheckSmatch                   PASS      349.22 seconds
bluezmakeextell               PASS      180.63 seconds
IncrementalBuild              PASS      638.28 seconds
ScanBuild                     PASS      1025.08 seconds



https://github.com/bluez/bluez/pull/2085

---
Regards,
Linux Bluetooth


--===============0602386573059067894==--
