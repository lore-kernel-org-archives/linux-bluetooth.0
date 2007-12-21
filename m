Return-Path: <cyrus@holtmann.org>
Message-ID: <951351190712210842u78ca4a25y7815ebf2d4589096@mail.gmail.com>
Date: Fri, 21 Dec 2007 16:42:36 +0000
From: "Jason Zhan" <zhan.jason@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198163598.8050.253.camel@aeonflux>
MIME-Version: 1.0
References: <951351190712200246v72181504u52169ed53a34fcd6@mail.gmail.com>
	<1198163598.8050.253.camel@aeonflux>
Subject: Re: [Bluez-devel] link key PIN code authentication
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0911711347=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0911711347==
Content-Type: multipart/alternative;
	boundary="----=_Part_7127_14501190.1198255356622"

------=_Part_7127_14501190.1198255356622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, Marcel

Thank you for your kindly reply.

I am starting to look at the D-bus framework and passkey-agent.c in
utils/daemon/.

One question regarding the bluetooth applet, maybe it's a little bit stupid.
But I really I can't figure it out by myself.

In my program, I prefer the user enter the passkey from the terminal rather
than from the applet window. I afraid I need to disable the bluetooth
applet, since it always automatically jump out a window when it finds
devices requesting pass key.

The figure 1 presented in "Security interface" shows the applet was built
upon the D-bus. Do I need to do some changes on gnome/applet? Or just modify
the passkey agent.

Please give me some hints on how to disable the applet during the
authentication.

Many thanks and Merry Christmas,
Jason



On 20/12/2007, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jason,
>
> > Currently, I am working on a project to handle the pairing procedure.
> > The aim is quite simple.  If  the authentication is required by the
> > user, the program will detect whether the link key exists. If not, the
> > program will print out several lines in the terminal and ask the user
> > entering the PIN code.  The authentication will perform based on the
> > PIN code which the user provided and finally the new link key for this
> > connection will be passed to the host for future connections if the
> > authentication is successful.
> >
> > The bluez exploits the D-Bus to manage the pin code and link key.
> > Since my application is very simple, I don't think I need the D-Bus
> > framework.
>
> D-Bus is a really simple framework and not using D-Bus means you can
> also not use hcid. Which means you have to duplicate all the effort
> inside hcid. If you have that much free time, have fun. However you time
> could be spent more useful ;)
>
> > HCI can send the command to LM by hci_send_cmd() method, but I cannot
> > find the suitable methods which can read back the request from the
> > LM.
>
> You would have to open a raw HCI socket and read the HCI events. See the
> Bluetooth specification for details. Please don't expect me to get into
> details here. The hcid does all this and with the passkey agent
> interface you have a nice framework to solve your problem. Use it.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_7127_14501190.1198255356622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, Marcel<br><br>Thank you for your kindly reply. <br><br>I am starting to look at the D-bus framework and passkey-agent.c in utils/daemon/.&nbsp; <br><br>One question regarding the bluetooth applet, maybe it&#39;s a little bit stupid. But I really I can&#39;t figure it out by myself.
<br><br>In my program, I prefer the user enter the passkey from the terminal rather than from the applet window. I afraid I need to disable the bluetooth applet, since it always automatically jump out a window when it finds devices requesting pass key. 
<br><br>The figure 1 presented in &quot;Security interface&quot; shows the applet was built upon the D-bus. Do I need to do some changes on gnome/applet? Or just modify the passkey agent. <br><br>Please give me some hints on how to disable the applet during the authentication. 
<br><br>Many thanks and Merry Christmas,<br>Jason<br><br><br><br><div><span class="gmail_quote">On 20/12/2007, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Jason,<br><br>&gt; Currently, I am working on a project to handle the pairing procedure.
<br>&gt; The aim is quite simple.&nbsp;&nbsp;If&nbsp;&nbsp;the authentication is required by the<br>&gt; user, the program will detect whether the link key exists. If not, the<br>&gt; program will print out several lines in the terminal and ask the user
<br>&gt; entering the PIN code.&nbsp;&nbsp;The authentication will perform based on the<br>&gt; PIN code which the user provided and finally the new link key for this<br>&gt; connection will be passed to the host for future connections if the
<br>&gt; authentication is successful.<br>&gt;<br>&gt; The bluez exploits the D-Bus to manage the pin code and link key.<br>&gt; Since my application is very simple, I don&#39;t think I need the D-Bus<br>&gt; framework.<br>
<br>D-Bus is a really simple framework and not using D-Bus means you can<br>also not use hcid. Which means you have to duplicate all the effort<br>inside hcid. If you have that much free time, have fun. However you time<br>
could be spent more useful ;)<br><br>&gt; HCI can send the command to LM by hci_send_cmd() method, but I cannot<br>&gt; find the suitable methods which can read back the request from the<br>&gt; LM.<br><br>You would have to open a raw HCI socket and read the HCI events. See the
<br>Bluetooth specification for details. Please don&#39;t expect me to get into<br>details here. The hcid does all this and with the passkey agent<br>interface you have a nice framework to solve your problem. Use it.<br><br>
Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_7127_14501190.1198255356622--


--===============0911711347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0911711347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0911711347==--
