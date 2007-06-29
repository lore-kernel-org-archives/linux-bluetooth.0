Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706291338w727333beoc5f2b0fca85e41da@mail.gmail.com>
Date: Fri, 29 Jun 2007 14:38:11 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
MIME-Version: 1.0
References: <46852386.8050608@free.fr>
	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1802851544=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1802851544==
Content-Type: multipart/alternative;
	boundary="----=_Part_57963_32145738.1183149491409"

------=_Part_57963_32145738.1183149491409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Guys

The API is not properly design for audio over hci that's why you are
> confused.


there are some parts of the dbus api that would be used even for the hci
mode. Disconnecting the headset for example, since there is not an
equivalent alsa call. Disconnect/reconnect will likely be handled in a
single system gui that is outside the audio app.

We could disable those concurrent method while in hci mode as they probably
> break
> the plugin stream, actually they normally affects only the rfcomm socket
> because
> sco socket got duped in the process so plugin got its own reference that
> is not
> affected by API calls, but anyway this is a not common behavior for a
> headset.
>
> btw, switching between audio device is currently done by changing its
> default device.


we need a way to tell the plugin that the sco (or a2dp) fd has been
invalidated, eg when disconnecting. This is broadcast over dbus and also
communicated over the socket to the alsa client so the alsa plugin will do
something sensible like use the wired audio. (similarly when the headset
reconnects during stream playback--the fd is now available and the plugin
needs to be told to re-request it)

Brad

------=_Part_57963_32145738.1183149491409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Guys<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The API is not properly design for audio over hci that&#39;s why you are confused.
</blockquote><div><br>there are some parts of the dbus api that would be used even for the hci mode. Disconnecting the headset for example, since there is not an equivalent alsa call. Disconnect/reconnect will likely be handled in a single system gui that is outside the audio app.
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">We could disable those concurrent method while in hci mode as they probably break
<br>the plugin stream, actually they normally affects only the rfcomm socket because<br>sco socket got duped in the process so plugin got its own reference that is not <br>affected by API calls, but anyway this is a not common behavior for a headset.
<br><br>btw, switching between audio device is currently done by changing its default device.</blockquote><div><br>we need a way to tell the plugin that the sco (or a2dp) fd has been invalidated, eg when disconnecting. This is broadcast over dbus and also communicated over the socket to the alsa client so the alsa plugin will do something sensible like use the wired audio. (similarly when the headset reconnects during stream playback--the fd is now available and the plugin needs to be told to re-request it)
<br><br>Brad<br></div><br></div><br>

------=_Part_57963_32145738.1183149491409--


--===============1802851544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1802851544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1802851544==--
