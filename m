Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0C50AC33
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377430; cv=none; b=TBuxp+xna5ItlPOkb/y9KlqBlEdv4RH+h7T1Bo0RgusaEA32vpxXWfZ8QXjK1ysq/F1S8WJbV6GbF+Nvl7lpKD6WJrr+kJdlLdrKYkVbeAb87SgkUhoaezbMXVrEyy6wRd9NXJtnpFDFSXsU8hvj0UrpfkbNnkVW7MLq6NwS9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377430; c=relaxed/simple;
	bh=Im2mqZeHtOAr0NDUOJ8C+Q7dHKl4Ym9tX3Ezf4Trc8A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bjEoi3rnmLo+ixsxO3WTOMsnu0UdKdzui/zs4+JUAawFfdiLZLgKGiy4ZoNAclPN7Q0OQmfZLW7qibHQuMUrP7VXaXGaJCF7RwKMDAEOqbL3aW6XgGrcasFumIqhqScgK9txcgp2+IsXHi/lUdCynlRIxftz8XGBCuxvPbUbzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7N92GYs; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7N92GYs"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0766cbe64so870539b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790377426; x=1790982226; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5XhzH7eu2XeMZEhbzQ9KX7xN0OBzg4zCCh+AqJ22kAI=;
        b=S7N92GYsXhxb+D1km6gpLl7Nbbz4mXsxiHdfUyQ0assNqXIMhv/ITktdT07LpQQ51i
         RQ11HjhskrDMkj2q+vRG7W664jdj1Ta95VHAIal5XQLE9lhTDW0YtQRdURdbEbXTqeFO
         /keuba7iTfSy5sPtNkvo9ghmgfYN29m3EFzdkQ4h87oOUb/Ef1XVjF2f2qBhb8cQfGM9
         g5Q2W/EOlivr8w2JcWfwFmNupBG2mkWccIPq1SDnJyWnAw3W/mwOOOSWdQAZhXgJ6bjx
         21q9LMtzleELaBDFuYBA75+HyXBiTxfc5K2eAO6if9+uqy6BPx7qOE30PABlb76dBelR
         AUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377426; x=1790982226;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5XhzH7eu2XeMZEhbzQ9KX7xN0OBzg4zCCh+AqJ22kAI=;
        b=06ZK5zHVmbQK9JGCl2t/q0qaTqOamP2fkyUktwewOHM749WoIEZTg86LmCGYqfib7C
         Pq4dcD4UjKb+0GuL6EQRqKdfRWJsqY/gZYBmlEQFokn4Smvx/5U21vhwhTyjytVRdwHg
         LkblWYyUXhMHjEnwc733jd+5IHv4TefnhcwZnQ2X05rZBELw5vKJdDRSVHAaDHeQQNd7
         TjyjfHEaMnyN8U2E88hJUbFCRf1UjOAFqp4BCuBuRqi99qj/zrNeQoy99ohi2S7R/Pq4
         3kloWMeUTH34S3xMHR3KbTELmmoNl2Exe7+pGqBJMmy1jXR1prConNXfnvfgCEpJFmb+
         Ov2g==
X-Gm-Message-State: AFuF++ncXESJgsGTANmWCZW8Wndpsg+L+Vo/cN5aQc6776J4/ErS0Go0
	ueCJjT/ORYD2ucrSRpxJ45jChb+IVZuyRZqW0mjQeBI0AZs4qM/GXpc0rrnXxIiP
X-Gm-Gg: AYBFou32XpR1e2ieQEWkmBfr+f2uklXEDX6uSTu0tCkXjSYxq2UPMplMHH6DxAsjVf5
	rOlXWw8liMogDNKnj8ISydTcnr2Xet2toRKLBVSvrevpGOTwCNoAuzTwM8EqXQpZswFWDLXNRIy
	ax/uqJHK3FaWBC9l5kNgywZfiWoqqL4DM6jhWdwcADr/dS9SXX04el3KFgne63J1kgfPVhEkVUI
	quC+SrogsZLG9SJ9kk7qQIK0uqzlqCzk+CNoWRcVytD7fUkIdLZ+oq77zDSG9p9vwDH3cE6XB07
	/HgZ5kq8b5ea5fDtIFb1og+s45vRTbB82bkevQFVeTm6nHz3F4oP/TT8YA+1D6W8W2PUaULZHbS
	nFTM+rLFrANY5WXWnCkIr5tlq8Q3xUwtcVk/d8oDI+BsM4LN/0zr4t1wFRBD9nFcYsBdKsDqbap
	3oE9vLybViW6KFm4CD18vMGtfmJ63d+zYjXIax+xLkbBjkh+k3soaNmnakr1BoKzVrxNWmJliD2
	8KKFQ==
X-Received: by 2002:a05:6808:2222:b0:4d6:9133:23fa with SMTP id 5614622812f47-4d72b43c64emr9430142b6e.48.1790377426368;
        Fri, 25 Sep 2026 16:03:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.238.80])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm3639860fac.9.2026.09.25.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:03:45 -0700 (PDT)
Message-ID: <6ab6fdd1.a932eb10.38b8b.be22@mx.google.com>
Date: Fri, 25 Sep 2026 16:03:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8232442032404349322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, natemendes13@gmail.com
Subject: RE: [BlueZ] dbus-common: Use audio-speakers icon for speakers
In-Reply-To: <20260925213032.4011392-1-natemendes13@gmail.com>
References: <20260925213032.4011392-1-natemendes13@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8232442032404349322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174091/

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      23.23 seconds
BluezMake                     PASS      359.07 seconds
CheckSmatch                   PASS      289.82 seconds
bluezmakeextell               PASS      93.01 seconds
TestFunctional                PASS      1074.26 seconds
IncrementalBuild              PASS      363.08 seconds
ScanBuild                     PASS      1019.27 seconds



https://github.com/bluez/bluez/pull/2591

---
Regards,
Linux Bluetooth


--===============8232442032404349322==--
