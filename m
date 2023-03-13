Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A4C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 19:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCMTj6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMTj5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 15:39:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997B7F014
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 12:39:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h19so14441605qtk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678736395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FsLGDaHA5CYVdwOe9pF0XE5JrEEJ9WVsRaEol9ZE+M0=;
        b=GJoJ2boO3v+V1PiXraRDP9Z/f8vEwL4yJR9tXOU6NOGR+KpoNIuqklWTHTTcl3nJ/w
         aqIjIGNVL3YHDGmAyB4Y24+PTPxKpAy//TuE/cN/UwVnzsjDANGNdNC7QnXqJE1RB1Xa
         Mn4j9Wbx8ye5+JkdNwKCrunOlqm8yLn/FQD/nzZttdDR72z88YsRy+To+b2VJTY5sE1V
         zpKkd56pE5rr5NZAFzoH+m6fWlC6qGskAL/ObPQGJLuRKeCHGUAJFWBvGGndRoPqL5sc
         bbYCd1PvMdDwv08L7KDPmNAke57OkS/AuvTgpjm4ESsPhPeweOHKHZFlliPMBO/3e9Jr
         fwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsLGDaHA5CYVdwOe9pF0XE5JrEEJ9WVsRaEol9ZE+M0=;
        b=GtGyGPI7TDrsWHCS5TUXMzCsBn+Jou+SJyWtmer8csqyR0siJqKqOMyzWyN7JnHbq3
         hf9gz423qiBwXAfjDIQRSbfsb9ZlrtHIlJ7kVDdQ61Knpnxa7eao+MM4Oz5sW9gBG17n
         PGXkGHC5KyrPj+GkGN7A3laT000D9k8sk116e+rggqm6enLCXKoRM/rOmymLrx/cXY43
         9lib2Z6BiRTySKrYQqdt5hi2iQy//XYmkigRp7keIOD0OTHA03b27fcPOXsiMV9I/H4E
         CwvofzURCFqutGIfFFiPkB5vEbQCHhLyjgN4c3k/jxULzGBS7RFk7knxOPHLu/FtBGKG
         1Zgg==
X-Gm-Message-State: AO0yUKWAmUb9hTWWqXs+INxZSkOplcJFl6F8xyySSEYsC/otFts6G+7u
        khfuYM4NS8SkBldTYh3Qa+9+J0K+spY=
X-Google-Smtp-Source: AK7set8kpL/HEmltECzpUFEhvW6dBv0G75ryf7VLSucfDTiu0/8CQlCAqfYglLzMwiI/xbD2tjv8zw==
X-Received: by 2002:ac8:7d52:0:b0:3a8:1677:bc39 with SMTP id h18-20020ac87d52000000b003a81677bc39mr32495629qtb.52.1678736395683;
        Mon, 13 Mar 2023 12:39:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.60])
        by smtp.gmail.com with ESMTPSA id 7-20020a370707000000b007456efa7f73sm286055qkh.85.2023.03.13.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:39:55 -0700 (PDT)
Message-ID: <640f7c0b.370a0220.8e37c.2112@mx.google.com>
Date:   Mon, 13 Mar 2023 12:39:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7192074317265222106=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix crash attempting to read Sets property
In-Reply-To: <20230313183121.162037-1-luiz.dentz@gmail.com>
References: <20230313183121.162037-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7192074317265222106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729577

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      27.32 seconds
BluezMake                     PASS      871.82 seconds
MakeCheck                     PASS      11.35 seconds
MakeDistcheck                 PASS      152.15 seconds
CheckValgrind                 PASS      249.23 seconds
CheckSmatch                   PASS      337.61 seconds
bluezmakeextell               PASS      100.19 seconds
IncrementalBuild              PASS      724.58 seconds
ScanBuild                     PASS      1055.53 seconds



---
Regards,
Linux Bluetooth


--===============7192074317265222106==--
