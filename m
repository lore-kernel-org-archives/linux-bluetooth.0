Return-Path: <SRS0=5fpF=AO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 16:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3927208FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jul 2020 16:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtqjlbhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGCQsJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgGCQsJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jul 2020 12:48:09 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D2C061794
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2020 09:48:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id p7so14513730qvl.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2020 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+Up3ZyusUMy5a05aqkaTQkkIYPZzDl5XBJxyPMX+it0=;
        b=PtqjlbhSLTmQO1d7KKTY+8lTpdB5g+QZ6wapSwOgt5FythAPnLehodmvuohu6Jydg/
         8wKYFTxGLgguWfHNWwD2w028isoYkscPOWDfaFy7tE4f6CR5BaVRgK4K+KpGpyOj0oF1
         Vy+956THND+H1LBWGxcACs+DBf8cSRBjozvqVSKnNWtqxblw6ybdkBzENbhcsF88dECb
         DZ0ghvJ9il/zneRdhASyIGhTxW1Lhop2G2FLTQO2NruZuX+Ozh3nT4yKSv5dZTIpsteg
         oK9gd/cv9KpUf0epbxg4DrIh1r9MnlmHwBeTlA64hMk3/s5FgcmluwOk8c9lV/D8KNty
         mcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+Up3ZyusUMy5a05aqkaTQkkIYPZzDl5XBJxyPMX+it0=;
        b=R02OngppKUBMe+0x2Yap5plHTUKtR6JzJbBzhLRlK94b90WuMKtckAkt76jGQA6VIj
         Nyu3zvHZNsrw43moTXm2u3gZv4opiYBZfj+bZBlU3V6U5mH+5S0Ml5WKluNlZpMh0xfg
         LCT3hZ2BwH7qPoCBwTloSKfZ49ym3vG7ufV4N/+Y5SKn6OI0aSFpTKl9AVn35rwKR3PO
         DaoEYY2OwcjdhMKq1asfUWBFX5vzpG9zixqNK9Bg8djxfWlX/LCLnWaAx5LU/d0+LsQ5
         f8SvX1BuuBppV6LxL/l2GpK2s8dnOMKk5z2JEMephozvbRA3SqL8l++5O6Bu8EVEQh6z
         UaSA==
X-Gm-Message-State: AOAM5335YYPkJj5w6G4TH0y44QL60uWpW+I7lVjDHCMoOoldU3OckCQW
        y9ENN1TRf4rInMPKCvEwT8Heq8mk2Xw=
X-Google-Smtp-Source: ABdhPJzzM3mYpacsN2/wNA/Q9AMF3j98FaaWEvUTVTX6/bCWcW1uq1+n4ootpI40yKfEKZ9vV2M7wg==
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr34934204qvu.206.1593794887998;
        Fri, 03 Jul 2020 09:48:07 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.240.96])
        by smtp.gmail.com with ESMTPSA id h41sm1041599qtk.68.2020.07.03.09.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 09:48:07 -0700 (PDT)
Message-ID: <5eff6147.1c69fb81.05e7.58b9@mx.google.com>
Date:   Fri, 03 Jul 2020 09:48:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6795625013646968184=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Fix Seg Fault - App unattached IVIndex chg
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200703162018.940172-1-brian.gix@intel.com>
References: <20200703162018.940172-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6795625013646968184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
18: B1 Line exceeds max length (92>80): "2  0x00448980 in l_hashmap_lookup (hashmap=0x46b550, key=key@entry=0x0) at ell/hashmap.c:487"
19: B1 Line exceeds max length (186>80): "3  0x00444704 in _dbus_object_tree_property_changed (dbus=0x469438, path=0x0, interface_name=0x44bb74 "org.bluez.mesh.Node1", property_name=0x44aa18 "IVIndex") at ell/dbus-service.c:1196"
20: B1 Line exceeds max length (165>80): "4  0x0044545c in l_dbus_property_changed (dbus=<optimized out>, path=<optimized out>, interface=<optimized out>, property=<optimized out>) at ell/dbus-service.c:1804"
21: B1 Line exceeds max length (107>80): "5  0x0041805c in node_property_changed (node=<optimized out>, property=<optimized out>) at mesh/node.c:2392"
22: B1 Line exceeds max length (93>80): "6  0x0040c690 in update_iv_ivu_state (ivu=false, iv_index=0, net=0x46e240) at mesh/net.c:2569"
24: B1 Line exceeds max length (149>80): "8  0x00431edc in l_queue_foreach (queue=<optimized out>, function=0x40c468 <process_beacon>, user_data=user_data@entry=0xbefff1e4) at ell/queue.c:441"
25: B1 Line exceeds max length (140>80): "9  0x0040a848 in beacon_recv (user_data=<optimized out>, info=<optimized out>, data=<optimized out>, len=<optimized out>) at mesh/net.c:2647"
26: B1 Line exceeds max length (182>80): "10 0x00431edc in l_queue_foreach (queue=<optimized out>, function=0x408bec <process_rx_callbacks>, function@entry=0x15463acd, user_data=user_data@entry=0xbefff230) at ell/queue.c:441"
27: B1 Line exceeds max length (188>80): "11 0x00409ec0 in process_rx (len=<optimized out>, data=0xbefff297 "+\001", addr=0xbefff258 "\260\362B", instant=4646248, rssi=-78 '\262', pvt=<optimized out>) at mesh/mesh-io-generic.c:121"
28: B1 Line exceeds max length (101>80): "12 event_adv_report (io=0x46c3c8, size=<optimized out>, buf=0xbefff255) at mesh/mesh-io-generic.c:159"
29: B1 Line exceeds max length (112>80): "13 event_callback (buf=<optimized out>, size=<optimized out>, user_data=0x46c3c8) at mesh/mesh-io- generic.c:172"
30: B1 Line exceeds max length (148>80): "14 0x0042ff58 in queue_foreach (queue=0x46d370, function=0x42f2b0 <process_notify>, user_data=user_data@entry= 0xbefff289) at src/shared/queue.c:219"
31: B1 Line exceeds max length (108>80): "15 0x0042f674 in process_event (size=<optimized out>, data=0xbefff283, hci=0x46c3d8) at src/shared/hci.c:258"
32: B1 Line exceeds max length (84>80): "16 io_read_callback (io=<optimized out>, user_data=0x46c3d8) at src/shared/hci.c:286"
33: B1 Line exceeds max length (95>80): "17 0x00432600 in io_callback (fd=<optimized out>, events=1, user_data=0x46d318) at ell/io.c:126"
37: B1 Line exceeds max length (99>80): "21 0x004337b4 in l_main_run_with_signal (callback=<optimized out>, user_data=0x0) at ell/main.c:642"
38: B1 Line exceeds max length (85>80): "22 0x00404e90 in main (argc=<optimized out>, argv=<optimized out>) at mesh/main.c:269"



---
Regards,
Linux Bluetooth

--===============6795625013646968184==--
