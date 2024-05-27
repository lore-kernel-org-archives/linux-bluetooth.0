Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64513A89E
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804047; cv=none; b=Pz5H76Kx71p0iA5eSbmphorUVsxQoeqD0+OxGaMVU2GePEGjaxJMT31FESqT1Dopxh3SVgGXQMSNKhLq4HFoy5rGXXJMhDpZI6MNdl+UPaBaQqBz+uYFtIU3L/x3Di9B4DiIlMTVSLH7CmtuR9hbZjtMwub405tA4ndm8S27QDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804047; c=relaxed/simple;
	bh=8S37kB+mZpep6SbW6jTS1/XsmxaeswjXM6FsraTG+bk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KEBqa8Q2mCU9bXXshw5A73TWpDFzyIQLPSHUvAmVZfpKHY7BPUlj5xC3zAlustQGZ2x4a8z4Sl6Ub1JEKYgVlOYZdH97ejuSmSfVZuGVUa47iETPC7Ge1s2Thyf7TUKUaOmEgDQIAhMjQ+5jzYPsbjr/ccGv1PmP2KaEozDmYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuP6pnuL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuP6pnuL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43fbbd06e48so11145801cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716804045; x=1717408845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pr+4q0NpnN4tQZx6pYtn0vDc0FSzhY4RfOW2KTjNrHc=;
        b=NuP6pnuLhMhHPblh0XYsOOat/N90jcYPFJO/G5cQhm7aJ984uYQ04L3ElyqA7+LD7K
         q/ynKUjht/kgMMfNe26sLlKoJSSDDm9Wy0zkZweyg07jkMbyr2VFu9Uqb5hDEcCOa2VX
         ZBM7fcxlGlT12m8XUJjommd/0GH3gFcnFqDeO6gX7rUixjc4uEAwj9WGFSaOtg9xqgN8
         NFoTV5EovaugrCydIw02+Y2VC9BMRgrb5DJRg8KJ0Ug2X503MjlkX9mxRxG5qvFCLtR9
         wo3TnxQXx18HYtTntg7bHRF8nrWbjZqANQBCAZGjF1vYmBaR6b8XGxhx6wsoAvq359M2
         YIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716804045; x=1717408845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+4q0NpnN4tQZx6pYtn0vDc0FSzhY4RfOW2KTjNrHc=;
        b=XgEkJFUG2kvcXOwDcviqKLDGPypjFRY5awlFlgPgE/fDNsvx/mezCO/MpiAnMP73QS
         /AcDmyvXoWLainNhcMJOZR5f+Z9ybWGZ3XPtcnlgTUMQ35vShox2uomH8NadvSDYFDiM
         C1E8IZy21bj2rvTJR6t0AiHRduNufpnrMBHG9084CrQWAkb13GyoLWfg8DqmgXhaWHIi
         FliLkIUP9N3PSfA9LcduVqMu50LWrECn9H3RT5wqs2wYNraWV0NL/tXeTM/bQMAvb6Ko
         0/idb/PZAlkQpWwrtBJ30ShaDVpiL11Jg6z5Tp5wF5naOf4LWTAggpyGDGIK/F/r6J7E
         UdqQ==
X-Gm-Message-State: AOJu0YxHe+94o9ITXWcf/3F3/NNttMsL27OcmCV5LoN6AaA7AIKZ21wA
	S16R2+y3ZmV718fy7WGV2cEeqB4ys/Axaxxq/D0p23qyd+tZ31IFWdiqZw==
X-Google-Smtp-Source: AGHT+IEyZWy5NQmjvi3ZBSGYHIK8WQR7dW1v+RLed0wACYfBVZ/QO2ceg3NjIB+2G0VQqS1TtEFwZQ==
X-Received: by 2002:a05:622a:164e:b0:43b:173e:ce1b with SMTP id d75a77b69052e-43fa74df0a0mr193266871cf.32.1716804044961;
        Mon, 27 May 2024 03:00:44 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.135.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18c313fsm32577121cf.89.2024.05.27.03.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:00:44 -0700 (PDT)
Message-ID: <665459cc.050a0220.4c7cc.a915@mx.google.com>
Date: Mon, 27 May 2024 03:00:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3717775451843846402=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main: Simplify parse_config_string()
In-Reply-To: <20240527082730.967400-1-hadess@hadess.net>
References: <20240527082730.967400-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3717775451843846402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856060

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       FAIL      0.47 seconds
BuildEll                      PASS      24.03 seconds
BluezMake                     PASS      1611.55 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      172.83 seconds
CheckValgrind                 PASS      245.74 seconds
CheckSmatch                   PASS      346.67 seconds
bluezmakeextell               PASS      117.44 seconds
IncrementalBuild              PASS      1387.87 seconds
ScanBuild                     PASS      978.17 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] main: Simplify parse_config_string()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (108>80): "bluez-5.75/src/main.c:425:2: alloc_fn: Storage is returned from allocation function "g_key_file_get_string"."
16: B1 Line exceeds max length (132>80): "bluez-5.75/src/main.c:425:2: var_assign: Assigning: "tmp" = storage returned from "g_key_file_get_string(config, group, key, &err)"."
17: B1 Line exceeds max length (126>80): "bluez-5.75/src/main.c:433:2: noescape: Assuming resource "tmp" is not freed or pointed-to as ellipsis argument to "btd_debug"."
18: B1 Line exceeds max length (110>80): "bluez-5.75/src/main.c:440:2: leaked_storage: Variable "tmp" going out of scope leaks the storage it points to."
19: B3 Line contains hard tab characters (\t): "438|	}"
21: B3 Line contains hard tab characters (\t): "440|->	return true;"


---
Regards,
Linux Bluetooth


--===============3717775451843846402==--
