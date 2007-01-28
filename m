Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0701271815qeb952b8l778b4ad5eee9460@mail.gmail.com>
Date: Sat, 27 Jan 2007 21:15:56 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9555d9ef0701271011x1be2b3a6l15642142312d971d@mail.gmail.com>
MIME-Version: 1.0
References: <9555d9ef0701271011x1be2b3a6l15642142312d971d@mail.gmail.com>
Subject: Re: [Bluez-devel] fedora core 6 and bluez
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

sudo yum install bluez-devel


On 1/27/07, yunus =F6zen <saltukbugrahan@gmail.com> wrote:
> Hi all,
>
> I have a fedora core 6 installed laptop. My "uname -r" output is
> here :"2.6.18-1.2798.fc6".
>
> I have tried to write some program with these includes :
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
>
> When I try to compile it by gcc I see these error messages :
> bluez01.c:5:33: error: bluetooth/bluetooth.h: No such file or directory
> bluez01.c:6:27: error: bluetooth/hci.h: No such file or directory
> bluez01.c:7:31: error: bluetooth/hci_lib.h: No such file or directory
>
> What can I do now?
>
> Thanks,
> Saltuk.
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>

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
