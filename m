Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 13:26:37 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 15/16] android: Implement basic HAL server
Message-ID: <20130930102636.GI10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAJdJm_PMy6pb-NnCc5fKc11ATUwKbSd71HMAWueWkxP_x4Ym=A@mail.gmail.com>
 <20130930082507.GF10262@aemeltch-MOBL1>
 <9C20AE4B-57C8-48A8-AE2B-80CE7E334C7D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9C20AE4B-57C8-48A8-AE2B-80CE7E334C7D@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Sep 30, 2013 at 10:33:54AM +0200, Marcel Holtmann wrote:
> >>> +       /* Since daemon would be run also on host we have to grant perms */
> >>> +       chmod(sock_path, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH |
> >>> +                                                               S_IWOTH);
> >> 
> >> If it is really necessary to have a world writable socket, better
> >> explain in detail on the comment.
> > 
> > the problem here is that we need to run this on a host and on Android
> > where HAL is running under user bluetooth, this has to be changed to use
> > ifdef logic.
> 
> and why are we not starting the daemon as user bluetooth with proper capabilities.

there is an option capability in init.rc
http://androidxref.com/4.3_r2.1/xref/system/core/init/init_parser.c#84

but it does nothing:
http://androidxref.com/4.3_r2.1/xref/system/core/init/init_parser.c#659

at least in Android 4.3

So we run as root and then drop uid and guid. Can we use some better way?

Best regards 
Andrei Emeltchenko 
