Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5eee8c670706030625o6aad300al5b1848f4e9394ebd@mail.gmail.com>
Date: Sun, 3 Jun 2007 14:25:35 +0100
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] a2dp stream + bluetooth mouse not working at same time
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0867068909=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0867068909==
Content-Type: multipart/alternative;
	boundary="----=_Part_25404_12434190.1180877135684"

------=_Part_25404_12434190.1180877135684
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've got the MS IntelliMouse Explorer for Bluetooth, and a pair of Orange
Bluetooth speakers
(http://www.acoustic-energy.co.uk/News_and_reviews/orangebluetooth.asp).
I'm using Feisty Fawn and have configured bluetooth-alsa to stream all
sounds to the bluetooth speakers (via .asounrc in pcm.!default) which works
well enough if it's the only bluetooth device I'm using.

The only issue is, whenever I connect and move the mouse (using hidd) while
I'm streaming music using a2dpd, the music starts cutting out and jumping
until I stop moving the mouse. My first thought was that the bluetooth
device reached a bandwidth limit. However, a thought occurred to me- since
the mouse is sending to the bluetooth device, but the speakers are receiving
from the device- is there not a separate send/receive bandwidth?

One thing I have tried is disabling the bluetooth sniff mode by echoing 0 to
/sys/class/bluetooth/hci0/idle_timeout, which I think may be providing a
slight improvement on things (altho it's hard to tell). Am I expecting too
much from my bluetooth transceiver? Anyone have any ideas how I can improve
the performance of these two devices working together?

Regards,
Alex

------=_Part_25404_12434190.1180877135684
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;ve got the MS IntelliMouse Explorer for Bluetooth, and a pair of Orange Bluetooth speakers (<a href="http://www.acoustic-energy.co.uk/News_and_reviews/orangebluetooth.asp" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://www.acoustic-energy.co.uk/News_and_reviews/orangebluetooth.asp</a>). I&#39;m using Feisty Fawn and have configured bluetooth-alsa to stream all sounds to the bluetooth speakers (via .asounrc in pcm.!default) which works well enough if it&#39;s the only bluetooth device I&#39;m using.
<br><br>The
only issue is, whenever I connect and move the mouse (using hidd) while I&#39;m streaming music
using a2dpd, the music starts cutting out and jumping until I stop moving the mouse. My first thought was that the bluetooth device reached
a bandwidth limit. However, a thought occurred to me- since the mouse
is sending to the bluetooth device, but the speakers are receiving from
the device- is there not a separate send/receive bandwidth? <br><br>One thing I have tried is disabling the bluetooth sniff mode by echoing 0 to  /sys/class/bluetooth/hci0/idle_timeout, which I think may be providing a slight improvement on things (altho it&#39;s hard to tell). Am I expecting too much from my bluetooth transceiver? Anyone have any ideas how I can improve the performance of these two devices working together?
<br><br>Regards,<br>Alex<br>

------=_Part_25404_12434190.1180877135684--


--===============0867068909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0867068909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0867068909==--
