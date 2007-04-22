Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50704221536g1e696aeaj8d97c10a84e3f98a@mail.gmail.com>
Date: Sun, 22 Apr 2007 19:36:10 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <462BDFE9.7010001@gmail.com>
MIME-Version: 1.0
References: <12a679470704221147v13b00925vf41dead8dc98ed24@mail.gmail.com>
	<c49421c50704221228x4fdd2ea1uda37debc07f6bc3e@mail.gmail.com>
	<462BDFE9.7010001@gmail.com>
Subject: Re: [Bluez-users] Max number of RFCOMM connections?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1965298496=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1965298496==
Content-Type: multipart/alternative;
	boundary="----=_Part_128470_91292.1177281370166"

------=_Part_128470_91292.1177281370166
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I totally agree with you, but I thought the question was about the maximum
number of RFCOMM connections.
When I said 30 I considered scenarios where there could be more than one
RFCOMM connection between the same two ACL-connected devices...

Actually, I have never implemented such scenario. I agree I am wrong if
bluetooth doesn't allow to establish such a set of simultaneous
connections...

Loreno

On 4/22/07, Manuel Naranjo <naranjo.manuel@gmail.com> wrote:
>
> I'm sorry, that's not right. There's a maximum of 7 ACL connections per
> bluetooth dongle, according to the specs of the BT SIG. And RFCOMM is
> implemented over ACL, so you have a maximum of 7 simultaneous rfcomm
> connections.
> > I believe the maximum number of allowed connections relates to the
> > number of ports available to connect to using rfcomm.
> > Thus, my guess is 30.
> >
> > http://people.csail.mit.edu/albert/bluez-intro/x92.html#rfcomm-and-tcp
> >
> > Regards,
> >
> > Loreno
> >
> >
> >     Hi all, can someone please enlight me on the following?
> >
> >     What is the maximum number of RFCOMM connections for each
> >     bluetooth dongle with BlueZ?
> >
> >     Thanks in advance
> >
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_128470_91292.1177281370166
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I totally agree with you, but I thought the question was about the maximum number of RFCOMM connections. <br>When I said 30 I considered scenarios where there could be more than one RFCOMM connection between the same two ACL-connected devices...
<br><br>Actually, I have never implemented such scenario. I agree I am wrong if bluetooth doesn&#39;t allow to establish such a set of simultaneous connections...<br><br>Loreno<br><br><div><span class="gmail_quote">On 4/22/07, 
<b class="gmail_sendername">Manuel Naranjo</b> &lt;<a href="mailto:naranjo.manuel@gmail.com">naranjo.manuel@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I&#39;m sorry, that&#39;s not right. There&#39;s a maximum of 7 ACL connections per<br>bluetooth dongle, according to the specs of the BT SIG. And RFCOMM is<br>implemented over ACL, so you have a maximum of 7 simultaneous rfcomm
<br>connections.<br>&gt; I believe the maximum number of allowed connections relates to the<br>&gt; number of ports available to connect to using rfcomm.<br>&gt; Thus, my guess is 30.<br>&gt;<br>&gt; <a href="http://people.csail.mit.edu/albert/bluez-intro/x92.html#rfcomm-and-tcp">
http://people.csail.mit.edu/albert/bluez-intro/x92.html#rfcomm-and-tcp</a><br>&gt;<br>&gt; Regards,<br>&gt;<br>&gt; Loreno<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Hi all, can someone please enlight me on the following?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; What is the maximum number of RFCOMM connections for each
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; bluetooth dongle with BlueZ?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Thanks in advance<br>&gt;<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express
<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_128470_91292.1177281370166--


--===============1965298496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1965298496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1965298496==--
