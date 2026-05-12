Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AA4C77B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580435; cv=none; b=aYjtmbb69c98VGMFyKYArpiXXAKAokLMPVyKGaV9K0qm+LLuyGYdCn84SXKHLcIR/+QvOOJFUi1EZh1zLjLbSSxXLeOPNCnvLt8x/ABroO99NcZfhieUOCjHM8NEuTAaWNYNYt8anIkUnZNi1u6zPCzJxG1L0ye0IlPnA+J0Oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580435; c=relaxed/simple;
	bh=JTcNqhPFBIMnS+NHh5qY06LfkNZmSaaAGgHkgtEVQOE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZqP8mIEfg7xrhBDUS2UiChzhsygdgF0f1o7hRuTGnB3q2eMfTNPYSOYjd1Za3r95xwd3LaNfYNvGhfED05uujUE7k9weYDOsGdq5rfn2K0rpG2kqxIOxGuKz1Hy/681/w336veuAjOtVtGcfWRrW9AbtAmGzda/yy30hD3kzIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6uazvsf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6uazvsf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8eea23d01f7so729672785a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778580432; x=1779185232; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=71iaHj2sR7UYW+3l9eHq5Rh1/wqVZwax74I85kpi0+g=;
        b=S6uazvsfFmBDjVU+ybUlbxdnDUgoOmr2Tf8jW/DS81WJpGoTvkS9cwVL01KC16O/2P
         uWEY2d0uWplyunxv1KVMfk1WFJfJz4cFRUEyMz8zqcDATgM5gLgNV2PsNZLEUBeFLuq3
         1Vouz7SY13wTg1kPCJg57HsmEMV27oKHrpWmFiRDDbq4LNSb1kwFpSDRvgi9oy3JqRPX
         voCjvnGhrnAgjkkEef3sb37nQ1BmcrwBAmbVfwUBxikoGU5p4cAUUP0QESyDmjZaA0WS
         sE8YOi0f9A/W00W+gkj7LhFYPc6JSvBktOF6xRPm5M7d3g3Cc4bddBB2HAdLh01wkmes
         wmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580432; x=1779185232;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71iaHj2sR7UYW+3l9eHq5Rh1/wqVZwax74I85kpi0+g=;
        b=ove6GRTr7ee+Uuq9q8mdXRASq9TO9c/M2h3/eZZb+2dizeqFT2gxfKw/SPD/l5lcoa
         ysDoKYwJo+0+eoTO1HwCfpBaRtAtejCbSuz2P0WblE6C6kie2vGyDypU4QsJGWQH0uSx
         EccCSa5JAT+3L+IC7TiUiralla0XJO3daHexNKd5KCod572mhj/9bhCmg4ze4c3Zfwmp
         EiXjNchMUXqJaqcWQD6FA67RY/jITe5w2i3RCvXuHBJxoE1fKG779pOEwAXTvZ+gZDjK
         1InVMlWg0aXkc9B4MvkOBqMOuSTxvmGPjgXb2Ydf2jISASBEbC5QDeyB2rfLsFgzBhbL
         09Dg==
X-Gm-Message-State: AOJu0YxmbZHNoUaSWASFgMDMWJoeTkrxZ6jQGbFTde5TFo96LgvblHGh
	rSWNT9+HrfwE1uSD3IL2daY2ve1cEIBF3X3p11vqygp2jVcxF2hJZBkZBv3KpA==
X-Gm-Gg: Acq92OGDNprEuORnAttW2s8wbsGKUR7jX17XgN7b8XLIGY/oUv4OevIxUFIivZi/S5u
	T0j5hegHQSFcDBdyC2dIsuouozXnkZav/2kH96YekvoRlXtugCIvmXKpomsZsqM2X9l8ix3M9Vp
	SV56nBcNgjhK4Bi2pc7u9iQx1+/VV4zfqeN8DacCLnp6xaaGTHeP83alSyZQVfqXu+Tu6il7H5A
	HJgiHZCmGtT7+pD/9p5HOYZ3jgfRzgp9tZpgX4T3WQbUGmPEPzuCV56fHjwH5/XfSp2OZ+Txb5A
	ACPJEh4hty+Cu1o3B7cYiNhSZpTL7yWGaHP9frkUp6PfdDyR3vgMnhcII0v3zQ5ZiahyyYKUnAM
	wd3FCu7Ht/XyjIUbzlb3zcXd1eiJhmE3+kVjCb1QJhimQahwk6gQZ9rOjqUqqE1qMl53MqdgQkN
	50sdeAZXAOjgY9maEC5rvHfKEqIjaoJYSyT+QNnPnBdro=
X-Received: by 2002:ac8:5d56:0:b0:50f:783f:3196 with SMTP id d75a77b69052e-514d20eadabmr32095481cf.33.1778580432193;
        Tue, 12 May 2026 03:07:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.157.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3d90sm112598461cf.20.2026.05.12.03.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:07:11 -0700 (PDT)
Message-ID: <6a02fbcf.050a0220.2e21b6.e1c7@mx.google.com>
Date: Tue, 12 May 2026 03:07:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2580850194372949436=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] pbap: Fix not checking Database Identifier length
In-Reply-To: <20260512083750.178053-1-frederic.danis@collabora.com>
References: <20260512083750.178053-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2580850194372949436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093372

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      605.42 seconds
CheckSmatch                   PASS      327.55 seconds
bluezmakeextell               PASS      166.87 seconds
IncrementalBuild              PASS      618.83 seconds
ScanBuild                     PASS      917.76 seconds



https://github.com/bluez/bluez/pull/2120

---
Regards,
Linux Bluetooth


--===============2580850194372949436==--
