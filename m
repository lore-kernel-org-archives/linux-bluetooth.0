Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <463A38C2.80403@mojo-working.com>
Date: Thu, 03 May 2007 12:32:18 -0700
From: Art Rothstein <holtmann@mojo-working.com>
MIME-Version: 1.0
To: Bluez-users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] hcitool info dropped feature details between versions
	3.7 and 3.9?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I recently upgraded my Ubuntu distro from 6.10 to 7.04.  This included an
hcitool upgrade from 3.7 to 3.9.  Remote device information is now missing the
details on device features, e.g.,

Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80
         <3-slot packets> <5-slot packets> <encryption> <slot offset>
         <timing accuracy> <role switch> <hold mode> <sniff mode>
         <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
         <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
         <transparent SCO> <enhanced iscan> <interlaced iscan>
         <interlaced pscan> <inquiry with RSSI> <extended SCO>
         <EV4 packets> <EV5 packets> <AFH cap. slave>
         <AFH class. slave> <AFH cap. master> <AFH class. master>
                           <extended features>

Is this intentional?  Is there another way to get this information from existing
utilities?
-----
McKinley Systems
San Francisco
415-827-7575
http://www.mojo-working.com



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
