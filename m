Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Jun 2010 15:45:24 +0200
From: clemens fischer <ino-news@spott.ath.cx>
To: linux-bluetooth@vger.kernel.org
Subject: Re: obexd: cannot object-push certain files (large, w/ logs)
Message-ID: <20100628134523.GA4527@spotteswoode.de.eu.org>
References: <20100627151712.GA4427@spotteswoode.de.eu.org>
 <AANLkTikrwAgP4bi0fkWWd-mqn_HFmfCWPZkQLe0rWttY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikrwAgP4bi0fkWWd-mqn_HFmfCWPZkQLe0rWttY@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz Augusto and shy, thanks for your info.

> Luiz Augusto von Dentz:

> You can clearly see that obexd respond the connection request with 200
> (ok) and after that there is no request from the remote device just a
> clear disconnect:
> 
> 16:58:37 < ACL data: handle 38 flags 0x02 dlen 15
> 16:58:37     L2CAP(d): cid 0x012b len 11 [psm 3]
> 16:58:37       RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 7 fcs 0x14
> 16:58:37         OBEX: Connect rsp(f): status 200 len 7 version 1.0
> flags 0 mtu 32767
> 16:58:37         Status 200 = Success
> 16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
> 16:58:37     handle 38 packets 1
> 16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
> 16:58:37     handle 38 packets 1
> 16:58:37 > ACL data: handle 38 flags 0x02 dlen 8
> 16:58:37     L2CAP(d): cid 0x0041 len 4 [psm 3]
> 16:58:37       RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3

> Have you tried transferring the same file with any other phone/stack?
> This one seems very unlikely to be a obexd bug since there is not even
> a request to transfer anything and as the connection itself seems ok,
> no missing agent apparently, I don't see anything wrong here.

This is interesting.  There are files of any size that can reliably be
transfered and others that cannot, also reliably.  Your interpretation
of the packet trace seems to indicate that the nokia-3650 firmware
selects between the two kinds.  I'm glad that I can trust obexd!

I have no other phone, but there's an application letting me at least
copy those files to a MMC card.  The only trouble is that I have to
remove both battery and MMC card from the phone, put it into
a card-reader on the PC, copy any files over and then reassemble that
phone.  The phone didn't come with a serial cable, the nokia software on
the CD is window$-only and the linux tools (eg. gnooki, gammu, but also
a number of applets) either require large dependencies or a GNOME/KDE
desktop.  But I'm a person with simple needs.  I need backups of the
contacts, calendar and notes on the phone.  So far I could not find out
the format of the file Backup/Backup.arc which is the reason for sending
or copying certain files one by one.

I bet you guys have special setups with command-line tools in scripts
for testing the differing scenarios a bluetooth device can be used in.

The most basic chain of commands to get push-obex to work was
('00:XX:XX:XX:XX:XX' being the bluetooth address of the phone):

    bluez-simple-agent hci0 '00:XX:XX:XX:XX:XX' (starts bluetoothd)
    hciconfig putkey '00:XX:XX:XX:XX:XX' (optional)
    /l/libexec/obexd -nd -r /tmp/ -a -o

This took me days to find out.  Simple commands like this categorized by
purpose might be candidates for a FAQ.  Do you have tips where to look
for CLI commands like this?  What do you use for testing?


regards, clemens fischer
