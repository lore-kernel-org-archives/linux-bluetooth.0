Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD509E7D0C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 03:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjIVDXe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 23:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDXd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 23:23:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CFB102
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 20:23:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1183450a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 20:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695353006; x=1695957806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrDNR1R1Ax/SXMx3+8Tht6sBUhoSwk+F/XvoeSUOfQ=;
        b=KyH+Fvt4qCfl8vdyBtEXIOGSU/A1+ChyW6JJH1TaOi+kIj47beukQkqbYUckppj3Vc
         oobkjeoqMvy0MvyZm/tVSkYPPNjnATDrK3Fn4WyWYRd0aQq9+zxLLEn3/cWg77NPBgCk
         wTWRRkudqpX+TwTx64gRvylH3DLgB+jXTUc+I6ax5i6FLggoyURAxK6fx3bl/QsC7LcG
         pr0m/yPb1Xdlr64wG4ik768YuMGFsn+vjRrea9v28PuZw/D86crvw/GonJtugZVzjM00
         dx414blLkeInx7NdUBEuwmFm95aLg877BTWFqMELhxmvQB5l9lacGScmgawD2Wy8FJ0S
         M+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695353006; x=1695957806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFrDNR1R1Ax/SXMx3+8Tht6sBUhoSwk+F/XvoeSUOfQ=;
        b=pteJExO/Nor94wYk+FpoYuwuoFOqivF6d2Zogf9y5JjzEHP+uo4MXiJyhawcMndaiq
         KIl+7JMUqMGHaoIl68nlTnxG1QzT1//aDDFW0tW+OIJOXf8B9KC3nwjCroZVd8xEkHOO
         LstLIVjqLp+7twvhr+N8wEA06tsZYfeeXheCoRHb+EsiaCf12BHltcJZ69Gm+srND2AQ
         QkYZnknvjrdkU7ProqqPiSLKXitpGjFaFg9zMeRyky/rABYCzPUltpZff9L8KIMk6b7h
         WtuxmkrSFJI0Hu9evBbOc2LHMTjhRMUUAEbxUkOuKUFv8izvv0Hf+rCbJ3fCmv+Ni+W6
         3B9w==
X-Gm-Message-State: AOJu0YzLI7tONVNI7c0r26WBZzsRI/oDX81VILFUpLODEe/IvhMyHuyf
        ROBaUoraSwbQuYHX0kyhghz7ktrgwUQ=
X-Google-Smtp-Source: AGHT+IEHpS1BdjyVOlkItPE6LMaNQpvbyiSc2ApGwgldRppnE/julyULEQNtoFLMQe6oltC0wPYa4Q==
X-Received: by 2002:a05:6a21:a58c:b0:153:b57b:2504 with SMTP id gd12-20020a056a21a58c00b00153b57b2504mr8561189pzc.58.1695353006048;
        Thu, 21 Sep 2023 20:23:26 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.161.18])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902744b00b001b9de39905asm2319734plt.59.2023.09.21.20.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 20:23:25 -0700 (PDT)
Message-ID: <650d08ad.170a0220.dc361.dbe0@mx.google.com>
Date:   Thu, 21 Sep 2023 20:23:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3763409803406211464=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] media-api: Update to reflect the last code changes
In-Reply-To: <20230921234738.929423-1-luiz.dentz@gmail.com>
References: <20230921234738.929423-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3763409803406211464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=786455

---Test result---

Test Summary:
CheckPatch                    PASS      2.52 seconds
GitLint                       FAIL      1.58 seconds
BuildEll                      PASS      34.31 seconds
BluezMake                     PASS      1192.51 seconds
MakeCheck                     PASS      13.44 seconds
MakeDistcheck                 PASS      195.33 seconds
CheckValgrind                 PASS      314.03 seconds
CheckSmatch                   PASS      437.84 seconds
bluezmakeextell               PASS      131.38 seconds
IncrementalBuild              PASS      5145.48 seconds
ScanBuild                     PASS      1374.82 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,3/5] client: Make transport.show to print QoS property

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	UUID: 00002bcb-0000-1000-8000-00805f9b34fb"
11: B3 Line contains hard tab characters (\t): "	Codec: 0x06 (6)"
12: B3 Line contains hard tab characters (\t): "	Configuration:"
14: B3 Line contains hard tab characters (\t): "	Device: /org/bluez/hci0/dev_00_AA_01_01_00_03"
15: B3 Line contains hard tab characters (\t): "	State: idle"
16: B3 Line contains hard tab characters (\t): "	Endpoint: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0"
17: B3 Line contains hard tab characters (\t): "	QoS Key: CIG"
18: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
19: B3 Line contains hard tab characters (\t): "	QoS Key: CIS"
20: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
21: B3 Line contains hard tab characters (\t): "	QoS Key: Framing"
22: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00 (0)"
23: B3 Line contains hard tab characters (\t): "	QoS Key: PresentationDelay"
24: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00009c40 (40000)"
25: B3 Line contains hard tab characters (\t): "	QoS Key: Interval"
26: B3 Line contains hard tab characters (\t): "	QoS Value: 0x00002710 (10000)"
27: B3 Line contains hard tab characters (\t): "	QoS Key: Latency"
28: B3 Line contains hard tab characters (\t): "	QoS Value: 0x000a (10)"
29: B3 Line contains hard tab characters (\t): "	QoS Key: SDU"
30: B3 Line contains hard tab characters (\t): "	QoS Value: 0x0028 (40)"
31: B3 Line contains hard tab characters (\t): "	QoS Key: PHY"
32: B3 Line contains hard tab characters (\t): "	QoS Value: 0x02 (2)"
33: B3 Line contains hard tab characters (\t): "	QoS Key: Retransmissions"
34: B3 Line contains hard tab characters (\t): "	QoS Value: 0x02 (2)"
35: B3 Line contains hard tab characters (\t): "	Location: 0x00000003 (3)"
36: B3 Line contains hard tab characters (\t): "	Links: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0"


---
Regards,
Linux Bluetooth


--===============3763409803406211464==--
