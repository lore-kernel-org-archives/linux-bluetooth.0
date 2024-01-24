Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087C130E5A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121223; cv=none; b=nzv4TWISzpElncSaBKjus89/keObkDmiLuQvCF/xUUGpwr2oMA7wi/WP+twAMqV/LiyZt5GiCWDqo3YcACorGWQpCiIzZr2Ft6rn55Y6UWuRoPsxsLwC3U1g/ti/zrF4mh7GJGeF7Xagh/OgLUVBXG1uPi+W9R45GDFVapqvPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121223; c=relaxed/simple;
	bh=FgMz/X34TOe++XTHvCvQeMKOg3V0gl5PTbhi52U9I0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IIcnpI8OzEMM8uUsuGlas98tZbJPS3p4knUq6xQvhBtE9ONj/zf2944qpoVANNnu8+E52QHixqvxa7o92GSILHLnXQPNp28uaEPEC/VRglu203OXGuAPdhVLHZ1ft0AWyd3JDkQ129V4fymNX2iIi2q8XlQlmOd7q7Hr2qIgYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPKr80k8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPKr80k8"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68196a09e2eso34298506d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 10:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121220; x=1706726020; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3STM3wsRIYeDwJgjpc35MfElmVdsV7yi4e3JLwc2Ky4=;
        b=nPKr80k86FppdMNPfTDl2xyJsWQjLUbC6wtACV6T9gtEKN4g7jCpGNRK9/jxZo+dEC
         2Du5+IJxIWcfDg360AosFUonbem+lxylwNoP+aIviA6+tiQgLfyhI1B4q4bdoawgvHuZ
         jXPN5px4gd2G158Bqzvcfciusks7DPcbmoAbFoFP2NQNKOoS51QtSx7v4A37aXBOnOPq
         Oy9xMESEVG61e9KmDAILKVOe6arNBUQnNcx7acpPa0lk0fkTi64CMl2aLFbUOtYTcdYY
         p74cHVIWSOnkVPA9j+0Uell7SQxkhXz6R2IOg2yyn4NcaGWVicErO62I71j6wcLbqp5J
         JOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121220; x=1706726020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3STM3wsRIYeDwJgjpc35MfElmVdsV7yi4e3JLwc2Ky4=;
        b=vVhmJar4Z+/TNOYxHitu+/ABP0n+a6faDylc7CMkRCNFo58OJazSWArMSHEkiEUzfo
         dnFiai83vxdH6K2uxYCeJPqLWbIeRGYi6mBBlIOsXhaYrEqxsANgjA0i7FnVh5A5UpdM
         By9aWHLE6KinrY2lYg/quR7I7c2Se8fY73rmaezU7e8FKSWLWRZFF1gFqbVbZs+cIW5O
         kXKtGod9Sex5FAHysBuBork6l5IESLxXuWsxUvdWZP2y9TCVsR2P6KiaAj/y8OhRWPZz
         5t348FUbcp3db8j2upvxSxkRMdNcDeui4iF1ixNp5QY3zJAbUmWw0fLdCFFlvw5Q7BdC
         /dJw==
X-Gm-Message-State: AOJu0YzjWqDKAL1Yu0S3+k7lrNGr+4d3t023F0QvoPPuBnMZjC8mXGXY
	/zpN/uFcWHNnwkpBNqMe7sXHUpQGYcv+tNaWVYXotcUuX6OhhgwA4JbNJj3R
X-Google-Smtp-Source: AGHT+IEsXl80KlDdVHOMQ3paSkrleddiV5TZjaHjOcOnJI4WxyyJJX9JqWAzY/oCq/mlOKDK/JrtCw==
X-Received: by 2002:a0c:e153:0:b0:686:2bb0:bf2e with SMTP id c19-20020a0ce153000000b006862bb0bf2emr1987194qvl.100.1706121220476;
        Wed, 24 Jan 2024 10:33:40 -0800 (PST)
Received: from [172.17.0.2] ([172.183.52.214])
        by smtp.gmail.com with ESMTPSA id nf5-20020a0562143b8500b00686ac3c9db4sm1078200qvb.98.2024.01.24.10.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:33:40 -0800 (PST)
Message-ID: <65b15804.050a0220.53c27.7287@mx.google.com>
Date: Wed, 24 Jan 2024 10:33:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6500000731126563477=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Autotools papercuts, linker GC, symlink dbus-org.bluez.obex.service
In-Reply-To: <20240124-autofoo-v2-1-a210f20aa2f7@gmail.com>
References: <20240124-autofoo-v2-1-a210f20aa2f7@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6500000731126563477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819560

---Test result---

Test Summary:
CheckPatch                    PASS      2.17 seconds
GitLint                       PASS      1.67 seconds
BuildEll                      PASS      24.22 seconds
BluezMake                     PASS      734.57 seconds
MakeCheck                     PASS      12.13 seconds
MakeDistcheck                 PASS      166.26 seconds
CheckValgrind                 PASS      228.88 seconds
CheckSmatch                   PASS      332.09 seconds
bluezmakeextell               PASS      108.61 seconds
IncrementalBuild              PASS      4118.59 seconds
ScanBuild                     PASS      966.75 seconds



---
Regards,
Linux Bluetooth


--===============6500000731126563477==--
