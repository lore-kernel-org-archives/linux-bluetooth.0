Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IAGD85$6F34A3FACB355ACDE301BD8A9AF51428@libero.it>
Subject: Re: [Bluez-users] Piconet problems
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "jers@inwind.it" <jers@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
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
Date: Mon, 17 Jan 2005 09:36:05 +0100

> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subv=
er: 0x175  
> >         Manufacturer: Cambridge Silicon Radio (10)  
> =
 
> the 0x175 firmwares are not HCI 16.4 and thus don't support scattern=
et 
> and are difficult to connect. 
>   
> > > > After that, I tried =
to create the second connection on slave2 side by running the same comman=
d (hcitool cc  
> > <master_addr>) and I obtain the following error:  =0D
=
> > > > # Can't create connectio: input/output error.  
> > >   
> > > =
Run "hcidump -x" as root and show us the output.  
> >   
> > HCIDump -=
 HCI packet analyzer ver 1.16  
> > device: hci0 snap_len: 1028 filter: =
0xffffffff  
>  
> What about trying to connect now, so we see traffic?=
 
  
Running 'pan -c <addr>' or 'pan --listen --rule GN',  HCIDump does=
 not show anything. 
 
If I run hcitool cc <addr>, it shows me 
 
< H=
CI Command: Create Connection (0x01|0x0005) plen 13 
  64 A1 85 98 E0 00=
 18 CC 02 00 00 00 01 
> HCI Event: Command Status (0x0f) plen 4 
  00 =
01 05 04 
> HCI Event: Connect Complete (0x03) plen 11 
  00 28 00 64 A=
1 85 98 E0 00 01 00 
> HCI Event: Page Scan Repetition Mode Change (0x20=
) plen 7 
  64 A1 85 98 E0 00 01 
> HCI Event: Max Slots Change (0x1b) =
plen 3 
  28 00 05 
 
Regards. Jers =0A=0A=0A=0A______________________=
______________________________________=0ALibero ADSL: 3 mesi gratis e nav=
ighi a 1.2 Mega. E poi hai l'Adsl senza limiti a meno di 1 euro al giorno=
. =0AAbbonati subito senza costi di attivazione su http://www.libero.it=0A=
=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
