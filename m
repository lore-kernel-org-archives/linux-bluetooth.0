Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E654667
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680494; cv=none; b=DtESxnRgOyYI0ydQmpqbjCSosj7a0mt7XFcir7nHOSgFKNbuXFtuR0Ng+LRk9aa6RtYJEORLLVyX0sY3EgsZ5ueP1upIR2O1NWDkoFpFz8fgM5dy0yfz3iApvKjyyn/TTEIS4hX1MHnr7oMgiW9U4CYOEdEvLp2b9qSjvUPcG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680494; c=relaxed/simple;
	bh=VXpkTIh/yAbV4ah5j5h2sVRpL2Nx4CHVkR9Wsaj/ph0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UnBLX8CfZqqBYNcodWifLNZzh/bODQyeM4g8yk2IauL+fCcWs6qLR//SFZkjvk/LrqmmOshgXIhy8SQoX4r6bU+yKn9ArRWHp80aHmWlXKyElFqiQh+fL+2LuhPLSGdokn2xv7Pe5Tjq0kK81Eq5WvbotX932Upw/uMg6Hr+n5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWGpBQhx; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWGpBQhx"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-210dec2442eso288094fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680492; x=1706285292; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+h/f5yVfrt/abEQLpLlmJSJH7DasxWkEPuqh9PQ1Vs=;
        b=MWGpBQhxpNO15fRQ/H0UHczI7Yb7HzzVy+35Rl1DA6MvB9KriozN/uqxpHq9zQE4+M
         /xAaXghfzoYjCG99qyOrs05VmvGNb7H8XcKtqFhjygOSOS4qZ63OOyb7l8jcjZHeeUuu
         60+YLJR4sIlRDmS2bw50pZ8PtsEF6fZWGgTB0OjZ2OiDqjR6Up/oA0rS+6fALJi9R4K3
         40z8hkt435CobiwgK3QVZzeQOF5aEY8o6PXeByR2Lx7FtpqW0kgaqr1ABdYxK4JxrsZZ
         avYIfECogyOW4giIqfkjRDSNY8xNylh+zDZ5Y6drk/lbeHnGrCQDu/H4yDS4VvD9Hvzw
         whHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680492; x=1706285292;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+h/f5yVfrt/abEQLpLlmJSJH7DasxWkEPuqh9PQ1Vs=;
        b=Fvgjw+3tP3Sm+ekUgmCUbFxkEpWdyNrHlwueoQSuySInGl9Fv+8clsUe4X6Io7kRW6
         slxZQ+xtBwphkgi8YpvmztG1t8pmuJLE08vhAMY6hZimzuoIAxuOQF8cQIhDWweNS8C0
         CPhkzft+PVXLSk8roYlamCjTSbg01dsCdcvsKRDKGLVdptFPA2ssE8HqsOV2KsJDjM8r
         iO1EH/JMvjNbOBUjl4mf0EGVefLfW9lJd6DK86rWlD7rsxeQMkC9l4+Wo0b0x+WfFdsD
         Fb6H9EIF4RLiCrpuey4AMBzhKKOo6UveGJadA2latGcmHvk1+Anbf/RLadM5O1um1cqz
         Epdw==
X-Gm-Message-State: AOJu0YyNKImpG84OxgnLliCAK9S0jQzyd7SY5Kc6EiVnozXpv0FxdtZ2
	mYUlEWnFtD4ItrufZIZ14dhTIlB6PxtHwEzBcxHqX8lkL0GEPZEDk+eitzVr
X-Google-Smtp-Source: AGHT+IGGk1xESvcrnJX49JL+DtpbYiW0/dMlzZKRNAo+zpa0LYtWJ/qWcUKizDhMdWjJAp6baffJZw==
X-Received: by 2002:a05:6870:2110:b0:210:ac52:bc08 with SMTP id f16-20020a056870211000b00210ac52bc08mr2703068oae.75.1705680492215;
        Fri, 19 Jan 2024 08:08:12 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.37])
        by smtp.gmail.com with ESMTPSA id od19-20020a0562142f1300b00681841da1casm1218259qvb.50.2024.01.19.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:08:12 -0800 (PST)
Message-ID: <65aa9e6c.050a0220.2c465.7a4a@mx.google.com>
Date: Fri, 19 Jan 2024 08:08:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4160558022338064379=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bap: Fix bcast endpoint config
In-Reply-To: <20240119150443.3163-2-iulia.tanasescu@nxp.com>
References: <20240119150443.3163-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4160558022338064379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818149

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.89 seconds
BluezMake                     PASS      714.74 seconds
MakeCheck                     PASS      11.55 seconds
MakeDistcheck                 PASS      160.56 seconds
CheckValgrind                 PASS      222.97 seconds
CheckSmatch                   PASS      326.48 seconds
bluezmakeextell               PASS      106.23 seconds
IncrementalBuild              PASS      670.06 seconds
ScanBuild                     PASS      937.69 seconds



---
Regards,
Linux Bluetooth


--===============4160558022338064379==--
