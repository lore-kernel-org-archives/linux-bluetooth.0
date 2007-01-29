Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0701290242u18e4c35bocac8a8e9afeaa7b0@mail.gmail.com>
Date: Mon, 29 Jan 2007 12:42:09 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] loading of hci_uart.ko
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1170065145.15389.117.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0701191104h376e9e89mca6769544b257e29@mail.gmail.com>
	 <1169235297.29458.19.camel@violet>
	 <4f436aae0701290157h3ac80220t801fffccdc2b8a8c@mail.gmail.com>
	 <1170065145.15389.117.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

On 1/29/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Choi,
>
> > > > when I do "hciattach /dev/ttyS0 any", somehow the needed module
> > > > hci_uart.ko is loaded.
> > > > I looked in hciattach.c but I do not see how is it done ?
> > >
> > > # modinfo hci_uart
> > > alias:          tty-ldisc-15
> > >
> > > It tells the kernel to load this module if any application request the
> > > line discipline 15.
> >
> > can you please elaborate on this ? when the app request the HCI line
> > discipline, how does the kernel knows it need to look for alias tty-ldisc-15 ?
> > does it then run modprobe ?
> > what code is responsible for that ?
>
> the kernel actually doesn't care what's the module name of module
> providing the line discipline 15. It simply requests the loading of the
> module and the userspace (insmod/modprobe) has to resolve this.

thank you very much
choi

>
> Regards
>
> Marcel
>
>
>
