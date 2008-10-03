Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
Date: Thu, 2 Oct 2008 17:47:30 -0700
From: "Nick Pelly" <npelly@google.com>
To: "Marcel Holtmann" <marcel@holtmann.org>, johan.hedberg@gmail.com
Subject: Keeping ACL link around after DBUS CreateBonding()
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel/Johan:

I have memories of one of you talking about a custom change to bluez
to not immediately drop the ACL link once DBUS CreateBonding() has
finished (so that SDP can then be done on that link).

Do you know the patch to do this? I am currently experimenting with
changing the timer expiry in hci_conn_put() for disc_timer. Maybe
there's a nicer way.

Thanks
Nick
