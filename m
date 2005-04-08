Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b5c638dc0504080556b2c1814@mail.gmail.com>
From: David Vitrant <prussia@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Configure PCMCIA Zoom Bluetooth
In-Reply-To: <BAY23-F23D512AD8D1EEE18AAD8EFB13F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1112896238.7898.52.camel@justakiss>
	 <BAY23-F23D512AD8D1EEE18AAD8EFB13F0@phx.gbl>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 8 Apr 2005 08:56:43 -0400

hi.. well the way i did it.. was to make an init script like like in
my previous email (except you might want to remove that last line)

then put it in /etc/init.d 

finally go into /etc/rc5.d and put a symlink to your script 

you should probably start with S99 (make sure the name isn't the same
as something htere).. and make sure it's after loading of bluetooth..

hope that helps.

dGV

On Apr 8, 2005 5:52 AM, Cesar Diaz <skagerrad@hotmail.com> wrote:
> With the device bcsp and the standard ubuntu packages work fine.
> 
> but now i have another problem when reboot the machine i must write manually
> it to work again
> 
> how i can automatize the load of module in the init
> 
> many thanks by the help
> 
> >From: Erwin Authried <eauth@softsys.co.at>
> >Reply-To: bluez-users@lists.sourceforge.net
> >To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
> >Subject: Re: [Bluez-users] Configure PCMCIA Zoom Bluetooth
> >Date: Thu, 07 Apr 2005 19:50:38 +0200
> >
> >Am Don, den 07.04.2005 schrieb Cesar Diaz um 19:38:
> > > Sorry but i write it correctly in my computer and the bluez-utils are
> >the
> > > last from ubuntu repositories
> > > and continue with the same error "unkwon type or id"
> > >
> >you should try
> >   hciattach <dev> bcsp
> >
> >if "zoom" isn't available.
> >
> >Regards,
> >Erwin
> >
> >
> >
> >
> >-------------------------------------------------------
> >SF email is sponsored by - The IT Product Guide
> >Read honest & candid reviews on hundreds of IT Products from real users.
> >Discover which products truly live up to the hype. Start reading now.
> >http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> >_______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
