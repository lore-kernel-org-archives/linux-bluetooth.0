Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh5PQklz"
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A725FDB
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 10:28:33 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-589d4033e84so2776597eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702319313; x=1702924113; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0eCRHruNe/Ygr4sSFy15UDDmJ0IyM2gJ3MPAmvfJY=;
        b=dh5PQklztsbPy4qmT4p24Q+KOwfeYOs7q21ZhJdx2fLfCQuBg9aqiGRQ6I0JVWNorD
         ngDAmFgHLX45V2uWFhwIQ7J0e3M2Rnuo+GmafmziUNRJ5STV7pAQKLQ7ckEaBPA567Qi
         A+Xonp07AuqrxNnZ9O5PQgLFJNS7OnhvnYfl2ijR5GDiGoKNNb29c/xJ4j0rmu4D7BKu
         T4z9xlJU8lQ/CAcdK5W1lVuua+S/poa9WAkeH0a+tz8jimMpc9DvCPcH36QQOMlo0fbU
         E1/7yCSTpnpbMLcvCmfp2IuNvnjsuTRJQputBiw+Y59PritV4OSCDtGPpBe2iY66T2e2
         hjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702319313; x=1702924113;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJ0eCRHruNe/Ygr4sSFy15UDDmJ0IyM2gJ3MPAmvfJY=;
        b=f04W+H6+0TqDRYHW08Pe2xOmXUDdbFvU6qCh2D2TjLvB0O6ctPuDWg6q1aKihUTKmx
         g+XIHNgHTyxx/0AFNqv3TbcZNHXM6l0mYFW99kII5FScVmCUj2nqSitLkWetqY1qSb0l
         CEjbo5C9eui9jPFqfE74U6WFHT6PvfYCD7Y5NBnvThV5NUv34tqPkobTS+s0PjYkQkPb
         sbGmcn1Q/CI4ES2VmAqKwRyT6KbeHq1uIHLf7sT6URxUNFCL8ImjNoepqqdeAvJ4RXBR
         ZmJHWWq0RtJnzN4I/+V3R880S7x6Qe+sdTrIcSxoM3+kiYbaOe8doEiD2juGhWBA9/sD
         z/6A==
X-Gm-Message-State: AOJu0YwYCVoRrHDPpWFqDr4fvs593v1F89UZyEt0dIOtfXbdwG0p1lEg
	XhwVECavG91WIkCkJrJ4JD1TJGybzho=
X-Google-Smtp-Source: AGHT+IGVpPHrNPgXBfK77u8RyDPQRQTzlRZMH2HWunAcertv4E5ZzDjfJwiiQw34unHF49vDp9MqWA==
X-Received: by 2002:a05:6358:7f05:b0:169:9c45:ca12 with SMTP id p5-20020a0563587f0500b001699c45ca12mr5930111rwn.23.1702319312866;
        Mon, 11 Dec 2023 10:28:32 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.208])
        by smtp.gmail.com with ESMTPSA id m8-20020a0cee48000000b0067a8cd6f034sm3500186qvs.138.2023.12.11.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:28:32 -0800 (PST)
Message-ID: <657754d0.0c0a0220.35859.edef@mx.google.com>
Date: Mon, 11 Dec 2023 10:28:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0752979084000937778=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/vcp: Fix notification endianness
In-Reply-To: <20231211171135.437354-1-luiz.dentz@gmail.com>
References: <20231211171135.437354-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0752979084000937778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808878

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      23.84 seconds
BluezMake                     PASS      696.67 seconds
MakeCheck                     PASS      11.47 seconds
MakeDistcheck                 PASS      153.50 seconds
CheckValgrind                 PASS      215.13 seconds
CheckSmatch                   PASS      318.62 seconds
bluezmakeextell               PASS      100.52 seconds
IncrementalBuild              PASS      641.15 seconds
ScanBuild                     PASS      907.11 seconds



---
Regards,
Linux Bluetooth


--===============0752979084000937778==--
