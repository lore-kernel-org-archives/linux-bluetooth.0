Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20050120225148.2bd40d9f@coredump>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] snd_bt_sco unknown symbol snd_hwdep_new
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
Date: Thu, 20 Jan 2005 22:51:48 -0800

Hi Folks,

I have some problems with the snd_bt_sco module... I have ALSA enabled
in my kernel (use it for my "real" sound card).

any tips?

dmesg:
---snip---
snd_bt_sco: Unknown symbol snd_hwdep_new
---snap---

make modules_install
---snip---
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-mh1;
fi WARNING: /lib/modules/2.6.10-mh1/extra/snd-bt-sco.ko needs unknown
symbol snd_hwdep_new
---snap---

thanks ... Collin

-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Coding without coffee is like driving without gas!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
