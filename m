Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6ED5803AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064537; cv=none; b=I1c8/c+XJF7/miKsgGIoUV+Knvs9atlCmhFCaC/QVylH9Xm2M5AnVPH0LFKGMR017OYoSFS78menjro9MsocO40Ng2RM/8oABTwcjtKu76sblyGbFDOV6nmKR6I78LbIFKoTP8XcwgMFgv/rteOttXO6opfuaH5zRFS6UxVZIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064537; c=relaxed/simple;
	bh=f4FQCRMPyulcn1a30FXgoaFUP40dNTP3EW9biAYt1jI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RF+n4MAyxF5Q1bs6DEbvwgYuWpccn80HvnNxVqtFt1QewBoCpYbRnRYTO4Ikh6Qv12XhMD65uG3U/snjLFy/zNxYfyQTA8E+dyEik3T42CXFbSM/h9srd2q0TLpfSTSRsRbWQWwomBg+SXX+gH8VSs1OuDWm0k7Lm3SDBe/7JBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7VeldIh; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VeldIh"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-47861ea0ce5so16462fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064534; x=1789669334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kc9JhE1/0tO7fr6+lWINZGQO0gIxwSxvu4BDAjQpo30=;
        b=J7VeldIh9dRhLytLhbZSEUr6T2XOGaWJKbr1IzkeHvqmVgl2yO0Y5B04WzJo1ThMv5
         iREIyfa0MMo5Nrk+23aq2mdIKZtNNzsYF0QHnTKtk5IuBIfzdBCUbTEmqcBGh4RPl46T
         sojj5ue6YS+xM+FADgsFHqWrwrp8+eE90HD0WI7UPlo8tmGBEJZjhFhTzogN+EPOcvQE
         HNfuyicOopnDk1Hzfj5SYnr5YtEYiomUdlc+oPO7thGqzT05bqY2iKFkHFl4YjvascVX
         zbtVOKOYZrQGUASnlt1jR64aXNPpdEeKT7ml4H+ufU1AacvfKVphO5Q8Wa6URG8qdFl1
         XTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064534; x=1789669334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kc9JhE1/0tO7fr6+lWINZGQO0gIxwSxvu4BDAjQpo30=;
        b=KRM7ctmp/s2mhg+znti4R+scwk/CbMrBBBscFgmvBKMGQZ2cRF2h3XtjLWwLDYMMiQ
         bFohTDoWRzOe5Teb2h1qfe3deAlMRrGgujvoNAEIBWCgUEfCipw3yYApvbXKaG2GUrlJ
         iX4+8PjCWKlUqnaYNMPmpwFAG/9aPf28G0K9OZXymFuBMhoupbRCe3qpWp6LCd7NOjVR
         V/zn56Wn0unto94t964snhGeWcB76IFpKzaljjQH4k1txJrxV4YlH82e+jMwjlgjsXaz
         QZH3welbpYM3AN/tWCHBliBFhTbzQxSrpVNak0GQowcxdXfXtFJTGVGU0Adwq5WhEl+r
         yAIQ==
X-Gm-Message-State: AFuF++k6/tW76dEucaIvMbim2UD3GiNPp0ltyNG8U6mdrrlRyAw0EoG8
	VOGQtpmNI6VQRb4EJC0qVbIZc1YeZ5M+l6C/4JTqUd2ohGYmjZDgwxgg6H7ldg==
X-Gm-Gg: AYBFou3oBFtZmH4mmp9MQvbOl1IsLA34pSNNatWg9RgFrvilPcCUO6ZcAb6OfBV/L9y
	UDpTIU5jc+fTzHl54OL2i+xL2xJZH4pQ4IUfU8pfThL4V+EtGdSDFYPL2qrlbPDo/GfCO7gqZ6C
	TI4/T482IgONYdngZOcyC6RikAKf8wRA9VodxVLNbU1an/TXsAXCufzD6g24rT62+q2qYSqwO9S
	ZQS31yrvbp4mdNRvnQnsZLdpsCRNVlSgDXMSX9HFS5iQd2LgVz2oBBpSRvCZ8xhlvKbhHASxr19
	7SHWu5WCPsf5qgrazGwXI+m4yIzKrHPULGZnXPYd3O/8OdO48v0YeElm7ZxxL5691D9l90WeLek
	AmlI8P0LtlQQwIqRIvy6/pocNWBb8A744PSV6M2lJUN0WUghxnufGKzKySxwR12xhOEXufqWgUk
	Z0WCFNYwqIZjZs/ymzPurK0Nm8UcTwaZvWEK2p0Vmt1N58bwugqvAhU9nZ+jMMSl4iP4o145b4D
	jZd
X-Received: by 2002:a05:6871:4715:b0:448:8bdd:8358 with SMTP id 586e51a60fabf-47de7e63690mr198975fac.15.1789064534496;
        Thu, 10 Sep 2026 11:22:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475541a7f37sm18178016fac.4.2026.09.10.11.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:22:13 -0700 (PDT)
Message-ID: <6aa2f555.a94c109a.36b556.e3d3@mx.google.com>
Date: Thu, 10 Sep 2026 11:22:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3992094274104901669=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Subject: RE: [BlueZ] obexd: Reference count the phonebook back-end setup and teardown
In-Reply-To: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
References: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3992094274104901669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1147292/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.47 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      17.93 seconds
BluezMake                     PASS      313.35 seconds
MakeCheck                     PASS      14.04 seconds
MakeDistcheck                 PASS      133.67 seconds
CheckValgrind                 PASS      221.90 seconds
CheckSmatch                   PASS      233.97 seconds
bluezmakeextell               PASS      87.32 seconds
IncrementalBuild              PASS      310.60 seconds
ScanBuild                     PASS      926.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] obexd: Reference count the phonebook back-end setup and teardown
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#202: FILE: obexd/plugins/phonebook.c:21:
+static unsigned int refcount = 0;

/github/workspace/src/patch/14753861.patch total: 1 errors, 0 warnings, 121 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14753861.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2509

---
Regards,
Linux Bluetooth


--===============3992094274104901669==--
