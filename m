Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612191225h709bd891r7c79f0d22f6882a2@mail.gmail.com>
Date: Tue, 19 Dec 2006 12:25:22 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <45883E80.50703@gmail.com>
MIME-Version: 1.0
References: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
	<45883E80.50703@gmail.com>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1364455863=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1364455863==
Content-Type: multipart/alternative;
	boundary="----=_Part_15119_19792895.1166559922640"

------=_Part_15119_19792895.1166559922640
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the code.  I have something simular in the way how I open RFCOMM
as a socket.
So I think I am on the right track.

However, in reading your code, what I do not understand is what part of it
are "serial" in nature?
In a quick glance, all are socket (and RFCOMM sockets) based.  I don't see
anything
that is serial in nature in your code (like open() a serial port to get a
file descriptor etc....)

Sorry if I am asking stupid questions.


Mark


On 12/19/06, Manuel Naranjo <naranjo.manuel@gmail.com> wrote:
>
> Mark,
> Here is a library I made on C++ based on the code from hcitool and some
> other code I found on the web, that let's you use the RFcomm layer as a
> serial port. It might need a lot of changes, it is just what I needed.
> Thanks
> Manuel
> >
> > Hi:
> >
> > In many examples that I found online where people are trying to make
> > their cellphone surf web or somehow talk to their cellphone from
> > Bluez, I notice that they can often do minicom over /dev/rfcomm0 in
> > the setup.
> >
> > If I want to access the serial port service like that, but from my C
> > program, do I just treat /dev/rfcomm0 as a serial device and use
> > standard Unix serial programming libraries from my C program to do so?
> > Just curious.  Thanks in advanced for any tip.
> >
> >
> > Mark
> > ------------------------------------------------------------------------
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys - and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>
>
> /***************************************************************************
> *   Copyright (C) 2006 by Manuel Naranjo   *
> *   manuel@aircable.net   *
> *
> *
> *   This program is free software; you can redistribute it and/or
> modify  *
> *   it under the terms of the GNU Library General Public License as
> *
> *   published by the Free Software Foundation; either version 2 of
> the    *
> *   License, or (at your option) any later version.
> *
> *
> *
> *   This program is distributed in the hope that it will be useful,
> *
> *   but WITHOUT ANY WARRANTY; without even the implied warranty
> of        *
> *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> *
> *   GNU General Public License for more
> details.                          *
> *
> *
> *   You should have received a copy of the GNU Library General Public
> *
> *   License along with this program; if not, write to the
> *
> *   Free Software Foundation, Inc.,
> *
> *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> *
> *
> *
> *
> *
> *   This class is a C++ warper of a Bluetooth RFcomm
> Socket                       *
>
> ***************************************************************************/
>
> #include "rfcomm.h"
>
> #include <string>
> #include <iostream>
> #include <sys/param.h>
> #include <sys/socket.h>
> #include <sys/ioctl.h>
>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
>
> RfComm::RfComm(void){
>         rfcommSocket = -1;
>         bt_addr = "00:00:00:00:00:00";
> }
>
> RfComm::RfComm(string addr){
>         rfcommSocket = -1;
>         bt_addr = addr;
> }
>
> RfComm::~RfComm(void){
>         Close();
> }
>
> void RfComm::Close(void){
>         if (rfcommSocket != -1)
>                 close(rfcommSocket);
>
> }
>
> void RfComm::Open(void){
>         bdaddr_t t_bdaddr;
>         str2ba(bt_addr.c_str(), &t_bdaddr);
>
>         struct sockaddr_rc sockaddr;
>         sockaddr.rc_family = AF_BLUETOOTH;
>         sockaddr.rc_bdaddr = t_bdaddr;
>         sockaddr.rc_channel = (uint8_t) 1;
>
>         rfcommSocket = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>
>         if (connect(rfcommSocket, (struct sockaddr *) &sockaddr,
> sizeof(sockaddr)) < 0) {
>                 std::cerr << "Error While Openning RFComm Connection"
> <<endl;
>         rfcommSocket = -1;
>         }
> }
>
> void RfComm::setAddress(string new_addr){
>         Close();
>         bt_addr = new_addr;
> }
>
> int RfComm::Write(string message){
>         int result = -1;
>         if (rfcommSocket==-1){
>                 std::cerr << "Not a valid socket, aborting"<<endl;
>                 return result;
>         }
>
>         result = send(rfcommSocket, (void *)message.c_str(), message.size(),
> 0);
>
>         if (result < 0)
>                 std::cerr << "There was an error when trying to
> write"<<endl;
>
>         return result;
> }
>
> string RfComm::Read(void){
>         char response[64];
>         string out = "";
>         if (recv(rfcommSocket, response, 64, 0) < 0) {
>                 std::cerr << "There was an error while trying to
> read"<<endl;
>                 return NULL;
>         }
>
>         out+=response;
>         return out;
> }
>
> int RfComm::getLinkQuality(uint8_t * lq){
>         struct hci_conn_info_req *cr;
>         bdaddr_t bdaddr;
>
>         int dd;
>         int dev_id;
>
>         str2ba(bt_addr.c_str(), &bdaddr);
>
>         dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
>         if (dev_id < 0) {
>                 std::cerr <<"Not connected, can't read Link Quality" <<
> endl;
>                 return -1;
>         }
>
>         dd = hci_open_dev(dev_id);
>         if (dd < 0) {
>                 std::cerr << "HCI device open failed";
>                 return -1;
>         }
>
>         cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct
> hci_conn_info));
>         if (!cr) {
>                 std::cerr << "Can't allocate memory";
>                 return -1;
>         }
>
>         bacpy(&cr->bdaddr, &bdaddr);
>         cr->type = ACL_LINK;
>         if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>                 std::cerr << "Get connection info failed";
>                 return -1;
>         }
>
>         if (hci_read_link_quality(dd, htobs(cr->conn_info->handle), lq,
> 1000) < 0) {
>                 std::cerr << "HCI read_link_quality request failed";
>                 return -1;
>         }
>
>         close(dd);
>         free(cr);
>         return 0;
> }
>
> int RfComm::getRSSI(int8_t * rssi){
>         struct hci_conn_info_req *cr;
>         bdaddr_t bdaddr;
>         int dd, dev_id;
>         int8_t temp;
>         str2ba(bt_addr.c_str(), &bdaddr);
>
>         if (dev_id < 0) {
>                 dev_id = hci_for_each_dev(HCI_UP, find_conn, (long)
> &bdaddr);
>                 if (dev_id < 0) {
>                         std::cerr << "Not connected, can't read RSSI." <<
> endl;
>                         return -1;
>                 }
>         }
>
>         dd = hci_open_dev(dev_id);
>         if (dd < 0) {
>                 std::cerr << "HCI device open failed" << endl;
>                 return -1;
>         }
>
>         cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct
> hci_conn_info));
>         if (!cr) {
>                 std::cerr << "Can't allocate memory" << endl;
>                 return -1;
>         }
>
>         bacpy(&cr->bdaddr, &bdaddr);
>         cr->type = ACL_LINK;
>         if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>                 std::cerr << "Get connection info failed" << endl;
>                 return -1;
>         }
>
>         if (hci_read_rssi(dd, htobs(cr->conn_info->handle), &temp, 1000) <
> 0) {
>                 std::cerr << "Read RSSI failed" << endl;
>                 return -1;
>         }
>
>         *rssi = temp;
>
>         close(dd);
>         free(cr);
>         return 0;
> }
>
> int RfComm::getTransmitPowerLevel(int8_t * level, uint8_t * type){
>         struct hci_conn_info_req *cr;
>         bdaddr_t bdaddr;
>         uint8_t temp;
>         int dd, dev_id;
>
>         str2ba(bt_addr.c_str(), &bdaddr);
>
>         if (dev_id < 0) {
>                 dev_id = hci_for_each_dev(HCI_UP, find_conn, (long)
> &bdaddr);
>                 if (dev_id < 0) {
>                         std::cerr << "Not connected. Can't read Transmit
> Power Level." << endl;
>                         return -1;
>                 }
>         }
>
>         dd = hci_open_dev(dev_id);
>         if (dd < 0) {
>                 std::cerr << "HCI device open failed" << endl;
>                 return -1;
>         }
>
>         cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct
> hci_conn_info));
>         if (!cr) {
>                 std::cerr << "Can't allocate memory" << endl;
>                 return -1;
>         }
>
>         bacpy(&cr->bdaddr, &bdaddr);
>         cr->type = ACL_LINK;
>         if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>                 std::cerr << "Get connection info failed" << endl;
>                 return -1;
>         }
>
>         if (hci_read_transmit_power_level(dd,
> htobs(cr->conn_info->handle), temp, level, 1000) < 0) {
>                 std::cerr << "HCI read transmit power level request
> failed" << endl;
>                 return -1;
>         }
>
>         *type =temp;
>
>         close(dd);
>         free(cr);
>
>         return 0;
> }
>
> static int find_conn(int s, int dev_id, long arg)
> {
>         struct hci_conn_list_req *cl;
>         struct hci_conn_info *ci;
>         int i;
>
>         if (!(cl = (hci_conn_list_req*)malloc(10 * sizeof(*ci) +
> sizeof(*cl)))) {
>                 std::cerr << "Can't allocate memory";
>                 exit(1);
>         }
>         cl->dev_id = dev_id;
>         cl->conn_num = 10;
>         ci = cl->conn_info;
>
>         if (ioctl(s, HCIGETCONNLIST, (void *) cl)) {
>                 std::cerr <<"Can't get connection list";
>                 exit(1);
>         }
>
>         for (i = 0; i < cl->conn_num; i++, ci++)
>                 if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
>                         return 1;
>
>         return 0;
> }
>
>
>
>
>
>
> /***************************************************************************
> *   Copyright (C) 2006 by Manuel Naranjo   *
> *   manuel@aircable.net   *
> *
> *
> *   This program is free software; you can redistribute it and/or
> modify  *
> *   it under the terms of the GNU Library General Public License as
> *
> *   published by the Free Software Foundation; either version 2 of
> the    *
> *   License, or (at your option) any later version.
> *
> *
> *
> *   This program is distributed in the hope that it will be useful,
> *
> *   but WITHOUT ANY WARRANTY; without even the implied warranty
> of        *
> *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> *
> *   GNU General Public License for more
> details.                          *
> *
> *
> *   You should have received a copy of the GNU Library General Public
> *
> *   License along with this program; if not, write to the
> *
> *   Free Software Foundation, Inc.,
> *
> *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> *
>
> ***************************************************************************/
>
> #ifndef __AIRcableRFCOMM_h__
> #define __AIRcableRFCOMM_h__
> #include <string>
>
> #define ERROR 0xFFFF
>
> using namespace std;
>
> extern "C++"{
>         class RfComm{
>
>                 private:
>                         int             rfcommSocket;
>                         string  bt_addr;
>
>                 public:
>                         //constructor
>                         RfComm(void);
>
>                         RfComm(string bt_addr);
>
>                         ~RfComm(void);
>
>                         void Open(void);
>
>                         void Close(void);
>
>                         int Write(string in);
>
>                         string Read(void);
>
>                         void setAddress(string new_addr);
>
>                         int getLinkQuality(uint8_t * lq);
>
>                         int getRSSI(int8_t * rssi);
>
>                         int getTransmitPowerLevel(int8_t * level, uint8_t
> * type);
>         };
> }; //C++
>
> static int find_conn(int s, int dev_id, long arg);
>
> #endif //__AIRcableRFCOMM_h__
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>

------=_Part_15119_19792895.1166559922640
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for the code.&nbsp; I have something simular in the way how I open R=
FCOMM as a socket.<br>So I think I am on the right track.<br><br>However, i=
n reading your code, what I do not understand is what part of it are &quot;=
serial&quot; in nature?
<br>In a quick glance, all are socket (and RFCOMM sockets) based.&nbsp; I d=
on&#39;t see anything <br>that is serial in nature in your code (like open(=
) a serial port to get a file descriptor etc....)<br><br>Sorry if I am aski=
ng stupid questions.
<br><br><br>Mark<br><br><br><div><span class=3D"gmail_quote">On 12/19/06, <=
b class=3D"gmail_sendername">Manuel Naranjo</b> &lt;<a href=3D"mailto:naran=
jo.manuel@gmail.com">naranjo.manuel@gmail.com</a>&gt; wrote:</span><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Mark,<br>Here is a library I made on C++ based on the code from hcitool and=
 some<br>other code I found on the web, that let&#39;s you use the RFcomm l=
ayer as a<br>serial port. It might need a lot of changes, it is just what I=
 needed.
<br>Thanks<br>Manuel<br>&gt;<br>&gt; Hi:<br>&gt;<br>&gt; In many examples t=
hat I found online where people are trying to make<br>&gt; their cellphone =
surf web or somehow talk to their cellphone from<br>&gt; Bluez, I notice th=
at they can often do minicom over /dev/rfcomm0 in
<br>&gt; the setup.<br>&gt;<br>&gt; If I want to access the serial port ser=
vice like that, but from my C<br>&gt; program, do I just treat /dev/rfcomm0=
 as a serial device and use<br>&gt; standard Unix serial programming librar=
ies from my C program to do so?
<br>&gt; Just curious.&nbsp;&nbsp;Thanks in advanced for any tip.<br>&gt;<b=
r>&gt;<br>&gt; Mark<br>&gt; -----------------------------------------------=
-------------------------<br>&gt;<br>&gt; ---------------------------------=
----------------------------------------
<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join S=
ourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share y=
our<br>&gt; opinions on IT &amp; business topics through brief surveys - an=
d earn cash
<br>&gt; <a href=3D"http://www.techsay.com/default.php?page=3Djoin.php&amp;=
p=3Dsourceforge&amp;CID=3DDEVDEV">http://www.techsay.com/default.php?page=
=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV</a><br>&gt; --------------=
----------------------------------------------------------
<br>&gt;<br>&gt; _______________________________________________<br>&gt; Bl=
uez-users mailing list<br>&gt; <a href=3D"mailto:Bluez-users@lists.sourcefo=
rge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; <a href=3D"https://l=
ists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br><br=
><br><br>/*****************************************************************=
**********<br> *&nbsp;&nbsp; Copyright (C) 2006 by Manuel Naranjo&nbsp;&nbs=
p; *<br> *&nbsp;&nbsp; <a href=3D"mailto:manuel@aircable.net">
manuel@aircable.net</a>&nbsp;&nbsp; *<br> *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nbsp; This program is free software=
; you can redistribute it and/or modify&nbsp;&nbsp;*<br> *&nbsp;&nbsp; it u=
nder the terms of the GNU Library General Public License as&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; published by the Free Software Foundation; either versio=
n 2 of the&nbsp;&nbsp;&nbsp;&nbsp;*<br> *&nbsp;&nbsp; License, or (at your =
option) any later version.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; *<br> *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; This program is distributed in the hope that it will be =
useful,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nbsp; but WITHOUT=
 ANY WARRANTY; without even the implied warranty of&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;*<br> *&nbsp;&nbsp; MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE.&nbsp;&nbsp;See the&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; GNU General Public License for more details.&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<br> =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nb=
sp; You should have received a copy of the GNU Library General Public&nbsp;=
&nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; License along with this program; if not, write to the&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nbsp; Free Software Foundation, Inc.,&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
<br> *&nbsp;&nbsp; 59 Temple Place - Suite 330, Boston, MA&nbsp;&nbsp;02111=
-1307, USA.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; *
<br> *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; This class is a C++ warper of a Bluetooth RFcomm Socket&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br> ************=
***************************************************************/<br><br>#in=
clude &quot;rfcomm.h&quot;<br><br>#include &lt;string&gt;
<br>#include &lt;iostream&gt;<br>#include &lt;sys/param.h&gt;<br>#include &=
lt;sys/socket.h&gt;<br>#include &lt;sys/ioctl.h&gt;<br><br>#include &lt;blu=
etooth/bluetooth.h&gt;<br>#include &lt;bluetooth/rfcomm.h&gt;<br>#include &=
lt;bluetooth/hci.h&gt;
<br>#include &lt;bluetooth/hci_lib.h&gt;<br><br>RfComm::RfComm(void){<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rfcommSocket =3D -1;<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bt_addr =3D &quot;00:00:00:00:00=
:00&quot;;<br>}<br><br>RfComm::RfComm(string addr){<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;rfcommSocket =3D -1;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bt_addr =3D addr;<br>}<=
br><br>RfComm::~RfComm(void){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;Close();<br>}<br><br>void RfComm::Close(void){<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (rfcommSocket !=3D -1)<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;close(rfcommSocket);<br><br>}<br><br>void RfComm::Open(void){
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bdaddr_t t_bdaddr;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;str2ba(bt_addr.c_str(), &amp=
;t_bdaddr);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct s=
ockaddr_rc sockaddr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;soc=
kaddr.rc_family =3D AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;sockaddr.rc_bdaddr =3D t_bdaddr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
sockaddr.rc_channel =3D (uint8_t) 1;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;rfcommSocket =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO=
_RFCOMM);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (connec=
t(rfcommSocket, (struct sockaddr *) &amp;sockaddr, sizeof(sockaddr)) &lt; 0=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;Error While Openning RFComm C=
onnection&quot; &lt;&lt;endl;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;rfcommSocket =3D -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;}<br>}<br><br>void RfComm::setAddress(string new_addr){<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;bt_addr =3D new_addr;
<br>}<br><br>int RfComm::Write(string message){<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;int result =3D -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;if (rfcommSocket=3D=3D-1){<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::=
cerr &lt;&lt; &quot;Not a valid socket, aborting&quot;&lt;&lt;endl;<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;return result;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result =3D send(rfcommSocket, (void *)mes=
sage.c_str(), message.size(), 0);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;if (result &lt; 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt;=
 &quot;There was an error when trying to write&quot;&lt;&lt;endl;
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return result;<br>}=
<br><br>string RfComm::Read(void){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;char response[64];<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;string out =3D &quot;&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;if (recv(rfcommSocket, response, 64, 0) &lt; 0) {<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;std::cerr &lt;&lt; &quot;There was an error while trying to read&=
quot;&lt;&lt;endl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;out+=
=3Dresponse;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return out;=
<br>}<br><br>int RfComm::getLinkQuality(uint8_t * lq){<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct hci_conn_info_req *cr;<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bdaddr_t bdaddr;
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int dd;<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int dev_id;<br><br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;str2ba(bt_addr.c_str(), &amp;bdaddr);<br><b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev_id =3D hci_for_each_d=
ev(HCI_UP, find_conn, (long) &amp;bdaddr);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;if (dev_id &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &=
lt;&lt;&quot;Not connected, can&#39;t read Link Quality&quot; &lt;&lt; endl=
;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dd =3D=
 hci_open_dev(dev_id);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i=
f (dd &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;HCI device=
 open failed&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cr =3D (hci_conn_info_req*)malloc(sizeof(*cr)=
 + sizeof(struct hci_conn_info));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;if (!cr) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;Can&#=
39;t allocate memory&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bacpy(&amp;cr-&gt;bdaddr, &amp;bdaddr);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cr-&gt;type =3D ACL_LINK;=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ioctl(dd, HCIGETCON=
NINFO, (unsigned long) cr) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;=
&lt; &quot;Get connection info failed&quot;;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (hc=
i_read_link_quality(dd, htobs(cr-&gt;conn_info-&gt;handle), lq, 1000) &lt; =
0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;HCI read_link_quality=
 request failed&quot;;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(=
dd);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;free(cr);<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br>}<br><br>int RfComm:=
:getRSSI(int8_t * rssi){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;struct hci_conn_info_req *cr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;bdaddr_t bdaddr;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int dd, dev_id;<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int8_t temp;<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;str2ba(bt_addr.c_str(), &amp;bdaddr);<br><=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (dev_id &lt; 0) {<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;dev_id =3D hci_for_each_dev(HCI_UP, find_conn, (long) =
&amp;bdaddr);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;if (dev_id &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;Not con=
nected, can&#39;t read RSSI.&quot; &lt;&lt; endl;<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dd =3D hci_open_dev=
(dev_id);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (dd &lt; 0)=
 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;HCI device open failed&=
quot; &lt;&lt; endl;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;cr =3D (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct=
 hci_conn_info));
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!cr) {<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;std::cerr &lt;&lt; &quot;Can&#39;t allocate memory&quot; &lt;&l=
t; endl;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;bacpy(&amp;cr-&gt;bdaddr, &amp;bdaddr);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;cr-&gt;type =3D ACL_LINK;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ioctl(dd, HCIGETCON=
NINFO, (unsigned long) cr) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;=
&lt; &quot;Get connection info failed&quot; &lt;&lt; endl;<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (hci_read_rssi(dd, h=
tobs(cr-&gt;conn_info-&gt;handle), &amp;temp, 1000) &lt; 0) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;Read RSSI failed&quot; &l=
t;&lt; endl;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;*rssi =3D temp;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;close(dd);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;free(cr);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;
<br>}<br><br>int RfComm::getTransmitPowerLevel(int8_t * level, uint8_t * ty=
pe){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct hci_conn_inf=
o_req *cr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bdaddr_t bdad=
dr;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint8_t temp;<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int dd, dev_id;<br><br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;str2ba(bt_addr.c_str(), &amp;bdadd=
r);
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (dev_id &lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;dev_id =3D hci_for_each_dev(HCI_UP, find_conn, (l=
ong) &amp;bdaddr);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (dev_id &lt; 0) {<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;=
&lt; &quot;Not connected. Can&#39;t read Transmit Power Level.&quot; &lt;&l=
t; endl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;re=
turn -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dd =3D =
hci_open_dev(dev_id);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if=
 (dd &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;HCI device =
open failed&quot; &lt;&lt; endl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cr =3D=
 (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct hci_conn_info));<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!cr) {<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;std::cerr &lt;&lt; &quot;Can&#39;t allocate memory&quot; &lt;&lt; =
endl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bacpy(=
&amp;cr-&gt;bdaddr, &amp;bdaddr);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;cr-&gt;type =3D ACL_LINK;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) &lt; 0) {<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;Get connection info failed&qu=
ot; &lt;&lt; endl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (hc=
i_read_transmit_power_level(dd, htobs(cr-&gt;conn_info-&gt;handle), temp, l=
evel, 1000) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &lt;&lt; &quot;HCI =
read transmit power level request failed&quot; &lt;&lt; endl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;return -1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*type =
=3Dtemp;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;close(dd);<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;free(cr);<br><br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;<br>}<br><br>static int f=
ind_conn(int s, int dev_id, long arg)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;struct hci_conn_list_req *cl;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct hci_conn_info *c=
i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int i;<br><br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!(cl =3D (hci_conn_list_req*)m=
alloc(10 * sizeof(*ci) + sizeof(*cl)))) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr=
 &lt;&lt; &quot;Can&#39;t allocate memory&quot;;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cl-&gt;dev_i=
d =3D dev_id;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cl-&gt;con=
n_num =3D 10;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ci =3D cl-=
&gt;conn_info;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (i=
octl(s, HCIGETCONNLIST, (void *) cl)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;std::cerr &=
lt;&lt;&quot;Can&#39;t get connection list&quot;;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (i =
=3D 0; i &lt; cl-&gt;conn_num; i++, ci++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!bacm=
p((bdaddr_t *) arg, &amp;ci-&gt;bdaddr))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 1;<br><br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;
<br>}<br><br><br><br><br><br>/*********************************************=
******************************<br> *&nbsp;&nbsp; Copyright (C) 2006 by Manu=
el Naranjo&nbsp;&nbsp; *<br> *&nbsp;&nbsp; <a href=3D"mailto:manuel@aircabl=
e.net">manuel@aircable.net</a>
&nbsp;&nbsp; *<br> *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; *<br> *&nbsp;&nbsp; This program is free software; you can redistribute =
it and/or modify&nbsp;&nbsp;*<br> *&nbsp;&nbsp; it under the terms of the G=
NU Library General Public License as&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; published by the Free Software Foundation; either versio=
n 2 of the&nbsp;&nbsp;&nbsp;&nbsp;*<br> *&nbsp;&nbsp; License, or (at your =
option) any later version.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; *<br> *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; This program is distributed in the hope that it will be =
useful,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nbsp; but WITHOUT=
 ANY WARRANTY; without even the implied warranty of&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;*<br> *&nbsp;&nbsp; MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE.&nbsp;&nbsp;See the&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; GNU General Public License for more details.&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<br> =
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nb=
sp; You should have received a copy of the GNU Library General Public&nbsp;=
&nbsp;&nbsp;&nbsp; *
<br> *&nbsp;&nbsp; License along with this program; if not, write to the&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; *<br> *&nbsp;&nbsp; Free Software Foundation, Inc.,&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
<br> *&nbsp;&nbsp; 59 Temple Place - Suite 330, Boston, MA&nbsp;&nbsp;02111=
-1307, USA.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; *
<br> **********************************************************************=
*****/<br><br>#ifndef __AIRcableRFCOMM_h__<br>#define __AIRcableRFCOMM_h__<=
br>#include &lt;string&gt;<br><br>#define ERROR 0xFFFF<br><br>using namespa=
ce std;
<br><br>extern &quot;C++&quot;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;class RfComm{<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;private:<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rfcommSocket;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string&=
nbsp;&nbsp;bt_addr;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;public:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//cons=
tructor<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;RfComm(void);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;RfComm(string bt_addr);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~RfComm(void);<br><br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void Open(void=
);
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;void Close(void);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;int Write(string in);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string Read(void);<br><br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void setAdd=
ress(string new_addr);<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in=
t getLinkQuality(uint8_t * lq);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int getRSSI(int8_t * rssi);<br><br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int getTransm=
itPowerLevel(int8_t * level, uint8_t * type);<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;};
<br>}; //C++<br><br>static int find_conn(int s, int dev_id, long arg);<br><=
br>#endif //__AIRcableRFCOMM_h__<br><br><br>-------------------------------=
------------------------------------------<br>Take Surveys. Earn Cash. Infl=
uence the Future of IT
<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance =
to share your<br>opinions on IT &amp; business topics through brief surveys=
 - and earn cash<br><a href=3D"http://www.techsay.com/default.php?page=3Djo=
in.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV">
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV</a><br><br>_______________________________________________<br>=
Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge=
.net">
Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/list=
info/bluez-users</a><br><br><br></blockquote></div><br>

------=_Part_15119_19792895.1166559922640--


--===============1364455863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1364455863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1364455863==--
