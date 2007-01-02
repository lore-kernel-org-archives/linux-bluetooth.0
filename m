Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 2 Jan 2007 08:18:13 -0200
From: Cris <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20070102081813.6a264b0e.ml133@netpole.com.br>
In-Reply-To: <57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in making multiple connections using
 single bluetooth adapter using bluez
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

On Tue, 2 Jan 2007 13:46:08 +0530
"siddhant tewari" <siddhant.tewari@gmail.com> wrote:

> hi,
>    Honest thanks to u for ur reply. Just a small question:
>     what i am trying is technically possible???
>     I dont have any problem in sending the code but it would be great pain
> for others to understand my code and some effort for me as well in making it
> more understandable for others.

Hi Siddhant,

If the question, whether it is technically possible, refers to the
specifications of bluetooth, the answer is yes. Being a master (i.e.,
the device initiating the connections) you can connect to up to 7
other different bluetooth devices. But if the question refers to
BlueZ, I can't tell you for sure. A few months ago I tested this and
it failed not too gracefully. This is one of the reasons why I don't
use libbluetooth anymore.

However, there is a simple way to test it. Obex push and obex ftp are
different profiles, but technically they use exactly the same methods
(hci, l2cap, rfcomm, obex). Thus if one works, the other will work as
well and vice verse. But the usage of obex ftp is much easier. Obex
ftp uses BlueZ to set up a connection the `BlueZ' way. If you prepare
two sessions of obex ftp to different peers but with the same file,
and launch them as fast as you can at the same time, they must arrive
approximately at the time. Just make sure that the peers have similar
hardware and transmission conditions. In any case, obexftp does show
you activity, which must be visible for both at the same time. If one
is waiting until the other is done, you've still got the original, sad
blues behaviour. As there is no bit of code you wrote to do so, there
is also no bit of a chance that you committed any error. So, there is
no need to publish your code.

I'd be curious to know the result.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
