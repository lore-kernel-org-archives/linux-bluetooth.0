Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86169489892
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847413; cv=none; b=I6Vw4gYoscC1yQs+OGTckOTnBRW8Xbg2lXCq5J/By3+N5NWZ7227DiWLxEUZ3hxtZyo9qX6mIwQaCvuhfxjpH+k7o5E7Q+EmW6kzBnyBQYnN93/+CTDAr10tY0xQxzP9nHTy0cmRWf3eJPoZnq/ynbbK6CEkhfI8ubVYcwZj8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847413; c=relaxed/simple;
	bh=pxeuRYQttfm2vbWjaksujUy7UqjSVHzbhWF9NiNGqvw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KFtode1/0uGsk7/A5PpVlu2AIUUs9kxTE5pKQuQTywnVqV2w34HoP7lY1HlFWPHHZ7vMsMSfu5zzpEKdWxWNbLxU9F61EMwrVGj8uv1cZ83kplE6ESo+OyzQhE0ZEvgYZu/HMP0PJBf02N8lkS1W86dFhxXpduPL2rwG2bWXhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDdvtvi7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDdvtvi7"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e57a753f9so863685a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847410; x=1788452210; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IaOZhGJJFVmMWm4PGrFHgcgcC9kSAmtAv2N4IWzI0QQ=;
        b=hDdvtvi7xoMhcf3Yn3F8In9wyY89hqbEzqVLdY0O2rrCDOfv1vL7/I0YTXLuy66lN/
         MQvlIWl/HJkVCcklN2HfZ7SV8XZhhWX5MBZ9iVMIkkiSwwN9hR6NQZznBSl547KeN4tQ
         3iyWsuG9IxJren8TRlH/wyk+6Y+WP0YdvJVbg3QJSwTlDu2frvYRBJpoprMqd0XcXHXH
         BNZTe2VpjtgszM9stDsulFKWfNZ14ZnIZqa3PJgbyheWMXHdoOx66uD2nZ0elesfdnu9
         /iGExL1K6J4FhdRRNxrqsoqndwQGBFylC9NLhzDjAY6JuoMw7rVVnGq1c4osrIizMBuG
         SpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847410; x=1788452210;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IaOZhGJJFVmMWm4PGrFHgcgcC9kSAmtAv2N4IWzI0QQ=;
        b=oIgRAZ52MztL8L7j6a+21EJLb3bMgqjvfOiASUGjNG3qKZ/RLcDrKiMHQg0PeJu6vZ
         2P86kvnkXpheu5eqsmp1KfPkqfL36abjR9h4sFLdJ1cTup9nWfVVGHbv3cV8mw2kLeml
         cB+raFv7s8iRJ1TkTPsue0CwEWk//WrbMovtPK3IPW4FmYBjXCsSUG5TJAkrYg+3WlBf
         rQ7k41gfjhf9IpkxfdorGMr0GXlbU5jIBUqEM8DNkNbN6FCw7ZSl8tm8yat1BEBHzI81
         v69n7Lpu0609jctZ+GJJQzGbmn0Z11yQ4CI+HopfAjXtQth1B1ur0FRTmyGCagC+2nI0
         bDcA==
X-Gm-Message-State: AFuF++lge+JnkLFDaKKH+s1EsB4F6AKLrE1r+zvphJq5q7q06QwNXWCD
	4V0stygWGdLxCNjXP/WQeuwTYMQm1RmDEj6vW9fgrO5klt+WIQ0H+A1V6m7+Ug==
X-Gm-Gg: AR+sD10EUjlWz0INNWORbYohlWgpl9ynsZQPzwWZRfnqwV/MnIMC8EMxI+kOZtDO7I6
	DN4A2ae+6I8anKZGtp6XPsf1MC2nAMPYySnOdBrJYOMkJEI3NigJ2HmOO9NuySyShNgdEAxqL6N
	whCbYq59vjnbrpSP/R8+/O1xOpGKZJI+7a6iYrnLRPS5ANOvxmZmGJN3lhyYjAMCXZjbvzSMgk8
	GE931/eZLr0shBEQPsnHigJjSWmaZ3dl0GNiw1qQPF2QdedvZcvSp4MLbNRhHhCDlnZpc0q1Bh3
	tFq7GvnkAU/gBydrabEvk7I/ga11io/Fu8/QLKUsoFcITy3DX268+Fe1DBTAdPlwJmPeoe6oFqW
	k+r97MiFtNg3CRSvSyDecxx3pGBFgqt5hG+ApJF+kJpqSF9v3GjI+A+ij6mcnYplDHrGcqpAE8V
	S6LGmtuOJdQ8oaMTTA1B1rDrmxETikXSmuJpPwsHp4lmjD4JO7aZegxL18PmTO+D1KG5RR
X-Received: by 2002:a05:620a:6404:b0:939:ded:aafc with SMTP id af79cd13be357-9390dedaed1mr348667585a.6.1787847410082;
        Thu, 27 Aug 2026 09:16:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e619db0sm483468885a.22.2026.08.27.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:16:49 -0700 (PDT)
Message-ID: <6a9062f1.5a609c75.c96ee.9bc3@mx.google.com>
Date: Thu, 27 Aug 2026 09:16:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6111940741824131203=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add ranging provider implementation
In-Reply-To: <20260827052034.1374180-2-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6111940741824131203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152414

---Test result---

Test Summary:
CheckPatch                    PASS      4.51 seconds
GitLint                       PASS      2.33 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      559.11 seconds
MakeCheck                     PASS      19.33 seconds
MakeDistcheck                 PASS      157.27 seconds
CheckValgrind                 PASS      224.20 seconds
CheckSmatch                   PASS      297.96 seconds
bluezmakeextell               PASS      96.31 seconds
IncrementalBuild              PASS      631.37 seconds
ScanBuild                     PASS      881.73 seconds



https://github.com/bluez/bluez/pull/2439

---
Regards,
Linux Bluetooth


--===============6111940741824131203==--
