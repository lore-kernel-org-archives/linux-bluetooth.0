Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Subject: Issue with new LE connection creation
Message-Id: <614A5683-0763-4E64-B178-67577793D8EF@holtmann.org>
Date: Fri, 9 Oct 2015 16:07:22 +0200
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

so when I try to connect a LE L2CAP connection to a device that does not exist and then abort it will not have reached the timeout, I get this:

< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
        Address type: Public (0x00)
        Address: 11:22:33:44:55:66 (OUI 11-22-33)
> HCI Event: Command Complete (0x0e) plen 4
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Command Disallowed (0x0c)

Notice the two attempts for disabling scanning. We should not do that. This is clearly a bug. This can be easily reproduced with latest bluetooth-next and this command:

l2test -V le_public -n 11:22:33:44:55:66

The same happens when you are waiting for the socket connect timeout. The scanning disable command is sent twice.

I also had a case where the disabling of the scanning is not sent at all and the controller kept scanning. However for that one, I do not have an easy way to reproduce it. But it is essentially the same case, you close the socket / application before the connection has been established.

Regards

Marcel

