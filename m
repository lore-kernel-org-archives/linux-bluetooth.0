Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F13638.1080207@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Again: Problems with Dongle, Headset or btsco
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net>
In-Reply-To: <41F128F4.2020006@webstuhl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 21 Jan 2005 18:04:56 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ben Pezzei wrote:
| Hi Lars,
|
| Tnx for your reply
|
| Lars Grunewaldt schrieb:
|
| ...
|
|> 3. disconnect the headset by pressing the "connect" button of the
|> headset again. Audio stops working until you "connect" again with the
|> button.
|
|
| like i said, the rfcomm connection is fine: (output from btsco <addr>):

btsco handles rfcomm and sco connections, so...

|   Device is 1:0
|   Voice setting: 0x0060
|   RFCOMM channel 1 connected
|   recieved AT+CKPD=200
|   opened hwdep
|   connected SCO channel
|   Setting sco fd
|   Done setting sco fd

this looks good.

| after reconnecting via headset:
|   disconnected SCO channel
|   recieved AT+CKPD=200
|   opened hwdep
|   Can't connect SCO audio channel
|   : Connection timed out

this does not. It should re-connect without problems, but I can't tell
whether this would be solved with mh1-patches or what might causing that
you can't reconnect to the headset.

You can try the patches out, I use them and it works well.

| I guess the Problem has to do with the SCO or ALSA Stuff

sco, not alsa I think. The alsa stuff is only needed to transmit the sco
data to the alsa functions and vice versa, so it's unlikly that the
impossibility of reconnecting on a new sco channel is the problem. More
likely the sco channel is not terminated correctly in the first place.

best regards,
~  Lars


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8TY3QWC6DTWkDAoRAlCCAJ9CyuecdSlBzOw+WP2AOqK5G0BOoACfWSNH
P0eRv2FWV2wQNyVtdZ3+m9I=
=NCy7
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
