Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Dec 2006 10:03:05 +0100
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061218090305.GA960@suse.de>
References: <be976db60612171036i7281422dj3680b209a9f90e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
In-Reply-To: <be976db60612171036i7281422dj3680b209a9f90e6@mail.gmail.com>
Subject: Re: [Bluez-users] dund and bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2006 at 10:36:31AM -0800, Mark S. Townsley wrote:
> Hi:  I would like to find out more about how DUN profile (and DUND daem=
on)
> works with Bluez.
> Is there any config tutorial or programming tutorial about how to integ=
rate
> DUN profile with Bluez?

Marcel, these two files are in the SUSE package for quite some time.
Maybe they are good for upstream bluez-utils, too?

--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=20

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="README.dund"

Problem Description:
====================
If you have some mobile device that is able to make a ppp connection via
bluetooth, and you want to use SUSE LINUX Professional as host to connect with,
you will have to correctly setup the dund.

What to do:
===========

Configuring the dun-daemon on your system:
------------------------------------------
  There's a file named 'dun.example' in this directory. You need to copy it to
/etc/ppp/peers/dun and edit its content. The file contains instructions for
the ppp-daemon regarding connections using dun, most of them are commented.

  Now you should look at the settings of the dun-daemon itself. Start YaST and
select 'bluetooth' from the 'Hardware'-menu.
  In the popup check if Bluetooth is enabled, if not, do so. Aftewrwards click
on the 'Advanced Daemon Configuration'-button. You will now see a list of
available daemons. dund should be listed there, too, otherwise your
installation might be broken.
  The dund is not activated in the default configuration. If you want to use
it, you should enable it now by selecting dund and clicking on 'enable'
afterwards.  With the still selected 'dund'-item click on "edit". A popup
containing the options used for the daemon (not for a single connection as the
ones in the example-file mentioned above!). 
  Change these options to "-listen --persist --msdun call dun" (without the
quotation marks). You can see the valid options by calling 'dund --help' from
a shell.  The 'call dun' is not directly used by dund, but given to the
ppd-daemon. It tells the pppd to use the options found in /etc/ppp/peers/dun. 

Connecting PDA (or whatever device you have) with computer:
-----------------------------------------------------------

  On the mobile device, search for the bluetooth-enabled machine, and connect
to it with ppp. Giving more concrete instructions is hard since the methods
vary from mobile device to mobile device.


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dun.example"

# Example-file for creating a ppp connection with bluetooth between e.g. a PDA
# and the computer. Move this to /etc/ppp/peers/dun and adapt the following
# options to your needs. The values and options below there are far from
# perfect, but were good in a lot of testcases. They may not be good for you!
#
# Most of the comments were taken from the pppd-manpage for your convenience.
# See there for more information and options

## Enables connection debugging facilities. You should use this if you have problems
#debug

# Baudrate
57600

## Disables the default behaviour when no local IP address is specified,
## which is to determine (if possible) the local IP address from the hostname.
## With this option, the peer will have to supply the local IP address
## during IPCP negotiation (unless it specified explicitly on the command line
## or in an options file).
noipdefault

## Add an entry to this system's ARP [Address Resolution Protocol] table with
## the IP address of the peer and the Ethernet address of this system. This
## will have the effect of making the peer appear to other systems to be on the
## local ethernet.
proxyarp

# IP address of PC : IP address to be assigned to PDA
192.168.1.1:192.168.1.2

# Your DNS server
ms-dns 10.0.0.1

## Enables pppd to alter kernel settings as appropriate. Under Linux, pppd will
## enable IP forwarding (i.e.  set /proc/sys/net/ipv4/ip_forward to 1) if the
## proxyarp option is used, and will enable the dynamic IP address option (i.e.
## set /proc/sys/net/ipv4/ip_dynaddr to 1) in demand mode if the local address
## changes.
ktune

## Do not require the peer to authenticate itself. This option is privileged.
noauth

## Don't use the modem control lines.  With this option, pppd will ignore the
## state of the CD (Carrier Detect) signal from the modem and will not change
## the state of the DTR (Data Terminal Ready) signal.
local

## Disable the defaultroute option.
nodefaultroute

## Disable the IPXCP and IPX protocols. 
noipx

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--PNTmBPCT7hxwcZjr--
