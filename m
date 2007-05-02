Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 2 May 2007 06:35:21 -0700 (PDT)
From: Anand Karimpuzha <fanofanne@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <263463.70441.qm@web37905.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] Sony PS3 remote on PS3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1726498661=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1726498661==
Content-Type: multipart/alternative; boundary="0-350340915-1178112921=:70441"

--0-350340915-1178112921=:70441
Content-Type: text/plain; charset=ascii

No pin required. 

I am using ubuntu feisty and the associated bluez packages (with the latest ps3 kernel from git)

hidd --search lets me connect to the sony bd remote (holding start+enter for 5 seconds). I am able to see that key presses result in hex events in hcidump.

bthid seems to let me translate key presses better than hid, I am still trying to figure out the right translation sequence.

Thats where I am at.  Maybe someone can help tell me if this is the right direction.

I'd like to get this working with lirc (which apparently can listen to an event interface) if possible.

Anand

----- Original Message ----
From: Harald Kubota <hkubota@gmx.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Sent: Tuesday, May 1, 2007 9:59:57 AM
Subject: Re: [Bluez-users] Sony PS3 remote on PS3

Anand Karimpuzha wrote:
> I have been trying to get the Sony PS3 remote working with bluetooth 
> and evdev, and so far I have been successful in getting it paired.

Whoa! What is the PIN to use? I tried to do the same, but without pin 
it's kind'a difficult to pair.

Harald


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-350340915-1178112921=:70441
Content-Type: text/html; charset=ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">No pin required. <br><br>I am using ubuntu feisty and the associated bluez packages (with the latest ps3 kernel from git)<br><br>hidd --search lets me connect to the sony bd remote (holding start+enter for 5 seconds). I am able to see that key presses result in hex events in hcidump.<br><br>bthid seems to let me translate key presses better than hid, I am still trying to figure out the right translation sequence.<br><br>Thats where I am at.&nbsp; Maybe someone can help tell me if this is the right direction.<br><br>I'd like to get this working with lirc (which apparently can listen to an event interface) if possible.<br><br>Anand<br><br><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">----- Original
 Message ----<br>From: Harald Kubota &lt;hkubota@gmx.net&gt;<br>To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Tuesday, May 1, 2007 9:59:57 AM<br>Subject: Re: [Bluez-users] Sony PS3 remote on PS3<br><br><div>Anand Karimpuzha wrote:<br>&gt; I have been trying to get the Sony PS3 remote working with bluetooth <br>&gt; and evdev, and so far I have been successful in getting it paired.<br><br>Whoa! What is the PIN to use? I tried to do the same, but without pin <br>it's kind'a difficult to pair.<br><br>Harald<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a target="_blank" href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing
 list<br>Bluez-users@lists.sourceforge.net<br><a target="_blank" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></div></div><br></div></div><br>

      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>
</body></html>
--0-350340915-1178112921=:70441--


--===============1726498661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1726498661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1726498661==--
