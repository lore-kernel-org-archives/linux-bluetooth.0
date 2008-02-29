Return-Path: <cyrus@holtmann.org>
Message-ID: <b535981e0802290028s22a771bcubbbc9a9fb993d1a7@mail.gmail.com>
Date: Fri, 29 Feb 2008 00:28:24 -0800
From: Jon <bluez@konsoletek.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <3E374F75-1F23-4B9E-89EB-BF25C688822F@gmail.com>
MIME-Version: 1.0
References: <b535981e0802282142m3e132b08jb1437607cccbcdc6@mail.gmail.com>
	<3E374F75-1F23-4B9E-89EB-BF25C688822F@gmail.com>
Subject: Re: [Bluez-users] HFP Status?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1641134144=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1641134144==
Content-Type: multipart/alternative;
	boundary="----=_Part_12373_18641494.1204273704631"

------=_Part_12373_18641494.1204273704631
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Feb 28, 2008 at 11:40 PM, Johan Hedberg <johan.hedberg@gmail.com>
wrote:

> Hi Jon,
>
> On Feb 29, 2008, at 7:42, Jon wrote:
> > I apologize if this is answered somewhere - I've tried finding the
> > information - but no dice.  My question is simple: Whats the status
> > of the Hands Free Protocol?
>
>
> If your all you need is getting some audio going through then the
> audio service latest 3.27 should work fine (as long as HFP support
> isn't disabled through audio.conf). Since the list of features for HFP
> is rather long and quite tightly bound to whathever telephony
> subsystem you have, we've decided to create a plugin system for the
> audio service where each plugin will act as an adapter to some
> specific telephony subsystem. You'll probably see some basic support
> for this kind of plugins already in the next bluez-utils release.
> However, as I said if you don't need any of the more advance telephony
> related features of HFP you should be able to get at least basic audio
> going with the latest releases.
>
> Johan
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

Howdy,
The end goal of my project is to get some amount of bluetooth handsfree
calling built into a carputer (a topic that I'm sure has come up before).
It will be a legal requirement (Shortly) in my state to use hands free while
driving.  Really all I need is to be able to answer & end the call - and of
course be able to hear/speak to the party.  I'm not sure what would be
classified as an "Advanced" feature, but I think I get the gist of it.

Thanks for your reply.
-Jon

------=_Part_12373_18641494.1204273704631
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Feb 28, 2008 at 11:40 PM, Johan Hedberg &lt;<a href="mailto:johan.hedberg@gmail.com">johan.hedberg@gmail.com</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Jon,<br>
<div class="Ih2E3d"><br>
On Feb 29, 2008, at 7:42, Jon wrote:<br>
&gt; I apologize if this is answered somewhere - I&#39;ve tried finding the<br>
&gt; information - but no dice. &nbsp;My question is simple: Whats the status<br>
&gt; of the Hands Free Protocol?<br>
<br>
<br>
</div>If your all you need is getting some audio going through then the<br>
audio service latest 3.27 should work fine (as long as HFP support<br>
isn&#39;t disabled through audio.conf). Since the list of features for HFP<br>
is rather long and quite tightly bound to whathever telephony<br>
subsystem you have, we&#39;ve decided to create a plugin system for the<br>
audio service where each plugin will act as an adapter to some<br>
specific telephony subsystem. You&#39;ll probably see some basic support<br>
for this kind of plugins already in the next bluez-utils release.<br>
However, as I said if you don&#39;t need any of the more advance telephony<br>
related features of HFP you should be able to get at least basic audio<br>
going with the latest releases.<br>
<br>
Johan<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>Howdy,<br>The end goal of my project is to get some amount of bluetooth handsfree calling built into a carputer (a topic that I&#39;m sure has come up before).&nbsp; It will be a legal requirement (Shortly) in my state to use hands free while driving.&nbsp; Really all I need is to be able to answer &amp; end the call - and of course be able to hear/speak to the party.&nbsp; I&#39;m not sure what would be classified as an &quot;Advanced&quot; feature, but I think I get the gist of it.<br>
<br>Thanks for your reply.<br>-Jon<br>

------=_Part_12373_18641494.1204273704631--


--===============1641134144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1641134144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1641134144==--
