Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4436772F.6030300@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO transparent transmission
References: <9ec07a230604041044j6b1b91f4ue25b44f2ed6f7c55@mail.gmail.com> <fe0a97c20604042223o7c59fb5fq871a004292ac1c55@mail.gmail.com>
In-Reply-To: <fe0a97c20604042223o7c59fb5fq871a004292ac1c55@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 07 Apr 2006 15:29:03 +0100

Sowmya Gattupalli wrote:
> On 4/4/06, Israel Gu=EDo <israzar@gmail.com> wrote:
>> example, with 0x0063 as voice settings. I have tried it with my Blueto=
oth
> How did u use CVSD when transmitting over sco?? [...]

He was quite clear that he'd used voice settigns 0x0063. The last two
bits indicate transparent coding and not CVSD.

Israel, you need to be sure you're sending data at exactly the right
average data rate. SCO links are synchronous and if you don't provide
data at exactly the right rate then something somewhere in the
system will have to insert or delete samples.

It would also be helpful if you stated what chip and firmware version
you were using.

	- Steven
--=20


To access the latest news from CSR copy this link into a web browser:  ht=
tp://www.csr.com/email_sig.php


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
