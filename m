Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13812C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiKREHs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiKREHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:07:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865E9A5DB
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:05:59 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id l15so2481307qtv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wq6KHdki87SD5jahyLfEoqpM/+X5Am6enenBIlGIsu0=;
        b=nDBQVuGXizfVdUyN68s4J2vwIhh2g1RPiz8ksmiFSERBwQXDQPtwWe+zDmHnmmo3Ol
         VfhoyHFu/d6vh/q9op+hzu5YcFQpAIbmBxqEhaw1frUTOyTt+Jq6LhPTNQyr8OlAkW31
         xbR8UNDtdMxqm37EIttUmgd/UGeEOon0TU4D5/YTulf9v+nznAg+Wh2xTOmHk4MiB10O
         UCBIAQaiCLElvEIwPzTXbgeJSYdJ1qv1LK4Ik13EWjwJ+61lD3WaostQnLeEjt4nwaLY
         gAYrf+3/wN/W4Gg9nuXF3qIHhB0gh6/tn7WsQl7swv27f88uuakuPl6zdjZmVfaZmU/O
         GFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq6KHdki87SD5jahyLfEoqpM/+X5Am6enenBIlGIsu0=;
        b=cgCmG+NfmsZF29c4jptftfNJNyFTU9rq3DEln3Nk4tF+YOAng7Vanorac2N4DIIJCK
         FRGPOZifH378DpNKVfXLy9c4KnepiGooEqqyWq3sB/ENWYI4vvrh8Pj3RmCOxx64SVk4
         TXDUlLGyzTd/n7hJkaf0OX5jhJvlSkzpVeXu55SGBovb5+UqK44aiPijUm1sUbnvl2mV
         pQlY6l/pY+Tw+he6oZFwB3Q7lQoRAZfo41GYoVeTX2nFpFRFpvITcS0dhi48bTd0TPxJ
         0FKNfjI1rZIPsLBJ27MmChjvMDrE4kRwxnFpu1Yv8BQcS3iXGo0raCHFDJPvRSxkiG2b
         kcYg==
X-Gm-Message-State: ANoB5plAyrzhJu1vus1/ktiTNWR18n8BruU57ANMIgIBrJnMTtcaUq0S
        8r/XrJTV3cxpywqV7yOAWpLqKrsxRZ42pg==
X-Google-Smtp-Source: AA0mqf5aRzNr1ILJ1EwZzNTkbnHVJs/cxc/wGRZfH2HFCGQn7bnLkCLevd/a0sQXPNEKuAvS2ebWGQ==
X-Received: by 2002:ac8:5543:0:b0:3a5:7036:b81d with SMTP id o3-20020ac85543000000b003a57036b81dmr5155057qtr.585.1668744358626;
        Thu, 17 Nov 2022 20:05:58 -0800 (PST)
Received: from [172.17.0.2] ([20.163.207.112])
        by smtp.gmail.com with ESMTPSA id t3-20020ac86a03000000b0039c7b9522ecsm1426733qtr.35.2022.11.17.20.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:05:58 -0800 (PST)
Message-ID: <637704a6.c80a0220.b9972.7b55@mx.google.com>
Date:   Thu, 17 Nov 2022 20:05:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3753719917197447777=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3753719917197447777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      32.53 seconds
BluezMake                     PASS      997.29 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      176.33 seconds
CheckValgrind                 PASS      287.45 seconds
bluezmakeextell               PASS      112.85 seconds
IncrementalBuild              PASS      804.48 seconds
ScanBuild                     PASS      1206.34 seconds



---
Regards,
Linux Bluetooth


--===============3753719917197447777==--
