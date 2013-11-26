Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Bruno Bruzzano <brunano21@gmail.com>
Date: Tue, 26 Nov 2013 17:26:08 -0500
Message-ID: <CACA6DsUuDH+YLo-UopvrAj8+-yV6P32a2bGmYeoYuAAT58n_zw@mail.gmail.com>
Subject: BT Handover Issue
To: sameo@linux.intel.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-nfc@lists.01.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Samuel,

When I try to send the BT Handover Message to pair my smartphone
(Nexus5), I encounter an issue.
My background is bluez upstream, neard upstream.
I did the following steps:
-run bluetooth -ndE
-run neard -nd '*'
-run ./simple-agent (with NoInputNoOutput capability)
-set power and poll the NFC Adapter
-put my device on top of the adapter ( -> neard recognizes the device,
creating the right deviceX interface)
-./test-device push /org/neard/nfc0/device0 Handover bluetooth

The procedure starts, but it stopped itself before to send the message
to the device.
Here, I made a pastebin of neard.
http://pastebin.com/XEqeucER
In addiction, here you can find other 2 pastbins about the messages I
receive when I do the push (typing './test-device push
/org/neard/nfc0/device0 .....')
http://pastebin.com/faai51ed
http://pastebin.com/N0jWnyXG

Another question: do you think it is possibile send the Handover
Message using the MIME type? I mean, typing: ./test-device push
/org/neard/nfc0/device3 MIME raw application/vnd.bluetooth.ep.oob
'lenghtOOB + device mac_address'

Please give me a feedback.
Thanks!

Bruno aka br1_21
