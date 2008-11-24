Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Nov 2008 10:01:33 +0800
Subject: Can we change org.openobex.Client's dbus node path?
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

	I notice that, in obex-client, we create the org.openobex.Client interface under path "/".
	It's the same as org.openobex.manager in obexd.

	While, when create new session for say FTP, Obexd put Session interface under path "/session*" , and obex client put the Session interface under path "/org/openobex/Session*"

	And this will make the introspect function on client: dbus-send --print-reply --dest=org.openobex.client / org.freedesktop.DBus.Introspectable.Introspect fail to show the node for /org/openobex/Session* (but dbus-send --print-reply --dest=org.openobex.client /org org.freedesktop.DBus.Introspectable.Introspect will work)
	While for obexd: dbus-send --print-reply --dest=org.openobex / org.freedesktop.DBus.Introspectable.Introspect can show the node for /Session*.

	So, can we change the path for org.openobex.Client and register it under path "/org/openobex/Client"?  Or we register session, FTP interfaces under root path like that in the obexd? Either way can solve the introspect problem.

Best Regards,
Raymond Liu

