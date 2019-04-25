Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13CC43218
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF298206BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfDYRYB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:24:01 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:47489 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfDYRYA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 13:24:00 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id Ji6BhUMTaZVjxJi6EhgTGL; Thu, 25 Apr 2019 19:23:58 +0200
Message-ID: <abe312a35d10b0478d4ea1f51da14860f017b921.camel@tiscali.nl>
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Networking <netdev@vger.kernel.org>,
        isdn4linux@listserv.isdn4linux.de,
        Holger Schurig <holgerschurig@googlemail.com>,
        Tilman Schmidt <tilman@imap.cc>,
        Al Viro <viro@zeniv.linux.org.uk>,
        gigaset307x-common@lists.sourceforge.net,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Date:   Thu, 25 Apr 2019 19:23:51 +0200
In-Reply-To: <CAK8P3a2bZpnv+NGQxiA3t_LB8e+so4Nkab5kuTcGjgn8i+f=BA@mail.gmail.com>
References: <20190423151143.464992-1-arnd@arndb.de>
         <20190423.193735.412590692063607790.davem@davemloft.net>
         <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com>
         <FBF10E1F-2D3D-4FFC-8F8C-5969A2F2A475@holtmann.org>
         <CAK8P3a2FLrGXh9iv4eWBX8D_zb7rq5YDErkzDjjHbA5JENHVGw@mail.gmail.com>
         <D5B4825C-88DE-4011-8C2C-141214486861@holtmann.org>
         <CAK8P3a2bZpnv+NGQxiA3t_LB8e+so4Nkab5kuTcGjgn8i+f=BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIBU4lx3DInNezseExlgsobhG2UukV4skpbjdd2o7OmLR6oKqPWYueauidCt1RcURVWzCgHbAsno/tazOfaQetWg3ntbFHh2S8u4eB2Ky1jVhWeuocuo
 s5HEF54sbFqsZ55+BKGnHRRQwUed5GH3KWmzSbSVWzC4e6kLKY69kT87E76jbbnaK62B69Ge6ni8pockL/0d/XuYBeVYmljW1G+SXAg1d9fwSBhXEEgnAdIC
 4cmHoePSJn1mrekT5I4rpt7glBODraa5spk1HpKHnzkz9pGCX2lY/QNKkOazZFnH3f/Cd0mF1r+quegs3YVhTehciDNCttD9X9FlM/VYSjTwMWio/CirA0uF
 exI5e5+gRIIMOGqVuFDOKsHb0XkAjog3LMN80DjZ6cPE77EFGA+2AzJiKCa8xI8iPYYe1TD92p4wz3/rI3ScM/fk9UXZsoZ0Zgeys13fMMqz+YnIODYI701R
 ZlxPoBpYEVlAyQyhmVrqz4UH9+bIporRXtXDuyQ+JNjtRFiZL9fwYuUNzSudeytx7nBwRpFMqp+CEPpajQjWYCokbY28yZHjnpwtkR7D9comUEBWxFuptsXX
 vcDCn+JMEO3r1sZGdslvd3lQnwnVzhR/ZKiHSEPV7fPdX/rGKzksV/cmQas1pSXVU7E=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Arnd Bergmann schreef op do 25-04-2019 om 13:08 [+0200]:
> The gigaset driver is similar here, you can use it for any kind of wireless ISDN
> communication,

Nit: the wireless part is strictly DECT (for the M101 and M105 hardware).

> but apparently there is little use for that without a physical
> ISDN connection.

Probably.

The main point is that once my ISDN line is canceled it would be nice to know
whether someone still cares about these drivers. (Do note that for day to day
data traffic I definitely do not really on ISDN. I'm not _that_ crazy.) Your
suggestion to exile them into drivers/staging is about the only policy we have
for finding that out.

Thanks,


Paul Bolle

