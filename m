Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186307;
	b=ttniE5uECAFzq/DNXX2SAt4odXPn1AVnAYjw1gh86AtGF3Ju0jqvLNLcUCNsa1p0+HSL
	 7YO1+7JgvpiZgu652FDMcsqAsnkMupNjzM4tZm6Fj5uACvzohHwddbQ6FuF47NDrfiX2L
	 BFrRh9Kc4aZ/JfL/Qf9xCxqUGxwhTMm5YVs41KXWw1gUUuDuq+iWoRhNCTikVXHpkWFMS
	 i0I4er7KyKIsUNnzi0dk/HB2yMawkk/Tt8p5NtjXJAgpwkkfgq6NffL4XZWJfqL5DEqnn
	 jppcEQCrE5+KDOitKCQuRhlBBPm92vVJT/mra0efvejowihqaqBr/ptC2hLLOCeLH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=mbISe0dYb37Znm1ajtOUUEvBMf/BCm3Dbz1vEQr3XB0=;
	b=zOj4UdDxk+KkhDaPep9/QGN2OOGveFuZYHT+05Wb6rqzbeeOOxI8sPpzSFHK9XfLh318
	 LJsqm1EWTMwPoxw+ZvmndATNuA7MQF5WsbHTSkaxR4jzFaSf2aeRZQBtdV/WoHIfWzwxl
	 EFlgQzgja/R+dCWn7ZyQ2Z68o9oh5YkmF1dAfjBDFFFGEWGvORYax+RJOtwNwGZ3Kbx8h
	 VDepp0+jtT690fBlkpyFWUGvhHchiGyQ3yCEPpX3X+HsZQqWDThKhKKNcNui5n0LTV8A3
	 qrtuNH74mPoeNVHq/1D5gwn02g91TSJoP4n+ReKJM8eA+Icc5aiDBHcISsiEHOPZ39g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LtcL2eZd;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EF606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17EF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LtcL2eZd
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so1517192c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795186306; x=1795791106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mbISe0dYb37Znm1ajtOUUEvBMf/BCm3Dbz1vEQr3XB0=;
        b=LtcL2eZdopaCcGFZlLkSUtltDnACsO8vp6m4xzLBL9H3eouOXa4ZD5Y4XJe4aq+Y3h
         FfTwhLPSt8BpTNZr6Al2KY3bA3qoM83ThVkNosOtRHWY+ivOG7AIkJdhy7UVfZ0DHZzA
         c7mkiDaev7MPZ52Iht6HgDW+Es5apZBMVOgQybgPEyiItPyDhujZFA5WPNL23uHDzQI3
         h9j0tqPNGpWO0dA5DxYeMMOwfnHtP8Ynk3AlpEdUf/wyE/hbNi3Sm4rlwfuHGCZoLbBt
         W92ewTBQ4cm3u1ZJWgdlK+E/GgyVTy3X2KFuAMLhDjNzVsUpvTWkeCGMMDTskXXEDiQv
         kawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186306; x=1795791106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mbISe0dYb37Znm1ajtOUUEvBMf/BCm3Dbz1vEQr3XB0=;
        b=z6UQjYF3wD8Wc15fuMK+y9EkOMRIz/ccw5CTfF2Ibjj+lUTt40kUmkhlTfrkYlH1Vi
         zfEm81h6slu9LoB0/XRJR4XlGLt6TaQgSuhHzj8r3VquSPJzb4fjCSBYCT+mbzx3BYUe
         lic9Fcqlh/U5+IcfsRevpHoWFIfUclRM2TKhKElWEWBVTZDwYrZHzFzNPrNWwvMztzba
         WaTOjcN1tjKPw+2EYQFRN0fO+14xT8Fw3jHcptID56zTkzAfuT7wxduCHdPDDe9YqZaL
         wZM/EphqyJbNyUmdSP7pbKlm3JeWKAiHF+IwUdnnHVxYsb4ameDLPPR1c2brf1CIq//P
         r7Ag==
X-Gm-Message-State: APuU4Z+NG7xDm+wW4kTOkiaDI78vVEudrI5VGkZ284CCfuwUYiIeEK+c
	KwHieND4oUCna8Fh4t5qF2EaYVHx7P1TXL9WUTBo9UrMA2+HOx+Hhsxizfkcgg==
X-Gm-Gg: AYBFou2aSK7xk/JvG50bi8qUlxT8ciAEFQ7D8iK/Z2DcYlrMcdYHL14gsEPQG/G7yno
	46HsGtXlRah50J9cbsaXVO++olclOSffP1BF6YTQmNeAsSfEiN1IhCCp/fjSSHQ7vJ9mWKtDgOu
	gVgH6UOwhEoT1ckzwrRcCrNZK8WAGGy1qL7hnkQXNzH/cBEs07jRJVxqR8zyz/CiqmTKJ/ByxEt
	UNxPFbbIqcFIO+7LcHFYKpETyZqFOEE8E/0J5enaUBCanX6SGOD6s94hwFCUIc5NO7iigsVYVY/
	BBlSmRBoyMKj7ZxufeBVb/aLN7kX3kByb/XTMd3+01Wt6vfb/+JYVWyAMnQMJ3mgxcxfxmMBSvP
	NvrdezETn+4vEG5of9jYKlnKjI3xECFjponzV+I+OEEMl1cgn6KUvGKPLtGn3uAI1R0hrjdIxgU
	+8QBU/nODbM5JYK/b5b51ytAh1sVwHypJVDM94kgCy+ukptysLE/fOsaDHteMBG81JJVyS8P8ko
	5p6OgJ7SttJ09k82NY6hsr9gWdOoZpQrTH0eLt9hQZ3YtLH3pgMgpha9qM4pjyT306s0DNevAR3
	O5UOOg6Y
X-Received: by 2002:a05:7022:3a83:b0:1b0:20:6444 with SMTP id a92af1059eb24-1b55690779bmr2975436c88.39.1795186305444;
        Fri, 20 Nov 2026 06:51:45 -0800 (PST)
Received: from [172.17.0.2] ([20.168.124.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm7326599c88.3.2026.11.20.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:51:45 -0800 (PST)
Message-ID: <6b005e81.0a7c1997.164086.b334@mx.google.com>
Date: Fri, 20 Nov 2026 06:51:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7979703913122418717=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rolandschober1968@gmail.com
Subject: RE: monitor: Decode Periodic Advertising with Responses
In-Reply-To: <20261120063856.16585-2-rolandschober1968@gmail.com>
References: <20261120063856.16585-2-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7979703913122418717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216977/

---Test result---

Test Summary:
CheckPatch                    PASS      3.81 seconds
GitLint                       PASS      2.39 seconds
BuildEll                      PASS      16.25 seconds
BluezMake                     PASS      236.60 seconds
MakeCheck                     PASS      0.78 seconds
MakeDistcheck                 PASS      124.05 seconds
CheckValgrind                 PASS      123.83 seconds
CheckSmatch                   WARNING   235.75 seconds
bluezmakeextell               PASS      76.08 seconds
TestFunctional                PASS      1011.03 seconds
IncrementalBuild              PASS      394.74 seconds
ScanBuild                     PASS      879.59 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/bt.h:4304:52: warning: array of flexible structuresmonitor/bt.h:4292:40: warning: array of flexible structuresmonitor/bt.h:3048:52: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/bt.h:4304:52: warning: array of flexible structuresmonitor/bt.h:4292:40: warning: array of flexible structuresmonitor/bt.h:3048:52: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2855

---
Regards,
Linux Bluetooth


--===============7979703913122418717==--
