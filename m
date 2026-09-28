Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B93B2FD4
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635054; cv=none; b=t3A2X3NgDKPqmAVGSg215NZonONhKsWhW+1745YzwJ3h0L8x4oP2rXW4t2R2tPg6+jphrrWSSOJL5wzhtBVrREO8x6u6xI/lK8NDX65U9um35ucqaOiBSoeO2+Pa4xZ3BvogbmdDCsKdPjUjRB5kbIlnLHDV/zmo5gPC36cxHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635054; c=relaxed/simple;
	bh=+/fOmDyKaOfuMc2Oe5xxikSJaUFG3CD2ExZ6pDWHmBw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AtHrbetCXjmeAGCHTncOvglcg0J2hKJ2P7YOaXDZvxK9f+pdtOxc0xaaah14+epxXzssVhtyDvGDqE8nwP7jti6YMTGsu+XeW+MfNcxKk8AMIKOyI8pAK/t7rujG4x//2NjbeW4WlDYc/Eza3rYLQwzTDQHbTi1nVcGDTqv5xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mroxScS5; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mroxScS5"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332f3092eeso18060511cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790635052; x=1791239852; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=52ZN+JHWlVO/8cXjl4yHFVbgo9Zi7P6Li0et4X1v/+k=;
        b=mroxScS5RmJFUUf1TByJlLaL2+m77xfMfV1L1sUSwB6+OYnOlC6ZIgTENZxW1Krls6
         UtA9mD6EsFgffwCBdXSxqBUxGAwEmvcLjAIiZRylyDhdY1XsVM9vUPqlhah2Ob1frIfe
         rJMjsbKvV4QFx+D/OoUaNaSeG9ry84ccOiPX6YgM0z0KNsMgUglGl9GCoUt2Unjcdjyk
         hvAT3CDE+xEQao9DeCXMLXMiB+4Uwol3q/5/RrWLO7UGQX4lolHU/xv0TZGQACWV0Um3
         FGb2g4qbaJt51cCWCwarWof0pwjM5rD8y+mwRyDa4C+CZ/eKgsNsm2bfGI5rjTwdrnJ7
         huXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635052; x=1791239852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=52ZN+JHWlVO/8cXjl4yHFVbgo9Zi7P6Li0et4X1v/+k=;
        b=W0K+q7EtX5ji306FYmGdDiLsfPwCzsJPZO/NODT96kjbneXQlyp4eU9aJcD6u7JC8g
         fUnhTK0EO/20bYX6f12Ea+8/wMvEe4erl5Qwdc2ebJUbnl1K3CWt4mhP7zUNWHAQfFc6
         Er79CXIVk/hs9KoBiNgzriPjf/4BbFOi1BE5rbzEP3JF5uNugYtT4CKlclIKLOX+H/ST
         PkrlxNNepMTuxL7FWJYjDaJA067/Muwse7UrByZ3G5edXgureEd7TcKUsnJw84tnd5UC
         7lxqWLzPfhUM9g7NcylV/RuahZCi+N/iACjdmUMu9Jrw1toKI8wHfkDeeI7ytFW6U0MU
         BXew==
X-Gm-Message-State: AFuF++m1nAEAl8A3Zzv/eG6SwcxSqEkqvUD+LFwWyhh6iL8fjQ6TWb02
	oUVk/RCnqOBtllN3OQEch6Hh2i9XIw39HSIwaasbTBCxUEysGlL68UPdxAG3mT2y
X-Gm-Gg: AYBFou2tjOtvjcKDblHF9jf73xKp7kDtPStJ5Np24iOF/7T8fmwWat+FcGTyzRwkaiW
	T0e2zRnC0HCT4GfyFv8xmfmuSH9ATD6At6QlPsjepZaHktNPuT5Pdkl1FeMzqj+T4AOJXCGLOnt
	0KQxRjBkwYrWTJHUd/yAvU1XwOGDGirjxW9cBChPoasfXB8go7jdGc8SuGyXsqFogqPHaNHiccq
	dgP9Z7j6cUtVCEglldFduHKODHZTCD7W996nj8F53aEixYLLGaARQFbLyUQiGtktuyy2jjcnjsi
	hpkzO5Htx6uZQlGMJhr/oDGMK8evzF3sSzJxZ/Oha8IPXtBVdehxEleHF45Hcf6qEIRyhhFEmyv
	dWyK8VBoUdND6YZwysAjSspH5gepYGYiE2jc/oyWx7BokBti0gjnfOXbqiyvuKtVnG4+caI4XlW
	sSUdFOq0TPkCsTHdRoUUmD82BTzjwFMHgJc7bgwmWN3bVX1bp34r+IA+z7+BUT11ZgjfntNuaZK
	TNMj6Ni
X-Received: by 2002:ac8:5a12:0:b0:532:9b14:96c5 with SMTP id d75a77b69052e-5330b706380mr242295201cf.60.1790635051603;
        Mon, 28 Sep 2026 15:37:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.237.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533223efcc4sm73057031cf.25.2026.09.28.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:37:31 -0700 (PDT)
Message-ID: <6abaec2b.eb3ee9d5.254ffb.7e02@mx.google.com>
Date: Mon, 28 Sep 2026 15:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6871301574458503262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] build: Fix coverage target failing with stale .gcda files
In-Reply-To: <20260928204732.1265535-1-luiz.dentz@gmail.com>
References: <20260928204732.1265535-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6871301574458503262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175582/

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      19.89 seconds
BluezMake                     PASS      392.34 seconds
MakeCheck                     PASS      14.72 seconds
MakeDistcheck                 PASS      146.61 seconds
CheckValgrind                 PASS      239.11 seconds
CheckSmatch                   PASS      295.94 seconds
bluezmakeextell               PASS      95.19 seconds
TestFunctional                PASS      1125.76 seconds
IncrementalBuild              PASS      396.82 seconds
ScanBuild                     PASS      1146.71 seconds



https://github.com/bluez/bluez/pull/2601

---
Regards,
Linux Bluetooth


--===============6871301574458503262==--
