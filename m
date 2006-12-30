Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 30 Dec 2006 17:50:38 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <544bb7070612280942n6907d4e2u107654fd71310df4@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0612301747480.20515@redbean.intranet.gw-instruments.de>
References: <544bb7070612272338m3f130e00p22ee2f1b7f67d3cb@mail.gmail.com>
	<56233.80.165.155.106.1167300847.squirrel@webmail10.pair.com>
	<Pine.LNX.4.63.0612281212140.12381@redbean.intranet.gw-instruments.de>
	<544bb7070612280942n6907d4e2u107654fd71310df4@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] bdaddr for CSR chipset - porting dificulties
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Ian, 

On Thu, 28 Dec 2006, Ian Rickard wrote:

> But only UART, not USB?  I tried again with transient = true (word 7 =
> 0x0008) and I still get a response with status 0x0009.
The bccmd tool should also work over USB (have not tried it, but the code 
is in place). 

> And yeah, I understand changing your BT address is generally a bad
> idea.  This is just for research purposes.  I'm trying to get a Wii to
> connect to a MacBook as if it were a Wii Remote and so far just
> matching the device name/class has proved insufficient.  Current
> theory is it will only connect to devices in Nintendo's OUI ranges.

Have you checked the SDP service records required ?? 

Ciao, 

Peter 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
