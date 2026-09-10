Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6957EDB0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064924; cv=none; b=TfFuOye4vEPfGT+TWrog9SfXPIDruRBu1zwl1yGhJSkhfM+fs03TrW0hjaN2ssDj1O8uWoBuO3UF6yCpa+iBvMFf+tU2QEPyW7jB07shzLt9q/FicLreaOX5uHJzlXuAKrBf91kIGsp6wSRWj2KQWaxBOgFdrhBALMouRfCtyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064924; c=relaxed/simple;
	bh=aHsimE8ZmjoNMx86ANCMawffhTSa4IStfVr967il7to=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r1qrgqhQI5whgc4QCAkUDcZeF8Pa8RlPlwyAOFb9op2y1jbhNsEVa7u3IHfQSEsUTmlXSRyJUzcuvZ7wPxzXAUwGiYb4vB0fUbsaKkNaDeadxPG/WmpyqVZVoXo1piVWuGUQO5TAhMA55ZLkbqudXK9uyuVc+AO/8WCAikhVq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suxkCT0u; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suxkCT0u"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso175250a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064909; x=1789669709; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=plxdebsFTK5C/WyULsSjSezYhmyMih0QusAgPRUgo/g=;
        b=suxkCT0uOkbwG2p4xQyc8mDkcsGqLp+IcrSYLhILz2oVo7q0s+8j4ctsiRSuin34Hd
         Mmu8bnXzXV+jopAuAKWs9/lnmGpMswhgzTIT1nyzyIm0iAI0GoHcnLmnAYM+Szu3QUc6
         2h1OfrutMQpi44xruGCKfiDfx+TrrK35S3LMZ3NN3WN8xaNdA8evb2i4XiKRSjjIHXPp
         aQJb+f6TpOJ5L2wRp/fXNKiw9auYXZ4/32dFLAdCdwlVe87NjDH5WHAKEEhSLrVlwMIC
         5TJBmgs0yvueCmYP0cbRm47XzQqaZVM9VosisAVUZfmAQ9f/m715IEHfCLaNai3765X5
         BV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064909; x=1789669709;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=plxdebsFTK5C/WyULsSjSezYhmyMih0QusAgPRUgo/g=;
        b=OJbWNuVoDq6Zjt1YMvtGzsEdoxlx9jdoV/ufE4+Yd0ND7jBDxeBdXCYTHnRPBC7Cvj
         WD+NdyPSgThmkSnNpFJ7JLgvfSFRjsarAh/1RPzPKYa7t5FVW9X3TpC9CRK+Rtyl6dGL
         SH3QtGJIH0LbfRT9iPMf9xbWW9kOPnuowB4Maztc95WFLwi5mHGRtxZd4HylDOxSHk3/
         hm44fv+27ikjlNauVh4BP8//APza/cuGwD/sx7cum5Jzoq+CJnxDGbF0UfEoTyIjvAZt
         ellOeg+KBC6zOfuag/ItkabMWyKK+nf57NBJuNivJGHoVQrXHUxMxwRL8C/lgw+INgk7
         aFhQ==
X-Gm-Message-State: AFuF++nQr33Cb3nuDR7VspuZFcximp9J8jXT8IOLbxSMNX46mhCNMKG3
	JajHk07Y0DynTTU5ghltCQWBq2GgIagm4lVBCXzj/kmGHyCsJU8j6YKtzQ5RNA==
X-Gm-Gg: AYBFou0vNCUULTzXGlADRrvTBDh5LlEzEZr911z7ygDGansFUKSSLB7MScqkYrCl8vg
	I2A28yOU7awSXqfVzG5XWzQ5u8cZel77kOu3U8+3B+I2rVT1S99YNuLFZhleUxOxpAC/l7WKrnR
	3qB4Dlb0RZzgrO/0wrgObhKHF3kMesqeGtUSYaZL/SVB1u+BKUL3YcEkvKHwN7DDDVo9rCY4Sfx
	k4DtOR0fWH0nhunVFr+mdap/KC2qk7toVzxAGa8IZrhd9Ld9RZ6xzaA8/EuTVlOZ7+gJXfRi/pR
	SxoaP8yz6cpx0cznA98PHvpE7/dx1EC8k/F0QHhP+8d65IKy+CxignkBu5b9tbWEwBqrZ/MS6gh
	9VviJod6vYysBRNexhfObZ0o0j3LCEDfTf/qJmsSQEyfc5z4t9z1E3Y/tU+WLK5virD04C9jnsJ
	PEvAVIiE2JNplvH4SEkCy/Em3NVe/Vigd01Jd+ohWiGpgKofAGemZwMyV7yC0vaL3/GAU2ivV9y
	Lowcg==
X-Received: by 2002:a05:6a21:6f88:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3daed2e2f72mr370004637.13.1789064908839;
        Thu, 10 Sep 2026 11:28:28 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.62.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm459867c88.7.2026.09.10.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:28:27 -0700 (PDT)
Message-ID: <6aa2f6cb.ee10049a.d1679.7982@mx.google.com>
Date: Thu, 10 Sep 2026 11:28:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4829221310683421716=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chad@allthenticate.com
Subject: RE: monitor: clamp max_len in print_packet
In-Reply-To: <20260814230419.2042327-1-chad@allthenticate.com>
References: <20260814230419.2042327-1-chad@allthenticate.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4829221310683421716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1146334/

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       FAIL      0.20 seconds
BuildEll                      PASS      19.78 seconds
BluezMake                     PASS      383.63 seconds
MakeCheck                     PASS      0.97 seconds
MakeDistcheck                 PASS      140.70 seconds
CheckValgrind                 PASS      146.12 seconds
CheckSmatch                   WARNING   294.82 seconds
bluezmakeextell               PASS      96.85 seconds
IncrementalBuild              PASS      387.73 seconds
ScanBuild                     PASS      1163.10 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
monitor: clamp max_len in print_packet

6: B3 Line contains hard tab characters (\t): "	char line[LINE_MAX], ts_str[96], pid_str[140];"
7: B3 Line contains hard tab characters (\t): "	int col = num_columns();"
8: B3 Line contains hard tab characters (\t): "	..."
9: B3 Line contains hard tab characters (\t): "	int max_len = col - len - extra_len - ts_len - 3;"
11: B3 Line contains hard tab characters (\t): "	if (max_len <= 0) {"
12: B3 Line contains hard tab characters (\t): "		extra = NULL;"
13: B3 Line contains hard tab characters (\t): "		max_len = col - len - ts_len - 3;"
14: B3 Line contains hard tab characters (\t): "	}"
16: B3 Line contains hard tab characters (\t): "	n = snprintf(line + pos, max_len + 1, "%s%s","
17: B3 Line contains hard tab characters (\t): "					label ? ": " : "", text);"
51: B3 Line contains hard tab characters (\t): "	cols   before   after"
52: B3 Line contains hard tab characters (\t): "	  10   abort    ok"
53: B3 Line contains hard tab characters (\t): "	  20   abort    ok"
54: B3 Line contains hard tab characters (\t): "	  40   abort    ok"
55: B3 Line contains hard tab characters (\t): "	  80   ok       ok"
56: B3 Line contains hard tab characters (\t): "	 200   ok       ok"
57: B3 Line contains hard tab characters (\t): "	2000   ok       ok"
58: B3 Line contains hard tab characters (\t): "	3000   abort    ok"
59: B3 Line contains hard tab characters (\t): "	5000   abort    ok"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2017:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2507

---
Regards,
Linux Bluetooth


--===============4829221310683421716==--
