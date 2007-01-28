Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0701281359m320d7914hdcbb1e66fc68dfe8@mail.gmail.com>
Date: Sun, 28 Jan 2007 23:59:38 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] hciattach <--> hcid
In-Reply-To: <1170020887.4630.20.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0701280715x72e4430n5c072dc0067555b8@mail.gmail.com>
	 <1170020887.4630.20.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

hi Marcel,

On 1/28/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > when I do hciattach, i see that hcid automatically add the new device,
> > and when i send -SIGTERM to hciattach, i see that hcid removed the device.
> > how does hcid knows about all these changes ?
> > where is the communication ?
>
> the kernel will tell hcid when a new host adapter has been attached or
> removed from the system.

can you please point me to the code which takes care of that ?

thank you
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
