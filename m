Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
From: Stefan Bellon <sbellon@sbellon.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <4d35427939sbellon@sbellon.de>
In-Reply-To: <41FC4BAF.4090201@xmission.com>
References: <4d3382eb6csbellon@sbellon.de> <41F81D6F.3000908@xmission.com> <4d33b69105sbellon@sbellon.de> <4d348a05e8sbellon@sbellon.de> <41FC4BAF.4090201@xmission.com>
Content-Type: text/plain
Subject: [Bluez-users] Re: bluetooth-alsa and Jabra BT800
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 30 Jan 2005 08:51:46 +0100

Brad Midgley wrote:

> How do you know you're using the right address? 

Well, because of this:

root@roma# hcitool info 00:07:A4:21:1D:86
Requesting information ...
        BD Address:  00:07:A4:21:1D:86
        Device Name: Jabra BT800
        LMP Version: 1.2 (0x2) LMP Subversion: 0x68d
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x8b 0x78 0x08 0x08 0x00 0x80
                <encryption> <slot offset> <timing accuracy> <role switch> 
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality> 
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <paging scheme> <transparent SCO> <broadcast encrypt> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <AFH cap. slave> <AFH cap. master> 
                <extended features> 

Isn't that enough?

> No sdp available doesn't look good.

Hm, is this a mis-feature of the headset then? How does a handy talk to
the headset then?

> Is the headset paired with a cellphone that is in range? Some
> embedded bluetooth radios will only talk to one device... if it
> discovers the paired phone at power on then your laptop typically
> won't be able to talk to it.

The Jabra BT800 can be paired with 8 devices. You see a list in the
display and can choose which one it talks to. I can verify that
switching the communication devices works. If I select my SonyEricsson
P900 and press the "answer" key, then voice dial on the P900 is
initiated. If I select the computer and press the "answer" key, then
the second light of my USB Bluetooth dongle lights up and hcidump
displays a connection handshake whereas my P900 stays silent.

-- 
Stefan Bellon


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
