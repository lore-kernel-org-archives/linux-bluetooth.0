Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <csq9pg$4gu$1@sea.gmane.org>
References: <20050120225148.2bd40d9f@coredump>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <20050120225148.2bd40d9f@coredump>
Subject: [Bluez-devel] Re: snd_bt_sco unknown symbol snd_hwdep_new
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
Date: Fri, 21 Jan 2005 08:08:32 +0100

Hi Collin!

snd-bt-sco needs the module snd-hwdep! You have to select a driver which
uses snd-hwdep too. e.g. EMU10K1 (SB Live! & Audigy, E-mu APS)

/usr/src/linux(-2.6.10-mh1)/sound/pci/Kconfig
...
config SND_EMU10K1
	tristate "EMU10K1 (SB Live! & Audigy, E-mu APS)"
	depends on SND
	select SND_HWDEP
	select SND_RAWMIDI
	select SND_AC97_CODEC
...

Best regards,
Sebastian



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
