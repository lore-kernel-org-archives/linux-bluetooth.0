Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9cc82a4d0610030619qbc160fdqe983cb529e5f8c02@mail.gmail.com>
Date: Tue, 3 Oct 2006 13:19:55 +0000
From: "Guylhem Aznar" <bluez-devel@externe.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45226231.6080203@palmsource.com>
MIME-Version: 1.0
References: <9cc82a4d0610020710q17efb8efk99079c5f943ddaf8@mail.gmail.com>
	<4521D073.1030105@xmission.com> <45221882.3020809@palmsource.com>
	<9cc82a4d0610030425g3c078f62o77fd4d29318c4bee@mail.gmail.com>
	<45226231.6080203@palmsource.com>
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

Hello

On 10/3/06, Fr=E9d=E9ric DALLEAU <frederic.dalleau@palmsource.com> wrote:
> Use stty -F /dev/ttyS0 460800 to see if your serial can be set at high
> speed. It should display an error if the speed is not supported.
> You will have good result with USB devices that do not need the
> hciattach commands. They are really cheap and easy to find.

Unfortunately, the ARM machines I have only have serial ports ....

I will try to have them chips on HWUART which should not have speed problem=
s.

Guylhem

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
