Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0808200615v203df9e1pd88e9fd8ac98d7ff@mail.gmail.com>
Date: Wed, 20 Aug 2008 15:15:06 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problem with CreateBonding after update 3.31 -> 3.36
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0795075158=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0795075158==
Content-Type: multipart/alternative;
	boundary="----=_Part_51842_15166526.1219238106899"

------=_Part_51842_15166526.1219238106899
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

After the update Im haveing a problem with create a bonding.
With 3.31 everything worked fine. With 3.36 after calling CreateBonding I
get the following error:

"Did not receive a reply. Possible causes include: the remote application
did not send a reply, the message bus security policy blocked the reply, the
reply timeout expired, or the network connection was broken."

Anyone an idea what there might go wrong?

Reading the ChangeLog I figured out that with v3.33 support for simple
pairing was added. I'm not sure what this exactly means, but I guess this
means pairing without using a PasskeyAgent. So it shouldn't affect me.


-- 
Regards,
--Codefritz

------=_Part_51842_15166526.1219238106899
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">After the update Im haveing a problem with create a bonding.<br>With 3.31 everything worked fine. With 3.36 after calling CreateBonding I get the following error:<br><br>&quot;Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.&quot;<br>
<br>Anyone an idea what there might go wrong?<br><br>Reading the ChangeLog I figured out that with v3.33 support for simple pairing was added. I&#39;m not sure what this exactly means, but I guess this means pairing without using a PasskeyAgent. So it shouldn&#39;t affect me.<br>
<br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br><br>
</div>

------=_Part_51842_15166526.1219238106899--


--===============0795075158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0795075158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0795075158==--
