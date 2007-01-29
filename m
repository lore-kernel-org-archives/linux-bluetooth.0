Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0701290157h3ac80220t801fffccdc2b8a8c@mail.gmail.com>
Date: Mon, 29 Jan 2007 11:57:00 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] loading of hci_uart.ko
In-Reply-To: <1169235297.29458.19.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0701191104h376e9e89mca6769544b257e29@mail.gmail.com>
	 <1169235297.29458.19.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On 1/19/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > when I do "hciattach /dev/ttyS0 any", somehow the needed module
> > hci_uart.ko is loaded.
> > I looked in hciattach.c but I do not see how is it done ?
>
> # modinfo hci_uart
> alias:          tty-ldisc-15
>
> It tells the kernel to load this module if any application request the
> line discipline 15.

can you please elaborate on this ? when the app request the HCI line
discipline, how does the kernel knows it need to look for alias tty-ldisc-15 ?
does it then run modprobe ?
what code is responsible for that ?

thank you very much for the help
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
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
