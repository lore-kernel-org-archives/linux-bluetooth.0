Return-Path: <fabchevalier@free.fr>
Message-ID: <1193490380.472337cc3082a@imp.free.fr>
Date: Sat, 27 Oct 2007 15:06:20 +0200
From: fabchevalier@free.fr
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: [PATCH] common/ dbus cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>


Marcel, while looking to move error stuff to common/, i came across
some bits of duplicated code.

Basically send_message_and_unref (dbus.h) and dbus_connection_send_and_unref
(dbus-helper.h) are the same functions, and
are both used in the code :-)

The attached patch simply removes send_message_and_unref and moves all its users
to dbus_connection_send_and_unref.

Regards,

Fabien
