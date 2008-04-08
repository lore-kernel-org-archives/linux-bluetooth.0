Return-Path: <cyrus@holtmann.org>
Message-ID: <49f5aca0804080148s3c430926n84a740de8370384c@mail.gmail.com>
Date: Tue, 8 Apr 2008 10:48:51 +0200
From: "Pedro Vivancos" <pedro.vivancos@vocali.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Problems with "CreateHeadset" method
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0570552355=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0570552355==
Content-Type: multipart/alternative;
	boundary="----=_Part_4675_26644549.1207644531537"

------=_Part_4675_26644549.1207644531537
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear friends,

I get an error when I call the CreateHeadset method of
org.bluez.audio.Manager interface by using the C sentences:

char *headset;
dbus_g_proxy_call(audio, "CreateHeadset", &error, G_TYPE_STRING,
"00:16:94:03:60:1B", G_TYPE_INVALID, G_TYPE_STRING, &headsetPath,
G_TYPE_INVALID);

The error message is:

Method "CreateHeadset" with signature "s" on interface
"org.bluez.audio.Manager" doesn't exist

but I read that there is a method "string CreateHeadset(string address)" in
the audio api.

Can anyone help me?

Thank you very much.
Pedro

------=_Part_4675_26644549.1207644531537
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear friends,<br><br>I get an error when I call the CreateHeadset method of org.bluez.audio.Manager interface by using the C sentences: <br><br>char *headset;<br>dbus_g_proxy_call(audio, &quot;CreateHeadset&quot;, &amp;error, G_TYPE_STRING, &quot;00:16:94:03:60:1B&quot;, G_TYPE_INVALID, G_TYPE_STRING, &amp;headsetPath, G_TYPE_INVALID);<br>
<br>The error message is:<br><br>Method &quot;CreateHeadset&quot; with signature &quot;s&quot; on interface &quot;org.bluez.audio.Manager&quot; doesn&#39;t exist<br><br>but I read that there is a method &quot;string CreateHeadset(string address)&quot; in the audio api.<br>
<br>Can anyone help me?<br><br>Thank you very much.<br>Pedro<br clear="all"><br>

------=_Part_4675_26644549.1207644531537--


--===============0570552355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0570552355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0570552355==--
