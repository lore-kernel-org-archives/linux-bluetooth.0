Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2603C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893F2206E6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2tnEBWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFELgG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgFELgE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 07:36:04 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DAC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 04:36:04 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g7so4472614qvx.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KLMOkqNzP1Ct28wQHn7k1VH7C9uI0B2Hyl+enuVIaIk=;
        b=b2tnEBWGWCHKDGIpkWjG0OOGY4avWi54nw+RbwELKqEqsfkMrIuOaRGpVoBUQevsFW
         r4ydda3ykVXLyEA3LUZAYk5NhrelTUx16pMvJX3N0eoyurJIhcYRp0G/L79fPpZNyLBA
         SmAuOJPbH0W1eGvN1738YBCZX/IWvcdl4QOxOCN1mWva5ZGXei4Bt25rHCj5yEgf5soK
         IpWB+uYelMwiWYenyFpVb4zjLWWb/9d/s3+Up3PHFyq9ZTOt57bXisNWKkYeOtFAq8YU
         zUdle0VtcfpPDawtsl8apiRf53B/ueT5gGcqbl3kpop0rG87UJX8ta6bq+XLJ6sMWJWc
         M+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KLMOkqNzP1Ct28wQHn7k1VH7C9uI0B2Hyl+enuVIaIk=;
        b=o/eE0RvDZr2hRxul4lRH01ZZw36/4RspFbML7Eml0hQZbv6XSkMqdyy70U6ZF01Z4Q
         p99LRt/WFLRiD83yS948fBO4lpsKLOrCiXmXpIdh/gBPkA2u5zr2S1o8sFdoCYCbfgKp
         0GdwNH2Ca97CdupR5d/YYtR6/ZBnO54oocHX/EuTjPnxTEWg0G5ApD+l2J3QWHylS2uf
         uwWAbgMAgQO7hWBs7JGfqm2ueBVcJ6QTRseFs3mqehP6UbU11VbqSyXpHLbYScMgW19m
         AmDbLWTHn/v/m3/BO/9US6Jm0OI0mUKr6Z2OwN3yI7xtcSply2Pl5fkJEebCGL7LWSrq
         zlDg==
X-Gm-Message-State: AOAM5313JqNJVb0uJaM7D7blD7ehwTn15oqMLibAl9mzHX8iPTCzCB/H
        pEBFuGoRd+VP2W1phNkT8rthhm3Vaok=
X-Google-Smtp-Source: ABdhPJx23F3dwoJMpfhYvZbCqlhEcoLW1wJe7WwH+ED66jNm04t1yeIHRuka4lTxne7jimq5/Yd/0g==
X-Received: by 2002:ad4:4baa:: with SMTP id i10mr9609717qvw.163.1591356963632;
        Fri, 05 Jun 2020 04:36:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.68.85])
        by smtp.gmail.com with ESMTPSA id g13sm6170530qki.95.2020.06.05.04.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 04:36:03 -0700 (PDT)
Message-ID: <5eda2e23.1c69fb81.a0d93.2161@mx.google.com>
Date:   Fri, 05 Jun 2020 04:36:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3232319704467667653=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, d.grigorev@omprussia.ru
Subject: RE: [BlueZ,v2] gobex: Fix segfault caused by interrupted transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200605111859.7742-1-d.grigorev@omprussia.ru>
References: <20200605111859.7742-1-d.grigorev@omprussia.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3232319704467667653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#14: 
0xecc6eeda in dbus_connection_get_object_path_data () from /usr/lib/libdbus-1.so.3

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '2baea85dec1a', maybe rebased or not pulled?
#32: 
commit 2baea85dec1a ("Bluetooth: L2CAP ERTM shutdown protect sk and chan")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'f65468f6e26c', maybe rebased or not pulled?
#33: 
commit f65468f6e26c ("Bluetooth: Make __l2cap_wait_ack more efficient")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '451e4c6c6b3f', maybe rebased or not pulled?
#34: 
commit 451e4c6c6b3f ("Bluetooth: Add BT_DBG to l2cap_sock_shutdown()")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'cb02a25583b5', maybe rebased or not pulled?
#35: 
commit cb02a25583b5 ("Bluetooth: __l2cap_wait_ack() use msecs_to_jiffies()")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e432c72c464d', maybe rebased or not pulled?
#36: 
commit e432c72c464d ("Bluetooth: __l2cap_wait_ack() add defensive timeout")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e7456437c15a', maybe rebased or not pulled?
#37: 
commit e7456437c15a ("Bluetooth: Unwind l2cap_sock_shutdown()")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '04ba72e6b24f', maybe rebased or not pulled?
#38: 
commit 04ba72e6b24f ("Bluetooth: Reorganize mutex lock in l2cap_sock_shutdown()")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '9f7378a9d6ce', maybe rebased or not pulled?
#39: 
commit 9f7378a9d6ce ("Bluetooth: l2cap_disconnection_req priority over shutdown")

- total: 0 errors, 9 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3232319704467667653==--
