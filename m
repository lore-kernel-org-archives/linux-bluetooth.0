Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CB3E8C59
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316172; cv=none; b=OXkaiGJqKdKtFHOR4z90I7I8Tytq4dGgks+eRHV8OapytERuMIkWgOVaVNOcH4YUsFYzONDYecWID3GTcW7sGpaNxiMycH/SYk0JNd27vbTowR0TlCwmCgcFGL18ZgnEap4mNRIdFR4NwCVe9HkWIcyDiMdmwy4GiiWHnhFz8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316172; c=relaxed/simple;
	bh=souW28JC48P6STXp5Gyx2tO0RzGpzNp8xZqJg41MSH0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SEpB3IhVV5jl81uD4zrmEMpVNiYlNupE/q4pjxJxp/e1UtVEgoogsnYfuwog764jvkF9eL6ZhBsrUfEHYPfQLx6WbCRmYf0Eop4hAahtCHgC+zLNj3ExzGU675oBmhCqOPorJvNAux9iNIO3vo1Wj5HDXDssk5AKg+lQXBUOuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgqhoQlo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgqhoQlo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eae9229110so1413528885a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777316170; x=1777920970; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6pk6GoO+sj3CJwIjuMdFiomKAaV21gJQcxIDEBvccTw=;
        b=KgqhoQlohfk971LZMhtzA6ZPEPRjeQ10o5aGzUo1jgAbAbBXq0SPHxi0Omeo5QOvlV
         E2c/ol+NDliNndciD8Kne1hj+aRyj/XWNL9mAvVq7JDGBrOcMnjKil9PPMa6TNvKl7jk
         cc9dc8EbjsFRml1Qwp5czYRFJ0cEGi6zZqMQYwuSFecWRJsT6VZPmQmMqRoOZEmH2pEu
         cQadXTSGHB05zeiHyEK1m4tpDikmvUgm+qGPuhv9x7pHBI7W6ixSf7foT+t4Ab8XEULq
         DWC68o4xQnoTOkvcy576K9jIe89HcDvcybJJ9ej5MamW0Y2YQxBUzMnYCAF9SNJlxDfl
         fDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777316170; x=1777920970;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pk6GoO+sj3CJwIjuMdFiomKAaV21gJQcxIDEBvccTw=;
        b=lIgyB0DbYRDUiOEn3Gyi7UeATlSibsDQTG2cmzXXzlPz0mm4o9Nbs2L/Xi//vtpAoB
         zvQsbFfxZjEppx0gx6wtJovVSnxkLs48EHgc1pyWUPFJijZFD8tqD0UZjguhYYo05Uo0
         N0smWv1ticxF+06FR9lGtkaCI+U1LCLTwFuBNJDBer3PWXF1norO7f7UacWVTPn56Ut3
         J2tKIKw34UsltZIh5EUz/ia8BMmaZOyFKFo6LZ2sRC8v++h6q3c64B64ivLUNVj+zA1q
         0JgGZQa5uMsj422aY53UF9EGkZgmx37WmSB8kgpqr1bI6IHHAGmeuXvV8yp0aM9WUuqa
         7zXA==
X-Gm-Message-State: AOJu0YzERIV+C9Gsuxgm31sEzyBo0UpThS2nFguCYfZmo6VV6PMRGBWl
	1ikW7zKR0Q86aG9doA6Txok/AyEqO05lc2c27i+Qo7mW0rY85qQ8D2eNKaaltg==
X-Gm-Gg: AeBDiev/66i3dDSjhgaqR2bjNJjfzxpKhka+Y3eQBgJZpY9lGERQnwiZplPL+IRKK6J
	10pDxqMjnOqJQQHVFgROSbPANKzHGFHAVHNbSPuiwo4n3ZWJoRZbCjUAof2FofT5QUY+XzhxrGw
	fv1N/AjCApxVWR+KqqcG+WkCsnfqdt164daeR10HdBpUKaubRwm+Igi0UQZ9YTz35wI19lm7WsW
	T7bdcYMdam9n+aNeWdSUVVtWwy8waZbD0+7uYXdik6Z/MBebSSljC4KIgBsJQ4DxNmKMVj2ziC0
	m6s8/ODDqGI+xtY65wpZL0LCgf7MGbeEyLXM2WdIBjlJfoq1dchFqeJ6b+TOnaI86IhhncIsJhv
	zVeyW4frkPNeH3o4EmPF4jx1dtyNBuliPLwS9Iago5qkESQJbz9gKni0JBeTzrjPrFPYrZ/0w6F
	S/u/IOgWt2CxeLTuu54I9VxxV2wZZ+guNCZozi9JYF
X-Received: by 2002:a05:620a:2a11:b0:8cf:d953:b4ee with SMTP id af79cd13be357-8f7b2fd82f9mr60018785a.15.1777316169607;
        Mon, 27 Apr 2026 11:56:09 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.117.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c49c0987sm9784185a.4.2026.04.27.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:56:09 -0700 (PDT)
Message-ID: <69efb149.050a0220.160a1a.60fa@mx.google.com>
Date: Mon, 27 Apr 2026 11:56:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7521202464938973619=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add ability to desynchronized transports for PTS tests
In-Reply-To: <20260427172056.148115-2-frederic.danis@collabora.com>
References: <20260427172056.148115-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7521202464938973619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086318

---Test result---

Test Summary:
CheckPatch                    FAIL      1.69 seconds
GitLint                       PASS      1.04 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      658.00 seconds
MakeCheck                     PASS      19.23 seconds
MakeDistcheck                 PASS      248.35 seconds
CheckValgrind                 PASS      297.60 seconds
CheckSmatch                   PASS      349.62 seconds
bluezmakeextell               PASS      181.86 seconds
IncrementalBuild              PASS      647.13 seconds
ScanBuild                     PASS      1011.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/3] doc: Add documentation for CIS transport Desynchronized property
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#73: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#73: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14541954.patch total: 1 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14541954.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2077

---
Regards,
Linux Bluetooth


--===============7521202464938973619==--
