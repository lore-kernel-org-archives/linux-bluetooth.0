Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EFF63417
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198123; cv=none; b=AUc1mGlI3ehQQXAnWKhUIE8sr0K6BXSywYjUaVc1UM19Bhq3nO1NYf9jFf6Mb8IPEOjbWJt07futhT7OVds8e+uKGZrSDIc7PaqfMvI6pwfbKWRm874SA3YN+9Wj8XbsxSykOInYWHm3a79iTQvRg99nJqFZAqxk19AQJ2f9xJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198123; c=relaxed/simple;
	bh=FrfMxYNhy9U+2smg5dwYOl2w+QLWiXDfMt0YwUVwV1Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xcz2HreC5XtzQrpYMTGXp5w7884S0ACfPHRLLRPxPsCgE8apeMi6unZvywFtOpdiBDXeyB5kR3sKuxTGv9TbvB7jKVxA4MbfQmRj53ee5dzgeor61fcQ/DOwCZNPfKtFBPuTmayMGOrj8kZBqzA/4wS4EgVp1j/M33d2BSdIai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhvMUbyl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhvMUbyl"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2903498ae21so3978888a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706198121; x=1706802921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XwAdTtDm+YtcavjznpFDZhPx6U2BX9iYJHhyxzWxAw4=;
        b=IhvMUbylULXnwGSWc8n+xGQuGKegIo+VFlJDipfp6qhW4B2qxZCpXQO6Xdy4GipdnJ
         2qgi8QPaUE8UBpmiwEFWkLl+2gQedYctktBV8MZvubQMagDi88t+OL8lXSQRuhKXdxO5
         U1l7fhLfN9H7VM7n+khfLKo1KOIGNeRB0sUQnZwaFnTxTWcH5bqvkj/Hv4TKlAKMysKj
         b0zFtIU2kL5g7ynBDjsb5gs2AXbNnNwNPNJsWcqF3oGzcWfSpn3NQGRdmHND20zICz4m
         TVx0R8JpoajBSorwGT+34KxmpClNMHmNrfrYFZpA1M4YPcBJIP7qJGYWgH7bSlk12jYb
         oThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198121; x=1706802921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwAdTtDm+YtcavjznpFDZhPx6U2BX9iYJHhyxzWxAw4=;
        b=rV912SHtNccb3bqtRrmVjY51bbllo/MGeRgXhmlcHHqjiumfgPLP6R9XY1sglgXOg0
         b+9iN3Lpb0sXfF8HoOZiIyuX5jz/7MDgcc7CLyc23E6oBN8Wrs4di7qTELSOV4wt/SXl
         DnVPw0jz/DcL8lj+FmpYKG5rRx+4ylB39MjMIAR5dOGtMePJ4go9LuZnBBEJVlANaKm1
         tE33EHH/rOvu0eiVIQ08GIRGa+3IV5P0+bTYMkaRIMfph2M3srnSmT7gCNy/CnJQ8Izh
         BcBu75iH0j01nZj+Pf0Zr1ve9rlM28CO0q7p2i5OHlLed7A4JipaBaGsQdx8zLx+HeZW
         ZQpA==
X-Gm-Message-State: AOJu0YwCGifGpmgA6zjWfxHCrP89/Ji+TtaXryR3qW21GbKpkV06x6yq
	OSXTq7WBorDH787oCXU6hdj7a5NruL2VtC5D18+pAAkyHwda7SmWlDAgrCvF
X-Google-Smtp-Source: AGHT+IHzA2A6LsK5Wkr/qY8ZdWjOWwxNGI3+ZRYD6hH6V6y0+nDAIU8IlES632GwTOSt6OOGmQZzeg==
X-Received: by 2002:a17:90a:1c90:b0:290:85a:dba1 with SMTP id t16-20020a17090a1c9000b00290085adba1mr721546pjt.5.1706198121080;
        Thu, 25 Jan 2024 07:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUU/2TxOiOQGhntphoL8CCy5ZvhYyF4JSBo8HBexv/Lr3nrPpOszktDftoNILAHsC0JH4rPckofbuCZ9hQ727ItTDczYA==
Received: from [172.17.0.2] ([52.238.28.65])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090ad99600b0028df5c748e4sm1700710pjv.44.2024.01.25.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:55:20 -0800 (PST)
Message-ID: <65b28468.170a0220.15fed.66cd@mx.google.com>
Date: Thu, 25 Jan 2024 07:55:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3694183762375746415=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] btdev: Fix not clearing le_pa_sync_handle on reset
In-Reply-To: <20240125142936.3373953-1-luiz.dentz@gmail.com>
References: <20240125142936.3373953-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3694183762375746415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819897

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      24.08 seconds
BluezMake                     PASS      724.48 seconds
MakeCheck                     PASS      11.50 seconds
MakeDistcheck                 PASS      160.61 seconds
CheckValgrind                 PASS      226.22 seconds
CheckSmatch                   WARNING   334.66 seconds
bluezmakeextell               PASS      112.05 seconds
IncrementalBuild              PASS      2072.65 seconds
ScanBuild                     WARNING   943.15 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1084:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1335:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1457:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============3694183762375746415==--
