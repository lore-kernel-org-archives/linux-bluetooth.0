Return-Path: <cyrus@holtmann.org>
From: "Malte J. Wetz" <bluez-users-mlist@malte-wetz.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 7 Jul 2008 12:55:06 +0200
References: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
	<20080704163313.GN8715@caesar.sig21.net>
	<alpine.LNX.1.10.0807060641520.7069@nge2.ngu.pk>
In-Reply-To: <alpine.LNX.1.10.0807060641520.7069@nge2.ngu.pk>
MIME-Version: 1.0
Message-Id: <200807071255.06344.bluez-users-mlist@malte-wetz.de>
Subject: Re: [Bluez-users] Headset not working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Am Sonntag, 6. Juli 2008 schrieb jayjwa:
> On Fri, 4 Jul 2008, Martin Mueller wrote:
> -> You can get the patch from:
> http://bluetooth-alsa.cvs.sourceforge.net/*checkout*/bluetooth-alsa/plugz
>/patches/sco-flowcontrol-v4.4.diff?revision=3D1.1 ->
>
> We seem to be talking about different patches. I am refering to the one
> needed to allow older bluetooth (I think it's 1.2?) headsets to work with
> newer kernels, that deals with SCO/ESCO. The one above modifies another
> file. Below is the one I use, and it's working now even on linux-2.6.25.9
> (kernel.org) that I'm currently using.

Well, as I wrote before, I'm already using the SCO/ESCO patch and it does =

not work.

The patch proposed by Martin does apply to current kernel (you just have to =

add =BB-F10=AB to your patch command as some line have moved beyond the def=
ault =

fuzz). But it does no good. Now, whenever I play back something via the =

headset, the entire kernel freezes and even Magic SysRq won't anymore. Only =

a hard reset gets me out of there.

Log files is insuspicous:

Jul  7 12:41:37 triton hcid[8053]: Audio API: received =

BT_GETCAPABILITIES_REQ
Jul  7 12:41:37 triton hcid[8053]: Audio API: sending BT_GETCAPABILITIES_RSP
Jul  7 12:41:37 triton hcid[8053]: Audio API: received =

BT_SETCONFIGURATION_REQ
Jul  7 12:41:37 triton hcid[8053]: config sco - device =3D 00:13:17:CF:C3:D=
5 =

access_mode =3D 2
Jul  7 12:41:40 triton hcid[8053]: pin_code_request (sba=3D00:0A:3A:81:33:1=
C, =

dba=3D00:13:17:CF:C3:D5)
<freeze here>


hci_usb is loaded with force_scofix=3D1. I cannot see any differences.

Still confused,
  Malte

-- =

Malte J. Wetz  <mail@malte-wetz.de>
Homepage: www.malte-wetz.de (PGP/GPG Keys available on homepage)

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
