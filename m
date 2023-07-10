Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF104EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 23:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGJXnK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 19:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGJXnJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 19:43:09 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8FE19A
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 16:43:08 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7679d444210so393093785a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689032587; x=1691624587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uEOesbgLwBesna46X5gd5YWTIFNREe0R8G49h59kqDs=;
        b=RdznSCIivv0nwtx/z0owFXUfgPWAuYuV7hS+U1trgyQFINA9HI88Oo1L/h3AtkbFtY
         94mLSEGzyLuZ1DUfHWUDNR9zGpeIynqD4XhOdXG5k4E2wXRQZad9V4WW6JNtuQempnfx
         xB49SK/cpcYyXj4AjG0Mi8LAn23/K3RXgWzZd31Lmr6kaenFRXmSVQNFRysVUKSFyxDO
         BXIE4D6tDec1S77O5/g9ChNVsW0oR1sZmTS/T/fLqog2JMmzA13OH0c162mV8UeuUgYg
         eXQFL/Qe2aayxF4QU+VxscQ3CZZA7PiYbS+JmY9yFvTjJpyQcwjGyZ+fxlL8FWw+ViP6
         Qp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689032587; x=1691624587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEOesbgLwBesna46X5gd5YWTIFNREe0R8G49h59kqDs=;
        b=CdUfeZNt2JetB2w/q4njkn+05BP9JZKOZwxZn9wgNJpRNShNYTd/v6caA5LgKBPheD
         vJKMKD5UltDkDDBKcJnq44mEgO9DsahT7I4oKX4WCZgFyPxpjVdcxMROMMj7qJ7tUJ3h
         45YIx6mMC3ii3ew5FJ/uf4it7H0BqYiZOGpSmu6LT6CEhqdBqnpo6PWngaBXyLplv7S+
         SKXv0FZ66eM9DcrIuxg28yffmwl4grndeICd2TSkLKwNLiLj9GLPhrGGtpip/mI3ihvn
         /8D/7jsL+FAS1Y8PTEzRRAFmbiQrL8PAEiywUz8yxX1AdWDivN6WzlxgxeISZWZ2cS62
         c1+A==
X-Gm-Message-State: ABy/qLb/gtwwOhEbhvCW9CJTPUhr+ZanQnAu32urYRByXQVkuMcsk8EA
        sHHe1ajUFlDkeukaLNf0apUmI2UNp7U=
X-Google-Smtp-Source: APBJJlGzcWGfacsvfjPCa6O8R37PhJAEiDJozklGXicbFE3HG2Q7VSOAu06NveeijOJRK//QzWmcKA==
X-Received: by 2002:a05:620a:d88:b0:767:a4b8:8d4 with SMTP id q8-20020a05620a0d8800b00767a4b808d4mr14785456qkl.0.1689032587606;
        Mon, 10 Jul 2023 16:43:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.87])
        by smtp.gmail.com with ESMTPSA id f23-20020a0caa97000000b0062ffbf23c22sm358055qvb.131.2023.07.10.16.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:43:07 -0700 (PDT)
Message-ID: <64ac978b.0c0a0220.cf8eb.17de@mx.google.com>
Date:   Mon, 10 Jul 2023 16:43:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6477718227857507257=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] main: Remove DEFAULT_SIRK
In-Reply-To: <20230710222014.1231369-1-luiz.dentz@gmail.com>
References: <20230710222014.1231369-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6477718227857507257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764179

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.70 seconds
BluezMake                     PASS      1002.34 seconds
MakeCheck                     PASS      11.66 seconds
MakeDistcheck                 PASS      153.17 seconds
CheckValgrind                 PASS      250.03 seconds
CheckSmatch                   PASS      346.86 seconds
bluezmakeextell               PASS      102.73 seconds
IncrementalBuild              PASS      855.00 seconds
ScanBuild                     PASS      1112.30 seconds



---
Regards,
Linux Bluetooth


--===============6477718227857507257==--
