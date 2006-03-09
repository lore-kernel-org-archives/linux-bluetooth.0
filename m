Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem : multi connection with PAN
Message-ID: <20060309065541.GA10323@163.com>
References: <20060307105813.97181.qmail@web26503.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060307105813.97181.qmail@web26503.mail.ukl.yahoo.com>
From: Amateur <ztl.post@gmail.com>
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
Date: Thu, 9 Mar 2006 14:55:41 +0800

On Tue, Mar 07, 2006 at 11:58:13AM +0100, BATAILLE Philippe wrote:
> 
>    # network files on each PC:  
> /etc/sysconfig/network-script/ifcfg-bnep0
>    DEVICE=bnep0
>    BOOTPROTO=static
>    BROADCAST=10.255.255.255
>    HWADDR=00:02:72:C6:6E:89         # specific device
> address different 
> for each node
>    IPADDR=10.0.0.x                            # x= 1,
> 2 and 3 for A, B 
> et C respectively
>    NETMASK=255.0.0.0
>    NETWORK=10.0.0.0
>    ONBOOT=no
>    

You should have a configuration file 'ifcfg-bnep1' there for device
benp1 too. Each PAN connection has its interface, named bnep0, bnep1,
and so on.

>    # on GN (bdaddr_A) starting  pand
>    pand -s  -r GN
> 
>    # on each PANU (bdaddr_B, bdaddr_C) creating a
> connection with A
>    pand -c bdaddr_A (on B)
>    pand -c bdaddr_A  (on C)
> 
>    # show the connections on A with 'pand --show'
>    bnep1:bdaddr_C GN

You can see here that you have two interface bnep0 and bnep1, but only
one of them have been configured.

>    bnep0:bdaddr_B GN
> 
>    # on A, ping to B (IP:10.0.0.2)
>    ping 10.0.0.2   (this command is OK)
>   
>    # on A ping to C (IP:10.0.0.3)
>    ping 10.0.0.3  (this command is not OK : Message
> "Host unreachable" )

Not surprisingly.

> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
