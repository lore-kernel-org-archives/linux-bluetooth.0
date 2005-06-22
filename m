Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Andrew Jones" <andrewjones@acselection.co.uk>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw
Message-ID: <006201c57729$e33234d0$3202010a@acselection.local>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
In-Reply-To: <1119442492.26772.162.camel@pegasus>
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
Date: Wed, 22 Jun 2005 13:57:03 +0100

Marcel,
I have posted my issue to both the Ubuntu forum and to Bluez. I can't
see anything on that page about either the hotplug or firmware.agent,
can you point me in the right direction for these? All I think I need is
the location bt3c_cs looks for the firmware on Ubuntu??
Thanks for your help on this and thankyou for your time developing this
module.
Andy

Andrew Jones
AC Selection 
01905 732 772
www.acselection.co.uk


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: 22 June 2005 13:15
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw


Hi Andy,
> 
> I am writing to enquire about an issue I'm having, it is as follows. I

> have a Sony Vaio Laptop (VGN-B1XP) with Ubuntu Linux installed
> (2.6.10-5-386) and a 3Com Bluetooth Card (3CRWB6096), I have installed

> all of the bluez utilities and unzipped the firmware file from 3Com 
> (BT3CPCC.bin), when i insert the card i get the following error is
> dmesg:
>  
> bt3c_open: Firmware request failed
> bt3c_interrupt: Call if irq 3 for unknown device
>  
> And in syslog:
>  
> kernel: cs: pcmcia_socket: unable to supply power
> cardmgr[6912]: socket 0: 3Com Bluetooth PC Card
> cardmgr[6912]: executing: 'modprobe bt3c_cs'
> kernel: bt3c_open: Firmware request failed
> kernel: bt3c_interrupt: Call if irq 3 for unknown device
> cardmgr[6912]: get dev info on socket 0 failed: Resource temporarily
> unavailable
>  
> It seems to me that the issue is that bt3c_cs cannot find the firmware

> file, although i have tried everywhere noted on the net. I have also 
> tried changing the reference in bt3c_cs from BT3CPCC.bin to 
> /T3CPCC.bin and dropping that file in the system root.
>  
> I think its looking (for the firmare) somewhere specific to Ubuntu but

> i can't find where.

check out http://www.bluez.org/drivers.html and make sure that you
installed the hotplug package and that firmware.agent is present.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


--------------------------------------------------------------------------------------------
This message contains confidential information and is intended only for the individual named.
If you are not the named addressee you should not disseminate, distribute or copy this e-mail.
Please notify the sender immediately by e-mail if you have received this e-mail by mistake and
delete this e-mail from your system. E-Mail transmission cannot be guaranteed to be secure or
error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or 
incomplete, or contain viruses. The sender therefore does not accept liability for any errors
or omissions in the contents of this message, which arise as a result of e-mail transmission.
If verification is required please request a hard-copy version.
AC Selection Ltd. The Avenue, The Cross, Worcester, WR1 3QA. www.acselection.co.uk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
