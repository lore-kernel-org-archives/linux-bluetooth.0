Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2B36CA8A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848680; cv=none; b=Js+SgSEXUVRBLjq+C2fCldsvm6+Ey/dwF7sx781UKWv1KhgQfj/Gzuin+7ChokQAFPCRJi9yucZJgea/GhK44W1kWuqIUJcOfcAluH+aOAQm/i6GgscW6iY2nnvoS0R3epHCb8w4ic6qLyvVWkQy3tYumVi2yYkRSjcG6aqZbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848680; c=relaxed/simple;
	bh=NSYhMWXkwFuuMZLGgAF7wT0svC+OWcLfHjEYIjzoaaU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cBrTZ/QpfW84EO3YNQZP5Dfcrx4m7VKYWl/5siA9y43VPOCjP0n16t3BAktTF7TTJiVuz7KkqCtjJ3vsVTP15eEC8+MF4ZjTyx1GliHkVkoBj1zRZekQU96BhpiYjGD2fzt7aBcxZRvKPnBRpwxauxPArKjjOKjC4rNHv2I+YL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg+5uZT0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg+5uZT0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290deb0e643so11233435ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761848678; x=1762453478; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCvNGzLZDx846fV/4Li+xV09B1XmQQdRgJo1/l8vD04=;
        b=fg+5uZT0ODY7WXdIUghKzpEdjyZDLCTiejQW6BmeeavYh4VfJI7BZwZtbQUAb960ud
         iUtrSVbL+RcaJb6Aq1P1tEM2K/A9D6cPUbrj0HZB5fdczSbHnYDpqRnhbM9UXvPsB7fA
         /6Nf5vmtxm6G9usTHQLEPvCH0IIgr1J1GDu++LSnKrYlghKt2exXAc2dzARKKQlXKEQl
         LhRtGf3TpQZ16bQ7v1gZhu6oslX8N8UiR+KycMjeXgCdMDjIYmKOWYcOzAQk+UG1Z21g
         eAAFc8rQOYZgvAKWYtbMK80j+mUVUH+T9N2H59n27m4ABmAyCD8G4vcTk2FnCPXmqwWc
         6zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848678; x=1762453478;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCvNGzLZDx846fV/4Li+xV09B1XmQQdRgJo1/l8vD04=;
        b=Lyt640ClvmUGmf2nEl5E7+G4rzErGXRPIbzGPHP7i31YZnk/yYhS0I3qRItRh4nW/W
         jrsFivQQscbA/TA/1O9zsUE4FP0EXVVQJ55CppKxBfF8EYk/p8s9JJfxxN72X9dBCS3x
         xG7nlVTZt9+sp4+WuQtVpGBHK6BXKSR2yW2ahho3NPZyiT0oYK1ipzZ0okxuJhO3K7KP
         aDgxMXQIjQDFaxI9hKsBqKfcWEpTGe7GQGmIVTvqHT7OUC9wgmTa5cSCoQXJW+woeEGp
         lYFw+ibmVEF3wtlFCcIRK5pvzpQh+SEdrXAaR6s2micKbter1q0KdAtYtm7JDtQhMDoW
         J9Iw==
X-Gm-Message-State: AOJu0Yw6T5PODTq2kw4OU3t1m3JLTSLz4yZQq0aMc1xs1BZBJ7jLKppG
	ljsqVzPuEv6ZBSMUkrSAj5gkO9fJQ3mFNiYbMSizs3+00rxAuuGi6rOR23olgQ==
X-Gm-Gg: ASbGnctitHG6L33XoAhGDdfsbejE66gwdMtp9F7/3YT19u8FuFvzlbCSK0tWaGc5vey
	5iaAB5ZSRCpdlvwt4qD9bFKGqSiFt/sh3xO4Esh1NVCMRtNUit+C43d53RF1F353xnBVUZCm2c1
	Mw+NkUhk7Vtzhbt4DaqfhHsNnh7UJEJH6lG3H9hTedARDi7smv2wvR/oCNxay4DNRNN7NyH20N4
	vbPb7tLrXtLK+VaWVxUKSPrRZugAiMplhoPqVObB/0kN3LdDW4PpbgBt6M2SBwkUP5h8RbIXXhG
	bv14P5AjIYhddTolAwK/p64kPrTE8LQZkvAutntccoQfFNF2XwvR0GYwX2np5SbPphf9Vye1EWb
	yq89O3TqgtblMyfk/B+gw+5HIt9Q+3Et3GbU3a6OyeKTx1a5fQxf1ymbv1DIZAgBCxXRQ5yxK2v
	xqXt8w
X-Google-Smtp-Source: AGHT+IGGpLuRSEfnDg+UO+ms2a9/tMTgn/nniCA8ba2mx1yrpGIKzen6ufvSsoRymk15oD8WHOrarw==
X-Received: by 2002:a17:902:d481:b0:27b:defc:802d with SMTP id d9443c01a7336-2951a48f874mr9750665ad.28.1761848678102;
        Thu, 30 Oct 2025 11:24:38 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.138.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm193604405ad.21.2025.10.30.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:24:37 -0700 (PDT)
Message-ID: <6903ad65.170a0220.ba0ce.d256@mx.google.com>
Date: Thu, 30 Oct 2025 11:24:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1787623430407347636=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] bthost: Fix crash on bthost_past_set_info
In-Reply-To: <20251030170126.251566-1-luiz.dentz@gmail.com>
References: <20251030170126.251566-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1787623430407347636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017827

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      2601.24 seconds
MakeCheck                     PASS      20.41 seconds
MakeDistcheck                 PASS      186.43 seconds
CheckValgrind                 PASS      238.88 seconds
CheckSmatch                   WARNING   309.74 seconds
bluezmakeextell               PASS      129.07 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      911.10 seconds

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
emulator/bthost.c:699:28: warning: Variable length array is used.emulator/bthost.c:700:32: warning: Variable length array is used.emulator/bthost.c:917:28: warning: Variable length array is used.emulator/bthost.c:951:28: warning: Variable length array is used.emulator/bthost.c:952:32: warning: Variable length array is used.emulator/btdev.c:459:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1787623430407347636==--
