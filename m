Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706030809u6f971992hf29f463facf56e71@mail.gmail.com>
Date: Sun, 3 Jun 2007 09:09:16 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <5eee8c670706030625o6aad300al5b1848f4e9394ebd@mail.gmail.com>
MIME-Version: 1.0
References: <5eee8c670706030625o6aad300al5b1848f4e9394ebd@mail.gmail.com>
Subject: Re: [Bluez-users] a2dp stream + bluetooth mouse not working at same
	time
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0555582547=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0555582547==
Content-Type: multipart/alternative;
	boundary="----=_Part_1061_13462966.1180883356801"

------=_Part_1061_13462966.1180883356801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hey


> The only issue is, whenever I connect and move the mouse (using hidd)
> while I'm streaming music using a2dpd, the music starts cutting out and
> jumping until I stop moving the mouse.


I'm not sure why it would be happening. I had this same problem when
streaming to a combo headset but I believe it's because the headset wanted
to be the master device by default. The laptop's adapter was cutting out
because of the inefficiency of the scatternet (laptop was master to mouse
but slave to headset). It helped to force master mode in that case. To try
that, put "master" in hcid.conf's lm setting and you take "rswitch" out of
the lp setting.

Are there any other bluetooth devices involved, even if they aren't active?

Brad

------=_Part_1061_13462966.1180883356801
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hey<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>The
only issue is, whenever I connect and move the mouse (using hidd) while I&#39;m streaming music
using a2dpd, the music starts cutting out and jumping until I stop moving the mouse.</blockquote><div><br>I&#39;m not sure why it would be happening. I had this same problem when streaming to a combo headset but I believe it&#39;s because the headset wanted to be the master device by default. The laptop&#39;s adapter was cutting out because of the inefficiency of the scatternet (laptop was master to mouse but slave to headset). It helped to force master mode in that case. To try that, put &quot;master&quot; in 
hcid.conf&#39;s lm
setting and you take &quot;rswitch&quot; out of the lp setting.<br><br>Are there any other bluetooth devices involved, even if they aren&#39;t active?<br><br>Brad<br></div><br></div><br>

------=_Part_1061_13462966.1180883356801--


--===============0555582547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0555582547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0555582547==--
