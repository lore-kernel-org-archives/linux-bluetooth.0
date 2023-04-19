Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBDC77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 10:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjDSKSM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjDSKSL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 06:18:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F45240
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 03:18:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b52ad6311so3507417b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681899490; x=1684491490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQJyWovMevrQk9u6sw0O6pz2BgRWdgC7XjOG0leNf3Y=;
        b=Lhp4StiQxiB6QOE7p5H+dY7XwVhgI4yPiX1uSwULRcnAjaDKFbNcsT9VwjDHJnt6RC
         kidTk6pwpcKyDXr5GqD1+M1gO1XwO8MCxABqUG7q2ID1gcIw1ULjs26Cqvm+KBPvxIWb
         9Ub4gTpYQyvcq0iiVhtpCLpV65q3niTf6KqVMKYtRvlur5FuZGSBg7cXxVux9oNpLIxW
         ENOxNzhsuPDFeSHz9dp4HoI13+ijcp549mR9a5wgQWPlBYHFEQCZSFQCd39EHAUbStuq
         lmAYb61+uErgLBjqUIywQEwsrgXu5kPWcJoZRbrObLdhegZf98Ks+XsQuHlK6CDkeEI2
         rYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681899490; x=1684491490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQJyWovMevrQk9u6sw0O6pz2BgRWdgC7XjOG0leNf3Y=;
        b=KJrmHQwFLmJTUh6ZH9m228elpJoHjP4zoUBtmN8IXjSYehnWojdBc5kYrvxKvBUJRV
         +UuAdQtxLp+Gj1FKN6a5JyVaUItQ3TaIQu2ZilCmTOCEu7haMH2K19tBGeqW4HG2yQap
         OkeVs6eumiDbBn7UAX2p4N5ROi5thr1gnri5QVy2rvqnsViN0HvYsqV1QZGJhbCjhfZ4
         gqc6LlnOW+QxgtbEdcI+8r8AZdUz8WnUzi85gbTrdVgQyikZ43TaQmMFLWACqp/zj+qj
         IclxTHQBgsEMnenNEOmGIgU6+4l9hODrW+N9DNvjO9ZdxripK2nsqKQNcN2QH/UK+J1T
         vtFQ==
X-Gm-Message-State: AAQBX9f3UtiQA6LTY2Hjyjy7XWWUGjUe1NenoHErbx6t7UYhiQo9vLBV
        9IphR1R7rjo7mcoK3Mc6f6Au7NLicUvs9Kba
X-Google-Smtp-Source: AKy350a/aknAbmpadpWZGRawBdlz/rCMXrx63W49JjLJErtEUV+k3I3miim2+XO/ONJGvrJ4VfNk8A==
X-Received: by 2002:a05:6a00:99f:b0:63d:33c9:aec4 with SMTP id u31-20020a056a00099f00b0063d33c9aec4mr3828409pfg.10.1681899489982;
        Wed, 19 Apr 2023 03:18:09 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78d07000000b00627df85cd72sm2480573pfe.199.2023.04.19.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:18:09 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     pmenzel@molgen.mpg.de
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] obexd: support to reply folder name to store file
Date:   Wed, 19 Apr 2023 18:18:06 +0800
Message-Id: <20230419101806.55929-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 19.04.23 15:12 Paul wrote:
>Am 19.04.23 um 05:07 schrieb Aaron_shen:
>
>[…]
>
>One cosmetic remark: Your name is shown as Aaron_shen. More common is
>probably Aaron Shen? I think you can improve that with:
>
>     $ git config --global user.name "Aaron Shen"
>     $ git commit --amend --author="Aaron Shen <aarongt.shen@gmail.com>"
>
>Then you can send v3.

Thank you, I will use real name "Guiting Shen" to send v3 patch.

Regards,
Guiting Shen
