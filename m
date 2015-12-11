Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Dec 2015 13:18:51 +0530
Message-ID: <CAKafyqo9fvjW8iYWTm86-BL5gr54Rgjwp6kXwAhZoHei4oPLXA@mail.gmail.com>
Subject: Re-connection over reboot Failing - Auth Failure
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

  I am logitek K803 bluetooth smart keyboard. I was using it with my
system. I did hibernate then I was seeing that KBD was not connected
back.

When I cleaned bluetooth cashe /var/lib and reconnected, started
working fine. is it the case the cache is corrupted ?



 HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 47, role master
      bdaddr 01:07:5B:00:15:10 (Public)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x06 handle 47 encrypt 0x00
    Error: PIN or Key Missing
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 47 reason 0x05
    Reason: Authentication Failure
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 47 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
