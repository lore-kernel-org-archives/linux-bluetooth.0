Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
From: Stefan Bellon <sbellon@sbellon.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <4d348a05e8sbellon@sbellon.de>
In-Reply-To: <4d33b69105sbellon@sbellon.de>
References: <4d3382eb6csbellon@sbellon.de> <41F81D6F.3000908@xmission.com> <4d33b69105sbellon@sbellon.de>
Content-Type: text/plain
Subject: [Bluez-users] Re: bluetooth-alsa and Jabra BT800
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 28 Jan 2005 23:17:05 +0100

Stefan Bellon wrote:
> Brad Midgley wrote:
> > did you put it in pairing mode (usually by holding down the power
> > button until it beeps) just before running btsco?

> I tried that as well. Doesn't make any difference. But the headset and
> the PC are already paired. Do you have to put the headset into pairing
> mode every time you start btsco?

> Anyway, even that would be acceptable if it worked. ;-}

> On http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/README there's the hint to
> find out about the channel to use with btsco. But I get:

> root@roma# sdptool search --bdaddr 00:07:A4:21:1D:86 0x1108
> Class 0x1108
> Failed to connect to SDP server on 00:07:A4:21:1D:86: Connection
> timed out

> Is this a problem? What else can I do to track down the problem? TIA.

Tomorrow I have some time I could spend on tracking that problem down.
But I could need a bit of help here. What else could I try to debug? I
really want to get my Jabra BT800 going with bluetooth-alsa.

-- 
Stefan Bellon


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
