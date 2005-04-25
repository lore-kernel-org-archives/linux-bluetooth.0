Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050425014245.12337.qmail@web20926.mail.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1084189507-1114393365=:11858"
Subject: [Bluez-users] How to NOT initialize newly attached Bluetooth dongles
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
Date: Sun, 24 Apr 2005 18:42:45 -0700 (PDT)

--0-1084189507-1114393365=:11858
Content-Type: text/plain; charset=us-ascii

Hi,
 
I have been using hcid in handling initialization of my Bluetooth dongle.
 
I have this issue with regards to me not wanting to initialize newly attached Bluetooth dongles.
Here is the scenario:
1. I let hcid initialize my attached Bluetooth dongle.
2. Then I configure the dongle to be in the OFF state/mode (hciconfig hci0 down).
3. When I detach the dongle and re-attach it, it comes back to UP and Running mode.
 
Since I put the dongle in OFF mode, I would like to keep this mode when I detach and re-attach the dongle.
 
My question then is how will I make it not being automatically initialized by hcid.
I have been trying to play with the hcid configuration file but to no avail.
 
Thanks,
Arch
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1084189507-1114393365=:11858
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have been using hcid in handling initialization of my Bluetooth dongle.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have this issue with regards to me not wanting to initialize newly attached Bluetooth dongles.</DIV>
<DIV>Here is the scenario:</DIV>
<DIV>1. I let hcid initialize my attached Bluetooth dongle.</DIV>
<DIV>2. Then I configure the dongle to be in the OFF state/mode (hciconfig hci0 down).</DIV>
<DIV>3. When I detach the dongle and re-attach it, it comes back to UP and Running mode.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Since I put the&nbsp;dongle&nbsp;in OFF mode, I would like to keep this mode when I detach and re-attach the dongle.</DIV>
<DIV>&nbsp;</DIV>
<DIV>My question then is how will I make it not being automatically initialized by hcid.</DIV>
<DIV>I have been trying to play with the hcid configuration file but to no avail.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV>
<DIV>Arch</DIV>
<DIV>&nbsp;</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1084189507-1114393365=:11858--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
