Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 phone & logitech DiNovo keyboard /
	MX900 mouse
From: Laurence Orchard <laurence@orchards.org.uk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1102315314.8510.57.camel@pegasus>
References: <1102035154.4258.14.camel@localhost>
	 <1102042749.7350.33.camel@pegasus>  <1102291223.4219.3.camel@localhost>
	 <1102315314.8510.57.camel@pegasus>
Content-Type: text/plain
Message-Id: <1102639996.4112.10.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 10 Dec 2004 00:53:15 +0000

On Mon, 2004-12-06 at 07:41 +0100, Marcel Holtmann wrote:
> Hi Laurence,
> 
> > I have now upgraded to Fedora Core 3
> > kernel-2.6.9-1.667
> > bluez-bluefw-1.0-6
> > bluez-hcidump-1.11-1
> > bluez-utils-2.10-2
> > bluez-libs-2.10-2
> > bluez-libs-devel-2.10-2
> > 
> > the problem more or less is the same, start Bluetooth, keyboard & mouse
> > stop working.
> > 
> > Same question as before, how do I set it up so the system will recognise
> > my phone, keyboard & mouse.
> 
> make sure that "hidd --server" is started somewhere in the boot script.
> 
> Regards
> 
> Marcel
> 

Yes hidd --server --search

run at boot S26hidd in rc5.d
after S25bluetooth

still the same problem, debugging is very difficult without a mouse or
keyboard. Can't query system, all I can do is press the reset button!

laurence
-- 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
