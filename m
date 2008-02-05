Return-Path: <cyrus@holtmann.org>
From: SA <sa@claborn.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 5 Feb 2008 16:11:46 -0600
References: <200801242256.33910.sa@claborn.net>
	<200802051542.11330.sa@claborn.net>
	<200802051546.45851.sa@claborn.net>
In-Reply-To: <200802051546.45851.sa@claborn.net>
MIME-Version: 1.0
Message-Id: <200802051611.46542.sa@claborn.net>
Subject: Re: [Bluez-users] How to setup a headset as an audio device?
	Getting "Device busy" errors
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

I just found out that this headset does not support HSP:

# sdptool search --bdaddr 00:0D:3C:6F:0E:89 HS
Searching for HS on 00:0D:3C:6F:0E:89 ...
#



sdptool search --bdaddr 00:0D:3C:6F:0E:89 HF
Searching for HF on 00:0D:3C:6F:0E:89 ...
Service Name: Hands-Free unit
Service RecHandle: 0x10000
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101



It's a "Jawbone" headset, from jawbone.com. Good quality. Apparently bad 
engineering or design.

	JW


-- 

----------------------
System Administrator - Cedar Creek Software
http://www.cedarcreeksoftware.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
