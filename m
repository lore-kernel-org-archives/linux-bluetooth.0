Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: =?iso-8859-9?Q?Yunus_=D6zen?= <yunus@yunus.gen.tr>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 26 Feb 2007 06:46:57 +0200
MIME-Version: 1.0
In-Reply-To: <1172447355.20450.12.camel@violet>
Message-ID: <E1HLZV5-0007Bn-TM@mail.sourceforge.net>
Subject: Re: [Bluez-devel] Kernel Module
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

Hi,

>> I want to write a kernel module and use some bluez commands those
>> included in the kernel. 
>> 
>> I will use it some experimental cases. 
>> 
>> Is it possible to use bluez commands in kernel modules? If so, how can I
>> do it?

>of course it is possible, but for what strange reason you might wanna
>find yourself writing a kernel module. Explain what you are planning to
>do and I might can give you a more detailed answer. I am not psychic.

There is a Project called ULLA (http://ulla.sourceforge.net) and I am
writing a simple bluetooth LLA fot it. ULLA collects link layer information
(802.11x, bluetooth, zigbee etc.) to application layer programmes.

I will take Bd Addrs and user friendly names fo nearby devices and give it
to ULLA Core. 

My program will be a kernel module, because I will collect link layer
information. ULLA calls these link layer information collecting modules to
Link Provider (LP).

Thanks,
Yunus.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
