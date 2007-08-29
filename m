Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <fc3d922d0708290252l3ccdaec1o527e9ffdb44ad2ca@mail.gmail.com>
Date: Wed, 29 Aug 2007 11:52:20 +0200
From: "=?ISO-8859-2?Q?Przemys=B3aw_Jakubowski?=" <przemyslaw.jakubowski@javatech.com.pl>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1188380835.6109.33.camel@violet>
MIME-Version: 1.0
References: <fc3d922d0708290244o2f4be49cv4063e8a70239522@mail.gmail.com>
	<1188380835.6109.33.camel@violet>
Subject: Re: [Bluez-users] Pin Authentication
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0687269392=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0687269392==
Content-Type: multipart/alternative;
	boundary="----=_Part_255_10043776.1188381140222"

------=_Part_255_10043776.1188381140222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I use BlueZ 2.25, and I have to use it.
Now I have set security auto, and pin_helper /usr/bin/bluepin where bluepin
is a file with 1234.
Is it correct configuration??

Regards, Przemek

2007/8/29, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> > I want to configure my computer, that accepts connection with some
> > defined default PIN.
> > How I should configure hcid.conf?
> > What I should insert in security , auto, none, or user.
> > Should I use passkey "1234" or maybe pin_helper /usr/bin/bluepin , and
> > bluepin is file with 1234.
> > Should I set maybe something else?
>
> if you use a default PIN, then you also can use no PIN at all. Anyway
> starting with BlueZ 3.x you need a passkey agent.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_255_10043776.1188381140222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I use BlueZ 2.25, and I have to use it. <br>Now I have set security auto, and pin_helper /usr/bin/bluepin where bluepin is a file with 1234.<br>Is it correct configuration??<br><br>Regards, Przemek<br><br><div><span class="gmail_quote">
2007/8/29, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>&gt; I want to configure my computer, that accepts connection with some<br>&gt; defined default PIN.<br>&gt; How I should configure hcid.conf?<br>&gt; What I should insert in security , auto, none, or user.<br>
&gt; Should I use passkey &quot;1234&quot; or maybe pin_helper /usr/bin/bluepin , and<br>&gt; bluepin is file with 1234.<br>&gt; Should I set maybe something else?<br><br>if you use a default PIN, then you also can use no PIN at all. Anyway
<br>starting with BlueZ 3.x you need a passkey agent.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.
<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp;<a href="http://get.splunk.com/">
http://get.splunk.com/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_255_10043776.1188381140222--


--===============0687269392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0687269392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0687269392==--
