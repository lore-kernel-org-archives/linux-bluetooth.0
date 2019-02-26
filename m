Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A58DC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8782147C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 09:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etM2T9yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBZJel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:34:41 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41197 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZJek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 04:34:40 -0500
Received: by mail-ed1-f47.google.com with SMTP id x7so10099239eds.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 01:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fPns8iLrkzJmdakOo2djy+9VkrAPQhJQR/I1syKqclM=;
        b=etM2T9yb2Kvb0TWpN01ruKSgGgIVMwMqxnMINpFnpZ2v/lJpsq4jjdKLegwbwZXl/s
         ZYsY7FYcQjotQg+PXhFnZdcKh5U3TKOWGUPWKPuBtMHN1VxRQu2qAikORhzy5H1y2hGC
         +owRGfUW0rHAZ3OIvPxR+ZB4RuFvw99R2PghXDNEomL6mp86JsX0aBhMv/IdVwIdnjV7
         NHvXhr5KDoDskvBMSHJKsxdHQRUO5w1sY6FqWgzynmHU7aDseNHxMuetKx09JFbTe63v
         PsyDhzcoO1BOawEqDD4vuhociSiN9S9muw4cADS2Xl47864phof9XyMEUw/Bc6PqXW3F
         a6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPns8iLrkzJmdakOo2djy+9VkrAPQhJQR/I1syKqclM=;
        b=luCW8Y5q2KOHQZXdh736R712bB7i1swhVNDppKSdSspGTJpsqaBKNox21D/F034ilB
         fa2/wgTlgpTgt/RrG55uXpp34g6QcI4XOCdUORh6kcmE5pQ4YiaNsbSSAQvR2KjDv2SA
         rrKyWk6PHK2OAs99yZ+1hm85N94q4vgtMWR27+eV3DBJ9bzXs7DYkhbrHeJhvT/TGJhn
         fTvBDKhRmHDiroZwIWqITmgDL9V0KiOppS0FzksJaEAERP8/wDQpvy1hLEGWWkBZccdQ
         7iAXjQ1I9qGMMpeAweJBCmMN+7RfEVXo85hCi/po3Q9nZauLDgHrxFZHY7ggYcHGjf1d
         Xz/A==
X-Gm-Message-State: AHQUAubQbdikEepvJBxnJi1hsAaWiObZZ5C/UGJtJLh/cNraze/Ali2R
        nHuoISuSERLACUAILAhrmfU=
X-Google-Smtp-Source: AHgI3IZ8WdLo+fqGrNjr3WRsmJaSMQszhizj63yYUVTtWwoWqv8+ky/EzhWuJC6eR9pkmXTXgUYysQ==
X-Received: by 2002:a50:9fe9:: with SMTP id c96mr18589476edf.0.1551173678045;
        Tue, 26 Feb 2019 01:34:38 -0800 (PST)
Received: from vudentzs-t460s ([192.198.151.62])
        by smtp.googlemail.com with ESMTPSA id x18sm2521595edd.4.2019.02.26.01.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:34:37 -0800 (PST)
Message-ID: <dfff10f65237cb50ef8e995770fc31d86fb4f5db.camel@gmail.com>
Subject: Re: [PATCH BlueZ] test/example-advertisement: add shutdown code
From:   Luiz Augusto Von Dentz <luiz.dentz@gmail.com>
To:     "Hunt, Preston" <preston.hunt@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 26 Feb 2019 11:34:34 +0200
In-Reply-To: <064187F9-FB73-4167-9458-242CD0A41B8E@intel.com>
References: <5EDC8785-AB89-452A-AC80-E31A244A4467@intel.com>
         <CABBYNZKArwJcBQG+45=5VHnQ9aEb1YLz_5Of74K2sRO==VcFYw@mail.gmail.com>
         <2E41061B-EEAD-4AEA-8F2D-BB7A8753D77B@intel.com>
         <69CBFA6F-BD2D-4D2B-BBC3-93C1B83C8ADE@intel.com>
         <203CC3D6-8987-4F56-AE91-2FD642E29FDB@intel.com>
         <064187F9-FB73-4167-9458-242CD0A41B8E@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Preston,

On Fri, 2019-02-22 at 22:42 +0000, Hunt, Preston wrote:
> Hello,
> 
> I just realized that this patch which I had submitted many months ago
> never got applied to the master branch. I was wondering if it slipped
> through the cracks or if there was an issue with it, in which case I
> am happy to address any concerns. Thank you!
> 
> With best regards,
> Preston
>      
>     
>     On 9/24/18, 8:46 AM, "Hunt, Preston" <preston.hunt@intel.com>
> wrote:
>     
>         The previous sample code did not release all resources when
> shutting
>         down. This is fine when it's a standalone program since
> Python will free
>         all resources automatically when the process terminates.
> However, in a
>         long-running process, this will eventually cause problems.
>         
>         This changeset shows how to properly release all resources,
> if an optional
>         command line "--timeout" argument is used. The default is no
> timeout to
>         maintain behavior of the previous implementation
> (advertisements will run
>         forever).
>         ---
>          test/example-advertisement | 42
> ++++++++++++++++++++++++++++++++----------
>          1 file changed, 32 insertions(+), 10 deletions(-)
>         
>         diff --git a/test/example-advertisement b/test/example-
> advertisement
>         index fd84eac..88a27ab 100755
>         --- a/test/example-advertisement
>         +++ b/test/example-advertisement
>         @@ -2,19 +2,18 @@
>          
>          from __future__ import print_function
>          
>         +import argparse
>          import dbus
>          import dbus.exceptions
>          import dbus.mainloop.glib
>          import dbus.service
>         -
>         -import array
>         +import time
>         +import threading
>          
>          try:
>         -  from gi.repository import GObject  # python3
>         +    from gi.repository import GObject  # python3
>          except ImportError:
>         -  import gobject as GObject  # python2
>         -
>         -from random import randint
>         +    import gobject as GObject  # python2
>          
>          mainloop = None
>          
>         @@ -136,6 +135,7 @@ class Advertisement(dbus.service.Object):
>              def Release(self):
>                  print('%s: Released!' % self.path)
>          
>         +
>          class TestAdvertisement(Advertisement):
>          
>              def __init__(self, bus, index):
>         @@ -170,7 +170,13 @@ def find_adapter(bus):
>              return None
>          
>          
>         -def main():
>         +def shutdown(timeout):
>         +    print('Advertising for {} seconds...'.format(timeout))
>         +    time.sleep(timeout)
>         +    mainloop.quit()
>         +
>         +
>         +def main(timeout=0):
>              global mainloop
>          
>              dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
>         @@ -183,7 +189,7 @@ def main():
>                  return
>          
>              adapter_props =
> dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, adapter),
>         -                                   "org.freedesktop.DBus.Pro
> perties");
>         +                                   "org.freedesktop.DBus.Pro
> perties")
>          
>              adapter_props.Set("org.bluez.Adapter1", "Powered",
> dbus.Boolean(1))
>          
>         @@ -198,7 +204,23 @@ def main():
>                                               reply_handler=register_
> ad_cb,
>                                               error_handler=register_
> ad_error_cb)
>          
>         -    mainloop.run()
>         +    if timeout > 0:
>         +        threading.Thread(target=shutdown,
> args=(timeout,)).start()
>         +    else:
>         +        print('Advertising forever...')
>         +
>         +    mainloop.run()  # blocks until mainloop.quit() is called
>         +
>         +    ad_manager.UnregisterAdvertisement(test_advertisement)
>         +    print('Advertisement unregistered')
>         +    dbus.service.Object.remove_from_connection(test_advertis
> ement)
>         +
>          
>          if __name__ == '__main__':
>         -    main()
>         +    parser = argparse.ArgumentParser()
>         +    parser.add_argument('--timeout', default=0, type=int,
> help="advertise " +
>         +                        "for this many seconds then stop,
> 0=run forever " +
>         +                        "(default: 0)")
>         +    args = parser.parse_args()
>         +
>         +    main(args.timeout)
>         -- 
>         2.7.4

Applied, thanks.

