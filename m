Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB9C05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 02:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjAXCyl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 21:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCyk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 21:54:40 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0B3928C
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 18:54:39 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so8479860otr.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 18:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qy0pWI8rq5+DKiVVM1WAIbCWu8XHVskuBFK+iL5BDWY=;
        b=b5YWqzaTzGyEu17V2u95OK1/FD6CAWRELNffjeD3IGEAII1ncrCZbTmlZ0DWJkR7gq
         P2YYw96jdtc2GZ9aE7MH8u0bKnd9UV82FLd+ntIe7Qd2vZakZYo91BOPMft0Bpg8Ujge
         1pBL14sowIa3q6U2hM1zf/rPOzVsRpmA0eEDa5ag/8aVKKCWWiqKRjfLCDzme3EbE/Tq
         whT8TjXYmGItIDelocdrkXYjbl+2Cz7FGQw2ywLjBN0DJ80EBlvYYbTltJNvseAWRkyS
         EFzuybatRjV2i50LninFua2vJYVZUf6C5m+NSPd+jD0WpQ78A9AXARFrDlH/tX3quEe8
         KrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy0pWI8rq5+DKiVVM1WAIbCWu8XHVskuBFK+iL5BDWY=;
        b=r74vVxfi33ikqmkU6+i2ubnWiNeQnYT/SxVRn3G3sVKSmJONgzFOUucKVUZfGsHf8k
         ZZDXtzYhTaGc8YaOUKVOyZXhgvEwhn44tp6CBBLXt0N2tJHhZN/LExLlJ01h0lxcbFrw
         4djX+naPrgz9qTeMN24uNnkDkh0GgRtLxrQcoMPJqWb48/gwwdt4PP3shatsG9EjTp1R
         K8C35RBRqDiSxGeJUI5IOU/fPNnMnACQoVhDEBCJzf7MtMSsjEcvzpQYnBIDee7oxvB1
         ngROyjPjoFpaNLhSVKi1Y51Le1Y13/n2/fhTpjFH4+fW0EupcXzOnFIN7ftMTQxkmlmk
         vlJA==
X-Gm-Message-State: AFqh2koujWabNlXe6+LXJMgqQQP/FN+3MZ6qRPLWy7UXoJv3YN9RDR5D
        GjuirxTNJuIBiHjz+s8UEkmxOUsphA0=
X-Google-Smtp-Source: AMrXdXuox6np0roX3uNHsELNaw/VALpbOzNPNu8T0nHUXPU3eXRrfNdReC/di3MVNma3ZDm+GrgHfA==
X-Received: by 2002:a9d:744c:0:b0:684:c630:beab with SMTP id p12-20020a9d744c000000b00684c630beabmr14291155otk.17.1674528878924;
        Mon, 23 Jan 2023 18:54:38 -0800 (PST)
Received: from [172.17.0.2] ([70.37.167.33])
        by smtp.gmail.com with ESMTPSA id x17-20020a9d6291000000b00677714a440fsm386497otk.81.2023.01.23.18.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 18:54:05 -0800 (PST)
Message-ID: <63cf484d.9d0a0220.e90c5.1e97@mx.google.com>
Date:   Mon, 23 Jan 2023 18:54:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0275860990467718623=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] profiles: Add Support for Metadata, CID and VID
In-Reply-To: <20230123235649.3231488-1-luiz.dentz@gmail.com>
References: <20230123235649.3231488-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0275860990467718623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=714926

---Test result---

Test Summary:
CheckPatch                    PASS      2.36 seconds
GitLint                       PASS      1.39 seconds
BuildEll                      PASS      28.94 seconds
BluezMake                     PASS      852.13 seconds
MakeCheck                     PASS      11.24 seconds
MakeDistcheck                 PASS      147.20 seconds
CheckValgrind                 PASS      243.48 seconds
CheckSmatch                   PASS      325.93 seconds
bluezmakeextell               PASS      97.34 seconds
IncrementalBuild              PASS      3509.77 seconds
ScanBuild                     WARNING   987.58 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:2664:13: warning: 7th function call argument is an uninitialized value
        endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============0275860990467718623==--
