Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE4DC433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F064F1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 18:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCRSE6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhCRSEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 14:04:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDDC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 11:04:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id 61so6497860wrm.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A/ztGgaAqaXjBmd9KEuFA8rCQ8Xxflx6k+iIXQuYRwU=;
        b=lb9D6yPr+C4N93wJX7yNTnEcJ9yYsJYQklg5MICLkx2kBXiW0NPKU3m/uS7BH/qSBf
         ktvXLaH4pFN0KBW/Ur5msuWm5wbBjPY2QaJhL9kLibWTVqcIZZHnZmIKnUQUBIf1iC5r
         Fp6A0ClPvSo+jt16gKi+btLJStucoprb81mLFk1BKewAwd4PXQHXGU/XcgVfOJDEon12
         fD+Z8dKRPNN1GuVHm1B92BUAZbscgcQVVpGXQsoOY1BHs3Scv4iCCYgNDSDwJLxkVLmh
         pxewBs4IoRReDxjyRu6NRywW3CPYUFBVQmy1agcKGp0y9Diq8a2hOiynpP+hutwAJHIS
         A9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A/ztGgaAqaXjBmd9KEuFA8rCQ8Xxflx6k+iIXQuYRwU=;
        b=aQ/xbR7kkOW6dsy8Lof4qeDNW9oYEP0vNNqMf5t1Xu/t4xmyuxeMDeWLI0dfjWKJH1
         efbYn/glUdzrP+76Rx8ZyLX72F/Qf9qTJK5Pmgjn3CbdAuJjvsf7wrhgYQ4csqev4GKE
         cRfKlFCKPReCtcwJzwN1SoJ5K4jCgc9kQRF5IrHOL9Ky25jWEdKIKr/JoSNK2obM0O8+
         ABq+OXXQsDfXEpX1PoAZPHAyj8YfthDHi4WkYaq1bw+aSyZeDDEAnT7VDv5lDvIbH/pf
         zNAgGMeGMHugxddKgzAV37b8n/jLuq98/Nq1Nuhep1K2w9zzgUgxySFOlYVcu1lcgPpd
         1wQA==
X-Gm-Message-State: AOAM530hXXvdaZNxm/ikId0Ra16Ak2kXMKou7LvyMwkyQjIgryl14e2i
        LMwh7I920vQQfokNeyM4g1H5wmAqu91VLKemjdeah4vrHrGBMw==
X-Google-Smtp-Source: ABdhPJz2zAFL8epTbZWx12YFSwp3Qb+Ssb3Gu53dLm4nnbqIT3SBlsu5LMcafP0KveEHIry3OukiYpNFIcpQabC02+g=
X-Received: by 2002:a5d:4286:: with SMTP id k6mr525867wrq.278.1616090671184;
 Thu, 18 Mar 2021 11:04:31 -0700 (PDT)
MIME-Version: 1.0
From:   Mihai Emilian <be.mihai22@gmail.com>
Date:   Thu, 18 Mar 2021 19:04:20 +0100
Message-ID: <CAP_L5iPOJXpATznLxmg1LArNaoLaDEr-zkYRwryLK8OBexwf0A@mail.gmail.com>
Subject: Developing and extending Agent1
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear community,

I am attempting to create a service that extends the functionality of
Bluez Pairing. I want to rewrite some of the functionality for
different paring methods (capabilities).

I read [this blog which uses Qt][1] to generate the code to create the
base code for the agent.

I used `gdbus-codegen` to generate the C code (like this[2]), using
the XML given in the blog in [1].

Then, in my main function, I acquired a SYSTEM BUS name and exported
all objects, including an object manager. My setup now looks like
this:[3]

Finally, I created a `callback` function based on the GDBUS signal
based on `handle-request-confirmation` which looks like this:

    g_signal_connect(agent, "handle-request-confirmation",
                 G_CALLBACK (on_request_confirmation), NULL);
> The above code is in main()

    int on_request_confirmation(CustomOrgBluezAgent1 *agent,
        GDBusMethodInvocation *invocation, gchar* path,
        guint32 passkey, gpointer userdata) {
            g_print("Hello WORLD!");
            set_trusted(path);
            return TRUE;
    }
> This is the actual callback function

My problem is that I am not able to have my Agent1 interface register
as a default agent. I tried invoking the `AgentManager1` in
`org.bluez` with `RegisterAgent` and `RequestDefaultAgent`, but it
doesn't seem to use the newly created service and I assume it uses a
separate one within the `org.bluez` service.

I have a couple of questions:
- Is this the proper way to implement a custom Agent1?
- How do I make it the default agent?
- How can I check what Agent is currently the default? It doesn't
appear anywhere in `d-feet` (the GUI d-bus explorer). I noticed the
agent implemented in Ubuntu though obex, but this is in Session (when
the bluetooth settings app is opened, the service appears in the
Session Bus):[4]

  [1]: https://medium.com/@matteodipirro/developing-a-bluetooth-agent-in-qt-c-with-bluez-and-d-bus-part-1-ee35d614ba72
  [2]: https://www.freedesktop.org/software/gstreamer-sdk/data/docs/latest/gio/ch30s05.html
  [3]: https://i.stack.imgur.com/pe0Li.png
  [4]: https://i.stack.imgur.com/UQ8na.png

Many thanks and regards,
Mihai
