Return-Path: <cyrus@holtmann.org>
From: SA <sa@claborn.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 5 Feb 2008 15:46:45 -0600
References: <200801242256.33910.sa@claborn.net>
	<d89ddf300802051041j76801e4n5214d01bf01b48e3@mail.gmail.com>
	<200802051542.11330.sa@claborn.net>
In-Reply-To: <200802051542.11330.sa@claborn.net>
MIME-Version: 1.0
Message-Id: <200802051546.45851.sa@claborn.net>
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

In the last message I may have caused some confusion.

Each time I try aplay I get this in /var/log/messages (doesn't matter which 
aplay command example I try):


==> messages <==
Feb  5 15:42:49 citrine audio[3438]: Accepted new client connection on unix 
socket (fd=8)
Feb  5 15:42:49 citrine audio[3438]: Package PKT_TYPE_CFG_REQ:0
Feb  5 15:42:49 citrine audio[3438]: No known services for device
Feb  5 15:42:49 citrine audio[3438]: Unix client disconnected (fd=8)




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
