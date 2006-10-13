Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452FDC44.90803@vasmac.com>
Date: Fri, 13 Oct 2006 14:34:44 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr> <452E99E8.6070406@vasmac.com>
	<452FBC82.1080901@free.fr>
In-Reply-To: <452FBC82.1080901@free.fr>
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fabien Chevalier wrote:
> Hello Jose,
>
>   
>> Hi, Fabien,
>>
>> I'll take a look at your patch. I've been working on one myself.
>> As I mentioned earlier, I've taken a different approach that works
>> well. I use the standard HCI synchronous flow control. Now since
>> USB dongles don't generate this, I have the hci_usb_tx_complete
>> generate a HCI_EV_NUM_COMP_PKTS for transfer. Then the existing
>> system works fine. No timers are necessary. Only a small change
>> to hci_sched_sco in hci_core.c was necessary.
>>     
>
> Yes this will work. The only issue i see with this approach is that it
> is hci USB centric. This works with USB because there is a dedicated USB
> channel to send SCO packets, and the bandwidth of this channel is
> precisely the one of the SCO stream. So when the USB controller
> acknowledges the transmitted packet, you know you can precisely send the
> next one, which is great. :-)
>
> Now, for RS232 hci devices, there is only one physical channel, the
> RS232 link, which is shared for SCO/ACL/CMD packets. The bandwidth is
> typically as high as 921 kbit/s. This means when the R232 controller
> acknowledges the SCO packet, you have to wait a bit to send the next SCO
> packet, and thus rely a way or another on a timer. It's too bad, but i
> see no other way for now :-(
>
> Thus, if we take into account the fact completed packets events are not
> send by bt controllers, and that the flow control stuff should work
> whatever controller driver is, it think we have to rely on timers ;-)
>
>   
Hi Fabien,

So your issue is supporting synchronous channels on the UART
interface. I think it's best to enable synchronous flow control.
and have the hci_uart manage the transmit queue to minimize delay.
This means that hci_uart can peek at the HCI_EV_NUM_COMP_PKTS
received to determine if another synchronous packet needs
to be sent.

Regards,

Jose

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
