Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A9EC678D4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjCGRoO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjCGRnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 12:43:37 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320739E676
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 09:39:38 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d7so15179002qtr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678210776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QjgxFCYPOuvw0FyXCTzcQHqbCrjydu2uosD4QYygoQA=;
        b=TWgJqsj4zOova2H2xKmPQWzQEb8Svci0BMLV/unBeXwVSkuMhB3/qEa2pDeV0XRzrS
         jrYI+5gWAhaL7e3BfP3acAXJysqQqaeJ6jSSJDOTyM3T7EqBfixtH8fqh75TsG8AHVCb
         RpP7kz45QtEI/zUHjzLX2Air6/ApA8yxAE3nzqFEsUEP8KZpQP3DQqYAvNq/HnOw/l56
         ST+Wm/DnthMDChWKjnV/MXFhXlvnIQfuwIF3R63UV29yv2K4yBonwRdjDASyqTi04XV8
         SzOFDGh6f9mWXKh2xqQwET1j1XWnQO6Hwa3VCTvUdkMdEU1WZdPl/kYmSYPP3hnK/oei
         M01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjgxFCYPOuvw0FyXCTzcQHqbCrjydu2uosD4QYygoQA=;
        b=zm4KpLI9IJz/zm83X528mffqKWeKEpf22SsGj/5+BHnqsiH1DDCqyP7jtttVWnybUh
         SWbv+VGT+3WR+IoXiwUF4w/W71xW45AKvS6Hk3yt9EF1guabZ/GNrRWi3TN/6109lkPE
         2ueDcyjOA3qvnnnjIiZKbtuohpQV8rydnESTAPMraPii8eecGlo9v4bFaA5ZyNxxgVGv
         HopXVkAT+cSv5WpZ0ltZA8RlRoNNbukQZ8Okj/+i8b4Escj/VUVP8Qo67nh7UyvO1i1b
         Zfjtg+5HCVM5gYaLO1U9tN8D4EUA/eqZuez5KOcLTvOkTXcID70sglR774L25O+QYCtu
         EcQg==
X-Gm-Message-State: AO0yUKUmMsLLCkqItPK11wyniBNTIWL2GT2NFA9TVRgafragzxzVDa+v
        WlhGNSnlJ5yF5hY05GwixpuaK7+XR4A=
X-Google-Smtp-Source: AK7set9S5gJQ9gqpgRmQMsm0hiipTIHt2niZKHrixwR68Im+Hf30v15hMeEYlBey0XJo4xX1lBX1jg==
X-Received: by 2002:ac8:5acc:0:b0:3bf:dbb4:3bcc with SMTP id d12-20020ac85acc000000b003bfdbb43bccmr25369542qtd.4.1678210776498;
        Tue, 07 Mar 2023 09:39:36 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.114])
        by smtp.gmail.com with ESMTPSA id i20-20020ac860d4000000b003b34650039bsm10013443qtm.76.2023.03.07.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:39:36 -0800 (PST)
Message-ID: <640776d8.c80a0220.63772.01e9@mx.google.com>
Date:   Tue, 07 Mar 2023 09:39:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0457834801310170878=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
Subject: RE: [6.2,0270/1001] Bluetooth: hci_conn: Refactor hci_bind_bis() since it always succeeds
In-Reply-To: <20230307170033.423462436@linuxfoundation.org>
References: <20230307170033.423462436@linuxfoundation.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0457834801310170878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:1981
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0457834801310170878==--
