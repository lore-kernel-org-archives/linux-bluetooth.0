Return-Path: <cyrus@holtmann.org>
Message-ID: <5f84803c0712161908l4816cf93y7eebeed73064d0ed@mail.gmail.com>
Date: Sun, 16 Dec 2007 22:08:52 -0500
From: "Chris Rivera" <crivera@novell.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0712060959n6db58e78y4adfa1b4a212df71@mail.gmail.com>
MIME-Version: 1.0
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1196699122.12292.113.camel@violet>
	<5f84803c0712030850k5810ee43na4a13f5e74657388@mail.gmail.com>
	<1196701181.12292.128.camel@violet>
	<5f84803c0712060959n6db58e78y4adfa1b4a212df71@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0610551311=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0610551311==
Content-Type: multipart/alternative;
	boundary="----=_Part_8237_29446512.1197860932465"

------=_Part_8237_29446512.1197860932465
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Anyone?  Anyone?

On Dec 6, 2007 12:59 PM, Chris Rivera <chrismrivera@gmail.com> wrote:

> Attached is an updated patch with the changes that we talked about.
>
> Chris
>
>
> On Dec 3, 2007 11:59 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > Hi Chris,
> >
> > >
> > >         I meant to look into it, but never got around it. Some small
> > >         comments
> > >         about it. Don't make the applet a singleton. That is totally
> > >         unneeded
> > >         since the applet will be loaded at login.
> > >
> > > I still think it should be a singleton.  You wouldn't ever want two
> > > applets running unless you're testing, and we have the singleton flags
> > > for that.  I don't think this hurts anything.
> >
> > I am okay with that. Please abstract everything into common/. And don't
> > forget to document it in the manual pages.
> >
> > >         For the "Present" method. Don't use the D-Bus low-level calls.
> > >         It should
> > >         be all dbus-glib. Which means we have to abstract that into an
> >
> > >         object. I
> > >         don't know if there is a well defined way for this. If it is,
> > >         it might
> > >         be good to use that. If not, then propose something for
> > >         freedesktop.org.
> > >
> > > I thought about doing this, but it seems like overkill to define a
> > > GObject to just expose one method.  GObject isn't exactly terse
> > > either.
> >
> > In a simple way you can use GObject for it. It is better than using the
> > low-level D-Bus calls.
> >
> > >         And we should probably have some generic methods inside
> > >         common/ instead
> > >         of doing it again in every program.
> > >
> > >         Please follow the kernel coding style. I know it is odd for a
> > >         GTK
> > >         application, but it makes it a lot easier for me.
> > >
> > > Which parts of the patch violate the kernel coding style?  The
> > > function parameter spacing?
> >
> > Mainly the spacing.
> >
> >
>

------=_Part_8237_29446512.1197860932465
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Anyone?&nbsp; Anyone?<br><br><div class="gmail_quote">On Dec 6, 2007 12:59 PM, Chris Rivera &lt;<a href="mailto:chrismrivera@gmail.com">chrismrivera@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Attached is an updated patch with the changes that we talked about.<br><font color="#888888"><br>Chris</font><div><div></div><div class="Wj3C7c"><br><br><div class="gmail_quote">On Dec 3, 2007 11:59 AM, Marcel Holtmann &lt;
<a href="mailto:marcel@holtmann.org" target="_blank">marcel@holtmann.org</a>&gt; wrote:
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>Hi Chris,<br><br>&gt;<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; I meant to look into it, but never got around it. Some small
<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; comments<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; about it. Don&#39;t make the applet a singleton. That is totally<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; unneeded<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; since the applet will be loaded at login.<br>&gt;<br>&gt; I still think it should be a singleton. &nbsp;You wouldn&#39;t ever want two
<br>&gt; applets running unless you&#39;re testing, and we have the singleton flags<br>&gt; for that. &nbsp;I don&#39;t think this hurts anything.<br><br></div>I am okay with that. Please abstract everything into common/. And don&#39;t
<br>forget to document it in the manual pages.<br><div><br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; For the &quot;Present&quot; method. Don&#39;t use the D-Bus low-level calls.<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; It should<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; be all dbus-glib. Which means we have to abstract that into an
<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; object. I<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; don&#39;t know if there is a well defined way for this. If it is,<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; it might<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; be good to use that. If not, then propose something for<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; 
<a href="http://freedesktop.org" target="_blank">freedesktop.org</a>.<br>&gt;<br>&gt; I thought about doing this, but it seems like overkill to define a<br>&gt; GObject to just expose one method. &nbsp;GObject isn&#39;t exactly terse
<br>&gt; either.<br><br></div>In a simple way you can use GObject for it. It is better than using the<br>low-level D-Bus calls.<br><div><br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; And we should probably have some generic methods inside
<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; common/ instead<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; of doing it again in every program.<br>&gt;<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; Please follow the kernel coding style. I know it is odd for a<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; GTK<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; application, but it makes it a lot easier for me.
<br>&gt;<br>&gt; Which parts of the patch violate the kernel coding style? &nbsp;The<br>&gt; function parameter spacing?<br><br></div>Mainly the spacing.<br><div><div></div><div><br></div></div></blockquote></div>
<br>
</div></div></blockquote></div><br>

------=_Part_8237_29446512.1197860932465--


--===============0610551311==
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
--===============0610551311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0610551311==--
