Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E34ADD84
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194044; cv=none; b=E1w6J/4GsrpbloLwbsa9c+SEQjO/mx1nx9qISe5DUaZfDFGAxM4bxnja8y7x+zfw4OwZWvxQVtmHimgT2RqmQBxMNDSUkrR/Wm6UkRauFYjiXlOyIUb4Aa2vD/FRyM1n8Wy1GhwHAzX7duFgAr+qvDtkMz2AKJ0+Yhf4a1xFb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194044; c=relaxed/simple;
	bh=NEskcmTT5zgcnOYbe2/fkgMmkj/u0wthJV4qFL+gq4o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iyF8ptBM2SkvwR3FiBHhALtD6hCWSMTP7nWHoPtiMpyswjliYzsT2scWYItZfCmcqwRF1eRbvDMzCLWEDn77L+Urrer2KE9KO3sZ4W/WsRIhoqeSswn+dIX7On3d3DKJGsMaO57PTBkSCAAVvfNbQ76ueal7/6Eb/+EYtqkuWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZeuJL+h; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZeuJL+h"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c8f9846c8so3977981c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194042; x=1779798842; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=02wg8zuiNGulxKecKJEpCCIs0AvyGeUJikctdjseqd0=;
        b=iZeuJL+hdCeoxJ3IcnMb1f8kKus6nzjMvQ+CLqByQgALt9xetDX68tJSUnGPMPu0CL
         cKdY+vsKhzRr0WmGp9hxYY6i+wZKiqprPfBWAyiyOD4Tf29MGxAc+/CoA13ufA/po7EE
         dBhN97ku2fU/P5PHy6jlEHjMyVffxVScFhw1T4A+DsypOkqMo1tz8ZnH31BAT5kHR36K
         s9pCGLgVPq+zidAOiiXzY5/TQdOI+FfMFVhbwbYCuFLgyerWJxtuKtd+D6Y0AVj6sJIn
         9D5G3eMH4CsDUkltWiyDFS8alcGWaZ0ABQ+C0UGFfNB1catpU2berg7oPzy5JSYI8dsm
         4Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194042; x=1779798842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02wg8zuiNGulxKecKJEpCCIs0AvyGeUJikctdjseqd0=;
        b=Lt8VMKMthRTspcdur9C0joJaKuhlvwDZQJBV0A+XSU1y7q8eB+mw1LOIL2dP4mE0HR
         HCezgWzPrRF8qhiG5t1E6yZYolAQqtmINGTV1GusaVnEvEie6O8WfxFrMfM3eOt2mw/b
         drJ0SCA0C8Ss0mz8OwKBp6RJuUgLsrwz7D4/qIfKt59VImcjPoSrfKfbj5QiWRze3cGn
         v0QBFX8cwMKu6BfLyWsoXoDgiSl1SIuo1S5bmUfjTmImf/6D/i7ovdWshcOhodpj6GO9
         8QBwpmD5EQkHk9hhueBPwmBKQmMu++2WYGTOcyEL0WU9MdedT3E/vWIPlvNawy/gdNNH
         EJdg==
X-Gm-Message-State: AOJu0Yw+a+ldKEVWmeKBOVUTfbONB3oOeQcfj6co6T6kj371o0xm3Wmz
	KZok6ajY3pbIG98f4bzLuSL7UzC4S2QNWuetHXRtrxAJPCmDFyQjl36FVkVOWA==
X-Gm-Gg: Acq92OEXwIzY3l+Z2rZRx6wHn/3v+QsfmqSm0CuOaBmW8GL/8AaircPUCnUB3MxSaIk
	7/8WHATLthVuIGtNsX8ArAj3KmqiEVudUfMGRfSQOoQK1rkeOwi29cYraRsKmiOAmdE+Lsgtcel
	OhOEO15PRa9ZqhsoHz9hsc29rf2S4P6l5Dl5YzOIc9O2QT5HgA9bhTUAhqLVKy/5rXaIOi/eKuw
	1vRaSGnva4ZpJK4JJ2vugz6Ee1wWL5cfdflnlma0DkFzFpQqduEaz+MJ5Etgv7DfHKF6QW8QWC+
	ds4LOFn+uVW9/8aWPSuNELX0eRjAWIxnr76keTw46537935xJNPJ+UDLES8OxEbFMtJuBNP3Qi2
	90LfiAq9deLSUUPuK84kt5ToJu9+81wcMzi45y5pwq+ZnpA2SIwjA5vr6s6prl/k9fxmHbTAd19
	O05J1ziuqMgRFqynVwY6tPQZYBY0LLVg==
X-Received: by 2002:a05:7022:31a:b0:128:e693:b61c with SMTP id a92af1059eb24-13504744146mr7934181c88.27.1779194042000;
        Tue, 19 May 2026 05:34:02 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351c3sm24899217c88.11.2026.05.19.05.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:34:01 -0700 (PDT)
Message-ID: <6a0c58b9.e877838e.202db1.7e68@mx.google.com>
Date: Tue, 19 May 2026 05:34:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8689090076837197222=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Add GAP extended advertising support
In-Reply-To: <20260519105519.226648-2-frederic.danis@collabora.com>
References: <20260519105519.226648-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8689090076837197222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097304

---Test result---

Test Summary:
CheckPatch                    FAIL      1.19 seconds
GitLint                       PASS      0.75 seconds
BuildEll                      PASS      21.12 seconds
BluezMake                     PASS      625.35 seconds
CheckSmatch                   WARNING   326.82 seconds
bluezmakeextell               PASS      164.98 seconds
IncrementalBuild              PASS      636.73 seconds
ScanBuild                     PASS      930.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/3] client/btpclient: refactor read-commands bitmap building
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#84: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#84: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14581674.patch total: 1 errors, 1 warnings, 255 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14581674.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
client/btpclient/gatt.c: note: in included file:./src/shared/btp.h:335:41: warning: array of flexible structures./src/shared/btp.h:340:55: warning: array of flexible structures./src/shared/btp.h:363:47: warning: array of flexible structures./src/shared/btp.h:392:42: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2137

---
Regards,
Linux Bluetooth


--===============8689090076837197222==--
