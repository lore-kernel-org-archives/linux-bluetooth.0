Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <52950c3f0703161049y3aa36ebeiaea30c0cc30c84f1@mail.gmail.com>
Date: Fri, 16 Mar 2007 13:49:29 -0400
From: "Timur Alperovich" <timur.alperovich@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <ddea76ce0703152326g73ec4815n4c0e3045fb846b32@mail.gmail.com>
MIME-Version: 1.0
References: <ddea76ce0703152326g73ec4815n4c0e3045fb846b32@mail.gmail.com>
Subject: Re: [Bluez-users] HELP with Input Manager Hierarchy,
	BlueZ D-Bus API!!!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1665728158=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1665728158==
Content-Type: multipart/alternative;
	boundary="----=_Part_85398_19027472.1174067369838"

------=_Part_85398_19027472.1174067369838
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If you are trying to use the PDA to connect to a pc over bluetooth, why not
use rfcomm to establish teh connection? After that you can send/receive
packets, much like using tcp sockets. Look at this guide for some details:
http://people.csail.mit.edu/albert/bluez-intro/

Timur

On 3/16/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
>
> Hello,
>
> No one has come back to me on the devel and user mailing lists.
>
> I am trying to use the BlueZ D-Bus API and have come across http://wiki.bluez.org/wiki/Input
> which states that "The Bluetooth Input daemon provides an interface to
> access Bluetooth Human Interface Devices. The Manager interface provides
> methods to list, create and remove input devices objects. The Device
> interface provides methods to retrieve device information, connect and
> disconnect"
>
> I am trying to develop for the Nokia 770 - the idea is to use the PDA as a
> mouse to control another bluetooth-enabled PC.
>
> Code-wise:
> - establish a bluetooth connection (via dbus?) I am unsure of how to use
> dbus to establish a bluetooth connection.
> - sending data (the mouse movements), via packets?, via HID Profile? Once
> I get at this point I believe I do not need to worry about the other end
> receiving the information since the other PC would have the bluetooth
> connection established and would reflect the data sent.
>
> Would someone please HELP???
>
> Thanks and regards,
>
> Meena
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_85398_19027472.1174067369838
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If you are trying to use the PDA to connect to a pc over bluetooth, why not use rfcomm to establish teh connection? After that you can send/receive packets, much like using tcp sockets. Look at this guide for some details: 
<a href="http://people.csail.mit.edu/albert/bluez-intro/">http://people.csail.mit.edu/albert/bluez-intro/</a><br><br>Timur<br><br><div><span class="gmail_quote">On 3/16/07, <b class="gmail_sendername">Meenakshi Seeballack
</b> &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,
<br><br>No one has come back to me on the devel and user mailing
lists.<br><br>I am trying to use the BlueZ D-Bus API and have come across <a href="http://wiki.bluez.org/wiki/Input" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://wiki.bluez.org/wiki/Input
</a> which states that &quot;The Bluetooth Input daemon provides an interface to access Bluetooth
Human Interface Devices. The Manager interface provides methods to
list, create and remove input devices objects. The Device interface
provides methods to retrieve device information, connect and disconnect&quot;<span><br><br></span><span>I
am trying to develop for the Nokia 770 - the idea is to use the PDA as
a mouse to control another bluetooth-enabled PC. <br><br></span>Code-wise:<br>- establish a bluetooth connection (via dbus?) I am <span style="text-decoration: underline;">
unsure of how to use dbus to establish a bluetooth connection.</span><br>-
sending data (the mouse movements), via packets?, via HID Profile? Once
I get at this point I believe I do not need to worry about the other
end receiving the information since the other PC would have the
bluetooth connection established and would reflect the data sent.
<br><br>Would someone please HELP???<br><br>Thanks and regards,<br><br>Meena<br>
<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br><br></blockquote></div><br>

------=_Part_85398_19027472.1174067369838--


--===============1665728158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1665728158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1665728158==--
