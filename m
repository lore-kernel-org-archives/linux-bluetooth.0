Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EA200C2
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767733552; cv=none; b=Xj13hgeXjlnHxyFnaYi95UZ0CFlWVcKLm5ppeU0y/Gjra07Nb+8HumnN9aJjqWNFs8r2ZGISY/1fpscelLH5JsJhnN4SZiUC274KLbEhOApG+yWsHkP9nEvxP1Vg4Jka+lM2Ou9zctivF+zT14lZ3xg0wDBHZDw/36wVfMfQdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767733552; c=relaxed/simple;
	bh=8VxrozweMMsKfPpWMqU/qiJupHxczqJW7UTPzB5VSa8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UjIj6jEJKBc+e5wcTwk/vgnTQAh1aoITc8BjpMD25PhaA0NDNGaln8JBVPcIxXXO5CjM7ZDkwtK6Yv4F0LPm5fKoXnH5AKkI7nWT1F2VKH0DF+u6zOEmpGmrhWSxOLwoifdlpGfwdhEzN9G0MwRbsM0CEj0hJwVG28WU0ODypOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzMl/xAI; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzMl/xAI"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11f2eac9726so238878c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767733550; x=1768338350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x8Pkvz4+5Q+jm1a1iRwAR/ELtHp8ORCJOgiX5vFtJ40=;
        b=NzMl/xAIzq0p165jH3/aqyu1corcOB5D2H+183uYdik5EShVyUF19ArUULENy5+btc
         cgC40GOJgjUQl19XbYflTaigYFWgnf6Zr1IulPX6HzHepoTLChzzj27E2V/onS9hnFAw
         MqBPBHqVWVLKNRUu7iiZmNO3lrfA76x6bWxS5zYs+I1m51lWBSPg5uBZd2CrDFz44aT/
         E+v2QuKfaT8QHzOgP4WRDMkW8/GWb9n/FvQXNy8ep8diQR3ubFOQzks9OpVylqRbVR4G
         vtNIuI7Z+nsZIPviTeldMbApj50FB1jmGVrKfbK2uoHzNRpRhdV+WchD+JDbkr3/Geoe
         2VGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767733550; x=1768338350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Pkvz4+5Q+jm1a1iRwAR/ELtHp8ORCJOgiX5vFtJ40=;
        b=K8P2Vw9aPyQIVXKem9tG8JMfjM10+DUD/Wf+HmBVvM50XaaTV8qAAt9DPb0M700dW0
         OlYcil5IIACJ6gZR065xfEusuTQzmQoRp/rwlce/+x+rrEP4HYv2WIbB5pHJxxinBEZy
         op6IH8dXfNekZU8vQlZNxQWHVXbFWh6LWLJy014szh8Ko5f5DFZPHT7lwhBLfQOIPL+N
         3V4/V62fb30LgFNegXxgxXIc3nMU5O6L6VDmVoZC2vmRHSPa3yVob/pm1lvfxows6qOv
         gO5TSSq7yCjodgroSxU+e8znqjyebDpjoBMTHFgoGXbH0AtRTOvLdkXKjG7zJCq9a9Dt
         vLZA==
X-Gm-Message-State: AOJu0YwDyNY9B3j3UgmdUVjlwPPup1O+I28ZSPZHmwW4nId7Ltmv8WCf
	tO1hwz33sdkXrGcq7TWP/uZKbeISM6uK5vThCW5sFz+uEs5JUUZTcP8PDfkxr1m4
X-Gm-Gg: AY/fxX6/DQIEEsUfXVIvvBtPCV3t4RN00Obs1o47WPYuIaOhUz3swKfKFf5qR1I1vxQ
	vc/1F8gNxiE5umUtuThMhS/ywH12kSegyQY7pOI3I//I7KgXtnH6WmFkNlGaPy2+RAwI5CLVUx1
	Pyc+0mrbIH8Vbtv7q/0WUVFjDCwZkFDW1QtQevCVA+zXQ3ae+tUbKdMEZfPFI52gPUXbjnIa3nR
	YTMVjF5VyZF9ao0zqSW5JWtr/TNQ/PrF9IGFz698+JhVfk9Dxc90O//pTuhg/8VMCbpxwMFUfkN
	BRYqRAs0a9UnLwZsYN5OafbnueaneKudLcgpOh0F473BN8EMr29B8Q0tGNFhjJLfIynNVGc1org
	wY0qJEEtTwpTOxRx5S5N5m4g/xq2D9uJk1u27zowUDgXFs3yK1p/bGfx1rclUdhd3sOO+aHDW1U
	k+qVUfBYqo5aqxxRG+
X-Google-Smtp-Source: AGHT+IFRaI+TpXCz9Amn5HazPkzfd7pbteazcZRdBBao2kybTgmB5Uuk4CgdEfApkNBShqJuZck0BQ==
X-Received: by 2002:a05:7022:2387:b0:121:d898:edae with SMTP id a92af1059eb24-121f866f2d5mr396603c88.24.1767733549710;
        Tue, 06 Jan 2026 13:05:49 -0800 (PST)
Received: from [172.17.0.2] ([104.209.7.209])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243496asm7109367c88.1.2026.01.06.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 13:05:49 -0800 (PST)
Message-ID: <695d792d.050a0220.20781c.0451@mx.google.com>
Date: Tue, 06 Jan 2026 13:05:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7953605095756354821=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] lib: Rename bt_iso_io_qos phy field to phys
In-Reply-To: <20260106200913.3419162-1-luiz.dentz@gmail.com>
References: <20260106200913.3419162-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7953605095756354821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039131

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      643.31 seconds
MakeCheck                     PASS      23.20 seconds
MakeDistcheck                 PASS      241.90 seconds
CheckValgrind                 PASS      303.74 seconds
CheckSmatch                   WARNING   352.34 seconds
bluezmakeextell               PASS      183.09 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1025.81 seconds

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
emulator/bthost.c:700:28: warning: Variable length array is used.emulator/bthost.c:701:32: warning: Variable length array is used.emulator/bthost.c:918:28: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:953:32: warning: Variable length array is used.src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7953605095756354821==--
