Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4A1369AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040962; cv=none; b=VBc/tja8zZDhyJaR5R7/RurKhedW8/HnYJKJ5IEvT076o75u/zDx7bgPTCmXYT7HcSJI7G1nJ7cLDTf0ewfhzcHCaEgRutOj0OAu0deAbPgW69aSd3Ii320bQ6dWVGbCPIpD9y0Pk9ccNLGngaqXuDGFA+Y0o5mc0hJDsVEeCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040962; c=relaxed/simple;
	bh=QmIqArGqqUJ4PcikxmRi8WEt6vXBQYaraP8BnkfsHzk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tRlp34l48ZhP+LemcAPs63jVcvC6w8TeVdYHvJdh7lb/TvS3EZ0npAsy6ys61rayL03jNkV8BROCOBflxn/9Zj+sqiZihQSOM7wPGfE4ovJZ/eO+KTAzQAKY4O4bb93FAv8uIWm6wH6j6JoTj6jj7aLej/+yd5EVseiRQ0h8FvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntn4iNGX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntn4iNGX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-785d60ae6d5so90904785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040959; x=1708645759; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JVdbPqh1JHapTbx9llURbg9+KU8GqPgf9f5HREOYtgE=;
        b=Ntn4iNGXxkiWvZeAnmDVr4rYd2HPrQR1fs289Uefyfhcuyl9C2gcuun8aE8t/hi14K
         AvorDIWcJZTcXa2QVc73+17i78oVW4hExzpjZmmTsogC6R+CTdSzlKBz1HLSmpZ70onk
         8hq5fJRdoMM5Z0C0nqxJbVkbqCyJWYfAUIY5A6E/zJY2otx79d/Z8K5lHwxcNKAEnqpF
         N3uMmFuQBEBFBhCNLyX2RI9U/ZaMQK9QmCOp+rvMRgj9PICMGLk3CdNskeXM2Yo5YMoI
         Fzj/9foCe37448HsZbKe4RPOi4YTSbp4sgb1zyqasKdzAvmr2g6qZn3QlDfW2dz9qV95
         mdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040959; x=1708645759;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVdbPqh1JHapTbx9llURbg9+KU8GqPgf9f5HREOYtgE=;
        b=r9pNcYSg1Y8wjtmN8HEsotXr9fXx3LLO2BLW9tMl5idfEZGiJRhYcvOB+qE8nkjXM0
         ET3u1U61iiBb9gj0W4rTx4LKDFyfIc6JQzy6YWrYSjLCRJOm6TRo7pV4BUAPKKZ9t0jt
         EpbXbBxS1AjV4jQB7e8BhG/bsEUVJCQQfIzchb6CYHunhOidEUCpOHDMexP/+oElHlFI
         ElCeDXMzQu33u6ZZWDI6iaysYbl125kbavVvIqBK3rrIp1GF86hhZdGaydoVJVSaYwtp
         /aLRvo3SJ03yitFM2akQSPHbQ60rhG4ZuhXPbsl/6GUbtpQqhr/QAZ9iPHqbnSxri/5a
         TCzw==
X-Gm-Message-State: AOJu0YxpkY1s6wLGyS06f5Uo9UgRD9jJXfUvH86wcEKShVxUFf+OiLOp
	fcgfcoELKTQG8T9pyT00nrUot39e5GpuUrKxjzJI2T/yWNxXoRI4e/cK01KG
X-Google-Smtp-Source: AGHT+IEXRPeyVJkZOkA/9BzrqqsKZVOUSdy89c7GH6qyHSIF/WF5CmJ9CCMXwjWEiMtLJI1cc2eQJw==
X-Received: by 2002:a05:620a:2490:b0:785:b8b9:f0a6 with SMTP id i16-20020a05620a249000b00785b8b9f0a6mr3771080qkn.52.1708040959596;
        Thu, 15 Feb 2024 15:49:19 -0800 (PST)
Received: from [172.17.0.2] ([172.183.82.149])
        by smtp.gmail.com with ESMTPSA id e6-20020a05620a208600b007872e3b954bsm1026768qka.83.2024.02.15.15.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:49:19 -0800 (PST)
Message-ID: <65cea2ff.050a0220.1180.5a7c@mx.google.com>
Date: Thu, 15 Feb 2024 15:49:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0242267673238425961=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes on the bcast source
In-Reply-To: <20240215212356.310301-2-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0242267673238425961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826588

---Test result---

Test Summary:
CheckPatch                    PASS      3.09 seconds
GitLint                       PASS      2.02 seconds
BuildEll                      PASS      25.09 seconds
BluezMake                     PASS      769.14 seconds
MakeCheck                     PASS      12.12 seconds
MakeDistcheck                 PASS      172.80 seconds
CheckValgrind                 PASS      241.48 seconds
CheckSmatch                   PASS      347.73 seconds
bluezmakeextell               PASS      112.50 seconds
IncrementalBuild              PASS      5188.44 seconds
ScanBuild                     WARNING   1011.39 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1134:2: warning: Use of memory after it is freed
        DBG(bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1147:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1242:33: warning: Use of memory after it is freed
        for (entry = queue_get_entries(bap->state_cbs); entry;
                                       ^~~~~~~~~~~~~~
src/shared/bap.c:1281:8: warning: Use of memory after it is freed
        bap = bt_bap_ref_safe(bap);
              ^~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1699:3: warning: Use of memory after it is freed
                stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
5 warnings generated.



---
Regards,
Linux Bluetooth


--===============0242267673238425961==--
