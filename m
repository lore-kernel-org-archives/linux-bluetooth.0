Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60608301504l19d81775vde1d7be054c6e62d@mail.gmail.com>
Date: Wed, 30 Aug 2006 15:04:56 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1156980766.4026.111.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <be976db60608301316g5945d06apd3b98264fe8e2405@mail.gmail.com>
	<1156980766.4026.111.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] location of link keys
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0782613340=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0782613340==
Content-Type: multipart/alternative;
	boundary="----=_Part_47275_23331354.1156975496248"

------=_Part_47275_23331354.1156975496248
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your reply.  That is what I thought except that
once I disconnect from the device, my /var/lib/bluetooth directory is
emptied.    So I am curious how they get wiped out.


On 8/30/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mark,
>
> > I am trying to look for where my link keys are stored by hcid.  I
> > thought it is under /var/lib/bluetooth but even with paired devices, I
> > still don't see link keys stored under /var/lib/bluetooth.  I believe
> > link keys are cached so for a device that has been paired before, the
> > same link key is handed down during pin-exchange and pairing.
>
> the link keys are stored under /var/lib/bluetooth/<bdaddr>/linkkeys
> since quite some time now.
>
> Regards
>
> Marcel
>
>
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

------=_Part_47275_23331354.1156975496248
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your reply.&nbsp; That is what I thought except that <br>once I disconnect from the device, my /var/lib/bluetooth directory is emptied.&nbsp;&nbsp;&nbsp; So I am curious how they get wiped out.<br><br><br><div><span class="gmail_quote">
On 8/30/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Mark,<br><br>&gt; I am trying to look for where my link keys are stored by hcid.&nbsp;&nbsp;I<br>&gt; thought it is under /var/lib/bluetooth but even with paired devices, I<br>&gt; still don't see link keys stored under /var/lib/bluetooth.&nbsp;&nbsp;I believe
<br>&gt; link keys are cached so for a device that has been paired before, the<br>&gt; same link key is handed down during pin-exchange and pairing.<br><br>the link keys are stored under /var/lib/bluetooth/&lt;bdaddr&gt;/linkkeys
<br>since quite some time now.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?
<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">
http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_47275_23331354.1156975496248--


--===============0782613340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0782613340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0782613340==--
