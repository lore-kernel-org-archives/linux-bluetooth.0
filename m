Return-Path: <cyrus@holtmann.org>
Message-ID: <5f84803c0712181151n258c0e6bmf237ed82be97f4f@mail.gmail.com>
Date: Tue, 18 Dec 2007 14:51:02 -0500
From: "Chris Rivera" <chrismrivera@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198005009.8050.185.camel@aeonflux>
MIME-Version: 1.0
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1197870459.8050.80.camel@aeonflux>
	<5f84803c0712170754n14d401a7l225d3d9b2f413850@mail.gmail.com>
	<1197917583.8050.87.camel@aeonflux>
	<5f84803c0712171129o770c38e5g35d57dea64be94f5@mail.gmail.com>
	<1197922624.8050.107.camel@aeonflux>
	<5f84803c0712171247t7879a8adp6d17981697396527@mail.gmail.com>
	<1197925294.8050.111.camel@aeonflux>
	<5f84803c0712181037w39132b53x1488195f71802479@mail.gmail.com>
	<1198005009.8050.185.camel@aeonflux>
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
Content-Type: multipart/mixed; boundary="===============1287608903=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1287608903==
Content-Type: multipart/alternative;
	boundary="----=_Part_16707_24480412.1198007462216"

------=_Part_16707_24480412.1198007462216
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 18, 2007 2:10 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Chris,
>
> > Updated patch attached.
>
> patch looks good to me. One question though, why do we use the extra
> register function. Can't we include that in the _new function. This
> would make the code a little simpler. We still have to check if the
> object creation succeeded.
>
>
This would require defining GObject properties and get and set operations.
Also, the register function is what actually initiates the connection to the
bus and requests the bus name.  This sort of operation might fail and
shouldn't be done in an object constructor.  The register function seemed
like the simplest solution.

Chris

------=_Part_16707_24480412.1198007462216
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 18, 2007 2:10 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Chris,<br><br>&gt; Updated patch attached.<br><br>patch looks good to me. One question though, why do we use the extra<br>register function. Can&#39;t we include that in the _new function. This<br>would make the code a little simpler. We still have to check if the
<br>object creation succeeded.<br><div><br></div></blockquote></div><br>This would require defining GObject properties and get and set operations.&nbsp; Also, the register function is what actually initiates the connection to the bus and requests the bus name.&nbsp; This sort of operation might fail and shouldn&#39;t be done in an object constructor.&nbsp; The register function seemed like the simplest solution.
<br><br>Chris<br>

------=_Part_16707_24480412.1198007462216--


--===============1287608903==
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
--===============1287608903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1287608903==--
