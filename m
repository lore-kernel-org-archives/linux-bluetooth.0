Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE81D357B
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944354; cv=none; b=H3JaSIImQBg+rJx19mSHJr/4tI2D/sYPxODQe8e4MfTDfH5zwca0xo5qzPKrmwmUXfX2kPVpS1up/tvlvIkBJ5B3yt7b7phyA5+0ez3CesLIbPTw8FuuPcKcBhjNTzadLE1T1mRvr0tShOj6ZETXlMx4CHH9Wk11GaVcV74ZywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944354; c=relaxed/simple;
	bh=6HlsOCIHsLVC5Lz1L6S2COx72RNIVWUEhhlwCcjTo+8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cdijlk+SBTCfcAqdyabjOnonDNqcR1niW4LCxgfTcoNnD5R5GGshuPuMIfAOQE0V2VYJ8BlmdDNOSoSocWWvAuBaVh0ex7pNEH0k9C1jVC/gl1gQrIN7SDs1jmZPM95m7tZ2I6wYDyk0cRwSQ+BXb9fB2od3Qfc6HrLKn7S2YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm4zCQZH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm4zCQZH"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso16799176d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729944351; x=1730549151; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktp5dKsjWaUGzGg921sUykAdELNh9+A3z/i3RzRbRHk=;
        b=Nm4zCQZHMjIu8ipPAzCwTViu+TaIY8AoyDr9UYHh5JOwHSGGYh3Nbzq6nAN0l6qPJ0
         G/KPFUnLp/LHuw1VwaNvsOHbYATjPLcPkdJX5KN0GdbF0gjxGLL5YpeY+ooE28Qw4Qy9
         V73ucPM41bgpyLhOI4Ywj/+NEsFoAY+8I/Z27C1QGArWlWYbpmlq70wvACpxq6mpuDMZ
         oUKVPjPoRlDgoWEsAoR3/qn4nmqGze2csCI80SuO5juSg02DnyYaoQy3/2W7hx1/MG6r
         aJTXTnRQlK3q4QYMzsGygl8K/BBmUnt+Xaryqx0L3zvt7W6wWRZL9RdpWWYx827zzLJW
         KXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729944351; x=1730549151;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktp5dKsjWaUGzGg921sUykAdELNh9+A3z/i3RzRbRHk=;
        b=mfli39Dm+TYmjzdjkTfIVBDGgOuECXc0HTs7vG9GAY0Q6p9RaGm4nog2KFY4vfoOWF
         mzfAsWphpqGfK/FS8Ep0U3iobnGqY3wGF0YqBok+pBRgtnmAJLhJwtsXWc5CUTM8qRtN
         5yYRB65ENgZjpI2MxarTO9k7OdtBavTHEdqGr+favnextTjJC41fPDwpgZUdHKJct/LA
         vmxtzYIWdmEK1DOQZsb6EA4xtxh01d/UbXePKBjApOmLbFBBetJxBQx1Z50+x+Yydfya
         ydoBZYJAFbUioLR4Ns5PMG2pvGFhNEq0sbkHxgaIK8KS8g9GoGd9iEX0RCUWaHKt3gQJ
         dsaQ==
X-Gm-Message-State: AOJu0Yydwsgcd7+FrvhoCLNncZhHVVsZtZVCFm2OT36a7LLPLPAl60bx
	31/UmZ3fKwkgITBRS5lV5P0d6bmsy36tJpbGCNxoIGgZm7wUDw7qbnxdMQ==
X-Google-Smtp-Source: AGHT+IFpQuk+S8f+rZTjg4KZlVSTmhJ2BE4gW2MZ8kh6ak5dduu2dP+RLxZROdvmkKVl8yuwu6rp8g==
X-Received: by 2002:a05:6214:5343:b0:6cd:e38a:a91e with SMTP id 6a1803df08f44-6d1856e6a44mr30236846d6.18.1729944351005;
        Sat, 26 Oct 2024 05:05:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a57d4csm14859166d6.132.2024.10.26.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:05:50 -0700 (PDT)
Message-ID: <671cdb1e.0c0a0220.25a331.5234@mx.google.com>
Date: Sat, 26 Oct 2024 05:05:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2599077450619452248=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: ucast streams can only have one link
In-Reply-To: <b0eeb28d794adca98f4a246cb368e68022e06e0e.1729937570.git.pav@iki.fi>
References: <b0eeb28d794adca98f4a246cb368e68022e06e0e.1729937570.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2599077450619452248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=903408

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.63 seconds
BluezMake                     PASS      1662.11 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      178.70 seconds
CheckValgrind                 PASS      252.74 seconds
CheckSmatch                   WARNING   357.13 seconds
bluezmakeextell               PASS      120.59 seconds
IncrementalBuild              PASS      1412.18 seconds
ScanBuild                     PASS      1004.74 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============2599077450619452248==--
