Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50609130556k2e703fb9qa0b4f2e1934b4260@mail.gmail.com>
Date: Wed, 13 Sep 2006 09:56:12 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e1effdeb0609130548h1a6dea73vef4a6a8dc8b08d5e@mail.gmail.com>
MIME-Version: 1.0
References: <c49421c50609120941i26ffb8dauf0ae2c0c31190808@mail.gmail.com>
	<e1effdeb0609130523g204fff2fk80a0786e92f81d89@mail.gmail.com>
	<e1effdeb0609130548h1a6dea73vef4a6a8dc8b08d5e@mail.gmail.com>
Subject: Re: [Bluez-users] restricting inquiry responses
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2113994588=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2113994588==
Content-Type: multipart/alternative;
	boundary="----=_Part_119790_27738895.1158152172517"

------=_Part_119790_27738895.1158152172517
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On the one hand this is good because I was trying to understand you previous
answer yet :-)

On the other hand this is a big issue in my current work. Btw, thanks for
the help!

Loreno

On 9/13/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> On 9/13/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> > On 9/12/06, Loreno Oliveira <lorenooliveira@gmail.com> wrote:
> > > Hi there,
> > >
> > > I have different base stations that permanently try to find out new
> mobile
> > > devices on their coverage areas. Once discovered and paired with some
> BS, I
> > > need this device to be able to not answer to that BS inquiries.
> > >
> > > Is there a solution for this??
> > >
> > > Regards,
> > >
> > > Loreno
> > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> > Hi Loreno,
> >
> > You can use the a D-Bus method to switch the device to "Connectable"
> > mode. The adapter interface supports the following discoverable modes:
> > discoverable: PSCAN ISCAN
> > connectable: PSCAN
> > off: NOSCAN
> >
> > Use the gbluezconf(test app) to setup this mode:
> > http://www.maemo.org.br/cktakahasi/gbluezconf/gbluezconf-00.32.tar.gz
> >
> > Or dbus-send:
> > $dbus-send --system --type=method_call --print-reply --dest=org.bluez
> > /org/bluez/hci0 org.bluez.Adapter.SetDiscoverableTimeout uint32:0
> > $dbus-send --system --type=method_call --print-reply --dest=org.bluez
> > /org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable
> >
> > The default discoverable timeout is 180sec. Setting it to 0 +
> > discoverable mode to "discoverable" the device will be always visible.
> > Setting the discoverable timeout to X + mode to discoverable, the mode
> > will be changed automatically to connectable mode after X seconds.
> >
> >
> > BR,
> > Claudio.
> > --
> > ---------------------------------------------------------
> > Claudio Takahasi
> > Instituto Nokia de Tecnologia - INdT
> >
>
> Hi Loreno,
>
> Sorry, I misunderstood your question. It's not possible "not answer"
> to a specific BS inquiries.
>
> BR,
> Claudio.
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_119790_27738895.1158152172517
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On the one hand this is good because I was trying to understand you previous answer yet :-)<br><br>On the other hand this is a big issue in my current work. Btw, thanks for the help!<br><br>Loreno<br><br><div><span class="gmail_quote">
On 9/13/06, <b class="gmail_sendername">Claudio Takahasi</b> &lt;<a href="mailto:cktakahasi@gmail.com">cktakahasi@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 9/13/06, Claudio Takahasi &lt;<a href="mailto:cktakahasi@gmail.com">cktakahasi@gmail.com</a>&gt; wrote:<br>&gt; On 9/12/06, Loreno Oliveira &lt;<a href="mailto:lorenooliveira@gmail.com">lorenooliveira@gmail.com</a>&gt; wrote:
<br>&gt; &gt; Hi there,<br>&gt; &gt;<br>&gt; &gt; I have different base stations that permanently try to find out new mobile<br>&gt; &gt; devices on their coverage areas. Once discovered and paired with some BS, I<br>&gt; &gt; need this device to be able to not answer to that BS inquiries.
<br>&gt; &gt;<br>&gt; &gt; Is there a solution for this??<br>&gt; &gt;<br>&gt; &gt; Regards,<br>&gt; &gt;<br>&gt; &gt; Loreno<br>&gt; _______________________________________________<br>&gt; &gt; Bluez-users mailing list<br>
&gt; &gt; <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br>&gt;<br>&gt; Hi Loreno,<br>&gt;<br>&gt; You can use the a D-Bus method to switch the device to &quot;Connectable&quot;<br>&gt; mode. The adapter interface supports the following discoverable modes:<br>&gt; discoverable: PSCAN ISCAN
<br>&gt; connectable: PSCAN<br>&gt; off: NOSCAN<br>&gt;<br>&gt; Use the gbluezconf(test app) to setup this mode:<br>&gt; <a href="http://www.maemo.org.br/cktakahasi/gbluezconf/gbluezconf-00.32.tar.gz">http://www.maemo.org.br/cktakahasi/gbluezconf/gbluezconf-00.32.tar.gz
</a><br>&gt;<br>&gt; Or dbus-send:<br>&gt; $dbus-send --system --type=method_call --print-reply --dest=org.bluez<br>&gt; /org/bluez/hci0 org.bluez.Adapter.SetDiscoverableTimeout uint32:0<br>&gt; $dbus-send --system --type=method_call --print-reply --dest=
org.bluez<br>&gt; /org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable<br>&gt;<br>&gt; The default discoverable timeout is 180sec. Setting it to 0 +<br>&gt; discoverable mode to &quot;discoverable&quot; the device will be always visible.
<br>&gt; Setting the discoverable timeout to X + mode to discoverable, the mode<br>&gt; will be changed automatically to connectable mode after X seconds.<br>&gt;<br>&gt;<br>&gt; BR,<br>&gt; Claudio.<br>&gt; --<br>&gt; ---------------------------------------------------------
<br>&gt; Claudio Takahasi<br>&gt; Instituto Nokia de Tecnologia - INdT<br>&gt;<br><br>Hi Loreno,<br><br>Sorry, I misunderstood your question. It's not possible &quot;not answer&quot;<br>to a specific BS inquiries.<br><br>
BR,<br>Claudio.<br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_119790_27738895.1158152172517--


--===============2113994588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2113994588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2113994588==--
