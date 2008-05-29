Return-Path: <cyrus@holtmann.org>
Message-ID: <a481fbf0805290401g57804562h34ef5147852256c9@mail.gmail.com>
Date: Thu, 29 May 2008 07:01:00 -0400
From: "Raymond Ingles" <sorceror171@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
MIME-Version: 1.0
References: <1945.124.170.117.82.1212030264.squirrel@www.magtech.com.au>
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

On Wed, May 28, 2008 at 11:04 PM,  <arasv@magtech.com.au> wrote:
> Hi,
>
> I need to determine my ppp IP address pair before I run pppd.
>
> The reason is that I have several network interfaces running at once on my
> system so I need to choose an IP address in a subnet that is not already
> taken.

 There are three private network ranges:
http://en.wikipedia.org/wiki/Private_network

 Almost always, you can find a range that's not going to be used by
any other NIC in the system. If my home network is on a 10.x subnet,
for example, and I'm letting people dial up via modem to a 192.168.x
range, I could use a 172.16.x address range for DUN.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
