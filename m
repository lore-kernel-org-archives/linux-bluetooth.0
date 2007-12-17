Return-Path: <cyrus@holtmann.org>
Message-ID: <5f84803c0712171247t7879a8adp6d17981697396527@mail.gmail.com>
Date: Mon, 17 Dec 2007 15:47:57 -0500
From: "Chris Rivera" <chrismrivera@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197922624.8050.107.camel@aeonflux>
MIME-Version: 1.0
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1196699122.12292.113.camel@violet>
	<5f84803c0712030850k5810ee43na4a13f5e74657388@mail.gmail.com>
	<1196701181.12292.128.camel@violet>
	<5f84803c0712060959n6db58e78y4adfa1b4a212df71@mail.gmail.com>
	<1197870459.8050.80.camel@aeonflux>
	<5f84803c0712170754n14d401a7l225d3d9b2f413850@mail.gmail.com>
	<1197917583.8050.87.camel@aeonflux>
	<5f84803c0712171129o770c38e5g35d57dea64be94f5@mail.gmail.com>
	<1197922624.8050.107.camel@aeonflux>
Subject: Re: [Bluez-devel] [PATCH] [RESEND] make bluez GNOME UIs singletons
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1689733811=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1689733811==
Content-Type: multipart/alternative;
	boundary="----=_Part_11653_8706313.1197924478033"

------=_Part_11653_8706313.1197924478033
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 17, 2007 3:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

>
> I think that is simply too complicated. If we use --singleton, it all
> has to come into place. And if D-Bus fails, the application is not good
> anyway. So I don't see the real benefit. If at any time later it will be
> needed, we can introduce it then.
>

Agreed.


>
> Please use use gtk_init_with_args and make the GOptionEntry data global
> and static. Look at bluetooth-analyzer for an example.
>

This would force the singleton flag variable to be global.  Is this what you
want?


>
> Also don't translate config options and errors that are printed on the
> command line. We only translate stuff inside the UI. The normal user
> won't see these anyway.
> <https://lists.sourceforge.net/lists/listinfo/bluez-devel>
>

OK.

Chris

------=_Part_11653_8706313.1197924478033
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 17, 2007 3:17 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br></div>I think that is simply too complicated. If we use --singleton, it all<br>has to come into place. And if D-Bus fails, the application is not good<br>anyway. So I don&#39;t see the real benefit. If at any time later it will be
<br>needed, we can introduce it then.<br></blockquote><div><br>Agreed.<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Please use use gtk_init_with_args and make the GOptionEntry data global
<br>and static. Look at bluetooth-analyzer for an example.<br></blockquote><div><br>This would force the singleton flag variable to be global.&nbsp; Is this what you want?<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Also don&#39;t translate config options and errors that are printed on the<br>command line. We only translate stuff inside the UI. The normal user<br>won&#39;t see these anyway.<br><div><div></div><div class="Wj3C7c">
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank"></a><br></div></div></blockquote></div><br>OK.<br><br>Chris

------=_Part_11653_8706313.1197924478033--


--===============1689733811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1689733811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1689733811==--
