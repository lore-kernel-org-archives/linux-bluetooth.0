Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050202045415.51412.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107313821.20994.2.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
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
Date: Wed, 2 Feb 2005 12:54:15 +0800 (CST)

Hi Marcel!
    Acutally, this project is just related to
bluetooth. I've seen your reply, and then got through
rctest.c. I found that the part of receiving mobile
exists. Then I wish to know need I include the
rctest.c file in my main program with which header
files include in it? Or need I put the part in my
program? And about the part you said that is the
socket program, I wish to know is it ok if I just put
it in my main program with which header files include
in it? And as I need to accept all mobile, not the one
that the address has been set in the program, to
connect with PC and then access the program, how can I
do to make sure that my wish is possible? Thank you
very much.
P.S. Alian, the third program is just about HCI, and
it seems not to be related to my project. Thanks for
pointing out about this.

Michael
 
 --- Marcel Holtmann <marcel@holtmann.org> 內容：
> Hi Michael,
> 
> >     I've found one powerpoint you made about
> Bluetooth programming on
> > Linux in Wireless Technologies Congress 2003. But
> I don't know for
> > those three programs you put, which one is
> describing about the PC
> > listening the mobile in RFCOMM channel. Let me put
> here.
> > For Handling of Bluetooth device addresses
> > #include <bluetooth/bluetooth.h>
> > void main(int argc, char *argv[])
> > {
> > bdaddr_t bdaddr;
> > char *str, addr[18];
> > str2ba("00:a5:b4:c3:d2:e1", &bdaddr);
> > ba2str(&bdaddr, addr);
> > str = batostr(&bdaddr);
> > printf("%s %s\n", addr, str);
> > free(str);
> > bacpy(&bdaddr, BDADDR_ANY);
> > }
> > 
> > For definition of the socket data types
> > static int rfcomm_connect(bdaddr_t *src, bdaddr_t
> *dst, uint8_t
> > channel)
> > {
> > struct sockaddr_rc addr;
> > int sk;
> > if ((sk = socket(PF_BLUETOOTH, SOCK_STREAM,
> BTPROTO_RFCOMM)) < 0)
> > return -1;
> > addr.rc_family = AF_BLUETOOTH;
> > bacpy(&addr.rc_bdaddr, src);
> > addr.rc_channel = 0;
> > if (bind(sk, (struct sockaddr *) &addr,
> sizeof(addr)) < 0) {
> > close(sk);
> > return -1;
> > }
> > addr.rc_family = AF_BLUETOOTH;
> > bacpy(&addr.rc_bdaddr, dst);
> > addr.rc_channel = channel;
> > if (connect(sk, (struct sockaddr *) &addr,
> sizeof(addr)) < 0) {
> > close(sk);
> > return -1;
> > }
> > So I wish to know which one is about socket based
> programming?
> 
> the second is about socket programming, because it
> has the command
> socket() in it ;)
> 
> The rctest.c program is a prefect example on how to
> create a listening
> RFCOMM server and parts of the rfcomm program may
> also help. If you
> don't how to do socket programming, then buy a book
> about it or read
> some of the howtos on the net about TCP/IP socket
> progamming. Actually
> using the sockets in Bluetooth is a lot more easier.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW --
> Interactive Reporting
> Tool for open source databases. Create drag-&-drop
> reports. Save time
> by over 75%! Publish reports on the web. Export to
> DOC, XLS, RTF, etc.
> Download a FREE copy at
> http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
>  

_______________________________________________________________________
新年願望第一位 : 找到友緣人
http://personals.yahoo.com.hk


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
