Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50606220326r601c6771v80ec23884736dcee@mail.gmail.com>
Date: Thu, 22 Jun 2006 02:26:37 -0800
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1150959776.13991.5.camel@localhost>
MIME-Version: 1.0
References: <bf1d6e70606212208r7ed5e33ak5895b61024c36850@mail.gmail.com>
	<1150959776.13991.5.camel@localhost>
Subject: Re: [Bluez-users] bluez installation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0770825444=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0770825444==
Content-Type: multipart/alternative;
	boundary="----=_Part_5340_20468815.1150971997042"

------=_Part_5340_20468815.1150971997042
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Are there other links for the archieves?? I tried
http://www.bluez.org/lists.html and none of the list archieves is
available...

Loreno

On 6/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Lavanya,
>
> > I tried installing the packages given in your website for Bluez..
> > namely
> >
> >       * bluez-libs-3.1.tar.gz
> >       * bluez-utils-3.1.tar.gz
> >       * bluez-firmware-1.2.tar.gz
> >       * bluez-hcidump-1.31.tar.gz
> >
> > the first one worked fine.. utils package configuring gave error as
> > below
> >
> >
> > checking for DBUS... Package dbus-glib-1 was not found in the
> > pkg-config search path.
> > Perhaps you should add the directory containing `dbus-glib-1.pc'
> > to the PKG_CONFIG_PATH environment variable
> > No package 'dbus-glib-1' found
> > configure: error: dbus-glib > 0.35 is required
> >
> >
> >
> > could you let me know where the problem is?
>
> check the mailing list archive. This has already been discussed and it
> is a bug. The bluez-utils should only require the D-Bus low-level
> library. Will be fixed in the next version.
>
> Regards
>
> Marcel
>
>
>
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat certifications in
> the hosting industry. Fanatical Support. Click to learn more
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_5340_20468815.1150971997042
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Are there other links for the archieves?? I tried <a href="http://www.bluez.org/lists.html">http://www.bluez.org/lists.html</a> and none of the list archieves is available...<br><br>Loreno<br><br><div><span class="gmail_quote">
On 6/21/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Lavanya,<br><br>&gt; I tried installing the packages given in your website for Bluez..<br>&gt; namely<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bluez-libs-3.1.tar.gz<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bluez-utils-3.1.tar.gz<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bluez-firmware-1.2.tar.gz
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * bluez-hcidump-1.31.tar.gz<br>&gt;<br>&gt; the first one worked fine.. utils package configuring gave error as<br>&gt; below<br>&gt;<br>&gt;<br>&gt; checking for DBUS... Package dbus-glib-1 was not found in the
<br>&gt; pkg-config search path.<br>&gt; Perhaps you should add the directory containing `dbus-glib-1.pc'<br>&gt; to the PKG_CONFIG_PATH environment variable<br>&gt; No package 'dbus-glib-1' found<br>&gt; configure: error: dbus-glib &gt; 
0.35 is required<br>&gt;<br>&gt;<br>&gt;<br>&gt; could you let me know where the problem is?<br><br>check the mailing list archive. This has already been discussed and it<br>is a bug. The bluez-utils should only require the D-Bus low-level
<br>library. Will be fixed in the next version.<br><br>Regards<br><br>Marcel<br><br><br><br>All the advantages of Linux Managed Hosting--Without the Cost and Risk!<br>Fully trained technicians. The highest number of Red Hat certifications in
<br>the hosting industry. Fanatical Support. Click to learn more<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=107521&amp;bid=248729&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=107521&amp;bid=248729&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_5340_20468815.1150971997042--


--===============0770825444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
--===============0770825444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0770825444==--
