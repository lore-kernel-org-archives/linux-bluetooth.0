Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Nov 2008 13:48:10 +0800
Subject: RE: Can we change org.openobex.Client's dbus node path?
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217AB09@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com>
 <CD8AC205-7C97-4078-A211-871D62407247@holtmann.org>
 <0463F45F3606F4428ED35AC8C709F92E0217AA44@pdsmsx502.ccr.corp.intel.com>
 <C0D77808-B8E7-4BF3-81D8-52EE39667C6C@holtmann.org>
 <0463F45F3606F4428ED35AC8C709F92E0217AAF9@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E0217AAF9@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>
>	I found the reason. During interface register object_path_unref did call
Sorry, typo here: should be object_path_ref

>invalidate_parent_data. But for our case: we have path "/" at first, and w=
e
>register interface at "/org/openobex/Session0", there are no data for
>"/org/openobex", so no any parent introspect data is invalidated. But the =
whole
>/org/openobex path is created for the first time. So actually the "/"'s
>introspect data need to be invalidated.
