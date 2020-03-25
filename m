Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE110C54FCF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E96208E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCYOnf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:43:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44773 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYOnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 10:43:35 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C695BCECCF;
        Wed, 25 Mar 2020 15:53:05 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_XjO9=2Y_W-uAXxb+myh1nLvF7_CxrprtLZ=pAj-FrVaQ@mail.gmail.com>
Date:   Wed, 25 Mar 2020 15:43:33 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel.holtmann@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1AFDC1E2-8875-4EFC-8A75-DAB89DA9FFB5@holtmann.org>
References: <20200320133748.154926-1-alainm@chromium.org>
 <CALWDO_WSHiNw+uwcZzufJ7rjHr=zpMs6f3ry=rdLMGLz2gJZ=w@mail.gmail.com>
 <1ACCF17B-90EB-4DE1-BD8C-A927ABEC3913@holtmann.org>
 <CALWDO_V=6NXLTZ=XTc+uAe3YUVkUfe88c4beWWoqWK7+vK4+8g@mail.gmail.com>
 <992DB845-DB7F-41B9-93E0-538B08BDF910@holtmann.org>
 <CALWDO_WF4n_Ta-fYoxTv4OF_guZy=d8urEyrosUPgWdHXo8Pag@mail.gmail.com>
 <C35897C0-9924-4598-859B-0ADD1EF2FB94@holtmann.org>
 <CALWDO_XjO9=2Y_W-uAXxb+myh1nLvF7_CxrprtLZ=pAj-FrVaQ@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> I suspect we'd want bluetoothd to have a configuration that can enforce a more secure posture.
> 
> Unfortunately when the command isn't supported, the platform is left between a rock and hard place... There isn't much we can do but to block the use of Bluetooth if the platform requires a more secure posture.

so if the BR/EDR part is not up to the policy that the host requires, we could still configure the LE part. BlueZ is set up in this way that you can run a dual-mode controller as just a LE controller.

I would also opt for the kernel just tells us what options it have. Then at least we can provide some feedback to the end-user on why Bluetooth is not available or why only selected features are available.

Regards

Marcel

