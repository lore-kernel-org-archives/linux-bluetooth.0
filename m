Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 19 Mar 2007 15:34:30 +0100
Message-ID: <6039B3E28F85164B82BBABFD30D98DDE013EC619@vilh303a.ww011.siemens.net>
In-Reply-To: <1174316592.3690.7.camel@aeonflux.holtmann.net>
From: "Koestering, Nina (EXT)" <nina.koestering.ext@siemensvdo.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to set the encryptions key size?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

thanks for the fast answer. 
How can I specify the range of the encryption key size for the CSR chip?
I want to enforce an encryption key of 128 bit and both sides support
the 128-bit encryption.

Best regards
Nina

> -----Original Message-----
> From: bluez-users-bounces@lists.sourceforge.net 
> [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf 
> Of Marcel Holtmann
> Sent: Monday, March 19, 2007 4:03 PM
> To: BlueZ users
> Subject: Re: [Bluez-users] How to set the encryptions key size?
> 
> Hi Nina,
> 
> > is there a way to specify the encryption key size? Is it possible to
> > enforce an encryption with a 128-bit key? I found out that 
> there is a
> > method to get the encryption key size, but I didn't find a 
> way to set
> > the key size.
> 
> the encryption key size can vary between 8-bit and 128-bit. Some chips
> have a limited encryption key size of 56-bit, because of export
> regulations in some country. For example for CSR chips you can use the
> command "hciconfig hci0 revision" as root to check for the maximal
> encryption key size.
> 
> In general the encryption key size is not changeable. However 
> with chips
> from CSR you can specify a range for it. Having a lower encryption key
> size of 40-bit renders most devices useless, because the other side
> won't accept any connection anymore.
> 
> So if your device has a maximum limit of 56-bit, this limit will be
> hardcoded into the firmware in most cases and thus not changeable.
> 
> However the method to read the encryption key size of a piconet is
> vendor specific. The Bluetooth SIG refuses to add a standard 
> HCI command
> for this task.
> 
> Regards
> 
> Marcel
> 
> 
> 
> --------------------------------------------------------------
> -----------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the 
> chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge
> &CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
