Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 2 Jan 2007 11:20:01 -0200
From: Cris <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20070102112001.2cae3a8d.ml133@netpole.com.br>
In-Reply-To: <57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
	<20070102081813.6a264b0e.ml133@netpole.com.br>
	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
	<20070102094414.f7b9cef1.ml133@netpole.com.br>
	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
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

On Tue, 2 Jan 2007 18:16:28 +0530
"siddhant tewari" <siddhant.tewari@gmail.com> wrote:

>     With linux being one of the major players in embedded domain and bluez
> being an official protocol of linux there is definitely a great need for
> multi connection support. You have suggested that somebody with a thorough
> understanding of bluetooth and its protocol should start to fork the full
> development of bluetooth support in linux , but that somebody cannot be at
> least me at this instance as i am just a starter and it took some effort
> from my side to even get the idea of what u wrote ... i think it should be
> someone like you who has such a clear picture of the problem or to be more
> precise really understands the problem well , who can initiate such
> development... all i can say is that i am ready to work if somebody  can
> guide me ....

I'd love to start a fork and am thinking about it since a long time
and each time I crash on BlueZ. Unfortunately, I lack the fundings to
do so, as this is certainly not a job for a weekend.

> Please tell me what are the other options parallel to bluez and is it really
> advisable to  use them .
> 
> I am stuck at this problem and i dont like leaving it as such.

As I told you, there is no other way. If there was, I wouldn't have
started a complete user-space bluetooth stack spending already many
months on that. And unfortunately, I'm not allowed to share my code so
far (I wish I was).

Well, besides the two options (giving up or doing it yourself), there
might be a third one: It seems that they are working now on flow
control which is quite related to multi-connections. At least it
should. Meaning: you can wait until they think it's somehow useable
and try then. But you'll always be stuck on a fundamentally broken
design and depend on the help of a not so benevolent dictator. And I
wouldn't expect to see mainstream kernels with this code before mid
2007. If you watch out for what is said about bluetooth, we can expect
a significant increase in complexity regarding implementations. At
latest then, BlueZ will have to change anyway. Maybe then, you'll be
able to use it. This may take a couple of years.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
