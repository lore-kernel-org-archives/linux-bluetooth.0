Return-Path: <cyrus@holtmann.org>
Message-ID: <483F3DE8.5040807@magtech.com.au>
Date: Fri, 30 May 2008 09:36:08 +1000
From: Aras Vaichas <arasv@magtech.com.au>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
	<a481fbf0805290401g57804562h34ef5147852256c9@mail.gmail.com>
In-Reply-To: <a481fbf0805290401g57804562h34ef5147852256c9@mail.gmail.com>
Subject: Re: [Bluez-users] DUND pre-pppd script
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Raymond Ingles wrote:
> On Wed, May 28, 2008 at 11:04 PM,  <arasv@magtech.com.au> wrote:
>   
>> Hi,
>>
>> I need to determine my ppp IP address pair before I run pppd.
>>
>> The reason is that I have several network interfaces running at once on my
>> system so I need to choose an IP address in a subnet that is not already
>> taken.
>>     
>
>  There are three private network ranges:
> http://en.wikipedia.org/wiki/Private_network
>
>  Almost always, you can find a range that's not going to be used by
> any other NIC in the system. If my home network is on a 10.x subnet,
> for example, and I'm letting people dial up via modem to a 192.168.x
> range, I could use a 172.16.x address range for DUN.
>   
Thanks, I should have been more explicit in my original email.

My device has eth0, usb0, ppp0 and possibly wlan0.

eth0 can be static, link-local or dhcp.
wlan0 can be static, link-local or dhcp.
usb0 is chosen to be on a private network range at connection time that
doesn't conflict with any of the above.
ppp0 is chosen to be on a private network range at connection time that
doesn't conflict with any of the above.

So you see that I have to choose an unused subnet dynamically in order
to keep everything happy and working. The problem is that pppd doesn't
seem to allow for choosing the IP address via a script.

To choose the free subnet I've written a script in Python that searches
all three 3 private network spaces against the existing connections and
then outputs a suitable range in various formats like ifconfig, pppd,
dhcpd.conf.

I think that I can solve this problem by configuring dund to call a pppd
wrapper which calculates the correct, non-colliding, subnet and then
passed on the arguments to pppd.

Aras



______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
