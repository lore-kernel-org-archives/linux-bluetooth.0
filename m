Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750701250229u61cbb820v929b8d0ad6ae3fb9@mail.gmail.com>
Date: Thu, 25 Jan 2007 11:29:52 +0100
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] multithread / multi process use
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0270179465=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0270179465==
Content-Type: multipart/alternative;
	boundary="----=_Part_4355_23574725.1169720992320"

------=_Part_4355_23574725.1169720992320
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello I'm new here, I searched for this issue but found nothing.

Using 2 threads or 2 process for reading a name of a 2 remote devices at
same time reports always the same name.
Is this a bug or the hci functions in library do not support concurrent use
?
(using 2.6.19 kernel on FC6 and bluez libs 3.7.1)

This is a simply way to reproduce this:

open a 2 shells and issue 2 commands at same time

hcitool name <bdaddress of a device close to you>

they both report the same name

here an HCI dump of what's happening

2007-01-25 11:15:06.093319 < HCI Command: Remote Name Request (0x01|0x0019)
plen 10
    bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
2007-01-25 11:15:06.114456 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-01-25 11:15:06.712794 < HCI Command: Remote Name Request (0x01|0x0019)
plen 10
    bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
2007-01-25 11:15:06.717442 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
2007-01-25 11:15:07.238429 > HCI Event: Remote Name Req Complete (0x07) plen
255
    status 0x00 bdaddr 00:0A:28:DF:2B:D8 name 'Seleso'
2007-01-25 11:15:07.239434 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-01-25 11:15:10.151342 > HCI Event: Remote Name Req Complete (0x07) plen
255
    status 0x00 bdaddr 00:17:4B:D3:9F:5B name 'Wince'

the second event with the second name is tracked but never reported back to
the caller cause the unknown event received.
so i see the name 'Seleso' as result on both the shells

this is the behaviour if I use the 2 command sequentially they works fine.

hcitool name 00:0A:28:DF:2B:D8

2007-01-25 11:19:51.930394 < HCI Command: Remote Name Request (0x01|0x0019)
plen 10
    bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
2007-01-25 11:19:51.951520 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-01-25 11:19:52.199514 > HCI Event: Remote Name Req Complete (0x07) plen
255
    status 0x00 bdaddr 00:0A:28:DF:2B:D8 name 'Seleso'

hcitool name 00:17:4B:D3:9F:5B

2007-01-25 11:20:39.520967 < HCI Command: Remote Name Request (0x01|0x0019)
plen 10
    bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
2007-01-25 11:20:39.542195 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-01-25 11:20:43.358090 > HCI Event: Remote Name Req Complete (0x07) plen
255
    status 0x00 bdaddr 00:17:4B:D3:9F:5B name 'Wince'




Since I need to use search names and search services (FAX especially) on a
multi-threaded application i'd like to know if is this possible or somewhere
there is a issue that prevent this.

------=_Part_4355_23574725.1169720992320
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello I&#39;m new here, I searched for this issue but found nothing.<br><br>Using 2 threads or 2 process for reading a name of a 2 remote devices at same time reports always the same name.<br>Is this a bug or the hci functions in library do not support concurrent use ?
<br>(using 2.6.19 kernel on FC6 and bluez libs 3.7.1)<br><br>This is a simply way to reproduce this:<br><br>open a 2 shells and issue 2 commands at same time <br><br>hcitool name &lt;bdaddress of a device close to you&gt;
<br><br>they both report the same name<br><br>here an HCI dump of what&#39;s happening<br><br>2007-01-25 11:15:06.093319 &lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
<br>2007-01-25 11:15:06.114456 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<br>2007-01-25 11:15:06.712794 &lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10
<br>&nbsp;&nbsp;&nbsp; bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000<br>2007-01-25 11:15:06.717442 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 0<br>2007-01-25 11:15:07.238429
 &gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0A:28:DF:2B:D8 name &#39;Seleso&#39;<br>2007-01-25 11:15:07.239434 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Unknown (0x00|0x0000) status 0x00 ncmd 1
<br>2007-01-25 11:15:10.151342 &gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:17:4B:D3:9F:5B name &#39;Wince&#39;<br><br>the second event with the second name is tracked but never reported back to the caller cause the unknown event received.
<br>so i see the name &#39;Seleso&#39; as result on both the shells <br><br>this is the behaviour if I use the 2 command sequentially they works fine.<br><br>hcitool name 00:0A:28:DF:2B:D8<br><br>2007-01-25 11:19:51.930394
 &lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000<br>2007-01-25 11:19:51.951520 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
<br>2007-01-25 11:19:52.199514 &gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:0A:28:DF:2B:D8 name &#39;Seleso&#39;<br><br>hcitool name 00:17:4B:D3:9F:5B<br><br>2007-01-25 11:20:39.520967
 &lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp;&nbsp;&nbsp; bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000<br>2007-01-25 11:20:39.542195 &gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
<br>2007-01-25 11:20:43.358090 &gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:17:4B:D3:9F:5B name &#39;Wince&#39;<br><br><br><br><br>Since I need to use search names and search services (FAX especially) on a multi-threaded application i&#39;d like to know if is this possible or somewhere there is a issue that prevent this.
<br><br><br>

------=_Part_4355_23574725.1169720992320--


--===============0270179465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0270179465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0270179465==--
