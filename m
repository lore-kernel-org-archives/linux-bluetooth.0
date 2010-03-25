Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: linux-bluetooth@vger.kernel.org
Subject: Problems with bt_io_listen
Date: Thu, 25 Mar 2010 15:45:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201003251545.52988.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

We are developing an implementation of HDP and MCAP for bluez. We are triying 
to perform many connections between two devices but when we make the second 
connection it is not created correctly.

We are using a defer connection (we passed a confirm callback to the 
bt_io_listen function) and we think that we are missing something but  we 
can't find what. If we used the connection callback (not defer) all the 
connections are done successfully.

We are listening with the following code:

static void confirm_cb(GIOChannel *chan, gpointer user_data)
{
	...
	node->chan = g_io_channel_ref(chan);
	...
	/* All is ok */
	return;
drop:
	/* Connection refused */
	g_io_channel_shutdown(chan, TRUE, NULL);
}

....
chan = bt_io_listen(BT_IO_L2CAP, NULL, confirm_cb, NULL,
				NULL, &gerr,
				BT_IO_OPT_SOURCE_BDADDR, &src,
				BT_IO_OPT_PSM, 0x1001,
				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
				BT_IO_OPT_INVALID);
...

Any ideas?

Regards and thank.

Jose.
