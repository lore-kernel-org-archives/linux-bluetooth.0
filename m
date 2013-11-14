Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Bruno Bruzzano <brunano21@gmail.com>
Date: Thu, 14 Nov 2013 16:47:42 -0500
Message-ID: <CACA6DsUNSeaZMTmXSoz-BY52H34jvLedAmB0T_1MsREnhs2MXw@mail.gmail.com>
Subject: 
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone!
As suggested by vcgomes, I subscribed to this mailing list to report a
possible bug. I hope I'll receive a feedback from you.
I'm using Neard and BlueZ5 and my goal is to try the bluetooth
handover. The steps I followed are: I run the Bluetooth daemon with
experimental arg (-E), run the neard daemon, powered the NFC adapter
and set it up in Polling mode; furthermore, I wrote the MiFare Classic
1k tag with a record to do the pair. In particular, I used a Samsung
S3 to write the tag, using the NXP WriteTag application. So, the last
step (I think!) is to put the tag on the adapter to start the pairing.
Unfortunally, something happens, that is, in my smartphone I receive a
pairing request and I give the 'Ok', but watching the debug of
Bluetooth daemon, I read always:
"bluetoothd[22063]: src/agent.c:agent_unref() 0x89470c8: ref=-87222"
"bluetoothd[22063]: src/adapter.c:btd_adapter_confirm_reply() hci0
addr B0:C4:E7:BC:B9:4A success 0".
This two lines are repeated continuisly, with the 'ref' that increases
up to a certain point. After that the Bluetooth daemon crashes.
Here you can find two pastebin, respectively for BlueZ daemon and Neard daemon.
BlueZ: http://pastebin.com/Z4W0V5NZ
Neard: http://pastebin.com/cNfQ7qi0


Best Regards
br1_21
