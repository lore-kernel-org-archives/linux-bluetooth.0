Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4f436aae0701020935t5131fb47t98a393342a5f612a@mail.gmail.com>
Date: Tue, 2 Jan 2007 19:35:41 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: "Kelvin Xu" <kyoxu@hotmail.com>,
        "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY117-F130D6B6CDAE201DCE7DEC0BFBA0@phx.gbl>
MIME-Version: 1.0
References: <4f436aae0701020922t3c792ab6k418dce30c32a7ea0@mail.gmail.com>
	<BAY117-F130D6B6CDAE201DCE7DEC0BFBA0@phx.gbl>
Subject: Re: [Bluez-devel] Embedded Bluez Startup
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

On 1/2/07, Kelvin Xu <kyoxu@hotmail.com> wrote:
> HI,
>
> Can you elaborate a little on what you mean?
> Do you mean 2.6.19 cannot be used with Bluetooth? Do you have the link to
> the patch?
Hi, please don't top-post.

the bug has nothing directly to do with BT.

It "just" corrupt files here and there (not so often btw).

the fix by linus is here:
http://lwn.net/Articles/215870/

Choi.




>
> Regards,
> Kelvin
>
>
> >From: "Choi Sonim" <choisonim@gmail.com>
> >To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
> >kyoxu@hotmail.com
> >Subject: Re: [Bluez-devel] Embedded Bluez Startup
> >Date: Tue, 2 Jan 2007 19:22:01 +0200
> >
> >Kelvin,
> >
> >On 1/2/07, Kelvin Xu <kyoxu@hotmail.com> wrote:
> >>Dear all,
> >>
> >>I just managed to installed both bluez-lib and bluez-Util to my ARM
> >>target.
> >>However, i just realise that there is the program "hciconfig" is not
> >>available thus i am unable to get my usb bluetooth dongle up. I have
> >>installed the Linux-2.6.19 kernel with the Bluetooth Subsystem Built in
> >><*>
> >
> >kernel 2.6.19 has awaken a nasty fs corruption bug.
> >
> >don't use it (there is a patch though if you want).
> >
> >Choi.
>
> _________________________________________________________________
> Get MSN Messenger emoticons and display pictures here!
> http://ilovemessenger.msn.com/?mkt=en-sg
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
