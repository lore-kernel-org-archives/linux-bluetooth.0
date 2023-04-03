Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91327C76188
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjDCVrT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDCVrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 17:47:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B679E75
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 14:46:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l18so22857485oic.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680558413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fqwpTlBalqDgVoPcHqV4SvpbJnbjgHwdrqhMhEHgZqo=;
        b=m8BTaKriUDU/LB0YwDxX9536++DEna+yJrQJZN8DaVjBjQfDxrXSzvKNeL+vt+LkLX
         INvanVqn6Q4f4AkJClsahalsKgfaDSfuHUi5WHEXPtJEeA5iU8a4nGExc/B9DPvw87wn
         0/X+C4M9y5FIeFlxezSKp/kqmguCkGetSg9ocGZH0/DxBa6pjdbxzKsWaeIsYjNZ8upI
         qQGoIy75QdXmZ3SufjvLXmI7KrLkg9ZRbYHP83X1q1/RBy4xCKR1Ujs5Ui6xqsqzqBWV
         TzsTw8gyK/YvWCW0Vo72XdeXAJrBS0xtEU13hIyNXEuVBQ/ZqV5a55Xo1YHL/VQwxsWV
         ZnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqwpTlBalqDgVoPcHqV4SvpbJnbjgHwdrqhMhEHgZqo=;
        b=m+7bV0JMaj7+ogibdOoJJofHdSuWqFTEjl/sSuA50/6/4UwTzXsYoIecKHk3jAyPj5
         K7hKTGmk4tjegHszxBZ74etNPX89SRw7Rt+bAlxlMG4AX5tHZOoDeXWNLiFRGWZHa6oS
         0Dnxz/s6OC+HZk91br4wkqD9bYYsVL6TO4xn/4jzO2sg4ZWaT21Ee24URZlxw1PLHcpz
         k45H04DgA5WcauO1o1TdzJNy8MulBDu+wYekiFw93jyi7Pxc/WAZquitUUC82tFCDblI
         MTIH5mcMJVdiS4apH5u1GkmGlQ3Htg/5ay955yigisd0MZ5B/jjM5o4QNdzj/0GE+mMU
         w4Rg==
X-Gm-Message-State: AAQBX9c/3ZZHgbeDQll76EZxz4AR/Dgfc0isGLPfQ5cqeGEmw/2CTzJu
        08lN+fVI6ThUJEwPR2zEU0qHdWUMQSc=
X-Google-Smtp-Source: AKy350YgYfHw3p34DYZ/RoDCaQ/3p6SzVaF+p/1wFQTWh0UqiJrwdqeceDv2fXZYOldxL+DWjy3o4w==
X-Received: by 2002:a05:6808:3cd:b0:386:9883:ca9d with SMTP id o13-20020a05680803cd00b003869883ca9dmr242226oie.2.1680558413535;
        Mon, 03 Apr 2023 14:46:53 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.33])
        by smtp.gmail.com with ESMTPSA id z127-20020aca3385000000b00383cc29d6b2sm4354416oiz.51.2023.04.03.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:46:53 -0700 (PDT)
Message-ID: <642b494d.ca0a0220.57a97.6ec4@mx.google.com>
Date:   Mon, 03 Apr 2023 14:46:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1156786149508728385=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] set: Fix not attempt to connect devices with RSI
In-Reply-To: <20230403203243.1960045-1-luiz.dentz@gmail.com>
References: <20230403203243.1960045-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1156786149508728385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736551

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      32.36 seconds
BluezMake                     PASS      1010.84 seconds
MakeCheck                     PASS      12.63 seconds
MakeDistcheck                 PASS      180.25 seconds
CheckValgrind                 PASS      297.27 seconds
CheckSmatch                   PASS      400.86 seconds
bluezmakeextell               PASS      119.21 seconds
IncrementalBuild              PASS      831.70 seconds
ScanBuild                     PASS      1249.51 seconds



---
Regards,
Linux Bluetooth


--===============1156786149508728385==--
