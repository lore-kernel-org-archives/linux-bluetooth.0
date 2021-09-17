Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1289AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 07:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB26B61130
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 07:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhIQHFL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhIQHFL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Sep 2021 03:05:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6591CC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 00:03:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v24so26234666eda.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NUapJou99CjaGyLWrYMKWGv5f/+p0hBQpPfEdbV2br8=;
        b=qZE7gmlpXefsDiPMrtRDjCeWR84t1iGN8bxu3lDW93I6Xo5vTjuuBXXm0uoJZe6R/M
         A/78kHFDaK3UFfbroz0+mooBL0fAASNMQGjMMGANpRxgvhS1fjN0yeX2zsXkBxnKWsk9
         SP5SH+kJXkbwLs/4uGDprdlN/Srb78Z64Q/GyIinFo2k7hSOmUIgt5/DM6KQL6KnTa52
         478Bu/70AMBCEGO4QWR6YKI/YCrYzKwqrVgon4Pv/SmvBR70G8J28nxAHeC6VYmK4SeD
         X5SFMfXlNoY6HYEQ9SV03+x5jRXVEV1Wo0UPTNgWy7ogyh3F+FeB9lzrcXEDbzNeWCyX
         XerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NUapJou99CjaGyLWrYMKWGv5f/+p0hBQpPfEdbV2br8=;
        b=ftdlCDGdjHUGbZ+2a0Xy8AJuGIfxkyQiUfgly4vV5wU0/2vcPVbFA2RnFE9ASXay+U
         X6n0ZdJjSlMu5P1fMCUXVgccZmbjZc1A1nab+JOP47JxJrq3dXuP0Cqt15RVTIBRNbUN
         jbJdIH5KQcVZhB3+M1N3V+UdCEyD2Ypve2Vw32jbEDDuGsw8Lhbbwj2MfCMvNXWQ/3ro
         B4aoh2Te1utzIkruq7qAKxnRix3xzg5/oaF2fw84Cgxi7yvDp92sjf7ORKGX5IBmjJqq
         h4KBsId2r/Plyq7jdup3nR9WNYUmqCmBCohZKG5Fv46bQYljo7mTb+gXwO7aAwCQgGVA
         092g==
X-Gm-Message-State: AOAM530eyJN8CwlYUsM/B0iwz+xoLL7fVoBN3yPwVetJwN5DpToyJm3O
        AWyJaPRrS+iqwMCHZlh4c0B/88NGPmnB9wI9aOFUHSOFkD0=
X-Google-Smtp-Source: ABdhPJzMXOeqfe523N2QHP9gD1ICHqN1WddDCOt4qxeJlj2nvMOxztDE5VRlaVTkO21h1wbKFxg+JlnItVLS8W/Ek6A=
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr11082741edv.230.1631862227964;
 Fri, 17 Sep 2021 00:03:47 -0700 (PDT)
MIME-Version: 1.0
From:   Barry Byford <31baz66@gmail.com>
Date:   Fri, 17 Sep 2021 08:03:36 +0100
Message-ID: <CAAu3APZAJD-uPUO1d4g=7smD34LUzkn87MkQKfdEcTC41FM5Vg@mail.gmail.com>
Subject: Deprecated Python Libraries
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Python examples in the test directory have some dependencies that
have issues:

optparse
According to the documentation this has now been deprecated

https://docs.python.org/3/library/optparse.html#:~:text=Deprecated%20since%20version%203.2

dbus-python
This has some known issues according to the documentation

https://dbus.freedesktop.org/doc/dbus-python/#:~:text=Alternative%20ways%20to%20get%20your%20Python%20code%20onto%20D-Bus

The above documentation has recommendations of switching to
import argparse
from gi.repository import Gio

Both of these should already be on systems because argparse is built
in to Python and gi.repository is used for GLib elsewhere in the
examples.
Would there be any interest in getting patches to change to these
different libraries?
Are these test scripts used in any of the automated tests?
Can I submit a PR via https://github.com/bluez/bluez/pulls?

Thanks,
Barry
