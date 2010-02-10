Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 9 Feb 2010 20:30:09 -0600
Message-ID: <8a7a8d7b1002091830i63a33c66s29fa11bebd50a857@mail.gmail.com>
Subject: Need advice about how to filter out some SCO packet types
From: Liejun Tao <liejuntao001@gmail.com>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
When setup Sco/eSco connection, current kernel code try to enable all
possible packet types, while some of them have bad performace.
I'm trying to filter out a few packet types, and need advice what's a good way.

1. in hci_conn.c, use a hardcoded mask to filter out the bad
types.It's easiest but impact widely.
2. provide a configurable option in bluez, like
SCO_ESCO_ALLOWED_TYPES, and find a way to pass it to kernel. It also
impact one system, but not all.  I'm still not sure if it's possble.
3. provide per socket option.

Please advice.
