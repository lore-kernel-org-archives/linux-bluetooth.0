Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ8T1fi0"
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8DBD56
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 21:25:05 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4239f5c1ec2so18220231cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 21:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701149105; x=1701753905; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZoD10rR8UaVkqYE/GBWvjlSYYLKnPa6oS2VRABVscg=;
        b=JQ8T1fi0qmja0Hw54kzRLzTtsw44qvfY4sFhTKYOYDxT3JvoVIEPTiRra8FXC+YO46
         8p9yRSN/oFFvSVyGu6Z/xCBfarCnKBrKul61w8LnrnofCbKU03rLo7BKNosDxSyvmiqO
         HnmmrDm5FP/Kj9/S/BRbaz57di1J33cY0Y0B3rHfspiAEjyV01JV2EzaQkBWjjN8j0sj
         TS3IjRg0uIxQcfTZU0dO3Ha40+HJ5nY0mYxldYL7Z5A+AugCzZ4FLNN/4kiDfJYcA7Ar
         4BljLqIblELZt3M6fUf1jntkLl1Fdur9rzq2ArfBquuEImKHrWSFocBfYv7rLQk9W543
         BYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149105; x=1701753905;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZoD10rR8UaVkqYE/GBWvjlSYYLKnPa6oS2VRABVscg=;
        b=dMr6P9bUmhxnpNDXU+ya9fvQBfSjEHMVG+iC+8QL1MCbzLDk1JyZ8nYKKRDD308gEZ
         pQduZ4GZtucdgnkKNT9E7Rfl5wuu/WTZ/atXiClSn+F+2gL506fFKqNQAxC3udn7GW/c
         iqCCusj9RXgTyo9qR7rFhpwS7fKX+QMsx/RVTYG1srZTvyoGctTatuu6SjKV17qL0H0c
         2zAFlJ2ZDPRwSoLCsJu4ukIVWDJmN7ERaMuaApkZoAHaRPwEw23HJDu3DIBEgU6i9sfu
         AUovtTJHDPVDw5J/hLe4LK+HspLEjQ9e5ihB9p7BKZPVJaZDPaODs+vbqu3RNNlrVit5
         jzPA==
X-Gm-Message-State: AOJu0Yw2QiDSHzVrd+6WUhxSSA+pNz7aGT6oxoICFKLYnCJ6WfzOWT1w
	UFhbgb0DRyIkG2bi4BwJ5qnM9MYr/EU=
X-Google-Smtp-Source: AGHT+IHI9R0ynR5WZkm8qlqke5PfazSLjP4wsxTcjxAYPdjPQ6ah0Ob6rQ6wHqVVQ1EeqIqEgW/LuA==
X-Received: by 2002:ad4:5152:0:b0:67a:1f78:5dc with SMTP id g18-20020ad45152000000b0067a1f7805dcmr11400585qvq.30.1701149083946;
        Mon, 27 Nov 2023 21:24:43 -0800 (PST)
Received: from [172.17.0.2] ([20.185.156.192])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a440b00b0077d9fdde1dcsm1866550qkp.42.2023.11.27.21.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:24:43 -0800 (PST)
Message-ID: <6565799b.050a0220.fbcac.80e7@mx.google.com>
Date: Mon, 27 Nov 2023 21:24:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3025096590356357019=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: monitor/intel: Add decoding of firmware SHA1 in read version event
In-Reply-To: <20231128042922.2514576-1-kiran.k@intel.com>
References: <20231128042922.2514576-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
X-Spam-Level: *

--===============3025096590356357019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804725

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.53 seconds
BuildEll                      PASS      24.25 seconds
BluezMake                     PASS      547.27 seconds
MakeCheck                     PASS      11.13 seconds
MakeDistcheck                 PASS      151.07 seconds
CheckValgrind                 PASS      213.09 seconds
CheckSmatch                   PASS      319.63 seconds
bluezmakeextell               PASS      97.62 seconds
IncrementalBuild              PASS      511.68 seconds
ScanBuild                     PASS      937.32 seconds



---
Regards,
Linux Bluetooth


--===============3025096590356357019==--
