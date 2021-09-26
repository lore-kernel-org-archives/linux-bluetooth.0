Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106C361038
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 17:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhIZREZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Sep 2021 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhIZREZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Sep 2021 13:04:25 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8FAC061570
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 10:02:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 194so33932104qkj.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBv8SZFMa+W/FwbBZFCnXDh0ribX+CXidUEiWzbjX/4=;
        b=HUqHyR39SZ8MCJmkxvgLc7csvqdBdbWQbBVq1qgJyCOoSjhshiK8gEOv2XvoHvby9K
         Mq78z63eT6tht7vfw6XBSnvprfe6GabPjfmbwI56oRWE5LN2Vy6E7IqDjZJN5ORlzTVp
         wdFvXSISiD7HYIav5QuICo9MovehaWRXIMMzLe+Tqpp0E+K7ciZ+dqKhLjYMaAKsk9Au
         BGgWsMpmljWE25jKZ433s6JTkTWBtETWTnL9X5kqpdGKEfkbsDO4S+9leFTVw/wPrTNb
         hIYmP1JnQS7asGLxvNxZwTT+WdUV511+lhJmbsCtheo51/81jE2e9dUchnjV+3pEf8ca
         oYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBv8SZFMa+W/FwbBZFCnXDh0ribX+CXidUEiWzbjX/4=;
        b=RCCqG28FYxUxSQPJPh4uJ8z7aqBvUJ2fATyVEcZUUcplQPWcuDMBOB7OsGdWnI5Y4g
         HA/5hd5dFpmj0XJm6gcG6cq5X5BFT11DlJWWjpc58DLuIGZZCRSkAWYi8Eaq8f4jrvYu
         3jNJL0cX47Qv0L6F389s2uQ0GYZfly3vKyJpGdM/726VsGyEJfFe1SZG21tuCVsKOlPJ
         eieQ3rjv6BW1iVZrGDTkcET0VAq7SY7Uqyt0BMiF/gmr6OzausDbbBbLfzeUuGdHAH+t
         sIGpKl8ivWWph2iPcmx88M48Kb598hmoOcgu5rcjhddPdSya8hE+K1hKQ73ZS0NKOGQ8
         o9Qw==
X-Gm-Message-State: AOAM5303iWOuq9tRu5bPDlUHwh4MVwjO/5lia629Rs+kjbIlwPyTM0Kv
        6+3LQf0NVfYMDsUILWJ9i5ZkmrxNdZr/3Q==
X-Google-Smtp-Source: ABdhPJymHVMIxGCwtOC3i9zm2RF/BtXRP/xLihPL49/jgk0xmDzKsu+u6Flebx2ttcNV1NOq0d48lA==
X-Received: by 2002:a37:b45:: with SMTP id 66mr19822542qkl.78.1632675767635;
        Sun, 26 Sep 2021 10:02:47 -0700 (PDT)
Received: from localhost.localdomain (38-13-8-207.starry-inc.net. [38.13.8.207])
        by smtp.gmail.com with ESMTPSA id g22sm10803833qkk.87.2021.09.26.10.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 10:02:47 -0700 (PDT)
From:   Dagan Martinez <martinez.dagan@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <martinez.dagan@gmail.com>
Subject: [PATCH BlueZ 0/1] gatt: remove superfluous extended properties
Date:   Sun, 26 Sep 2021 13:00:38 -0400
Message-Id: <20210926170039.49865-1-martinez.dagan@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As discussed on Slack, the BlueZ source contains superfluous
non-standard extended properties with no effect other than the creation
of unnecessary CEPDs with bits set in the "reserved" field. These
extended properties are set when a characteristic has a `secure-*`,
`encrypt-*`, or `encrypt-authenticated-*` flag set.

According to section 3.3.3.1 of the Bluetooth core spec 5.3, the only
valid extended properties are "reliable write", and "writable
auxiliaries."

This patch removes all other extended properties.

Dagan Martinez (1):
  gatt: remove superfluous extended properties

 src/gatt-database.c    | 6 ------
 src/shared/att-types.h | 8 --------
 2 files changed, 14 deletions(-)

-- 
2.31.1

