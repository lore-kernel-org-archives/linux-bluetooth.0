Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0702180546o4c7a7c58x3028230c1f33878e@mail.gmail.com>
Date: Sun, 18 Feb 2007 15:46:02 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] immediate unsolicited disconnect after hcitool cc
Cc: "Marcel Holtmann" <marcel@holtmann.org>
In-Reply-To: <1171802646.26794.6.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0702180425r2abd39e7q2842ef50e585e67a@mail.gmail.com>
	 <1171802646.26794.6.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

hi Marcel,

On 2/18/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Choi,
>
> > after I do "hcitool cc xx:xx:xx:xx:xx:xx" I have a connection
> > I can see with "hcitool con" but after one or two seconds I can
> > see in hcidump that an HCI disconnect command is sent and
> > the connection is disconnected.
>
> don't use this command for piconet creation. Use higher layer like L2CAP
> and RFCOMM. The kernel will create the needed ACL link for you and take
> fully care of it.

are there command line utilities I can use to test file transfers
(like in OPP or FTP) ?

thank you very very much for the help
choi

>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
