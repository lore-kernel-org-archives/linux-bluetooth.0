Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0807020232k7e8a3e15j1ea32ba428313d6f@mail.gmail.com>
Date: Wed, 2 Jul 2008 11:32:00 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1214989958.11537.170.camel@violet.holtmann.net>
MIME-Version: 1.0
References: <3e9cdced0807020150p7fa242ecw724c38fa47b956dd@mail.gmail.com>
	<1214989958.11537.170.camel@violet.holtmann.net>
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
Content-Type: multipart/mixed; boundary="===============0227171977=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0227171977==
Content-Type: multipart/alternative;
	boundary="----=_Part_209_30528927.1214991120675"

------=_Part_209_30528927.1214991120675
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

well I guess you mean only the same programm which has sent the
CreateBonding signal can also send the CancelBonding signal? (no
reconnection between so that it doesn't change its d-bus bus id)
But thats the case!

Fritz

On Wed, Jul 2, 2008 at 11:12 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Fritz,
>
> > Want to cancel a running bonding process by sending
> > CancelBondingProcess.
> > But as a reply I get Not authorized, unfortunately.
> > What might be the problem (However, I'm root)?
>
> only the program (with the unique D-Bus bus id) can call this method.
> Same as that we will cancel any attempt automatically if the caller
> dies.
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

------=_Part_209_30528927.1214991120675
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>well I guess you mean only the same programm which has sent the CreateBonding signal can also send the CancelBonding signal? (no reconnection between so that it doesn&#39;t change its d-bus bus id)<br>But thats the case!<br>
<br>Fritz<br><br><div class="gmail_quote">On Wed, Jul 2, 2008 at 11:12 AM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Fritz,<br>
<div class="Ih2E3d"><br>
&gt; Want to cancel a running bonding process by sending<br>
&gt; CancelBondingProcess.<br>
&gt; But as a reply I get Not authorized, unfortunately.<br>
&gt; What might be the problem (However, I&#39;m root)?<br>
<br>
</div>only the program (with the unique D-Bus bus id) can call this method.<br>
Same as that we will cancel any attempt automatically if the caller<br>
dies.<br>
<br>
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
</blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_209_30528927.1214991120675--


--===============0227171977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============0227171977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0227171977==--
