Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add "Class" property to org.bluez.Adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Bea Lam <bea.lam@trolltech.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49ADD4C8.8040705@trolltech.com>
References: <49ADD4C8.8040705@trolltech.com>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 22:04:02 +0100
Message-Id: <1236200642.6670.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bea,

> I mentioned on IRC a while back that a "Class" property for the Adapter
> interface might be useful. I've attached a patch to this effect. Please
> let me know if there are any issues.

+       /* Class */
+       class = adapter->dev.class[0]
+               | (adapter->dev.class[1] << 8)
+               | (adapter->dev.class[2] << 16);
+       dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
+

This should more like this:

	class = adapter->dev.class[0] |
			adapter->dev.class[1] << 8 | ...

Regards

Marcel


