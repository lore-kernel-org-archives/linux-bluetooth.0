Return-Path: <vonzoltan@yahoo.it>
Message-ID: <20041022151332.19433.qmail@web40624.mail.yahoo.com>
Date: Fri, 22 Oct 2004 17:13:32 +0200 (CEST)
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: Re: [Bluez-users] [ECONNRESET]Problem with last buffer readed with a read or recv
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098443254.4704.42.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

 --- Marcel Holtmann <marcel@holtmann.org> ha scritto:

> Hi Andrea,
...
> the line "addr.rc_channel = htobs(10);" is wrong,
> because rc_channel is
> only a uint8_t and so you don't need any byte
> swapping magic. Remove the
> call to htobs() and simply set the channel number.
> 
> On the server side you forgot to init clientAddrLen
> before you called
> accept(). Do a "clientAddrLen = sizeof(clientAddr);"
> first.

Thanks for the hint i haven't looked at this
particular..i didn't know. 

> 
> for me this looks ok, because you close the
> connection from the server
> side and recv returns with an error. Does it makes
> any difference when
> you use read/write instead of recv/send?

Yes also using read/write i get the same behaviour

> For this behaviour you must send me a kernel patch
> that implements this,
> but I will only accept it if you change the L2CAP in
> the same way.

For the moment i think i'm not a kernel hacker :-( 

> Regards
> 
> Marcel

Thanks Marcel for the time spent
 Best regards
  Andrea S.


		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it
