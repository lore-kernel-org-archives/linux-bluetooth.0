Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Lauri Lubi" <lauri@lubi.se>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 10:52:23 +0100
Message-ID: <022d01c7228a$377febb0$9301a8c0@LUBI>
MIME-Version: 1.0
In-Reply-To: <1166434619.6557.55.camel@aeonflux.holtmann.net>
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

Well, I'm a man in a bad need of performance and have to create ACL
connections in the most optimized way. The current tests (hcidump) have
unfortunately showed that the Linux kernel (2.5.16) does make use of
pscan_repetition_mode, not sure about the clock_offset. Inquiry scan has
been done just seconds before connection attempts.

With this background I guess there are 2 ways out: messing with HCI directly
and taking the risk of kernel overriding me; or re-writing some
Bluetooth/sockets code in the kernel. Do you agree?

Does anybody have some good hints for where to start in the kernel source
tree? I would like to try modifying how the kernel creates an ACL
connection, and if some options (clock_offset and pscan_rep_mode) can be
passed to it. I guess that bluez-libs has nothing to do with how the kernel
implements HCI_CREATE_CONNECTION?


Mvh
Lauri Lubi
Mob +46 730 39 31 00
 =


-----Ursprungligt meddelande-----
Fr=E5n: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] F=F6r Marcel Holtmann
Skickat: den 18 december 2006 10:37
Till: BlueZ development
=C4mne: Re: [Bluez-devel] Immediate disconnect after doing "hcitool cc"

Hi,

> Is there more information available how the kernel creates an ACL
> connection? I have been reading source code for 2.6.13-15 but not seen
> anything about creating an ACL connection yet. Well, I am quite unfamiliar
> with the kernel source code.
> =

> I have re-written some parts of hcitool so that it uses clock_offset and
> pscan_repetition_mode when ACL-connecting. Is kernel code more optimised
> that this?
> =

> Q2: Any ideas for a good way to time kernel creating the ACL connection?
So
> that to compare with a "hacked" hcitool.

this is all the wrong approach. Create a L2CAP or RFCOMM connection and
the kernel will create any needed ACL link for you. Don't try to think
to complicate. If you try to mess around with connection reference
counting of the ACL the kernel will always win and simply disconnect the
link if it thinks it is no longer needed. Messing around directly with
HCI is never a good idea.

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
