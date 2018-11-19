Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F2C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 02:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2842080F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 02:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKxyf/eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2842080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeKSMyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 07:54:13 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:44989 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeKSMyN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 07:54:13 -0500
Received: by mail-ua1-f52.google.com with SMTP id d19so10184517uaq.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Nov 2018 18:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AD3m4ufIh4dacXU7/LTWeVFD1OwHizZw0qVlwsFCvGo=;
        b=jKxyf/eUg7DNwVgY43iV0JPf74RcMSj2fep6NeAcj6E/EWCOYh4c+ZPk63nWfTomLR
         etvYbUfMoiXtfUEYBdFxo+Vl4hC+5rZ04KuPIj0xL+rzEwTfSIEoAEOwFLDfGovfIlMR
         iTKsh5mh8FlYiTveMAm68QM/gKW5HOEKhqEJE/QKwT9i3KQMJndowVzOU+W82fzu8haR
         7ySwKRLptejr6v7S0R8aODDkkO4g66MZv1BBLDaOE9B8W/MOb4dr4jT/GcZu11KOwBcp
         oEOwx79/Dp6eSMNMnTl05+jCA9HW3cCHFcbGYiEMbnmH0vbuh68khpe74+7/esiC7rBD
         xV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AD3m4ufIh4dacXU7/LTWeVFD1OwHizZw0qVlwsFCvGo=;
        b=X1rfY3ZirUIo6pjnT+TH0blkZjHLbpYWRUU7uZsDt3jJaolnCPKYE3x9+rcN9YThtB
         OZwyFmbq6GHf0fIKhO/nBqs3YANbcDskL61VO61pAQQfHTZLCWUZeTGoltugUYx1/hcT
         iXwFlOc98tgGLJiTQi3yqW8h2KfzWbUJtedGBuaKN/zq24Xc/zxjxpYivH3Vco0vXGGB
         6PJukgCJUOSOZphqt77JYLbGaGGv18t/mVffh3L2jaMg6xc+OhmTYhpZEIMrSQa54JTY
         lX8chAnVrJIOG55WwBlefFcxx9OAcPKFtPbbZyt4SF0MQwOgzUsnAqMf36MefO0P+v8Z
         q0ig==
X-Gm-Message-State: AGRZ1gJ419K8gWLMwvA+wqqNZecPqT3BX9QjLchUbHrSBMZXtkLdS2on
        itXQIPn/YvofKlVhg2ebHLw9eMbqwTM7AzO+eD6OSKMg
X-Google-Smtp-Source: AJdET5cVcRyzvbZYGfO2pRqRXtso6imtmq9R1D5XGj27iBf+ekq+FGD53vbDfRXsIRcTIvA7oOKG2+lOGyEvActJ5ao=
X-Received: by 2002:ab0:7544:: with SMTP id k4mr8749908uaq.66.1542594726024;
 Sun, 18 Nov 2018 18:32:06 -0800 (PST)
MIME-Version: 1.0
From:   Calvin Yoo <choongbeom@gmail.com>
Date:   Mon, 19 Nov 2018 11:31:54 +0900
Message-ID: <CAO9gXyTw4P+poT_qDi3SoBHaBELWdPV7Fv4Q7Ce7vN7q_oDbDw@mail.gmail.com>
Subject: How to test SDP(Service Discovery Protocol) on PTS ?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

"LMP Error Transaction Collision" error occurs when I try to test
SDP/SR/SA/BV-01-C.
And finally displays "IUT failed to accept SDP channel".
I checked server role and other mandatory items of SDP ICS and start
the test and make my device discoverable(advertising).

Is there any prior preparation for this test or need controls with sdptool?
I mean do I need to do something more than advertising?


Thanks,
Choongbeom
