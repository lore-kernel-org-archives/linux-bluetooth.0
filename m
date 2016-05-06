Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 May 2016 02:44:03 -0700
Message-ID: <CAGup35xNHnGOeB2KT9n0oUBetqRJVygmHbNZBaNqu9HXw+98nA@mail.gmail.com>
Subject: connect() returning EINPROGRESS
From: Allan Hessenflow <allan@flynixie.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a tool that was developed with bluez 4.101 and it works fine
there.  Now I'm trying to get it to run on a different machine with
bluez 5.37 and it is failing.  It communicates with a BLE device.  It
first listens to advertising packets until it sees the device it is
looking for, then does an hci_le_create_conn().  That much appears to
work fine.  It creates a bluetooth socket, binds it (to BDADDR_ANY),
and does a setsockopt() to set BT_SECURITY to BT_SECURITY_LOW.  All of
that returns success.  Finally it does a connect().  That goes away
for quite a while (I haven't timed it, something on the order of a
minute) and then returns non-zero with errno set to EINPROGRESS.  I
didn't explicitly set the socket to non-blocking and it certainly
doesn't appear to be some implicitly set characteristic since it takes
so long to return, so I don't know what EINPROGRESS could mean in this
case.  Can anyone tell what I'm doing wrong?

allan

-- 
Allan Hessenflow            allan@flynixie.com
