Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0701271830p6f171d9cu892458220baa9362@mail.gmail.com>
Date: Sat, 27 Jan 2007 21:30:34 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750701250229u61cbb820v929b8d0ad6ae3fb9@mail.gmail.com>
MIME-Version: 1.0
References: <80236d750701250229u61cbb820v929b8d0ad6ae3fb9@mail.gmail.com>
Subject: Re: [Bluez-users] multithread / multi process use
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

I think the proper thing to do here is to have your application use
the D-Bus API, which should do the right thing across multiple
processes.  Maybe someone else who's more in touch with hcid can give
more details.

-albert

On 1/25/07, Emanuele Novelli <ema.novelli@gmail.com> wrote:
> Hello I'm new here, I searched for this issue but found nothing.
>
> Using 2 threads or 2 process for reading a name of a 2 remote devices at
> same time reports always the same name.
> Is this a bug or the hci functions in library do not support concurrent use
> ?
> (using 2.6.19 kernel on FC6 and bluez libs 3.7.1)
>
> This is a simply way to reproduce this:
>
> open a 2 shells and issue 2 commands at same time
>
> hcitool name <bdaddress of a device close to you>
>
> they both report the same name
>
> here an HCI dump of what's happening
>
> 2007-01-25 11:15:06.093319 < HCI Command: Remote Name Request (0x01|0x0019)
> plen 10
>     bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
> 2007-01-25 11:15:06.114456 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> 2007-01-25 11:15:06.712794 < HCI Command: Remote Name Request (0x01|0x0019)
> plen 10
>     bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
> 2007-01-25 11:15:06.717442 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
> 2007-01-25 11:15:07.238429 > HCI Event: Remote Name Req Complete (0x07) plen
> 255
>     status 0x00 bdaddr 00:0A:28:DF:2B:D8 name 'Seleso'
> 2007-01-25 11:15:07.239434 > HCI Event: Command Status (0x0f) plen 4
>     Unknown (0x00|0x0000) status 0x00 ncmd 1
> 2007-01-25 11:15:10.151342 > HCI Event: Remote Name Req Complete (0x07) plen
> 255
>     status 0x00 bdaddr 00:17:4B:D3:9F:5B name 'Wince'
>
> the second event with the second name is tracked but never reported back to
> the caller cause the unknown event received.
> so i see the name 'Seleso' as result on both the shells
>
> this is the behaviour if I use the 2 command sequentially they works fine.
>
> hcitool name 00:0A:28:DF:2B:D8
>
> 2007-01-25 11:19:51.930394 < HCI Command: Remote Name Request (0x01|0x0019)
> plen 10
>     bdaddr 00:0A:28:DF:2B:D8 mode 2 clkoffset 0x0000
> 2007-01-25 11:19:51.951520 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> 2007-01-25 11:19:52.199514 > HCI Event: Remote Name Req Complete (0x07) plen
> 255
>     status 0x00 bdaddr 00:0A:28:DF:2B:D8 name 'Seleso'
>
> hcitool name 00:17:4B:D3:9F:5B
>
> 2007-01-25 11:20:39.520967 < HCI Command: Remote Name Request (0x01|0x0019)
> plen 10
>     bdaddr 00:17:4B:D3:9F:5B mode 2 clkoffset 0x0000
> 2007-01-25 11:20:39.542195 > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> 2007-01-25 11:20:43.358090 > HCI Event: Remote Name Req Complete (0x07) plen
> 255
>     status 0x00 bdaddr 00:17:4B:D3:9F:5B name 'Wince'
>
>
>
>
> Since I need to use search names and search services (FAX especially) on a
> multi-threaded application i'd like to know if is this possible or somewhere
> there is a issue that prevent this.
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
