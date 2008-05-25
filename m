Return-Path: <cyrus@holtmann.org>
Message-ID: <685df2130805241855v3ebc7fd5wef3fab700c3a5c4a@mail.gmail.com>
Date: Sat, 24 May 2008 21:55:25 -0400
From: "Joshua Bryant" <josh@bryantweb.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Change Default Headset not working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0491862726=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0491862726==
Content-Type: multipart/alternative;
	boundary="----=_Part_11694_10699960.1211680525170"

------=_Part_11694_10699960.1211680525170
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The command to change the default headset is not working for me. I change
the default headset, but mplayer continues to connect to the old default
headset. Bluez is changing the default headset, but mplayer does not connect
to the new default headset.

My .asoundrc:

pcm.headset {
type bluetooth
}

   $ dbus-send --system --type=method_call --print-reply --dest=":1.27"
/org/bluez/audio org.bluez.audio.Manager.DefaultDevice
   method return sender=:1.27 -> dest=:1.33 reply_serial=2
      string "/org/bluez/audio/device1"

   $ dbus-send --system --type=method_call --print-reply --dest=":1.27"
   /org/bluez/audio org.bluez.audio.Manager.ChangeDefaultDevice
string:/org/bluez/audio/device0
   method return sender=:1.27 -> dest=:1.34 reply_serial=2

   $ dbus-send --system --type=method_call --print-reply --dest=":1.27"
   /org/bluez/audio org.bluez.audio.Manager.DefaultDevice
method return sender=:1.27 -> dest=:1.35 reply_serial=2
      string "/org/bluez/audio/device0"

Why does mplayer still connect to the old default headset after the change?

Thanks for your help-
Josh

------=_Part_11694_10699960.1211680525170
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The command to change the default headset is not working for me. I
change the default headset, but mplayer continues to connect to the old
default headset. Bluez is changing the default headset, but
mplayer does not connect to the new default headset.<br>
<br>My .asoundrc:<br><br>pcm.headset {<br>type bluetooth<br>}<br><br>
 &nbsp;&nbsp; $ dbus-send --system --type=method_call --print-reply --dest=&quot;:1.27&quot; /org/bluez/audio org.bluez.audio.Manager.DefaultDevice<br><div id="1f3d" class="ArwC7c ckChnd">
 &nbsp; &nbsp;method return sender=:1.27 -&gt; dest=:1.33 reply_serial=2<br>
 &nbsp; &nbsp; &nbsp; string &quot;/org/bluez/audio/device1&quot;<br><br>
 &nbsp; &nbsp;$ dbus-send --system --type=method_call --print-reply --dest=&quot;:1.27&quot;<br>
 &nbsp; &nbsp;/org/bluez/audio org.bluez.audio.Manager.ChangeDefaultDevice&nbsp; string:/org/bluez/audio/device0<br>
 &nbsp; &nbsp;method return sender=:1.27 -&gt; dest=:1.34 reply_serial=2<br><br>
 &nbsp; &nbsp;$ dbus-send --system --type=method_call --print-reply --dest=&quot;:1.27&quot;<br>
 &nbsp; &nbsp;/org/bluez/audio org.bluez.audio.Manager.DefaultDevice<br>method return sender=:1.27 -&gt; dest=:1.35 reply_serial=2<br>
 &nbsp; &nbsp; &nbsp; string &quot;/org/bluez/audio/device0&quot;<br><br>Why does mplayer still connect to the old default headset after the change?<br><br>Thanks for your help-<br>Josh</div><br><br><br>

------=_Part_11694_10699960.1211680525170--


--===============0491862726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0491862726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0491862726==--
