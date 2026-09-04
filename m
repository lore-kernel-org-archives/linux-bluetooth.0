Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606E34A797
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552808; cv=none; b=epQv5PdtZxQl05PG+Qe2Rv8MQILHxA8nNz/pSXCRYPkTEBLT6ClgffEXxF/yw1HfQqzuTe+BADq9vLa0LZGdKXc0Jzx0vm+p9PuFSpzYBnC5FOlIV/JtBz6bZhO3/B9Jznf8oOwGXaZqbkRgfDJz8hfnrVJa67MBf1sNZ64WsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552808; c=relaxed/simple;
	bh=lM60QM2S4ElX3XwXV1LsN1UHuqAdmwU45OTLMF/ez3g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rLy0XQv241ox370GkR6IcIKnn3Hy8M6xnhWmjKKDtS9KQD2RBRNC6Oa9XNB8DM6RjQWbLD/uIr+nUEjCXtybzmkJxGEaDEQBTJehYRAf0dF8JbIQNY0YgU/DgSw/ocEQuFs2m2VNGF7uDgiUgyxVb6GLfBBiP0DSljQxJgECEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahl0rC7X; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahl0rC7X"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1b233ca8dso845558eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788552795; x=1789157595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rAL1OEOSfXaTpKXWnhHhhEFY829IvY70FChVzZ/V+x8=;
        b=Ahl0rC7Xs1GT7D50C438dUIxsR/cHnfHXXSbCBcKwzNJIbN5EKq14D9fXfkQEwXyDU
         CcLtcs2cwhQtRewN5ITX9rgSz2mIcSR4es1C2rbKy9sZazqqwbYm5yVNLPErO4RI4dzI
         FbDCubIwvpztg2BnTjHyOXKRbymnFWFSZoqhBmfT/YcklsQut39RANIPZT2Mt7GTUTJF
         au+G9BAlBI+tQT076U+VEzCHmn4mE0r3eU89pjvUnvvXcVasYypovwRGpoEWm//uh2ba
         58mGH9fSgsgyogOnI1ydydNr+PlZMcOJE7zEr02sDDk1RWpxO1O+w3G9UqmUMvTpQv16
         FmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788552795; x=1789157595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rAL1OEOSfXaTpKXWnhHhhEFY829IvY70FChVzZ/V+x8=;
        b=IEqSQGMFCxDy+kuA/Tv6B91it9J+KDo/wUibysJtLr99N4D60v/T59Lbh2JDAtBS+L
         13vhvIu58B5OWd4Oog7JYlzCnjxRVmHqnbo1yYTzwTqBneLR8EsdkGE1e+AviW4uQ30J
         NOxFGueTK2UuWigvmeUjU9Ko8hFs/fwNHGAwWAenN9RxUX1J0eAenp2HTNxN0Zy2XUVj
         GpytzzHfE6ZBxDaibGEoMMEk906LXGb4HxOnGiD3EuX5rS3wdfVBXxWSZYKtB/3b9SA5
         FwJLnj/i3Baqz+rMDQ+5/nFTGfATyZI2Nvr1kq42wn/TTMvDumUhrsk/ehOSN53LhVkE
         E5bg==
X-Gm-Message-State: AFuF++lO0D8AIHE/faugJL4tTBBApfeAzlajFrAIEcC7NbcKP9Ahgap+
	jGrAJuYopgzWC0s/s/ZoKaAmoPaHEE5AKnT5VY31lf61wvhhlPGNPbOcLBLLBg==
X-Gm-Gg: AYBFou3cOxDHMADueAoAGPptdCSvXtkr74Yowg232zouDA+bvttXi0PvmiAJ1L+vDQ0
	Cn6k19wBb+ZJDnQm3ECm0gCjhjj8k3euuhHm1OlDZUdr255to7h0eIQgDpT2obvNoqnR+Cqeq+x
	qoIXU9CIZl/1HVjhf3XSwU+qc8Epe3E/ZNJ2haD1mwKelUUVF2haHX25Z7VMVqVia3uo9+D/P71
	Q6+TxRih1qlrSfesNeiPiCiphPtVJhP4hTE8pHUUKkkp11SGkpoO3A3ic0vB6eIQL4tPnr027ph
	+H6v9wL/AtMgJuBn8HqDh1aNQKvQ/QpsUtZcPcVfV3V0B7OnZEggtzzF3mIkQgjrjigEk2YK6Mm
	H3I2l26Xle7kbyxsaI8Nbj2ZP9AYNfY+ANdIQjIr9QrUDyPUUvbkFLBqnU1keFliU/n8omwZL3I
	FOTS/rT7WerfYs+STCfu+CklQJ9fV+1GWuJFcsprNkaUsatBiuVCGf5Uj3kokyXGEWEL8Ccg==
X-Received: by 2002:a05:6820:a291:20b0:6b7:1f06:5b42 with SMTP id 006d021491bc7-6b71f065cc9mr4003843eaf.3.1788552794985;
        Fri, 04 Sep 2026 13:13:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.158.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243a9388sm8459110c88.10.2026.09.04.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 13:13:14 -0700 (PDT)
Message-ID: <6a9b265a.7eadad10.3238c.1722@mx.google.com>
Date: Fri, 04 Sep 2026 13:13:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1890827771013603118=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
In-Reply-To: <20260904182833.59624-1-proxy-alt@proxy-alt.dev>
References: <20260904182833.59624-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1890827771013603118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158295

---Test result---

Test Summary:
CheckPatch                    FAIL      0.48 seconds
GitLint                       FAIL      0.25 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      549.72 seconds
MakeCheck                     PASS      1.08 seconds
MakeDistcheck                 FAIL      127.88 seconds
CheckValgrind                 PASS      151.27 seconds
CheckSmatch                   PASS      297.92 seconds
bluezmakeextell               PASS      96.93 seconds
IncrementalBuild              PASS      562.30 seconds
ScanBuild                     PASS      878.13 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#251: FILE: src/shared/gatt-client.c:850:
+				queue_push_tail(root_client(client)->unverified_ccc,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#270: FILE: src/shared/gatt-client.c:1820:
+							!notify_data->callback) {

/github/workspace/src/patch/14792115.patch total: 0 errors, 2 warnings, 255 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14792115.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it

1: T1 Title exceeds max length (84>80): "[BlueZ,v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it"
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../test-driver: line 107: 53187 Aborted                 (core dumped) "$@" > $log_file 2>&1
../../test-driver: line 107: 53223 Aborted                 (core dumped) "$@" > $log_file 2>&1
../../test-driver: line 107: 53503 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[4]: *** [Makefile:10413: test-suite.log] Error 1
make[3]: *** [Makefile:10521: check-TESTS] Error 2
make[2]: *** [Makefile:11006: check-am] Error 2
make[1]: *** [Makefile:11008: check] Error 2
make: *** [Makefile:10929: distcheck] Error 1


https://github.com/bluez/bluez/pull/2493

---
Regards,
Linux Bluetooth


--===============1890827771013603118==--
