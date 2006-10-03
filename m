Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45226231.6080203@palmsource.com>
Date: Tue, 03 Oct 2006 15:14:25 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <9cc82a4d0610020710q17efb8efk99079c5f943ddaf8@mail.gmail.com>	<4521D073.1030105@xmission.com>
	<45221882.3020809@palmsource.com>
	<9cc82a4d0610030425g3c078f62o77fd4d29318c4bee@mail.gmail.com>
In-Reply-To: <9cc82a4d0610030425g3c078f62o77fd4d29318c4bee@mail.gmail.com>
Subject: Re: [Bluez-devel] Bluez article on OReillyNet
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


>> You won't get it working on serial device slower than 460800 bauds ie
>> COM ports. However, arm machines may have a serial port that can reach
>> that speed. Maybe sbc settings can be tweeked to use less bandwith but
>> this also depends on headset.
>>     =

>
> I'll use one of the dreaded HP headsets (OEM by logitech). Could I get
> it working at 230400 ?
>
>   =

You will hear something but this is not  usable. 460800 is the least I =

got a good result with.
Use stty -F /dev/ttyS0 460800 to see if your serial can be set at high =

speed. It should display an error if the speed is not supported.
You will have good result with USB devices that do not need the =

hciattach commands. They are really cheap and easy to find.

Fr=E9d=E9ric.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
