Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714683D47A0
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872114; cv=none; b=hny3LdaTExkLaWpaiOy/oE9oJB43mNhX7eYRJRaEW4WUce81DNlElIzauelyDk2+RLam99GPij1lT1kVku0U4SI8bZ21qdTtvCQ6VDANQlhWqMhK0jfHuUdQ/VF55WtBe+aZYtTSIvXV/3nvGtSAKYP+cjF13zufwC9FrkUlkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872114; c=relaxed/simple;
	bh=LHUOkZx56ZUuWZPjI/PAepWrafzNVo5ZjH3GaDYjrYo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BKug+Z9AsVMI0RFsIzuCQO9uwzzAlzsHdB11vrgXrsIPNHyjSqtpe9Z3419UWm8mfu9gZ3YQsAOutveO1xpAzyA/zEHDtYNqnrO44ZUXnJCFsvTFXVQ7Peb5rHcFa88Ut1L9Tejhhi47rR0dagNfYsgrsHdR9JmI7WWLyKCh9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijOr5NEh; arc=none smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijOr5NEh"
Received: by mail-oo2-f34.google.com with SMTP id 46e09a7af769-821c01c2fc5so681177a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872112; x=1791476912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fkL0E6uz3kYrHOYimERlEvqo+Aja2qrriuGb2RjT874=;
        b=ijOr5NEhSzDv8fEJGUTxbliX//kmX3od9vM2NIsXvGxX1lNFiXBLQmwhSb0KJ6pP7Z
         WnuCcOUtUXZ2Haj61EFndbAuEdVPmTJZBrFn+a/oySXYCVTKUsIggfFtaywImtKc+X8t
         9aK40q/I2fOuZ5DcD9M1mlDfTZM/2QBC7coeA0NBFQIPbiw3rdS/rGI8oaZwq1O8GqAf
         j37oo+aCfByCk2+tDrQYKjLGWdllCB+y6st9bugqX/1gVzUoxVCROGlVaePCm7Ysxf50
         ZHxaMC+fC6Jwuif2Ck9+aaHC1rgb59dHsjkPnk9BWg/CsGJAz69guNAHiqJ884Hj2ryr
         6NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872112; x=1791476912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fkL0E6uz3kYrHOYimERlEvqo+Aja2qrriuGb2RjT874=;
        b=JbzVzKdMl3LEbupszGUmZ6MYOeT8uXkUEO9AMD9c+RgYQ5IB/3r1xHpcmf+dVivJGS
         tJtpBaKqhSuYrQ8oDcVZZivm+PzIX3LB7orHpvPyGv1jz6M2uEP44er2aw+o2vvMYZLB
         o5wESjAbivdd6y8ltV6ypCpG7QJSSel2GGIbe+s8DMPJkMxfPKQo6EfMzJHQMzsfv2jZ
         NCJlvHXURyqP89DZ30n2Wejcv04VPpW3HifdSndIcJ7Ewz9REJ4rAIDc78j9cYS6vZqA
         P4qL+1zyCaDjKuWHZ0TqaBbSrJz71vz2TYSDYJtiE4wDUuvhdz5ZgVnkfLlqu8AxlEYG
         TIvQ==
X-Gm-Message-State: AFuF++lGfbMfjv7oxA6QXFUDN/Bf+qxzgltV9M6cmtmGoZu23EWMgxUf
	lzuMX1k5CfaK9/ldzBJBliBu1IDZcmjQgQSEeULsI2Hl2UdMH+i04Mo9iOGr3w==
X-Gm-Gg: AYBFou17iQEXQ4TcVunwtA0T9dwcvGSIx8JiUDw4/R1nNtKqxOMBz8SpE9SICYvMSjZ
	PMPNedZuk36Oa5MD8d6hD5UDlGTfAYITyn6TU7rSUW3SB30oH9Uqq0ET8k0dLSh/MOZEQINnzOF
	dxaQuSXKHDT6vPeuU/YeGfDXGX5Eo/xR6s48zmWi6B+TeFhvhywgGV7/sVs6o4FVm1/pV9a1Mlw
	N1T8spZkiqcK+GgXfJWam2uKbJKjn/+D03DmPpZ4Jj9NYJ05WYrWugVkW8zKVau9oDCe5MXYsaz
	s/Pjq3eKjtgM3fKPgEdFxkLNXcWjJb5KMUCm89DNaYvvtZH+iFINdZDXrL0/YhMbZxhfPNCC1Sz
	dfQyCx7MJKWbK4qR/5ZelAwpHvKC7Hehv9EhfvU95DozHWxzrSDVuZvVubJddHkxSRs44kB8nht
	OqbRyl0t+cMWKRoln+xEx1/Cmp4I85KbF+73PnLTMkZKLzrBtvnnhW6oqaay8KeOavUnH6Mi/XT
	ncEiA==
X-Received: by 2002:a4a:e913:0:b0:6da:453d:7cd4 with SMTP id 006d021491bc7-6dcf4c6ad1fmr5171700eaf.23.1790872112044;
        Thu, 01 Oct 2026 09:28:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.22.237])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd97aff835sm3078670eaf.6.2026.10.01.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:28:31 -0700 (PDT)
Message-ID: <6abe8a2f.42bc1fc1.55617.2ac0@mx.google.com>
Date: Thu, 01 Oct 2026 09:28:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6562347528243998640=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] doc: Add commit message guidelines for AI coding assistants
In-Reply-To: <20261001151054.2422165-1-luiz.dentz@gmail.com>
References: <20261001151054.2422165-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6562347528243998640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1177764/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       PASS      0.83 seconds
BuildEll                      PASS      13.41 seconds
BluezMake                     PASS      234.91 seconds
MakeCheck                     PASS      13.12 seconds
MakeDistcheck                 PASS      104.58 seconds
CheckValgrind                 PASS      160.10 seconds
CheckSmatch                   PASS      167.39 seconds
bluezmakeextell               PASS      62.04 seconds
TestFunctional                PASS      808.73 seconds
IncrementalBuild              PASS      234.15 seconds
ScanBuild                     PASS      661.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/3] doc: Add commit message guidelines for AI coding assistants
WARNING:BAD_SIGN_OFF: Do not use whitespace before Assisted-by:
#117: FILE: doc/coding-assistants.rst:47:
   Assisted-by: Claude:claude-3-opus coccinelle sparse

/home/runner/work/bluez/bluez/src/patch/14861431.patch total: 0 errors, 1 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14861431.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2619

---
Regards,
Linux Bluetooth


--===============6562347528243998640==--
