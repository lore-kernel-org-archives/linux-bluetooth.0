Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d1f423d305032910506488f90@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCIDump Usage
In-Reply-To: <1112121679.9016.105.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <d1f423d305032907072dc78400@mail.gmail.com>
	 <1112109452.9016.71.camel@pegasus>
	 <d1f423d3050329103355c4215a@mail.gmail.com>
	 <1112121679.9016.105.camel@pegasus>
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
Date: Tue, 29 Mar 2005 13:50:57 -0500

Marcel,


I understand. But, does the stack offer me a way to catch data from
the lower layers ? In case that I would like to improve HCIDump with
such capability.


On Tue, 29 Mar 2005 20:41:19 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Anderson,
> 
> > Well, I know that the standard has many error handlers between the
> > layers, but of course error might occurr and I am really insterested
> > to log when they happen. would you suggest a way that i could log them
> 
> the hcidump can't log radio, baseband or link manager layers. It is HCI
> and higher and thus you normally don't see any errors there.
> 
> Regards
> 
> Marcel
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


-- 
Anderson Clayton B. Rodrigues
Eng. de Software
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
