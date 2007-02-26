Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002d01c75995$ccc41470$664c3d50$@gen.tr>
References: <E1HLZV5-0007Bn-TM@mail.sourceforge.net>
	<1172482542.27370.9.camel@violet>
	<002d01c75995$ccc41470$664c3d50$@gen.tr>
Date: Mon, 26 Feb 2007 12:44:43 +0100
Message-Id: <1172490283.27370.20.camel@violet>
Mime-Version: 1.0
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

Hi Yunus,

> >> >> I want to write a kernel module and use some bluez commands those
> >> >> included in the kernel. 
> >> >> 
> >> >> I will use it some experimental cases. 
> >> >> 
> >> >> Is it possible to use bluez commands in kernel modules? If so, how can
> I
> >> >> do it?
> >> 
> >> >of course it is possible, but for what strange reason you might wanna
> >> >find yourself writing a kernel module. Explain what you are planning to
> >> >do and I might can give you a more detailed answer. I am not psychic.
> >> 
> >> There is a Project called ULLA (http://ulla.sourceforge.net) and I am
> >> writing a simple bluetooth LLA fot it. ULLA collects link layer
> information
> >> (802.11x, bluetooth, zigbee etc.) to application layer programmes.
> >> 
> >> I will take Bd Addrs and user friendly names fo nearby devices and give
> it
> >> to ULLA Core. 
> >> 
> >> My program will be a kernel module, because I will collect link layer
> >> information. ULLA calls these link layer information collecting modules
> to
> >> Link Provider (LP).
> 
> >the architecture with the kernel module is totally crap. The data
> >collection has to be done in userspace and all these information are
> >provided over D-Bus.
> 
> We talked about this kernel-module problem with you a couple of weeks ago in
> irc #bluez channel. You advice me to work in userspace everytime. My work
> contains only some querying functuonality, for example bd address, user
> friendly name etc. I do not want the whole bluez functuonality in my
> project. I have to do in in kernel-space.

and why does nobody believe me that it is a bad idea to have such stuff
inside the kernel. You have to have the BlueZ userspace part anyway,
because otherwise the adapter is not useful. However feel free to change
the kernel and invent all things again. The D-Bus API actually provides
a prefect interface for your needs. You might wanna run the example
bluetooth-proximity tool to see what I mean. It is only an UI using
D-Bus only.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
