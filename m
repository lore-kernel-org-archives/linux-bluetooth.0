Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0807020309j61e53e36v9a27a0ee7aac80a9@mail.gmail.com>
Date: Wed, 2 Jul 2008 12:09:24 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1214992658.11537.173.camel@violet.holtmann.net>
MIME-Version: 1.0
References: <3e9cdced0807020150p7fa242ecw724c38fa47b956dd@mail.gmail.com>
	<1214989958.11537.170.camel@violet.holtmann.net>
	<3e9cdced0807020232k7e8a3e15j1ea32ba428313d6f@mail.gmail.com>
	<1214992658.11537.173.camel@violet.holtmann.net>
Subject: Re: [Bluez-users] CancelBondingProcess -> Not authorized
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0530020978=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0530020978==
Content-Type: multipart/alternative;
	boundary="----=_Part_299_9525995.1214993364084"

------=_Part_299_9525995.1214993364084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Im using utils-3.31.
Programm is coming soon..

Might the scenario when I get on the bus with dbus_bus_get(), sending
CreateBonding message and now do a dbus_connection_unref (accidently) after
that try to send the CancelBonding message result in this error?

> well I guess you mean only the same programm which has sent the
> CreateBonding signal can also send the CancelBonding signal?
Is that true so far?





On Wed, Jul 2, 2008 at 11:57 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Fritz,
>
>  (no
> > reconnection between so that it doesn't change its d-bus bus id)
> > But thats the case!
>
> show us your testing program. You are using bluez-utils-3.35?
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Regards,
--Codefritz

------=_Part_299_9525995.1214993364084
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Im using utils-3.31.<br>Programm is coming soon..<br><br>Might the scenario when I get on the bus with dbus_bus_get(), sending CreateBonding message and now do a dbus_connection_unref (accidently) after that try to send the CancelBonding message result in this error?<br>
<br>
&gt; well I guess you mean only the same programm which has sent the<br>
&gt; CreateBonding signal can also send the CancelBonding signal?<br>Is that true so far?<br><br><br><br><br><br><div class="gmail_quote">On Wed, Jul 2, 2008 at 11:57 AM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Fritz,<br>
<div class="Ih2E3d"><br>&nbsp;(no<br>
&gt; reconnection between so that it doesn&#39;t change its d-bus bus id)<br>
&gt; But thats the case!<br>
<br>
</div>show us your testing program. You are using bluez-utils-3.35?<br>
<div><div></div><div class="Wj3C7c"><br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!<br>
Studies have shown that voting for your favorite open source project,<br>
along with a healthy diet, reduces your potential for chronic lameness<br>
and boredom. Vote Now at <a href="http://www.sourceforge.net/community/cca08" target="_blank">http://www.sourceforge.net/community/cca08</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_299_9525995.1214993364084--


--===============0530020978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============0530020978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0530020978==--
