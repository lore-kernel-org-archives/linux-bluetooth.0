Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100326156.6216.29.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
	 <1099943605.29330.21.camel@pegasus>  <1100326156.6216.29.camel@localhost>
Content-Type: text/plain
Message-Id: <1100350419.7349.43.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 13 Nov 2004 13:53:39 +0100

Hi Matthew,

> Real reason for it is this, user-space thinks cnum field is 16 bit, kernel 
> thinks it is 32 bit.  Bug only shows up in big-endian architectures as result
> count is returned in top byte of what is received from the kernel, whereas on
> i386 it is in the lowest where by fluke it works...
> 
> Mismatch in the kernel and user-space  header files:
> 
> in the kernel, net/bluetooth/hid/hdip.h: 
> 
> struct hidp_connlist_req {
>         __u32  cnum;
>         struct hidp_conninfo __user *ci;
> };
> 
> in libbluetoth, include/bluetooth/hidp.h:
> 
> struct hidp_connlist_req {
>         uint16_t cnum;
>         struct hidp_conninfo *ci;
> };
> 
> Which way should we go here?  We need to fix kernel or user-space, and I need your 
> 'official' touch before I post a patch in the Debian bug report I am going to submit.
> The fix I prefer affects the user-space bluetooth include files.

thanks for finding this mismatch. We change the userspace, because the
kernel interface should stay stable. Actually I looked also at BNEP and
CMTP and found that we have the same problem in CMTP. So I must have
done this wrong in the early days of CMTP and then copied over to HIDP.
A patch for this is in the CVS now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
