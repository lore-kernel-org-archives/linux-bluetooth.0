Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Reply-To: <ag@new-media-artists.de>
From: "Andreas Gaufer" <ag@new-media-artists.de>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: AW:  [Bluez-devel] Device Busy during "hcitool info" or  "sdptoolsearch"
Message-ID: <FJENILNPNAGPJMMDOKDCEEKKDJAA.ag@new-media-artists.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3FE0C1B9.5090504@csr.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 18 Dec 2003 01:50:20 +0100

Hi Steven, Marcel, List,

>In your case, the correct response to having your inquiry rejected is
>to back off for a few seconds and try again - either that, or find some
>way of sharing access to the device.

Sounds good to me, im actualy handling it like this. The only problem is if
a device is in range that does not respond to the connection attemt will
make the device unusable for inquiry until the connection attemt times out.

Who decides when to timeout? I guess the host, so where can i configure
these timeouts?

Greetings

Andreas



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
