Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050202024903.71368.qmail@web60905.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107245676.8848.27.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1004963638-1107312543=:68773"
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
Date: Wed, 2 Feb 2005 10:49:03 +0800 (CST)

--0-1004963638-1107312543=:68773
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel,
    I've found one powerpoint you made about Bluetooth programming on Linux in Wireless Technologies Congress 2003. But I don't know for those three programs you put, which one is describing about the PC listening the mobile in RFCOMM channel. Let me put here.
For Handling of Bluetooth device addresses
#include <bluetooth/bluetooth.h>
void main(int argc, char *argv[])
{
bdaddr_t bdaddr;
char *str, addr[18];
str2ba("00:a5:b4:c3:d2:e1", &bdaddr);
ba2str(&bdaddr, addr);
str = batostr(&bdaddr);
printf("%s %s\n", addr, str);
free(str);
bacpy(&bdaddr, BDADDR_ANY);
}

For definition of the socket data types
static int rfcomm_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t channel)
{
struct sockaddr_rc addr;
int sk;
if ((sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
return -1;
addr.rc_family = AF_BLUETOOTH;
bacpy(&addr.rc_bdaddr, src);
addr.rc_channel = 0;
if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
close(sk);
return -1;
}
addr.rc_family = AF_BLUETOOTH;
bacpy(&addr.rc_bdaddr, dst);
addr.rc_channel = channel;
if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
close(sk);
return -1;
}
So I wish to know which one is about socket based programming? Thanks a lot!
Michael

Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Michael,

> I thank Marcel here for help on initializing
> connection from mobile to PC. Now, before I can do
> that, I initialize the rfcomm connection from PC to
> mobile, and then run my project program. The syntax is
> as follows:
> snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)",
> modemname);
> tmp[sizeof (tmp) - 1] = 0;
> openlogfile (tmp, logfile, LOG_DAEMON, loglevel);
> set_alarmhandler (alarmhandler, alarmlevel,
> modemname);
> openmodem ();
> setmodemparams ();
> But now, when I initialize the connection from mobile
> to PC, once I run the program, "/dev/rfcomm0: No such
> device" is shown. So, I wish to know how can I modify
> the program by changing some syntax from that I post
> here? Or is there any program that I can include in my
> main program? Thank you very much.

if you wanna connect from a mobile phone to a machine running BlueZ you
need to write an application that listens on a RFCOMM channel. This is
about socket programming and you convert this socket later in to a TTY
with a /dev/rfcommX device node, but actually unless you have some
legacy application like pppd this should not be needed. What you need is
to do direct socket programming. It is as easy as using a TTY and I
posted detailed information about how to change a TTY based program into
a socket based program years ago. Check the mailing list archive.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
新年願望第一位 :  找到友緣人 

--0-1004963638-1107312543=:68773
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I've found one powerpoint you made&nbsp;about Bluetooth programming on Linux in Wireless Technologies Congress 2003. But I don't know for those three programs you put, which one is describing about the PC listening the mobile in RFCOMM channel. Let me put here.</DIV>
<DIV>For Handling of Bluetooth device addresses</DIV>
<DIV>#include &lt;bluetooth/bluetooth.h&gt;<BR>void main(int argc, char *argv[])<BR>{<BR>bdaddr_t bdaddr;<BR>char *str, addr[18];<BR>str2ba("00:a5:b4:c3:d2:e1", &amp;bdaddr);<BR>ba2str(&amp;bdaddr, addr);<BR>str = batostr(&amp;bdaddr);<BR>printf("%s %s\n", addr, str);<BR>free(str);<BR>bacpy(&amp;bdaddr, BDADDR_ANY);<BR>}<BR></DIV>
<DIV>For definition of the socket data types</DIV>
<DIV>static int rfcomm_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t channel)<BR>{<BR>struct sockaddr_rc addr;<BR>int sk;<BR>if ((sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) &lt; 0)<BR>return -1;<BR>addr.rc_family = AF_BLUETOOTH;<BR>bacpy(&amp;addr.rc_bdaddr, src);<BR>addr.rc_channel = 0;<BR>if (bind(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<BR>close(sk);<BR>return -1;<BR>}<BR>addr.rc_family = AF_BLUETOOTH;<BR>bacpy(&amp;addr.rc_bdaddr, dst);<BR>addr.rc_channel = channel;<BR>if (connect(sk, (struct sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {<BR>close(sk);<BR>return -1;<BR>}</DIV>
<DIV>So I wish to know which one is about socket based programming? Thanks a lot!</DIV>
<DIV>Michael</DIV>
<DIV><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>&gt; I thank Marcel here for help on initializing<BR>&gt; connection from mobile to PC. Now, before I can do<BR>&gt; that, I initialize the rfcomm connection from PC to<BR>&gt; mobile, and then run my project program. The syntax is<BR>&gt; as follows:<BR>&gt; snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)",<BR>&gt; modemname);<BR>&gt; tmp[sizeof (tmp) - 1] = 0;<BR>&gt; openlogfile (tmp, logfile, LOG_DAEMON, loglevel);<BR>&gt; set_alarmhandler (alarmhandler, alarmlevel,<BR>&gt; modemname);<BR>&gt; openmodem ();<BR>&gt; setmodemparams ();<BR>&gt; But now, when I initialize the connection from mobile<BR>&gt; to PC, once I run the program, "/dev/rfcomm0: No such<BR>&gt; device" is shown. So, I wish to know how can I modify<BR>&gt; the program by changing some syntax from that I post<BR>&gt; here? Or is there any program that I can include in my<BR>&gt; main pr
 ogram?
 Thank you very much.<BR><BR>if you wanna connect from a mobile phone to a machine running BlueZ you<BR>need to write an application that listens on a RFCOMM channel. This is<BR>about socket programming and you convert this socket later in to a TTY<BR>with a /dev/rfcommX device node, but actually unless you have some<BR>legacy application like pppd this should not be needed. What you need is<BR>to do direct socket programming. It is as easy as using a TTY and I<BR>posted detailed information about how to change a TTY based program into<BR>a socket based program years ago. Check the mailing list archive.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting<BR>Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.<BR>Download a FREE copy at
 http://www.intelliview.com/go/osdn_nl<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>新年願望第一位 :  <a href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-1004963638-1107312543=:68773--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
