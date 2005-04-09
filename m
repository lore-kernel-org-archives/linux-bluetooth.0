Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?q?R=FCdiger_H=E4rtel?= <r_haertel@gmx.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504091713.36367.r_haertel@gmx.de>
Subject: [Bluez-users] Bluetooth modem
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
Date: Sat, 9 Apr 2005 17:13:36 +0200

Hello,

I am interested in using bluetooth to connect to a modem. I found 
two products:
- Acer Bluetooth (ww.Acer.de -> Products->Kommunikation)
- Typhoon Bluetooth modem 
(http://www.anubisline.com/german/articlec.asp?id=20008&catid=200).

Has anyone experience with these modems ? Was it difficult to get 
them working ?
What about the distance? Originally defined for 10 m now devices 
supporting 100 m; How far does it reach within a house ? How many 
walls is it able to get through ?



---

Marcel reminded me to ask here instead of asking him directly. So 
here is my question that was answered by him:

> I am considering to use a bluetooth modem from acer. I think it 
> should work but I know to little about the software components to 
> be used. Can you say a little bit about it.
> 
> For example:
> When the bluetooth stick is plugged in and everything is ok, ie. 
> linux detects it. How do I proceed to tell wvdial/smpppd where to 
> connect to ?
> 
> Haven't found any pointers to this topic. Only AVM fritz. But I 
> think that is different because it uses ISDN. But I'll have a 
read.

You know that such a question should be posted to the BlueZ users
mailing list. However these modem are no different from the dialup
procedures over mobile phones. You need to create the /dev/rfcomm0
device node with the rfcomm program and then use whatever dialer you
normally use for /dev/ttyS0.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
