Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B39224B05
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007597; cv=none; b=dk0lSRwkgkJOEHmU5iBiPCX0GKZh9WxR1RL79wJBo0i15yc1alBh9GbVB9yM+fRrg2iPeD2RGOWfee5O4MU/hLM9EtfwrYrct3FMimFU311gMBoGvKEeTCZkUSVS80BkeOnE7Glh3FSqNvaymdN8YekLZs3edg3VN9+h4kLxtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007597; c=relaxed/simple;
	bh=zj2EyGFed60QKwABEI7rdKIRCFDnHh3WmKl6U2JRNZU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cYVN2GyIFi1ymQ1cwOLyz+7c8YPcdGgqd1u5SGFC3ye/ceitdHtsfEDRv2La40CgdZfpXhMEODGkTcfhO7WWbhmBL6lJA9/nch3l37pY76KGcSBpw8s4eaSooSuAV1qO+BnvZOU6JeyoSdZLZQ3L3X6UCnYodXLDl386l4uOuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG46C4kv; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG46C4kv"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a137692691so29026495ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766007595; x=1766612395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kP9H5UttRiRdR4pFt9vzDNxTAuQy/NoNY8asz/QSzfs=;
        b=NG46C4kvrlMmnnPvEOFgqK6rnu1hLAM/qWtCQQkpHJadIYSB9bANOEljrzJl9kZtLs
         gwFX2R686Efsb566Tf9NH/R/1EMj/13GzCWQ8/Ji5rQRc+aHWGMnS7GMtp3j0/RpLtEC
         UkLxruu9OFL2Yp4b6xAMsb/hqc79Bnt6LBXjiXhBW0/7BuqyQdkevI7mv0r07UF26XC4
         ICRS7/R5XQCAY0foP13hN4l1R52ZNfgffmqR/Qb0fwhOPU/mOtXinpc48HRsiQ1DSO1O
         QDWP3rdD5Q8uMVr4xkMs5jpoYJRM5AK3q6nuCLH9BctoKbfjYyb50mbF1arLzfCB0ewL
         Xozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766007595; x=1766612395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP9H5UttRiRdR4pFt9vzDNxTAuQy/NoNY8asz/QSzfs=;
        b=glJoMoJq7OXDYdM8TJAuPotITDfL9qyubhLDCwW+lsO5GnXmYjac5u2B6sZmp9JLET
         4gfR+y6JmrdBOr/aWi0sAo7aZFmvHzBKunJROaLpF3jCSHjqSqZQT4dmQlI05qbCBh4M
         XRToe0E4CQTKH6/9ONBwMDb/K5jrCnJtB3uSu4Ueb9k+hEE6a5xq0Dyg5t4wdlu/dgJ2
         kUTmPKIsMutuL0QTO/+A+5xvo6H83p/2RS/fwNSfF8xzHQNVTnRcMTmmRzEJ999yUcKN
         NkuZAGPj+E7cpm/Lm/jv0D7z66RGNOtCM/FDMjXhhOwf7oHotaNGtCWbplus4qPPDUz0
         bQHw==
X-Gm-Message-State: AOJu0YwKh32m/5Mjdg8CZ6o9Qe4eRyh1b6B4MKLoHHvHxIdWSfqU+70S
	ujhdvSKfzIhessBHziiMAjGWQjE68DbpK6Qbb24Unx2yE0qSg5LH6OliWX8FRsAG
X-Gm-Gg: AY/fxX7F9GgIm3WpS5WN+jmQsZVnX99zf2+/rBrTFGc6JFug5KVLubKlzYIrRu6eMXv
	mSmN1krQmNaamEwNu6xuwW3H8O2RApPu8a8kWZwLLz5xGJOkQ7NdTk1GfVcAuCHjS1d/HLP2BFl
	9LvYt2wAaGgUMhEH/DlkgMiRMCqzFK4zU4TnGGIZ5yR+bKqbIBuACWH24WdHQwFYY/cmlQwZC1R
	MHTQmlL9NrytcsfwmNednY7/4Gw4tVkLlhkkle/8kEmEkrvtt9szZywAg+44kIZfzbfb9bMgNL/
	ZA0MF2XxWx1YZMYGww2yGqcc3i1wvRqoOGl+RA2ujMYOUxeGCqOBEXYL3WeWvwGfpkUVy82dDK1
	EIWlbLaOVly5Ayg4CaymxPQYwCQayRqDj27fsAfzHIuwYBwwX1RYtKwcHSd89swE9mkN9d5p9tg
	HtvUzyn9ci5kuU5dXgYKo=
X-Google-Smtp-Source: AGHT+IF6+uNuej1pSwDt6VeeZR1lEyb+sJ+G81/kKxLMzMP/JzR2JQdLC5L7i9u/ztVudMwxjdKEcw==
X-Received: by 2002:a05:7300:5728:b0:2ab:ca55:b763 with SMTP id 5a478bee46e88-2ac30146959mr17094174eec.42.1766007594770;
        Wed, 17 Dec 2025 13:39:54 -0800 (PST)
Received: from [172.17.0.2] ([172.182.200.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b04e5c2e83sm442366eec.9.2025.12.17.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:39:54 -0800 (PST)
Message-ID: <6943232a.050a0220.2e1588.6e49@mx.google.com>
Date: Wed, 17 Dec 2025 13:39:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7853144773197060570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] emulator: Add support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE
In-Reply-To: <20251217204133.282359-1-luiz.dentz@gmail.com>
References: <20251217204133.282359-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7853144773197060570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034336

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      654.20 seconds
MakeCheck                     PASS      22.02 seconds
MakeDistcheck                 PASS      246.24 seconds
CheckValgrind                 PASS      304.13 seconds
CheckSmatch                   WARNING   353.48 seconds
bluezmakeextell               PASS      183.24 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      1034.54 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:470:29: warning: Variable length array is used.emulator/btdev.c:470:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7853144773197060570==--
