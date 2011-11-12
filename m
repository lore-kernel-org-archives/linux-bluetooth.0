Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6LEFsRx6ADbWAmRY4cY6J=7cex8aF0PEu1f8cK+hi72g@mail.gmail.com>
References: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
	<CAMOw1v6Z9aKnJ9V4SJCCK5ruU21JnZSbiHyMAZEfvi5rUKFRtw@mail.gmail.com>
	<CAOazyz1MXi1v3O7RC-dTLhrLgPJ1Zk4+iKNu0ZMHQyFah1OFJg@mail.gmail.com>
	<CAMOw1v4YrqrpVYiiEE5cUj0Zx7p=KRopskMA2pYLJMFa7fTusA@mail.gmail.com>
	<CAOazyz2N++pmzPeoTrj=BGn1C6YfR1zbXD18-O8owWVDm7WLVg@mail.gmail.com>
	<CAMOw1v6LEFsRx6ADbWAmRY4cY6J=7cex8aF0PEu1f8cK+hi72g@mail.gmail.com>
Date: Sat, 12 Nov 2011 02:29:05 +0200
Message-ID: <CAOazyz0RnY9_UjSLTafFvV0wVH9b+f3cCaXFT1t=cwL5Fb29gw@mail.gmail.com>
Subject: Re: Out of tree plugins
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Nov 12, 2011 at 2:17 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ( e.g. in the mail thread you mentioned, dbus_connection_unref() and
> dbus_bus_get() are not right. If you need those you should link
> against d-bus instead when building as an external module )

This is needed in order to get the address of the bluetooth controller.
I am no expert in this library so maybe there is another way to do so.

The code currently uses:
---
struct btd_device *adapter_get_device(DBusConnection *conn,
                                struct btd_adapter *adapter, const
char *address);
---

Can this be somehow be replaced with:
---
struct btd_device *adapter_find_device(struct btd_adapter *adapter,
const char *dest);
---

Alon
