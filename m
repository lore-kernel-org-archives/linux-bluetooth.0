Return-Path: <cyrus@holtmann.org>
Message-ID: <49345A86.1040902@mobileinteraction.com>
Date: Mon, 01 Dec 2008 22:43:34 +0100
From: Erik Stackenland <erik@mobileinteraction.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bug in hci_read_remote_name?
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm new to bluetooth and BlueZ, so it might be that I just don't know what I'm
talking about but this does not seem right.

The problem is in hci_read_remote_name

<code>
...
char bt[20];
ba2str(&bdaddr, bt);
printf("get name: %s\n", bt);

/* Get the name */
if (hci_read_remote_name(dd, &bdaddr, sizeof(name_str), name_str, timeOut) < 0)
{
  return -1;
}

printf("found name: %s\n",name_str);
...
</code>

<printout>
...
get name: 00:17:D5:5A:86:85
get name: 00:1E:45:08:36:28
found name: SGH-X820
...
</printout>

The problem here is that I know for a fact that 00:1E:45:08:36:28 is not
SGH-X820, but should be named W910i, and that 00:17:D5:5A:86:85 is SGH-X820.

I'm using 1000 millis timeout for hci_read_remote_name, so my assumption is that
the time runs out before the response is received and when I ask with an other
bt address a few millis later I get the response for the earlier request.

So is it possible that this is a bug?

System is debian-40r5 standard installation installed today. Dont know how to
check BlueZ version.

Thanks!


