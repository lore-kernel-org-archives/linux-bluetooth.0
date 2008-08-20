Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0808200740p335fd2acq6c2e2aef891293f0@mail.gmail.com>
Date: Wed, 20 Aug 2008 16:40:48 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <3e9cdced0808200615v203df9e1pd88e9fd8ac98d7ff@mail.gmail.com>
MIME-Version: 1.0
References: <3e9cdced0808200615v203df9e1pd88e9fd8ac98d7ff@mail.gmail.com>
Subject: Re: [Bluez-users] Problem with CreateBonding after update 3.31 ->
	3.36
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1870927562=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1870927562==
Content-Type: multipart/alternative;
	boundary="----=_Part_53046_3291401.1219243248054"

------=_Part_53046_3291401.1219243248054
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Its seems there might be a problem during the registration of my passkey
agent:

hcid[149]: register_passkey_agent called without any adapter info!

As already said, with 3.31 I dont have this problems...

thanks


On Wed, Aug 20, 2008 at 3:15 PM, Fritz Code <codefritz@googlemail.com>wrote:

> After the update Im haveing a problem with create a bonding.
> With 3.31 everything worked fine. With 3.36 after calling CreateBonding I
> get the following error:
>
> "Did not receive a reply. Possible causes include: the remote application
> did not send a reply, the message bus security policy blocked the reply, the
> reply timeout expired, or the network connection was broken."
>
> Anyone an idea what there might go wrong?
>
> Reading the ChangeLog I figured out that with v3.33 support for simple
> pairing was added. I'm not sure what this exactly means, but I guess this
> means pairing without using a PasskeyAgent. So it shouldn't affect me.
>
>
> --
> Regards,
> --Codefritz
>
>
>
>
>


-- 
Regards,
--Codefritz

------=_Part_53046_3291401.1219243248054
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Its seems there might be a problem during the registration of my passkey agent:<br><br>hcid[149]: register_passkey_agent called without any adapter info!<br><br>As already said, with 3.31 I dont have this problems...<br>
<br>thanks<br><br><br><div class="gmail_quote">On Wed, Aug 20, 2008 at 3:15 PM, Fritz Code <span dir="ltr">&lt;<a href="mailto:codefritz@googlemail.com">codefritz@googlemail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div dir="ltr">After the update Im haveing a problem with create a bonding.<br>With 3.31 everything worked fine. With 3.36 after calling CreateBonding I get the following error:<br><br>&quot;Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.&quot;<br>

<br>Anyone an idea what there might go wrong?<br><br>Reading the ChangeLog I figured out that with v3.33 support for simple pairing was added. I&#39;m not sure what this exactly means, but I guess this means pairing without using a PasskeyAgent. So it shouldn&#39;t affect me.<br>

<br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br><br>
</div>
</blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br><br>
</div>

------=_Part_53046_3291401.1219243248054--


--===============1870927562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1870927562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1870927562==--
