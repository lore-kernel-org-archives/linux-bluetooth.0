Return-Path: <cyrus@holtmann.org>
Message-ID: <4CD7A05F.1080805@ihug.co.nz>
Date: Mon, 08 Nov 2010 20:01:51 +1300
From: elroy <elroy@ihug.co.nz>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Ubuntu 10.04 - BlueZ 4.60 - Console-only BlueZ setup
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

I'm trying to setup a Ubuntu 10.04 Server with a BT USB adapter to be 
able to connect and send/receive files from a cellphone.


I am trying to do this setup via standard bash shell console only.

The problem I seem to be running into, is unlike the version of BlueZ in 
Ubuntu 7.04, I cannot access MAN pages for BlueZ config files 
(main.conf/etc), and am struggling to find anything that resembles 
orderly documentation on the 'Net.

So far, I can get this:



bluetoothd8643?: pin_code_request (sba=00:10:60:32:3A:93, 
dba=00:18:0F:DE:98:8D)
bluetoothd8643?: No agent available for 0 request


It appears as though I need some form of D-Bus software to communicate 
to BlueZ through - this seems to require a GUI - is there any other 
simpler way to do the Pairing/Config via xxx.conf files without having 
to revert back to bluez-compat?


I have been documenting my progress so far, to try to aid others 
following my path - this may be useful to elaborate on what I am doing 
and have achieved so far.


Regards,

Elroy Liddington.
