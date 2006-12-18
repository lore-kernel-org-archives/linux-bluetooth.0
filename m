Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Lauri Lubi" <lauri@lubi.se>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 09:00:28 +0100
Message-ID: <020201c7227a$94e3a590$9301a8c0@LUBI>
MIME-Version: 1.0
In-Reply-To: <1166359423.6557.35.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Immediate disconnect after doing "hcitool cc"
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

Is there more information available how the kernel creates an ACL
connection? I have been reading source code for 2.6.13-15 but not seen
anything about creating an ACL connection yet. Well, I am quite unfamiliar
with the kernel source code.

I have re-written some parts of hcitool so that it uses clock_offset and
pscan_repetition_mode when ACL-connecting. Is kernel code more optimised
that this?

Q2: Any ideas for a good way to time kernel creating the ACL connection? So
that to compare with a "hacked" hcitool.

Mvh
Lauri Lubi
Mob +46 730 39 31 00
 =


-----Ursprungligt meddelande-----
Fr=E5n: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] F=F6r Marcel Holtmann
Skickat: den 17 december 2006 13:44
Till: jbarnett@pobox.com; BlueZ development
=C4mne: Re: [Bluez-devel] Immediate disconnect after doing "hcitool cc"

Hi Jon,

> No. The disconnect happens at most maybe a couple of seconds after the
> cc command has completed. I've tried:
> hcitool cc 00:12:EE:E0:AB:CA; hcitool auth 00:12:EE:E0:AB:CA

don't use "hcitool cc" for connecting devices. This command is not for
general purpose use. Let the kernel create you low-level ACL, because it
knows what to do.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- =

No virus found in this incoming message.
Checked by AVG Free Edition.
Version: 7.5.432 / Virus Database: 268.15.23/591 - Release Date: 2006-12-17
15:17
 =


-- =

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.432 / Virus Database: 268.15.23/591 - Release Date: 2006-12-17
15:17
 =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
