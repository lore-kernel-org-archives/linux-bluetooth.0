Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3115C64991
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 10:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIAKqp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiIAKqm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 06:46:42 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86CF8259
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 03:46:41 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id DD0B12000D;
        Thu,  1 Sep 2022 10:46:38 +0000 (UTC)
Message-ID: <1ef5e51d2103b6f02826777ebf5415f74018e317.camel@hadess.net>
Subject: Re: [PATCH] plugins: Do not try to autopair with Nissan Connect
 devices
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Florian Leeber <florian@ubports.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 01 Sep 2022 12:46:33 +0200
In-Reply-To: <CABBYNZJGc2Y3UULighw95un9mb8khLM2dfTOB3jRV8D3ksVDXg@mail.gmail.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
         <CABBYNZJGc2Y3UULighw95un9mb8khLM2dfTOB3jRV8D3ksVDXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2022-08-31 at 13:18 -0700, Luiz Augusto von Dentz wrote:
> Hi Florian,
> 
> On Wed, Aug 31, 2022 at 12:44 PM Florian Leeber <florian@ubports.com>
> wrote:
> > 
> > It seems that Nissan Connect carkits a) do not use 0000 but 1234 as
> > default code
> > but also b) the autopair plugin is not allowed to make a second
> > attempt
> > to pair.
> > Let´s try to not use the autopairing at all for those devices.
> > ---
> >   plugins/autopair.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/plugins/autopair.c b/plugins/autopair.c
> > index 0b09e89..6bf07e3 100644
> > --- a/plugins/autopair.c
> > +++ b/plugins/autopair.c
> > @@ -66,6 +66,9 @@ static ssize_t autopair_pincb(struct btd_adapter
> > *adapter,
> >          /* The iCade shouldn't use random PINs like normal
> > keyboards */
> >          if (strstr(name, "iCade") != NULL)
> >                  return 0;
> > +       /* Nissan Connect carkits use PIN 1234 but refuse a retry
> > */
> > +       if (strstr(name, "NISSAN CONNECT") != NULL)
> > +               return 0;
> 
> Well this is already starting to grow which imo defeats the purpose
> of
> hardcoding directly on the code so perhaps we could have a section
> e.g. [Autopair] where one can enter device names that shall not use
> defaults PINs, or may an entry where one can add its own specific PIN
> sequence for a given device name including none:
> 
> [Autopair]
> PIN=0000,1234
> # The iCade shouldn't use random PINs like normal keyboards
> iCade=
> # Nissan Connect carkits use PIN 1234 but it refuses retries
> NISSAN CONNECT=1234
> 
> With this the logic is check if there is an entry for the device name
> and then use as PIN otherwise use the PIN entry (if not defined use
> the current settings as default).

FWIW, gnome-bluetooth has its own database on top of bluez, which we
prefer to the code in bluez. I'd be happy getting rid of it.

Loads of devices that need pairing despite their class and Bluetooth
version, and devices that need special handling like the Navman GPS
that expects a non-numerical PIN.

The database:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/lib/pin-code-database.xml
The code to parse it:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/lib/pin.c
