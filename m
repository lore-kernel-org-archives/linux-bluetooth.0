Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 phone & logitech DiNovo keyboard /
	MX900 mouse
From: Laurence Orchard <laurence@orchards.org.uk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1102666379.11207.2.camel@pegasus>
References: <1102035154.4258.14.camel@localhost>
	 <1102042749.7350.33.camel@pegasus>  <1102291223.4219.3.camel@localhost>
	 <1102315314.8510.57.camel@pegasus>  <1102639996.4112.10.camel@localhost>
	 <1102666379.11207.2.camel@pegasus>
Content-Type: text/plain
Message-Id: <1102727487.6653.6.camel@localhost>
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
Date: Sat, 11 Dec 2004 01:11:27 +0000

On Fri, 2004-12-10 at 09:12 +0100, Marcel Holtmann wrote:
> Hi Laurence,
> 
> > Yes hidd --server --search
> 
> no, only "hidd --server". The search option is only for the first
> connection.
> 
> > run at boot S26hidd in rc5.d
> > after S25bluetooth
> 
> There is a nice init script in bluez-utils that does this all for you
> and with Fedore Core 3 this should be all in place and you only need to
> activate it somewhere. Maybe /etc/default/ or so.
> 
I 
 I took out the --server option,but it still isn't working.
it displays the following message during boot:-
'Can't open RFCOMM console socket: address family not supported by
protocol'

looking back through /var/log/messages I found the following error
messages:- 

Dec 10 23:49:04 localhost rpcidmapd: rpc.idmapd startup succeeded
Dec 10 23:49:04 localhost hcid[2497]: Bluetooth HCI daemon
Dec 10 23:49:04 localhost hcid[2497]: Can't open HCI socket. Address
family not supported by protocol(97)
Dec 10 23:49:04 localhost bluetooth: hcid startup succeeded
Dec 10 23:49:04 localhost sdpd[2503]: init_server: opening L2CAP socket:
Address family not supported by protocol
Dec 10 23:49:04 localhost sdpd[2503]: main: Server initialization failed
Dec 10 23:49:04 localhost bluetooth: sdpd startup succeeded
Dec 10 23:49:05 localhost kernel: usb 1-1.2: new full speed USB device
using address 5

then a little later:-

Dec 10 23:49:06 localhost kernel: Bluetooth: Core ver 2.6
Dec 10 23:49:06 localhost kernel: NET: Registered protocol family 31
Dec 10 23:49:06 localhost kernel: Bluetooth: HCI device and connection
manager initialized
Dec 10 23:49:06 localhost kernel: Bluetooth: HCI socket layer
initialized
Dec 10 23:49:08 localhost kernel: Bluetooth: HCI USB driver ver 2.7
Dec 10 23:49:08 localhost kernel: usbcore: registered new driver hci_usb


any ideas?

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
