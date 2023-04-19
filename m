Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC6C77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 14:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjDSOvN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDSOvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 10:51:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247149EF
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 07:51:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b509fe13eso2506528b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681915869; x=1684507869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSB03QyydsznU9pXkVXs0E5jlEBK6XEtEhrAdG6OIao=;
        b=N7ReGX6SBvV/GABViaZWQIRF91oCoWF6c1+crUpIaGkxtY8Gl71KJfMvQ7AP8ucRhw
         DQ8mCyVH/yVHfxwy9xg3u/K25e7KS9a/pX3wGxrgFkVXa+TFLNIjW1a6vSUUSno10Czc
         ZnB1UNspeAWZ2onlY/aKtSibVmDYpyS90bNgOGBQ6P7c9wYVMztsdcJVdQAyrECVXAE8
         PBjrnFgXYmsI69/tGGYakrNgL3ryvUSwaFDjEAtrxy8V0WYVoqvOSDfek6z1afwJin2u
         DP/1gJjzzMg5NEZLM62sy2JgI8/UZM9rDSbzjS5Y2iQ6aL9LeUgRI/ECxSB6DpibU3bG
         IIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915869; x=1684507869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSB03QyydsznU9pXkVXs0E5jlEBK6XEtEhrAdG6OIao=;
        b=PbtdgvGkJb3C5J2JTnS1C/e47d3Z1KGuNRhG+9eMbJaK429N1b3PlMS9Mb8vEx1AI+
         VGOoQyNBYVAAa/PYJQ4VDTjgitFOz14jcG8UZkVWMbP0ldLdex2+yNUASsPmJHsR/D9R
         DlQ4a0mbTO6J7sQv55v2BXk2k8ruaMgCSsVrhRdx9hrJSrqPxcTm7rzy5Vp6+s3p75wp
         j7O6cg7JlJEbOOfEMzwRE3PDp4bRhqiTMR4R4+Tme/UrCtzRegNHwJjNclIgmsDB1UYe
         mfnCdZLzSeWvmD53AlCb3Yx+LLU9iAOncj4D6druYeGEodPkCc9DLzAKUu2+QssnDUFK
         T3Wg==
X-Gm-Message-State: AAQBX9fGAgoaF3y6TDb5CZ9THSnfnOlEoQudwvrZCXlhCPtOb23P7axR
        uZ4BeMx5zwo7JjdLp0C2P8I=
X-Google-Smtp-Source: AKy350ap4xTv3Vj2Ma7Y6KQJEUxJCaozL+B9ZAJVB2go9E7QrCtlIBfeZ4B6UJNjdw+FLTtU6uisCA==
X-Received: by 2002:a05:6a00:1947:b0:63d:2aac:7b83 with SMTP id s7-20020a056a00194700b0063d2aac7b83mr3952444pfk.31.1681915868690;
        Wed, 19 Apr 2023 07:51:08 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.65])
        by smtp.gmail.com with ESMTPSA id j14-20020a62e90e000000b005ac419804d5sm11321189pfh.98.2023.04.19.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:51:08 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     pmenzel@molgen.mpg.de
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3] obexd: support to reply folder name to store file
Date:   Wed, 19 Apr 2023 22:50:19 +0800
Message-Id: <20230419145019.11548-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Paul,

On 19.04.23 19:49 Paul Menzel wrote:
>Am 19.04.23 um 12:19 schrieb Guiting Shen:
>> From: Aaron_shen <aarongt.shen@gmail.com>

>The old name is still documented as the author for the commit. Did you
>execute the second command?

>     git commit --amend --author="Aaron Shen <aarongt.shen@gmail.com>"

>Or with your real name:

>     git commit --amend --author="Guiting Shen <aarongt.shen@gmail.com>"

>You can verify the success with `git show` and look at the meta data.

Sorry, I forgot to make new patch to send.

> The obex agent usually reply the filename by getting the default filename

>s/reply/replies/

>Do you mean *returns* instead of *replies*?

Yes, I mean to return the filename or folder name to reply the AuthorizePush
request from obexd manager.
Do I use 'returns' instead of 'replies' in v4 patch? 

>> from the filename property of the transfer object which is not convenient.
>> The patch helps that the obex agent can reply folder name or new filename
>> or null which will use the default filename if new_name is NULL and the
>> default folder if the new_folder is NULL in opp_chkput().

Regards,
Guiting Shen
