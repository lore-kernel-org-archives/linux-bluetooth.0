Return-Path: <cyrus@holtmann.org>
Message-ID: <951351190712261349w3b541e7bn319da55ae02b1410@mail.gmail.com>
Date: Wed, 26 Dec 2007 21:49:46 +0000
From: "Jason Zhan" <zhan.jason@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198556341.8050.321.camel@aeonflux>
MIME-Version: 1.0
References: <951351190712240702x7b84c38j135735888bbd40d0@mail.gmail.com>
	<1198556341.8050.321.camel@aeonflux>
Subject: Re: [Bluez-devel] passkey-agent
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0953025659=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0953025659==
Content-Type: multipart/alternative;
	boundary="----=_Part_13519_8702769.1198705786566"

------=_Part_13519_8702769.1198705786566
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey, Marcel and Olivier

The problem has been solved. The reason is that the bluetooth-applet has
registered the default passkey agent. So I only can register the specific
passkey agents for bluetooth devices or disable the default passkey agent in
bluetooth-applet.

Many thanks for all your help.

Regards,
Jason

On 25/12/2007, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jason,
>
> > Currently, I am implementing a passkey-agent for my own application.
> > The principle is similar with the /daemon/passkey-agent.c. However,
> > when I run it, the system gives me some errors: "Can't regiter passeky
> > agent, passkey agnet already exists".
>
> the error message is pretty clear. You can have multiple remote device
> specific passkey agents, but only _ONE_ default passkey agent.
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

------=_Part_13519_8702769.1198705786566
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey, Marcel and Olivier<br><br>The problem has been solved. The reason is that the bluetooth-applet has registered the default passkey agent. So I only can register the specific passkey agents for bluetooth devices or disable the default passkey agent in bluetooth-applet. 
<br><br>Many thanks for all your help.<br><br>Regards,<br>Jason<br><br><div><span class="gmail_quote">On 25/12/2007, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Jason,<br><br>&gt; Currently, I am implementing a passkey-agent for my own application.
<br>&gt; The principle is similar with the /daemon/passkey-agent.c. However,<br>&gt; when I run it, the system gives me some errors: &quot;Can&#39;t regiter passeky<br>&gt; agent, passkey agnet already exists&quot;.<br><br>
the error message is pretty clear. You can have multiple remote device<br>specific passkey agents, but only _ONE_ default passkey agent.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_13519_8702769.1198705786566--


--===============0953025659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0953025659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0953025659==--
