Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806090210i2c4cc2fah3bab16c041ab2b0e@mail.gmail.com>
Date: Mon, 9 Jun 2008 11:10:57 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] pairing problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0726017361=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0726017361==
Content-Type: multipart/alternative;
	boundary="----=_Part_7502_3954498.1213002657562"

------=_Part_7502_3954498.1213002657562
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

I want to use a Bluetooth keyboard and it works fine so far, but there are
some problems after the initial pairing.

To get the keyboard wokring I do the following steps:

hcid and passkey-agent are running.

hcitool scan
hcitool cc <bdaddr>
After this step hcitool con lists a established connection to the keyboard
auth <bdaddr>
Enter PIN on keyboard

Now the entry in hcitool con changes to AUTH
So the connection is authorized and established and the keyboard works (I
use bthid, anyway the process of authorization and pairing is done by hcid,
and hcitools)

Usually from now this initial pairing process shouldnt be necessary for
further sessions, but unfortunately it is.
In oder to use the keyboard again (after disabling it) I have to go through
the whole process again, but befor I have to /var/lib/bluetooth/*

So how can I establish further connections without the whole pairing
process?

thanks


-- 
Regards,
--Codefritz

------=_Part_7502_3954498.1213002657562
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!<br><br>I want to use a Bluetooth keyboard and it works fine so far, but there are some problems after the initial pairing.<br><br>To get the keyboard wokring I do the following steps:<br><br>hcid and passkey-agent are running.<br>
<br>hcitool scan<br>hcitool cc &lt;bdaddr&gt;<br>After this step hcitool con lists a established connection to the keyboard<br>auth &lt;bdaddr&gt;<br>Enter PIN on keyboard<br><br>Now the entry in hcitool con changes to AUTH<br>
So the connection is authorized and established and the keyboard works (I use bthid, anyway the process of authorization and pairing is done by hcid, and hcitools)<br><br>Usually from now this initial pairing process shouldnt be necessary for further sessions, but unfortunately it is.<br>
In oder to use the keyboard again (after disabling it) I have to go through the whole process again, but befor I have to /var/lib/bluetooth/*<br><br>So how can I establish further connections without the whole pairing process?<br>
<br>thanks<br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_7502_3954498.1213002657562--


--===============0726017361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0726017361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0726017361==--
