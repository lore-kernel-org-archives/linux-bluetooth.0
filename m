Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EDDCD548C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 07:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjISHhg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjISHhe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 03:37:34 -0400
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:37:25 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF492125
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 00:37:24 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 474A5761253; Tue, 19 Sep 2023 09:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108691; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=xYH9wwyL5RB038q5aBpXzgOo/xcNtCJer7iAqPYCZJdH9qeLAlJ3L4pwbobhaG34n
         OoJJMvVOFbpepgenEqzHfPWtQvzr2hlS4Z3GA89YxOt67+Hbxdnu/JUz+iysAwh6Ci
         G3zI+pmNhLn5ldyE3Iluk9kGZ2Az6aNj+gm77pIpAMY6iBae82KvAVPDTx7TMGw6nv
         8LQSDlG0nWvojOD4NVKEloQyRT52F08B6lUY2VSYl0xpySwYVP4Nfe0/20E5gWvMwE
         4cSq5MzRdVK7e/0Pii7Oe2KQwgNt6raufN9aAprG9UOpweIgqoV+mz5EokqDzxIYsc
         Xk7Q3tcl3f32w==
Received: by mail.leeswilly.pl for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 07:30:18 GMT
Message-ID: <20230919084500-0.1.3z.bc17.0.mn893qmalc@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:30:18 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-bluetooth@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
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


Pozdrawiam
Jakub Lemczak
