Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F2C05052
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 09:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358928AbjHRJGj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358937AbjHRJG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 05:06:28 -0400
X-Greylist: delayed 1789 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:06:28 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4DFE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 02:06:27 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id B390884404; Fri, 18 Aug 2023 09:11:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346313; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=RaP15nbxehOJL2Zy4zekTM/ZS/rwZzHmnpTj+rxfSwS5kcDD7SJ/kZQNB2wyPo+jK
         g0w9B42lxf5YMjw3nNqKxX+uS51U9/FwmHY5v9G7BtiJrYsFD6QsKX3I2Xx2xZ+sSu
         fJibJ1lhZzitJfa9pzfub/GBYFhJpE+ttEmGYc80FjirTFsEIIFDw5I16hK9ZMo30l
         B3ouardllGpecU1Zo6KOclK4VaJLsBPb5C1aTlCLlF4QvKtmvz0S5L0NVT/iw34gQY
         QCCMdLbXJs1huBaku/qcIco8f1z0CrK1jhtgBSV40IHamMi5G2sv1aGxBqSFGNW0aj
         z2jBhBeHOBUmg==
Received: by mail.leachkin.pl for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 08:11:05 GMT
Message-ID: <20230818074501-0.1.4u.csxp.0.6heqoz5srk@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:11:05 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-bluetooth@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
