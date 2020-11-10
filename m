Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9BC388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77023206B6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9Es7JkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgKJEr3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgKJEr3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 23:47:29 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF540C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 20:47:28 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i7so7771725qti.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 20:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G2NWJiEsSuJq1A2Kw2Z1yNDS1XrqUHaFE2m9jf+fFXo=;
        b=l9Es7JkP73Wuw4wD9apOpc3zqZRk/lC6vAWij4hB0A0S8GRPokqWacn/vOIbIiTdXx
         X5574PyzugziQmauAdYSkmtbCkGPb3nytxzvmevhoUY8tsgqNrLOY2wigqzvblynmI13
         lJfErMq9YmwyE6dPH2b+l316Vs7d/+Phxy3WOqeV0WOTiCPY9j1EaTTeBTGNhUf5Ur7y
         jhc353EMnx7Z9JK4hXWY9OYILlsU7Su/xVuF8UdW4orBf9wlr5bxBLheeDb62fxmEt9k
         IQ2MDkqErL47agYYoexjA7vJmI1YKajK7LMQcV39ytu+Nfpp/yBRC/G3Dazo2ihf44uR
         VXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G2NWJiEsSuJq1A2Kw2Z1yNDS1XrqUHaFE2m9jf+fFXo=;
        b=DTM3zFLHiBagjgXFaOll4WadkBW6nBLtVI0pUl89T2lAtl+GwVsUdRwH0qYr4Q78aD
         OjBvXV8dnfw0NE6O+3qSgYpS1NmH81yGam7e4PWB3JQNSrXTaoR65qyB/JSXIvR3DY6j
         KV+PkO7ijjBmxANJA9nFEki5g9JcD8GqNz6BTfj0fzpZ5BSjK2wR9fIvx7CIIxQen5VZ
         lHCW/Qpwx8nOPwQHz7RgeJKnkEuoQkoTtQCp/g7wMqY84xA0Z8hvPGakaUJStcRJjSQu
         3+MUuLOVuOW2vZpM51GuuMf6BZCrgu3jBwH3+gSu19QGW1NoHSaW4sT9NN7qprJ9X/9p
         ElaQ==
X-Gm-Message-State: AOAM533rmY41V+4OwTso7O6jnp84SbU8y+78P+S1VPp46IqRrwRmKcYJ
        vjRkgyYnkflCEpjx+UWvgvTdUcCiJVsSfA==
X-Google-Smtp-Source: ABdhPJz/vo9OvuDX60HJXb07sIsOR0qdgP7ZQ2JJctToAT8Soa8QCWoPYOkS51uZTQDUfxpAH/jgxQ==
X-Received: by 2002:ac8:709a:: with SMTP id y26mr16836437qto.246.1604983647716;
        Mon, 09 Nov 2020 20:47:27 -0800 (PST)
Received: from [172.17.0.2] ([52.167.133.38])
        by smtp.gmail.com with ESMTPSA id 203sm4932158qkd.25.2020.11.09.20.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:47:27 -0800 (PST)
Message-ID: <5faa1b5f.1c69fb81.4334e.ec42@mx.google.com>
Date:   Mon, 09 Nov 2020 20:47:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2880060913502187701=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix memory leak when failing to load a node
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110042451.71288-1-inga.stotland@intel.com>
References: <20201110042451.71288-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2880060913502187701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380863

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2880060913502187701==--
