Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F0D35E.10404@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd_bt_sco unknown symbol snd_hwdep_new
References: <20050120225148.2bd40d9f@coredump>
In-Reply-To: <20050120225148.2bd40d9f@coredump>
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
Date: Fri, 21 Jan 2005 11:03:10 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brad:

maybe this should be added to the setup guide, too...

best regards,
~  Lars


Collin R. Mulliner wrote:
| Hi Folks,
|
| I have some problems with the snd_bt_sco module... I have ALSA enabled
| in my kernel (use it for my "real" sound card).
|
| any tips?
|
| dmesg:
| ---snip---
| snd_bt_sco: Unknown symbol snd_hwdep_new
| ---snap---
|
| make modules_install
| ---snip---
| if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-mh1;
| fi WARNING: /lib/modules/2.6.10-mh1/extra/snd-bt-sco.ko needs unknown
| symbol snd_hwdep_new
| ---snap---
|
| thanks ... Collin
|


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

iD8DBQFB8NNdQWC6DTWkDAoRAgDaAJ0T7KBY2RwHjZTSkIFwQFDoWRbz8wCfS75s
F/vJhdooa0Hg+JmPZqJmpjs=
=qju1
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
