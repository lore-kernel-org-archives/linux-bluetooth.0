Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: Discovering LE advertisements programatically
From: Adam Warski <adam@warski.org>
In-Reply-To: <C4A59DF3-F4DF-445A-AA86-6BB9A81A2910@warski.org>
Date: Sun, 26 Jan 2014 12:20:21 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <730D01B5-447B-4845-B8A8-D87E2B25E311@warski.org>
References: <41458C64-3510-481A-92F4-1296C06600CC@warski.org> <CAJdJm_PFAWLvBQFXOntGu+sA7-vGuVRx5956OL3CD8QjmqZiEA@mail.gmail.com> <C4A59DF3-F4DF-445A-AA86-6BB9A81A2910@warski.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>>> I’m trying to find a good way to discover and retrieve LE advertisements programatically.
>>> 
>>> My first shot was to try to use DBus. I was trying to extend what the test/test-discovery script is doing, but it seems using DBus I can only get notified of new devices being discovered. Is there a way to get the actual LE advertisement via DBus? The device properties seem not to contain the info from the advertisement PDU.
>>> 
>>> If that’s not possible using DBus, is the way to go just using C?
>>> 
>>> I also tried using command line, a combination of “hcitool lescan” and “hcidump”/“hcidump -R" gives what I need more or less (plain hcidump gives me the RSSI, hcidump -R gives me the raw packet that I need). Still, I guess there must be a better way.
>> 
>> My suggestion would be to take a look at "hcitool lescan" for how it
>> is done using C sockets. Or you can modify hcitool lescan to dump the
>> full advertising report instead of just the name.
> 
> Indeed by modifying the source of the hcitool, lescan method (print_advertising_devices), I am able to get the advertisement content. However, I’d also like to get the RSSI - is it possible from that method? I have access to the open device (dd), and the evt_le_meta_event and le_advertising_info structures - but that doesn’t seem to be enough. There is a hci_read_rssi in lib/hci.c, but it requires a “handle” - I think it’s only useable if a conneciton is open.

Actually, looking at the whole data received from the socket, I think the last byte - and the only byte remaining after the advertisement packet - is the RSSI.

So I guess writing to the group worked as a rubber duck :)

Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

