Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <a3b1b800606180216r729c9e1fq91f67249b916d968@mail.gmail.com>
Date: Sun, 18 Jun 2006 11:16:55 +0200
From: "Jan Benes" <jbenes@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150540024.17539.20.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <e85851c20606132201w49ef3b8cm621062753b1ea490@mail.gmail.com>
	<1150540024.17539.20.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] how to get service name and how to connect
	through it
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

Hi Marcel and Gloria,
gloria, try also googling for "albert huang bluetooth" he's got some
useful stuff in his thesis.

marcel: i've already written that but I must reiterate that the main
reason people keep asking is that there's quite a big lack of
documentation. Even if you just want to write a small utility, you
have to study quite a lot of source code. Seems to me like some kind
of sport or what under linux (I'm more of a Windows guy). Or that's my
point of view at least. I know you try, to me writing a BlueZ app
seemed much like building a new car from parts where my only reference
is an already completed car. You can peak inside, see how they did it,
but in the end, you have to do a lot of tweaking and trying of
different combinations to make it work. And for example, I never got
an answer to why the HCI scanning routine (and the hctitool utility =>
BlueZ) ignores my timeout value...also, there's lots of error codes
and nobody tells me what went wrong or why.

On 6/17/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Gloria,
>
> stop cross posting. There is no need for it at all. Pick one mailing
> list.
>
> And don't include personal email addresses. You either get your answers
> on the mailing or you don't.
>
> Read this document first before you post the next time:
>
> http://www.catb.org/~esr/faqs/smart-questions.html
>
> > i want to try to write some scratch code about how to get service name
> > from a certain phone (i.e xx:xx:xx:xx:xx:xx) and how to connect
> > through it? what function should i use?
>
> Check the source code of hcitool, sdptool and rfcomm.
>
> Regards
>
> Marcel
>
>
>
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
