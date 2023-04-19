Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F2C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 16:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjDSQOi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjDSQOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 12:14:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8174172E
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 09:14:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b87d23729so61311b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681920875; x=1684512875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thn6E5ysjGjhpaysTDAAhBKGnqxtgGVQIBPPpemkKg=;
        b=amm9iJpyjnHgtla0owm/pmwJQrbsS7hrk45t5fgJhJnd7ywLzlgIU+qweiosGsNP8Q
         9ef6F45J9E+X/wal9GWig0At1H901Ln3hXMmRZdQ+mAIQSxIkZTKi01ZMuumrM+JF2SU
         o/gWcrgSzD02uXKJ3Op0r1mMl5TpEujw/C8fYzZ8cTU3zTpES3YZhLx6vB3SkZqd7atE
         Ne05owqCCgMet3qfEefG+Rz4AH/USoOHYjfMBqo7Y7tSXrv12WhAxxFSLg0tVbNwQ8fg
         UOJ8LmIvbVQNZJv9dBz7RF+b9VDqYO2ovk3Vi5FOgjUaRMik/QHzONzu7InJbCROdsv9
         aJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920875; x=1684512875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9thn6E5ysjGjhpaysTDAAhBKGnqxtgGVQIBPPpemkKg=;
        b=I9A8BXIPTeKSSiWv3ePnhk/V9Q4OT0Um4y9dtWs4AAFTx6WDmil+F/NjSHVjbzU4cj
         j+2PYJ+7Zt37i5Wc0omD0vcNyHye5f3Dg8NGHk0Rd8BAAQANzDpbHBoT6giDuo6z8rpl
         9qikxUAf4Vvdr1M45KoeDGtKl2q0ONkEnOA4212WNkGYNc7n3kVyo+viRLcYHKyTPq2w
         OQpqYXh5xVMx6ZpmDJvAbDF9haYYMB508PnSYow8YRL1pD7vJYzCPMao16hkIffqjoP1
         ibh2dWhLzRe3Vg21RfZTfkFe1WFWVAGnjhuRxF2+L3MtVloM57J8YFOnvre5EZ6CLRWc
         ow/A==
X-Gm-Message-State: AAQBX9dybMOg+Y0Sm+utjhqpKQoA6Zr6YMYREg++9RpwsRg0+NwOnTfc
        S6ryZCdwXYyGSXhBQgzpbjkUXkUtt9ntDLaV
X-Google-Smtp-Source: AKy350ajtydKgML5r6DeyRxcEg+irYBpXCQsp9yH1LK3860CZQXBip51UiLJp+7tfxa00SZ8MwGK+Q==
X-Received: by 2002:a17:902:f70f:b0:1a1:aa68:7e61 with SMTP id h15-20020a170902f70f00b001a1aa687e61mr6623347plo.33.1681920875121;
        Wed, 19 Apr 2023 09:14:35 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.65])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a7f0600b00246578736bbsm1609737pjl.8.2023.04.19.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:14:34 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     pmenzel@molgen.mpg.de
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3] obexd: support to reply folder name to store file
Date:   Thu, 20 Apr 2023 00:14:18 +0800
Message-Id: <20230419161418.17944-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e8cbf8c3-f2ff-2e4d-ab00-e3579f745e9f@molgen.mpg.de>
References: <e8cbf8c3-f2ff-2e4d-ab00-e3579f745e9f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Paul,

On 19.04.23 22:54 Paul Menzel wrote:
>Am 19.04.23 um 16:50 schrieb Guiting Shen:
>
>> On 19.04.23 19:49 Paul Menzel wrote:
>>> Am 19.04.23 um 12:19 schrieb Guiting Shen:
>>>> From: Aaron_shen <aarongt.shen@gmail.com>
>>
>>> The old name is still documented as the author for the commit. Did you
>>> execute the second command?
>>
>>>      git commit --amend --author="Aaron Shen <aarongt.shen@gmail.com>"
>>
>>> Or with your real name:
>>
>>>      git commit --amend --author="Guiting Shen <aarongt.shen@gmail.com>"
>>
>>> You can verify the success with `git show` and look at the meta data.
>>
>> Sorry, I forgot to make new patch to send.
>
>No problem.
>
>>> The obex agent usually reply the filename by getting the default filename
>>
>>> s/reply/replies/
>>
>>> Do you mean *returns* instead of *replies*?
>>
>> Yes, I mean to return the filename or folder name to reply the AuthorizePush
>> request from obexd manager.
>> Do I use 'returns' instead of 'replies' in v4 patch?
>
>At least for me that would be more correct.

Got it, thanks. I will send v4 patch tomorrow.

>>>> from the filename property of the transfer object which is not convenient.
>>>> The patch helps that the obex agent can reply folder name or new filename
>>>> or null which will use the default filename if new_name is NULL and the
>>>> default folder if the new_folder is NULL in opp_chkput().
>
>PS: By the way, your replies are not correctly threaded. The message
>header says you are using git-send-email to compose/send this message –
>the one I am replying to right now with Message-Id:
>
>20230419145019.11548-1-aarongt.shen@gmail.com

Sorry, I found the Message-Id to reply finally.
Wish this reply will be right.

Regards,
Guiting Shen
