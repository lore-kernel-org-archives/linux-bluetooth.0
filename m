Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Jul 2010 11:12:35 +0400
Message-ID: <AANLkTikcX6_SydJf4YRG3ym4Q0GVGQ26WpAh3Mm1uyyQ@mail.gmail.com>
Subject: obex-client: doesn't allways closes socket
From: Vitja Makarov <vitja.makarov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Recently I've found that obex client doesn't allways close socket, I
was using obexd-0.29...
Even more sometimes it closes same socket twice using
g_io_channel_unref() and close()

When it comes to client/session.c:rfcomm_connect() with error,
session->sock is not set and socket is not closed on
session_shutdown()
Don't know why g_io_channel_unref() isn't called for that socket..

test-case:
./send-files xx:xx:xx:xx:xx xxx.xxx
ls /proc/`pgrep obexd-client`/fd | wc -l

then don't accept incoming connection on your phone, press no

When you press yes to receive file, see strace output obexd-client
closes socket twice...

vitja.
