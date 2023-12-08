Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMdYPFMG"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F861720
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 02:05:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77f2f492a43so84894885a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702029925; x=1702634725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yFR4XD/YLVCTELsbXZVMkR9wB0rviaEshW4INodZCEs=;
        b=HMdYPFMG6CIYxtb78Lbvsc7BePI96bVKL4zDpIaoAejXTdUdpx0bWI2uIcijpP8Ogh
         CiQr+5t/G1+WqdIlzFLX2AWh6i1O/gs8DUE8QUAJ5XIfdQGa5k+df6Rs2ccW3jTxspgG
         +pA+037bhmId9HmNsWUeLKR3yr6GFTPuc4mJs1OhbjlWkSgrBVCEVAwpBrS4CEu28Hyx
         6JQpDL24VgYfY6fX6+AcgD9JReB/KtvVefvIhGN2c+qMsWqrpe3NIXbjINfToG4nWNXq
         Fi50tz6uxzbahwhLeH2FIxgqFT3tPlKSMjNRyN1Ugjd9KnAXP/Brn+UUGEM6KD+YcZJ8
         Rjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702029925; x=1702634725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFR4XD/YLVCTELsbXZVMkR9wB0rviaEshW4INodZCEs=;
        b=fvUuAfp3QMQP8GvAsAQ2My2QLayvj1Fqv6gpBNA0OnS2h5XpinM99CkEhkbIowreWT
         16tZoePhg8uoy9NBbaW38ruh8ixCK650MGC+DOsXQ2pAIqydcPF3pmsS3uLUQyEfFQ6z
         1Wn8koII8twPIV/Nl27IKO1yyoehNulU8S6z6Ps+KXJmbi4wExx0DU/Owfl/sGyU99Jg
         qp+MhHiKMt3pcpUCGEDbK6zwsNhlRl70Vu1oIw6UqzipFVOp7eZv6KxqKorsmlwC48EG
         hin+4+8BrHEdk45GNoSYQP7zdy/gZOBj0W2JjK5aQkfF4xit7jdDXOPtnFcfyMDeFaLF
         Yg1g==
X-Gm-Message-State: AOJu0YzNzbPiZBsBsTpVbFCgHkJ6Hwjln1AdFO4CTT8/3aI8yrHdwl0W
	aDId/JKbaECtO+51mT59aRmidkDDSf4=
X-Google-Smtp-Source: AGHT+IF0+pmZHY/TVF1JAvJmb6Q6aJEfHy5NpP6m929JOJhBn6RgUJ0F6n7XkoV6xVenHAT0Fd+uFQ==
X-Received: by 2002:a05:620a:1273:b0:77d:c2ef:9ecf with SMTP id b19-20020a05620a127300b0077dc2ef9ecfmr2815318qkl.51.1702029924982;
        Fri, 08 Dec 2023 02:05:24 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.147])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a22ca00b0077d8ad77069sm589004qki.26.2023.12.08.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:05:24 -0800 (PST)
Message-ID: <6572ea64.050a0220.59941.2a8c@mx.google.com>
Date: Fri, 08 Dec 2023 02:05:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3307297939131460931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] tools: avtest: Add reject-code option
In-Reply-To: <20231208090013.620051-1-frederic.danis@collabora.com>
References: <20231208090013.620051-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3307297939131460931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808168

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      23.79 seconds
BluezMake                     PASS      705.71 seconds
MakeCheck                     PASS      12.21 seconds
MakeDistcheck                 PASS      153.49 seconds
CheckValgrind                 PASS      215.19 seconds
CheckSmatch                   PASS      320.19 seconds
bluezmakeextell               PASS      100.24 seconds
IncrementalBuild              PASS      627.88 seconds
ScanBuild                     WARNING   907.88 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/avtest.c:225:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 3);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:235:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 4);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:244:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 3);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:258:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf,
                                ^     ~~~~~~~~~~~~~~
tools/avtest.c:265:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf,
                                ^     ~~~~~~~~~~~~~~
tools/avtest.c:272:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf,
                                ^     ~~~~~~~~~~~~~~
tools/avtest.c:279:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf,
                                ^     ~~~~~~~~~~~~~~
tools/avtest.c:291:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 4);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:295:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 2);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:304:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 3);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:308:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 2);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:317:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 3);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:324:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 2);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:346:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 4);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:350:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 2);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:359:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 3);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:363:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 2);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:376:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 4);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:380:5: warning: Value stored to 'len' is never read
                                len = write(sk, buf, 2);
                                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:387:4: warning: Value stored to 'len' is never read
                        len = write(sk, buf, 2);
                        ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:397:4: warning: Value stored to 'len' is never read
                        len = write(sk, buf, 2);
                        ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:562:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 2);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:570:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, invalid ? 2 : 3);
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/avtest.c:584:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 4 + sizeof(media_transport));
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/avtest.c:597:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 3);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:607:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 3);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:619:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 3);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:634:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 3);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:646:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 3);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:655:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 3);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:662:3: warning: Value stored to 'len' is never read
                len = write(sk, buf, 2);
                ^     ~~~~~~~~~~~~~~~~~
tools/avtest.c:698:2: warning: Value stored to 'len' is never read
        len = write(sk, buf, AVCTP_HEADER_LENGTH + sizeof(play_pressed));
        ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
32 warnings generated.



---
Regards,
Linux Bluetooth


--===============3307297939131460931==--
