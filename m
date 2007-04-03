Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0704031005l56b76930id68bb98c1379e659@mail.gmail.com>
Date: Tue, 3 Apr 2007 14:05:22 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <0DD4EA5DCF754A409C4E182C758C37F33DE1BF@tigris.empics.co.uk>
MIME-Version: 1.0
References: <0DD4EA5DCF754A409C4E182C758C37F33DE1BF@tigris.empics.co.uk>
Subject: Re: [Bluez-users] Bluetooth parings on dual-boot
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 4/3/07, Steve Drew <steve.drew@paphotos.com> wrote:
>
>
> Hi,
>
> I'm having a problem with my dual boot laptop, and my google skills seem to
> be failing me, was wondering if anyone had come across this before or had
> any suggestions.
>
> The laptops are dual booting XP (sp2) and SuSE 10.2 ( 2.6.18.2 kernel, bluez
> 3.7.14)
>
> The phone (Nokia 6680) pairs and work correctly for dial up networking, but
> once it has been paired for use under XP, it has to be repaired under Linux
> (and vice versa).
>
> The laptop has a different Bluetooth hostname under XP and SuSE, but the
> problem still occurs. Is there anyway round this, or am I going to have to
> do this due to the same Bluetooth MAC of the adapter in the laptop?
>
> I've also used the same key when pairing the phone under XP and SusE but
> again the problem occurs.
>
> Any suggestions etc gratefully received.
>
> Thanks
>
> steve
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

Hi Steve,

This problem happens because the hcid returns the stored link key.
It is basically the same problem that I reported in the item 6 of
BlueZ TODO list:
http://wiki.bluez.org/wiki/TODO

Just remove the stored link key and pair it again.

$dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/hci0 org.bluez.Adapter.RemoveBonding
string:aa:bb:cc:dd:ee:ff

or

remove the remote device entry from the file=>
/var/lib/bluetooth/aa:bb:cc:dd:ee:ff/linkkeys


BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
