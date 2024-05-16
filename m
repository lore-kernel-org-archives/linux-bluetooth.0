Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191D4A2C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878411; cv=none; b=rgdjlDv92SutyVQlEEvLfkiUe8Q7TNgQgk/xZTRl8x4wzu1rYFWDXhQldQtkMzQfUqiQZ7WtdTvxEqHWiiVk8VDub9N4eOJ0WGeUlZhvvYqStBtvs7bSjmZJkRzACPdt/1Oq9oGiykmHFvsB/ABlVzdoT/qpLBaVnL9RiYjR+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878411; c=relaxed/simple;
	bh=IQ8lRBjDRqaeUTlXAdF5vlkC7XW8WhL63+MgxwZzMDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xb86pc4dnooKbNldKh0ch31p+vfExcQKpJTC9LFp/u1G3pwhbb7mZYOaY3cRc6WiI+NxXf1ro7mjgMHf6gFQIsCllHPSQNQwXa62be2uHFEkENBIWtAO5l5ttrK1lX+zw2/BNJqKFhrpflwSQR6w2BcJnN357vXQFwic2j3NBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy5jJXuW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy5jJXuW"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so391695b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715878409; x=1716483209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XlFa81AWuYkukimynNYYVSMF3bi6PLOuCkQGVwNLbnY=;
        b=Xy5jJXuWaip9Wppr8gKhpCJ/t8hzzeTmUHGcqfBqU6uGURqz8GlTe+paMgWvm/e5Hr
         CFyvoDwKtqwpDhGuLr3B6mE3R2Bms7IQY1yxyr45e7dSW7kFktWpFdvpdZsZkH7REEXj
         k89+eLS8Qo1LvhQoxloXJ+2ZOfcOyHqJB6Pp/8Ql+abrECAom0FEi1x477AgyXAj2JzO
         bAVPwLIBgofRoYAab30BHlbMO21ZkTMA3SpSDsriuDh0oW7mhs9mp0fFS3lIBMzq3cTF
         aiQ/HjE+wDvx/KO/xtldvyE7cIU68IqwVvE6cs4KF8rC8je0IMmqziZw8Q6DXmzucEXG
         iPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878409; x=1716483209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlFa81AWuYkukimynNYYVSMF3bi6PLOuCkQGVwNLbnY=;
        b=TXNNUgK+gI3v6A89/nIz51XihkODkgSdvn8nJc/LJBMOjJwrbxS0lSM+iiArtWen1t
         Fq8UwEKJg0oay30CDUO6l6/X8ht7lbP3YSTln0hzH2Axvqs5Vhzl+uq2YbOZ7cPQ2kWh
         KnTt+vybA8korgtH20kv0B2cV+IaAgF6uzF0PM8M067kTEwsWfKipgh8cPej1Kym/XPB
         E1COvIZA4g00G76D5Gn9yzlwL2h+vHOkGcdz5xQ0guhAjkDxPeQGDnu/fKtKfpw+KSHP
         WubqtSq2I89Yg/7YjuqE+JnuqdvM8Hcf+M+qsPnKEtftyVc59aKA5DrYhAKdIc2Epc9V
         7OTA==
X-Gm-Message-State: AOJu0YxAhJPxpwvDtfNNaj95qNFO5BjdHmPaastrjc2qxwZKxoeSdL2a
	6a2LIWfTLrTR/uJwSrL7ZiO8+JPwjD5Z5Pl6GiK7VwQFN2vq6KKXF5dsDQ==
X-Google-Smtp-Source: AGHT+IFDHosFEmI2RgfUq66NMp+81NmUyi2go5nVUP8TrjXheGYhDysIrtZltNuMvVx5ufeTt1XJYQ==
X-Received: by 2002:a05:6a00:4645:b0:6ec:d76b:6fac with SMTP id d2e1a72fcca58-6f4e02ad046mr19235344b3a.12.1715878409411;
        Thu, 16 May 2024 09:53:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.152.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b300d9sm13274384b3a.215.2024.05.16.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 09:53:28 -0700 (PDT)
Message-ID: <66463a08.a70a0220.d9494.2633@mx.google.com>
Date: Thu, 16 May 2024 09:53:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5008004878417671003=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Create transports for matching BISes
In-Reply-To: <20240516130400.16713-2-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5008004878417671003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853706

---Test result---

Test Summary:
CheckPatch                    PASS      2.04 seconds
GitLint                       FAIL      1.62 seconds
BuildEll                      PASS      24.38 seconds
BluezMake                     PASS      1644.91 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      176.03 seconds
CheckValgrind                 PASS      246.87 seconds
CheckSmatch                   WARNING   350.27 seconds
bluezmakeextell               PASS      118.84 seconds
IncrementalBuild              PASS      9437.52 seconds
ScanBuild                     PASS      985.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v5,6/6] shared/bap: Add stream ops for get_location, get_dir and get_state

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v5,6/6] shared/bap: Add stream ops for get_location, get_dir and get_state"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============5008004878417671003==--
