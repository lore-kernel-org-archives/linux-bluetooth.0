Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Handling a Hardware Error event on iPAQ h5550
In-Reply-To: <Pine.GSO.4.33.0503171103450.12042-100000@horus.imag.fr>
Message-ID: <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Mar 2005 11:56:36 +0100 (CET)


Hi Catalin,

I'm not that familiar with the architecture of BlueZ but with the
experiences for our own stack I can tell you this is not trivial. The main
problem here is that the Bluetooth Stack is not stateless. One possible
solution is to feed the reset done event to the higher layers (l2cap). But
than L2cap must be modified to correctly shut down all connections. It
would be easier if the HCI layer tracks the state of all ACL and SCO
connections (Marcel ??). Than a reset done event can be handled like a
unexpected link loss on all active connections and the higher layers do
not need any modifications (hopefully).

Anyway, I'm pretty sure there is no way to solve this with a simple hack.

It may be much simpler trying to find the cause of the data corruption.
Do you have hardware handshake enabled ??
Have you tried different baud rates ??
Do you get any errors from the UART driver (like FiFo overruns) ??
Have you tried to modify the UART FiFo settings ??

Good luck,

Peter

On Thu, 17 Mar 2005, Catalin Drula wrote:

> Hi,
>
> I was trying to debug the Bluetooth subsystem on an HP iPAQ h5550 running
> Linux:
>
> root@h3900:~# hciconfig -a
> hci0:   Type: UART
>         BD Address: 08:00:17:1A:EB:76 ACL MTU: 339:4 SCO MTU: 60:9
>         UP RUNNING PSCAN ISCAN
>         RX bytes:-2117082264 acl:19904935 sco:0 events:4940395 errors:0
>         TX bytes:386017560 acl:9879838 sco:0 commands:430 errors:0
>         Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'POCKET_PC'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
>         Manufacturer: RTX Telecom A/S (21)
>
> The problem I am facing on this machine is that it seems that the UART
> communication is sometimes unreliable. What happens is that while sending
> data, there sometimes seems to be corruption between the host and the
> controller. For example, doing an l2test where the iPAQ is sending to a
> PC, every once in a while on the receiving side there are data or sequence
> or size mismatches. After a while, the corrupted bytes happen to be in the
> H4 header, and the controller assumes it has lost synchronization with the
> host, thus sending a "Hardware Error" event. It then expects a "Reset"
> command to resynchronize.
>
> Since a lot of digging has not found the root cause of these errors in the
> UART communication, I wanted to hack the Bluez stack to better handle when
> these loss of synchronization events occur (I am not refering to patching
> the main Bluez stack, but rather make a hack for our own purposes here,
> and perhaps share it with other iPAQ h5550 users).
>
> It is easy enough to add the sending of a "Reset" command after a
> "Hardware Error" event is received, but I get the impression that there's
> more needed, such as tearing down the established connections somehow. The
> point is to get a "clean" stack to start with after such an event (and of
> course, propagate the error up the stack so that the application gets a
> "broken connection"). Any advice on how hard it is to do that, and what
> needs to be done?
>
> Currently, what happens is that after sending "Reset", we resynchronize
> with the controller, but the previous connections still show:
>
> root@h3900:~# hcitool con
> Connections:
>         < ACL 00:10:DC:57:C9:79 handle 1 state 8 lm MASTER
>         > ACL 08:00:17:1A:E6:02 handle 2 state 8 lm SLAVE
>
> Thanks in advance for your help,
>
> Catalin
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
