Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3490C4741F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B2021D7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgIYQsB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:48:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32832 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIYQr7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 12:47:59 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7EE83CECDE;
        Fri, 25 Sep 2020 18:54:55 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bluez PATCH v2 02/10] doc/mgmt-api: Add new MGMT interfaces to
 mgmt-api
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAP2xMbuXo0FMvi1Sv9bv2+neXaRMB=aAQ1F6N=fDEF7P2mP5dw@mail.gmail.com>
Date:   Fri, 25 Sep 2020 18:47:55 +0200
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <52AD92A0-2442-4DCD-99A5-EB2BB74F146A@holtmann.org>
References: <20200918221357.3436905-1-danielwinkler@google.com>
 <20200918151041.Bluez.v2.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
 <0E891E36-FA71-414C-9E60-596D253A82A5@holtmann.org>
 <CAP2xMbuXo0FMvi1Sv9bv2+neXaRMB=aAQ1F6N=fDEF7P2mP5dw@mail.gmail.com>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> I have already imposed a "powered" requirement for both MGMT
> advertising commands and in the documentation here. In our discussions
> regarding this feature, we had chosen to emit a Tx Power Selected
> event because these "extended" advertising commands may be used even
> on platforms without controller support for extended advertising
> features. In other words, we thought it would make more sense to emit
> a Tx Power Selected event when relevant, rather than always returning
> a Tx power in the MGMT response, even if it is not relevant. If you
> think I should return the selected Tx Power directly, I can do so.
> Perhaps we can populate the response with
> HCI_ADV_TX_POWER_NO_PREFERENCE if extended advertising is not
> available. Please let me know your thoughts.

I would prefer to directly return Selected_TX_Power value since then you know for sure that the controller has chosen one or does not support it (for that use -127 / TX_POWER_INVALID as value). It has the advantage that you clearly know what you have. Otherwise we have to wait and hope for an event that might come or might not come. Meaning we have to start a timer in userspace and handle the case when it doesn’t come. So I think just return the value and we set it to INVALID if we don’t have it.

>> I was thinking we rename Read Security Information Command and also return these values there. I think it is a bit of waste to introduce yet another command to return controller capabilities.
> 
> My mistake, I was under the impression that you preferred adding a new
> command. I will look into adding the new Tx power range parameters to
> the "Read Security Information Command". Please let me know your
> preferred new name for the command.

Maybe we keep it simple as “Read Controller Features” command.

Regards

Marcel

