Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC77205E30
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713631047; cv=none; b=jh4t7pyceIROYaLW/EzP6BLRni3GvlYjJTePJ58Vi81ONU+uhX+J/g8wsmdlYMKoCFBvxMIYG3C9JkiwSUX0RmE64xMqriwAhl2vYRQOzprCYIbJaZF0ZwOfMRTNp9VMcccxtpugWgp1YF1CV/h8AD9f1kjpLkwqmvtrhvzzHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713631047; c=relaxed/simple;
	bh=tDzq1jPkfqFlXIVJF2y/fG11pAnPnIbZxh+zVbMgRyE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wq0k6gd50BrIxwx7W82Ict80O29/Ni9DwAjcEskm3g63ycGu2K+CAooht7ji6jomW/9lTVHx00XZE+QQuzbPy35Y8f0qjRhNbgMbJMpHmgRiLa0MHNXRovuYcQf3RJLZIngKrep3Fe8DZC7LzBoxOH2CB9QXdlsq5HvLDhPVfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNzuuWUo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNzuuWUo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5715a9ebdso25699265ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713631045; x=1714235845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5rYLbumMhfxdEfcAoOGdgWgl41QmTS3IrAjqW7S0pTg=;
        b=fNzuuWUouadoHTggQSQRNecQ8gm5wZWyfKMQgMddToOP0+EY8/bHIZLP65cypAHNPn
         OuAsjq57A+6Lhqc/L+w8Jz/Y/krOKGFidWPUEj7/Knl6j1Vtyzr6eC3wwMNRWS5kLhEH
         Lg3N/tRbR/8h4gKfS7SopVjlLVN1ylOOMRXi0QZU2WkSS5xF9082GQQTWs+mHyjPp+G+
         QciXip2aCI4kTHFX5SjPdovAOeDEJeXdh/F30cYSLuzbdf9zXDFQFkqCM7vCJ12QjpYn
         2Ey+wdNjKp3qk4JYsZu/d4aocu/GeriB1piDz3Dbyft8xBjgV9ypc2bzdBnYFkgaKgnE
         D8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713631045; x=1714235845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rYLbumMhfxdEfcAoOGdgWgl41QmTS3IrAjqW7S0pTg=;
        b=M1XTm5Sfnrs3UPw35IYHUsDCpvmFRMc3axcXLkr8O5c6qXNVj7KyFM93JI4M1zEr/B
         uTDtL72zWC9N/cp82CqYwrAYL3xEnslHxFV3vRZZ14qPA4RSp3pYPwcXezKkPHHBrsvu
         HBLmpfKXJ3Q0HUE4unfD9UeO9G6K04ll43OAcjn/VxqdrleplvnbbMtmAQhUslSjcVBZ
         aE1lZ0t252/zoA0dFIsviU+vCsLZYQjhhhNQpYx9Q6Xq90F60jOzmGgVcuGsF7/XnANe
         7DPzWBS47W7rf5+xLjkTGW5S5ODn28fNIalpsTEraMdfNSlyzQZKYyzuioifQpJhxruN
         jHWw==
X-Gm-Message-State: AOJu0YzDyuu9bAN5JpkcWerJZmGZVK4pgk65YKUD0TOlZGnuNor8Lpc5
	HcaiJ54dGHnFgvFpXvuWIab/PYJ9dR8oosqjFvW1FYeW2kQcQ1165MiS4w==
X-Google-Smtp-Source: AGHT+IEG3c3tpAxWZXlQB0m0PbwuMeZ4BYKblXsp35xtJ90rmxJ8VJjb198IEc5BnPSKM12fUF26BQ==
X-Received: by 2002:a17:902:e944:b0:1e4:ad9b:f770 with SMTP id b4-20020a170902e94400b001e4ad9bf770mr6900120pll.23.1713631044692;
        Sat, 20 Apr 2024 09:37:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.0.32])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001e5c0ac3279sm5247180plt.74.2024.04.20.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 09:37:24 -0700 (PDT)
Message-ID: <6623ef44.170a0220.5b129.276e@mx.google.com>
Date: Sat, 20 Apr 2024 09:37:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7728457439269292605=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] bap: call select_cb on bt_bap_cancel_select() to clean up
In-Reply-To: <7f5110805a5180fb910d735f631c6f3b9a19dee4.1713624621.git.pav@iki.fi>
References: <7f5110805a5180fb910d735f631c6f3b9a19dee4.1713624621.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7728457439269292605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846336

---Test result---

Test Summary:
CheckPatch                    FAIL      0.51 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.36 seconds
BluezMake                     PASS      1655.16 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      175.12 seconds
CheckValgrind                 PASS      244.96 seconds
CheckSmatch                   PASS      348.65 seconds
bluezmakeextell               PASS      118.36 seconds
IncrementalBuild              PASS      1442.54 seconds
ScanBuild                     PASS      982.82 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] bap: call select_cb on bt_bap_cancel_select() to clean up
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '41d6c4e1c92f', maybe rebased or not pulled?
#96: 
Fixes: 41d6c4e1c92f ("bap: cancel ongoing SelectProperties() before freeing the ep")

/github/workspace/src/src/13637159.patch total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13637159.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7728457439269292605==--
