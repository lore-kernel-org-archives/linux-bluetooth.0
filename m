Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETnkdvMM"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB1610DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 09:04:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cbe7386263so4274004b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701191067; x=1701795867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucxx7yCcwwx3Dtt5jQjsdsGEp7XSGKldTFxn9xk3dWo=;
        b=ETnkdvMMm9ajNrMLTmBh7O7CcRxxLrt/y30vn/wJicuULQ8xs5hL+/UK2Jh1F7lWSZ
         VffUIfNVH4itYZYANeckZuQqdsdWiO15PBcUfRApOGYwuxxWkmSldl9jnYBhzWAZuI/x
         wgfAaBo5jmHLZHS0u4hW9GqK9YMRwshSEi0vEcWfAnE0zUtryqRLgjtm763dpWjHnW+P
         +IGGNYCNI5gcJGtEo5HpcqXcDEu7DGAkJGZHtmuRiNIfw09vmGIQKfgeZW98uCP1BGhl
         Ds3mH3udSvfjRhtbrjLqClAeLl8G4OYpEokLf6lPwAjsIJ01aO30/3GsXAr/+afBck0m
         R9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701191067; x=1701795867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucxx7yCcwwx3Dtt5jQjsdsGEp7XSGKldTFxn9xk3dWo=;
        b=JqLr2NIZsIzQEGeDpchQl6pj+AqIbBtsS3T/yZvnh+WFc5AF2YOcyrEZD+OYbBmHe6
         0yhFhCXAsXqnGZADdv460Rn0uUyMuHJfB+hRNCXG/9Oo4zgI/xohlLT6bEgT+GhVn9hp
         ctFjmxE5DUYpFsUpcnhXyzGE6B8xy8kJk0c16t34w9MTm3PK1jgM5XCihAzgm9A+cGJF
         3iuKadqhNnydbV1rwhhniAK3fQBO52sfYoiPmSHCtUPZjJ6Dujj/sFGF82NtDrEdKenD
         3YlcIiyixE55sJ+U7UmHU+l3pQfGPfSoykR+Na7tQJDaGCMxyxKVKVWBERmE55X8Xtcj
         KjPw==
X-Gm-Message-State: AOJu0YwaZvU4LUZSkN/Qs/xUMuGh5UtAwC31P2nwXbL7aSab30xWUR39
	ffpte3iw/1GbYEKGetRg0Nne/IXR7ko=
X-Google-Smtp-Source: AGHT+IHILekPOReAO763I3JTskSDvFT7PQkhCDgKMHg2+zeZ/s+JjILnjWZAfU3y7/SPzVTRN4yTxA==
X-Received: by 2002:a05:6a20:5491:b0:18a:b5c3:55c1 with SMTP id i17-20020a056a20549100b0018ab5c355c1mr17764058pzk.57.1701191067633;
        Tue, 28 Nov 2023 09:04:27 -0800 (PST)
Received: from [172.17.0.2] ([20.172.17.135])
        by smtp.gmail.com with ESMTPSA id h13-20020a62b40d000000b006cb60b188bdsm9290022pfn.196.2023.11.28.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:04:27 -0800 (PST)
Message-ID: <65661d9b.620a0220.fb397.7691@mx.google.com>
Date: Tue, 28 Nov 2023 09:04:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3183574452904976836=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] isotest: Fix high-reliability QoS presets
In-Reply-To: <20231128153303.1731575-1-luiz.dentz@gmail.com>
References: <20231128153303.1731575-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3183574452904976836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804917

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      23.88 seconds
BluezMake                     PASS      541.78 seconds
MakeCheck                     PASS      10.65 seconds
MakeDistcheck                 PASS      148.23 seconds
CheckValgrind                 PASS      208.38 seconds
CheckSmatch                   PASS      312.62 seconds
bluezmakeextell               PASS      95.40 seconds
IncrementalBuild              PASS      497.86 seconds
ScanBuild                     PASS      884.68 seconds



---
Regards,
Linux Bluetooth


--===============3183574452904976836==--
