Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7224C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 12:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiBPMFm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:05:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBPMFl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 07:05:41 -0500
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 04:05:29 PST
Received: from mail.heine.tech (mail.heine.tech [IPv6:2a01:4f8:1c0c:5073::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020491DE59A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 04:05:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id A08061814B9;
        Wed, 16 Feb 2022 12:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.tech; s=dkim;
        t=1645012658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to;
        bh=zEKbwPRsNTvuQSntWGvSbKBYf7Fm80VdBm6Y9QiEzDI=;
        b=OFefllUxD2wSQcmDl/4ZqK789yEMRbf82f9mmjcn6LpN/Uzbuq0UF0Dsmxv+LHf9xCE9/q
        y4xQxX4iALNZ5tGPdxK7R7IYJcMRBHe42VAdtKIT128jK5CgY2TrPaRMsqdenz4iBVXTyd
        k7hO4cYsT+m08sMHsdTI+tw+eKgRaiw=
From:   "Michael Nosthoff" <bluez@heine.tech>
In-Reply-To: <20220215225015.3568246-1-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="utf-8"
Date:   Wed, 16 Feb 2022 12:57:38 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        "Michael Nosthoff" <bluez@heine.tech>,
        "Michael Nosthoff" <buildroot@heine.tech>
To:     "Fabrice Fontaine" <fontaine.fabrice@gmail.com>
MIME-Version: 1.0
Message-ID: <50-620ce680-7-4d762500@265872973>
Subject: =?utf-8?q?Re=3A?= [PATCH BlueZ] =?utf-8?q?tools/mesh-cfgtest=3A?= include 
 limits.h
User-Agent: SOGoMail 5.5.0
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fabrice,

On Tuesday, February 15, 2022 23:50 CET, Fabrice Fontaine <fontaine.fab=
rice@gmail.com> wrote:

> ---
> I'm sending back this patch as for an unknown reason, the patch sent =
by
> Michael in July 2021 is set as superseded in patchwork:
> https://patchwork.kernel.org/project/bluetooth/patch/20210722204923.2=
9735-1-bluez@heine.tech
> 
I had sent a v2 with an improved description. The buildbot didn't like =
the Commit Msg because of the too long
urls to the buildroot autobuilders. Maybe that's why it was marked as "=
archived" on patchwork?

https://patchwork.kernel.org/project/bluetooth/patch/20210723081039.303=
96-1-bluez@heine.tech/

Regards,
Michael

