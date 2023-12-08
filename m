Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J05mgJo+"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B718A10D8
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 03:32:19 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fb71880f12so1239956fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702035139; x=1702639939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WceH6dZvtt558SBBj3b1I9ngGpa6TenxZzXLsOjTqmE=;
        b=J05mgJo+1o+o58YrQrpj7KArOG/sFuo3GtJlsz8fYoFKuOEGltD4DPPYmS0SHHyU06
         f+ciRSr3GWXw5ZR+OumniH91NldEivh8J6flhVq2uy5zD8hk1lKgdq20Zsk/rwo9pnAD
         Y1l6Is7UCamQqouVhqyyJeIZlLG2tbxwPSSWsFaYpjhPTJzMi5Fik5EDJxrplGGls5Dq
         U68CIF81Bk9b3RipYv2/SGlC+nMRnV+5ltgkRSE6AfDMCwMFTq732m87zOKLRawfQzq4
         tnHp2f8HW1ZjknXpSrH2Fu1E47BQWuj0OgyU9v+A+hfnCSHJFWEp23jkhSx3+632u28N
         KneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035139; x=1702639939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WceH6dZvtt558SBBj3b1I9ngGpa6TenxZzXLsOjTqmE=;
        b=kKlc/L3McvBWGcWNoJsoCsR9YIFeSOBU6mZQ2BmKeiMOuSDY/5vn362vXcN4wkMU8e
         xDAzyiYUsD7Ra9XyuohMkRn8Sb95zzf1iPSQyM9S6j3r2v/oVY5pT8HYjk5r6G2j0Gyf
         OuNVN1KNeb3y3AkyGBKCDpFZvVbAI8TNCQUUnov4Wk0WIJi0Elz4ixYOgXoCHkz2tEmK
         usqtu9bwFH/kRtgIRau20f3QQrXD0NYbcA1pWopANadIHqZHoQKnTYzbfOw07UkAQjE8
         /0jMae7/s9cqzRcMQh0CIPJavNLAV0NM5SmXpLUPSZ8uELWGOPTVPRBgsf2SnCqc1Qmy
         CZxg==
X-Gm-Message-State: AOJu0Yy7mJh5zYXLhE2pJkeDuLzjtNByuod68b68jFdTa5ObKsoFSVku
	gTRgg4LYgCS4ndOO6qHpV15aELV6kdk=
X-Google-Smtp-Source: AGHT+IEFX9B9VyFwkbXOKURGBaxK0pFABDL3xqINJ5F9HzOvvSZOt/HdEsGCIJTxOZqD1B0QXlbtIg==
X-Received: by 2002:a05:6870:2189:b0:1fb:186d:7409 with SMTP id l9-20020a056870218900b001fb186d7409mr4178442oae.71.1702035138775;
        Fri, 08 Dec 2023 03:32:18 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.223])
        by smtp.gmail.com with ESMTPSA id f7-20020a656287000000b005c66e25497dsm1168259pgv.83.2023.12.08.03.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:32:18 -0800 (PST)
Message-ID: <6572fec2.650a0220.392ee.32a2@mx.google.com>
Date: Fri, 08 Dec 2023 03:32:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0822033811619316929=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] tools: avtest: Add reject-code option
In-Reply-To: <20231208101711.624001-1-frederic.danis@collabora.com>
References: <20231208101711.624001-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0822033811619316929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808201

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      5.31 seconds
BuildEll                      PASS      24.14 seconds
BluezMake                     PASS      722.61 seconds
MakeCheck                     PASS      11.68 seconds
MakeDistcheck                 PASS      159.32 seconds
CheckValgrind                 PASS      221.07 seconds
CheckSmatch                   PASS      328.72 seconds
bluezmakeextell               PASS      103.24 seconds
IncrementalBuild              PASS      677.93 seconds
ScanBuild                     WARNING   977.76 seconds

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


--===============0822033811619316929==--
