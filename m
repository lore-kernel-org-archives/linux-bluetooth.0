Return-Path: <cyrus@holtmann.org>
Message-ID: <b5c34db00801042031s4564c190sc9cc5ff0718cc188@mail.gmail.com>
Date: Sat, 5 Jan 2008 10:01:12 +0530
From: umeshyv <umeshyv@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <477E9A32.8080908@cs.wisc.edu>
MIME-Version: 1.0
References: <477C6D10.2040003@cs.wisc.edu> <1199337678.26099.35.camel@aeonflux>
	<477E9A32.8080908@cs.wisc.edu>
Subject: Re: [Bluez-users] enabling/disabling in response to ThinkPad hotkey
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1246989030=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1246989030==
Content-Type: multipart/alternative;
	boundary="----=_Part_15201_32767848.1199507472917"

------=_Part_15201_32767848.1199507472917
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,
I use suse linux 10.1 and i connected bluetooth usb dongle and enabled
bluetooth server and i removed mouse from my system and i own sony erricsion
(K750i) mobile and it contains remote control application in it and using
that i am able to access desktop in windows  vista and is this possible to
do in linux.please send your valuable comments

Regards
Umesh

On Jan 5, 2008 2:12 AM, Ben Liblit <liblit@cs.wisc.edu> wrote:

> Marcel Holtmann wrote:
> > The reason for this is that the Bluetooth on/off switches are all
> > different and HAL and rfkill is the way to abstract it into a common
> > interface. It is not the job of hcid to abstract this.
>
> OK, I see your point.  HAL is supposed to keep other daemons from having
> to worry about such things.  I've conveyed your reply back to the HAL
> mailing list.
>
> That said, it's unfortunate that the end result is an Fn+F5 key which
> does *nothing* useful out of the box.  Even if different users would
> want it to do slightly different things, right now it does *nothing* by
> default.  I'm savvy enough to write my own script that runs as root,
> hooks into HAL D-BUS signals, and responds accordingly.  Most users
> won't do that, so for them, this key is useless.
>
> Oh well.  Between HAL and Bluez, things are much better now than they
> ever were before.  We're not done yet, but at least we're making progress.
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_15201_32767848.1199507472917
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,<br>I use suse linux 10.1 and i connected bluetooth usb dongle and enabled bluetooth server and i removed mouse from my system and i own sony erricsion (K750i) mobile and it contains remote control application in it and using that i am able to access desktop in windows&nbsp; vista and is this possible to do in 
linux.please send your valuable comments<br><br>Regards<br>Umesh<br><br><div class="gmail_quote">On Jan 5, 2008 2:12 AM, Ben Liblit &lt;<a href="mailto:liblit@cs.wisc.edu">liblit@cs.wisc.edu</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Marcel Holtmann wrote:<br>&gt; The reason for this is that the Bluetooth on/off switches are all<br>&gt; different and HAL and rfkill is the way to abstract it into a common<br>&gt; interface. It is not the job of hcid to abstract this.
<br><br>OK, I see your point. &nbsp;HAL is supposed to keep other daemons from having<br>to worry about such things. &nbsp;I&#39;ve conveyed your reply back to the HAL<br>mailing list.<br><br>That said, it&#39;s unfortunate that the end result is an Fn+F5 key which
<br>does *nothing* useful out of the box. &nbsp;Even if different users would<br>want it to do slightly different things, right now it does *nothing* by<br>default. &nbsp;I&#39;m savvy enough to write my own script that runs as root,
<br>hooks into HAL D-BUS signals, and responds accordingly. &nbsp;Most users<br>won&#39;t do that, so for them, this key is useless.<br><br>Oh well. &nbsp;Between HAL and Bluez, things are much better now than they<br>ever were before. &nbsp;We&#39;re not done yet, but at least we&#39;re making progress.
<br><div><div></div><div class="Wj3C7c"><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.
<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></div></div></blockquote></div><br>

------=_Part_15201_32767848.1199507472917--


--===============1246989030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1246989030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1246989030==--
