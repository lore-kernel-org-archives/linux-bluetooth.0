Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0EB1AA3C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365268; cv=none; b=KyDe403rjBF7YvLwIZ0/vzRjRi0GXOsU+Dnd/XJAEa8tyw4LHwdbAAHO87hbftFHU/Q7xvossZ0Hnt/w9sxu7/WbptDcUJ2nywHG9U2pHAf4MuukIrMMSaeKvbTD4x/ze+I3I0hVHMIudx5tvee+pXHq02cE5laU3LQD4987SWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365268; c=relaxed/simple;
	bh=iUMiqTqfIfTQ0/RaoYGsl3xakXgoJoZ3ouqkqIN/ctU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iISb9kJO6ATZs7HHVkmQpDDysmHYz2pu+BWNo9P0l+Rd9mt4e1LDq7r+0gx/fLg7xserBzgiWA29mKOVadk+94rBkcBK4JMrOcorXo4sBxhW1aPBftENHhYXHdyYkeclFXKs8XKs/zNArCB07N2+A/6akABoVln2FpFWj//8fu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onhhjqe7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onhhjqe7"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5e97b8a22so1625826eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722365265; x=1722970065; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1kJzj5rBlSzVgvWT/5hmvBUfnsFLMv2ak0BALilsduc=;
        b=Onhhjqe7TT8SxciRVE9xhkIfy76XpjA509JzvzcuaiFF+NUGxRTxKv89XZe6GjIKRB
         9hpEImpCjzcEesopMk8crTif+tR6SYxChB/rNGGbdGIpHE1qNgjTyHXRe7Sdw8QAZ/E2
         F80fD3RSPnbq4PpMWzZrI3flVaiE7raTusZGMn/vNog5TNTng9jmdUEnrjz14PS8rzTs
         0LtsjXSRBBP+lBq7U8oi0gCA0dI1qn1Eqy+xe+gVbC23J9iwrqwQVq50Vnb72qc4bjQp
         xfsdFRhN51hK5r8bFJu5AiqXs6b+FZSaN7kq8G2kqmn5zx6rQH6eZsc+auI/A2I2xPYa
         +7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365265; x=1722970065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kJzj5rBlSzVgvWT/5hmvBUfnsFLMv2ak0BALilsduc=;
        b=KijZhH0Z2P+Oqbdt9VQt8lZJtbts8woU2KHPc3y0HNr5ZOAKsiefREDHYwlPuOPyFq
         2Wi4YNhKZnGkmt/Ab5PQSC5W3lVkUGQpbtfuPKO7lg/NlKqOqkq13eSFYTbXQC5Wm/IL
         ydunlSjByZ+nQdQz3yM9kHjf8AV1ZDmchlZfhduc7UguAAX0ZufysrhOEjs6+T1WPoog
         kFV8cD02ADYaWz+0txWhe1ufvOX7gZSEEpNeBE9njSxTnUBkfIPF0nHEOgXQh0m88T9A
         As6biWzOLwOlb1U6h1ZUDevQbOnfiwjiaHaZOFQMo5MOz+Jq0qiXmo6JrHgw+5Kr5hLl
         f4HA==
X-Gm-Message-State: AOJu0Yx7s/geNZIeBPy9DtU+fYDpbo+JrdXmslgiEtuLosyxTu8YNQTe
	MdOWllK7ObYuIJU6gLm3YekIF28FgIwnuTvKjiszy0ytgOsJgeNNfL4bKg==
X-Google-Smtp-Source: AGHT+IHvMsTR0gUiDBioBDvDh5E+WE8A81Zc8afWCKZpomaB4jV/6hkqKeO5qWYXvWwZu6z7gfddlQ==
X-Received: by 2002:a05:6358:4298:b0:1aa:d4a3:3d64 with SMTP id e5c5f4694b2df-1adc0472601mr1308226955d.11.1722365265427;
        Tue, 30 Jul 2024 11:47:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1e68a7824sm468215485a.78.2024.07.30.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:47:45 -0700 (PDT)
Message-ID: <66a93551.050a0220.128e77.cfbb@mx.google.com>
Date: Tue, 30 Jul 2024 11:47:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5257170957756159143=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add 'broadcasting' state
In-Reply-To: <20240730140947.411655-2-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5257170957756159143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875092

---Test result---

Test Summary:
CheckPatch                    FAIL      3.29 seconds
GitLint                       PASS      2.08 seconds
BuildEll                      PASS      24.72 seconds
BluezMake                     PASS      1729.78 seconds
MakeCheck                     PASS      13.71 seconds
MakeDistcheck                 PASS      182.09 seconds
CheckValgrind                 PASS      251.51 seconds
CheckSmatch                   PASS      355.43 seconds
bluezmakeextell               PASS      121.61 seconds
IncrementalBuild              PASS      12670.36 seconds
ScanBuild                     PASS      1027.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,3/8] transport: Add "select" method
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                    ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                     ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                                        ^

/github/workspace/src/src/13747448.patch total: 3 errors, 0 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13747448.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5257170957756159143==--
