Return-Path: <bluez-users-admin@lists.sourceforge.net>
In-Reply-To: <1102495339.9988.31.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] remove pairing with device?
MIME-Version: 1.0
Message-ID: <OF4C259331.38DF59B1-ONC1256F64.00304800-C1256F64.00308C40@isbac.com>
From: Marius Schaefer/Camberg/ISBAC <Marius.Schaefer@ISBAC.COM>
Content-Type: text/plain; charset="US-ASCII"
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
Date: Wed, 8 Dec 2004 09:50:16 +0100

Hi Marcel,

> Hi Marius,
> 
> > I've gotten BlueZ and OpenObex to work, so I can send files from my 
phone 
> > to my linux box. I read the pin from /etc/bluetooth/pin. 
> > That works very well. But once the phone is paired with Bluez, I can 
> > change the pin of BlueZ, but the phone stays paired and won't ever ask 
for 
> > the new pin. When I delete the pairing on the phone, it will ask for 
the 
> > new pin, I need to delete the pairing on the BlueZ side. Is that 
possible?
> 
> the link keys are stored in binary form in /etc/bluetooth/link_key. Look
> at the mailing list archive for details about that. There has been a
> thread lately.
> 
That was exactly what I was looking for, many thanks!

Marius



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
