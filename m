Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170608241406r558970ebm8cd8fa121f785ea7@mail.gmail.com>
Date: Thu, 24 Aug 2006 18:06:32 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <44EE10FD.5060404@cs.bgu.ac.il>
MIME-Version: 1.0
References: <44EE10FD.5060404@cs.bgu.ac.il>
Subject: Re: [Bluez-users] 2.25->3.3 can't ping headset
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

Hi Niv,

On 8/24/06, Niv <nivv@cs.bgu.ac.il> wrote:
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>      bdaddr 00:0D:44:33:E1:63 ptype 0xcc18 rswitch 0x01 clkoffset 0x61fa
> (valid)
>      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) status 0x00 ncmd 1
>  > HCI Event: Link Key Request (0x17) plen 6
>      bdaddr 00:0D:44:33:E1:63
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>      bdaddr 00:0D:44:33:E1:63
>  > HCI Event: Command Complete (0x0e) plen 10
>      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>      status 0x00 bdaddr 00:0D:44:33:E1:63
>  > HCI Event: PIN Code Request (0x16) plen 6
>      bdaddr 00:0D:44:33:E1:63
> < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>      bdaddr 00:0D:44:33:E1:63
>  > HCI Event: Command Complete (0x0e) plen 10
>      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1

It seems your headset wants to pair with you but you don't have a
passkey agent. You really want the new bluez-gnome package (you can
find a link on the Download page) so you can use bt-applet as your
default passkey agent.

Regards,

-- Ulisses

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
