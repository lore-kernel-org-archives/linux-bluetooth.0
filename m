Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805280503t35048a12l83f240b03a35668f@mail.gmail.com>
Date: Wed, 28 May 2008 14:03:00 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1211975876.31263.16.camel@pcmik05.zmk.uni-kl.de>
MIME-Version: 1.0
References: <3e9cdced0805270034s3409b6aby382454375651b711@mail.gmail.com>
	<1211975876.31263.16.camel@pcmik05.zmk.uni-kl.de>
Subject: Re: [Bluez-users] Bluetooth Keyboard Kernel 2.4
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1363915956=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1363915956==
Content-Type: multipart/alternative;
	boundary="----=_Part_8449_5524898.1211976180077"

------=_Part_8449_5524898.1211976180077
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes thats right.
Its running on an embedded Linux, an upgrade to Kernel 2.6 is not possible.

--Fritz

On Wed, May 28, 2008 at 1:57 PM, Thomas Ilnseher <illth@gmx.de> wrote:

>
> Am Dienstag, den 27.05.2008, 09:34 +0200 schrieb Fritz Code:
> > Hi,
> >
> > I have to connect a bluetooth keyboard, I'm using Kernel 2.4.21.
> > The bluetooth subsystem and bluez utils (hcitool, hcid, hciconfig)
> > work so far.
> >
> > Well I have two options now, try this way (which is not related to
> > bluez):
> > http://klausler.com/msbtkb-linux.html
> >
> > Or try to use bluez.
> > If I use bluez I have to load hidp.o module, right?
> > But my kernel 2.4.21 doesn't provide such a module.
> >
> > So I'm not sure what to do in order to get a bluetooth keyboard
> > running in my Kernel 2.4.21.
> why are you running such an old kernel ?
> embedded system ?



>
>
> > If there are any hints / experiences.
> >
> > Note: I'm flexible in the keyboard type and manufactuarer,  so if
> > anybody can recommend a keyboard for the use of Kernel 2.4.21 I would
> > appreciate that.
> >
> > Thanks.
> > Fritz.
> >
> >
> > --
> > Regards,
> > --Codefritz
> >
> >
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2008.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________ Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> --
> Thomas Ilnseher <illth@gmx.de>
>
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



-- 
Regards,
--Codefritz

------=_Part_8449_5524898.1211976180077
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes thats right.<br>Its running on an embedded Linux, an upgrade to Kernel 2.6 is not possible.<br><br>--Fritz<br><br><div class="gmail_quote">On Wed, May 28, 2008 at 1:57 PM, Thomas Ilnseher &lt;<a href="mailto:illth@gmx.de">illth@gmx.de</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
Am Dienstag, den 27.05.2008, 09:34 +0200 schrieb Fritz Code:<br>
<div class="Ih2E3d">&gt; Hi,<br>
&gt;<br>
&gt; I have to connect a bluetooth keyboard, I&#39;m using Kernel <a href="http://2.4.21." target="_blank">2.4.21.</a><br>
&gt; The bluetooth subsystem and bluez utils (hcitool, hcid, hciconfig)<br>
&gt; work so far.<br>
&gt;<br>
&gt; Well I have two options now, try this way (which is not related to<br>
&gt; bluez):<br>
&gt; <a href="http://klausler.com/msbtkb-linux.html" target="_blank">http://klausler.com/msbtkb-linux.html</a><br>
&gt;<br>
&gt; Or try to use bluez.<br>
&gt; If I use bluez I have to load hidp.o module, right?<br>
&gt; But my kernel 2.4.21 doesn&#39;t provide such a module.<br>
&gt;<br>
&gt; So I&#39;m not sure what to do in order to get a bluetooth keyboard<br>
&gt; running in my Kernel <a href="http://2.4.21." target="_blank">2.4.21.</a><br>
</div>why are you running such an old kernel ?<br>
embedded system ?</blockquote><div>&nbsp;&nbsp;&nbsp; <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class="Ih2E3d"><br>
&gt; If there are any hints / experiences.<br>
&gt;<br>
&gt; Note: I&#39;m flexible in the keyboard type and manufactuarer, &nbsp;so if<br>
&gt; anybody can recommend a keyboard for the use of Kernel 2.4.21 I would<br>
&gt; appreciate that.<br>
&gt;<br>
&gt; Thanks.<br>
&gt; Fritz.<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Regards,<br>
&gt; --Codefritz<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; -------------------------------------------------------------------------<br>
&gt; This SF.net email is sponsored by: Microsoft<br>
&gt; Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
&gt; <a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
&gt; _______________________________________________ Bluez-users mailing list <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a> <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>

--<br>
Thomas Ilnseher &lt;<a href="mailto:illth@gmx.de">illth@gmx.de</a>&gt;<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_8449_5524898.1211976180077--


--===============1363915956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1363915956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1363915956==--
