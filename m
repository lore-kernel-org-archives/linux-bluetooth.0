Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jean-Pierre Lord <jeanplord@videotron.ca>
To: bluez-users@lists.sourceforge.net
Message-id: <000801c41e98$9e75d080$0100a8c0@terre>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_TU9EA47i85IICc+blcsI2A)"
Subject: [Bluez-users] Connection dropped or cannot connect
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 09 Apr 2004 21:10:27 -0400

This is a multi-part message in MIME format.

--Boundary_(ID_TU9EA47i85IICc+blcsI2A)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

My Linux box has a Anycom usb-220 bluetooth adapter connected to it which is used to serve my iPAQ1940.  Works "superbly great" except those times it won't work at all ;-).  Either a long connection (like a download) will be cut or i will not be able to open a new connection.  When it happens, i have 2 choices: unplung the bluetooth adapter for a few seconds (which requires no other intervention on the software side) and replug it or reset the device using hciconfig.  Except that doing this reset will sometimes crash the hole Linux box.  I then get a stack dump and once i got a message that looked like this: "...killing interrupt handler...".  Sorry i wasn't fast enough to write down the message.

I'm running "Kernel 2.4.24-mh2 on an i586" with bluez-libs-2.5, bluez-sdp-1.5, bluez-utils-2.5.  I normally run hcid, sdpd, "dund --listen --msdun call dun".  It seems to me that enabling authentification and encryption has made the whole thing less reliable.

What can i do to improve reliability?

Thank you

An lsmod shows the following:
Module                  Size  Used by
bnep                    8912   0  (autoclean)
ppdev                   6960   0  (autoclean)
ppp_deflate             3120   0  (autoclean)
zlib_inflate           19648   0  (autoclean) [ppp_deflate]
zlib_deflate           18688   0  (autoclean) [ppp_deflate]
bsd_comp                4416   0  (autoclean)
ppp_async               6544   0  (autoclean)
ppp_generic            16960   0  (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4736   0  (autoclean) [ppp_generic]
crc32                   2848   0  [bnep]
sco                     7936   0  (unused)
hci_usb                 6336   1
usb-ohci               16816   0  (unused)
rfcomm                 29040   1  (autoclean)
l2cap                  15632   2  (autoclean) [bnep rfcomm]
bluez                  28224   3  (autoclean) [bnep sco hci_usb rfcomm l2cap]
ipt_MASQUERADE          1344   1  (autoclean)
ipt_state                576   2  (autoclean)
ip_nat_ftp              2912   0  (unused)
iptable_nat            16592   2  [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_ftp        3760   1
ip_conntrack           18752   3  [ipt_MASQUERADE ipt_state ip_nat_ftp iptable_nat ip_conntrack_ftp]
iptable_filter          1680   1
ip_tables              12000   6  [ipt_MASQUERADE ipt_state iptable_nat iptable_filter]
3c509                   8304   2
rtc                     6112   0  (autoclean)

--Boundary_(ID_TU9EA47i85IICc+blcsI2A)
Content-type: text/html; charset=iso-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2800.1400" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial size=2>My Linux box has a Anycom usb-220 bluetooth adapter 
connected to it which is used to serve my iPAQ1940.&nbsp; Works "superbly great" 
except those times it won't work at all ;-).&nbsp; Either a long connection 
(like a download) will be cut or i will not be able to open a new 
connection.&nbsp; When it happens, i have 2 choices: unplung the bluetooth 
adapter for a few seconds (which requires no other intervention on the software 
side) and replug it or reset the device using hciconfig.&nbsp; Except that doing 
this reset will sometimes crash the hole Linux box.&nbsp; I then get a stack 
dump and once i got a message that looked like this: "...killing interrupt 
handler...".&nbsp; Sorry i wasn't fast enough to write down the 
message.</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I'm running "Kernel 2.4.24-mh2 on an i586" with 
bluez-libs-2.5, bluez-sdp-1.5, bluez-utils-2.5.&nbsp; I normally run hcid, sdpd, 
"dund --listen --msdun call dun".&nbsp; It seems to me that enabling 
authentification and encryption has made the whole thing less 
reliable.</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV>
<DIV><FONT face=Arial size=2>What can i do to improve reliability?</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Thank you</DIV></FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>An lsmod shows the following:</FONT></DIV>
<DIV><FONT face=Arial 
size=2>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Size&nbsp; Used 
by<BR>bnep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
8912&nbsp;&nbsp; 0&nbsp; 
(autoclean)<BR>ppdev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
6960&nbsp;&nbsp; 0&nbsp; 
(autoclean)<BR>ppp_deflate&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
3120&nbsp;&nbsp; 0&nbsp; 
(autoclean)<BR>zlib_inflate&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
19648&nbsp;&nbsp; 0&nbsp; (autoclean) 
[ppp_deflate]<BR>zlib_deflate&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
18688&nbsp;&nbsp; 0&nbsp; (autoclean) 
[ppp_deflate]<BR>bsd_comp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
4416&nbsp;&nbsp; 0&nbsp; 
(autoclean)<BR>ppp_async&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
6544&nbsp;&nbsp; 0&nbsp; 
(autoclean)<BR>ppp_generic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
16960&nbsp;&nbsp; 0&nbsp; (autoclean) [ppp_deflate bsd_comp 
ppp_async]<BR>slhc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
4736&nbsp;&nbsp; 0&nbsp; (autoclean) 
[ppp_generic]<BR>crc32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
2848&nbsp;&nbsp; 0&nbsp; 
[bnep]<BR>sco&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
7936&nbsp;&nbsp; 0&nbsp; 
(unused)<BR>hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
6336&nbsp;&nbsp; 
1<BR>usb-ohci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
16816&nbsp;&nbsp; 0&nbsp; 
(unused)<BR>rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
29040&nbsp;&nbsp; 1&nbsp; 
(autoclean)<BR>l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
15632&nbsp;&nbsp; 2&nbsp; (autoclean) [bnep 
rfcomm]<BR>bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
28224&nbsp;&nbsp; 3&nbsp; (autoclean) [bnep sco hci_usb rfcomm 
l2cap]<BR>ipt_MASQUERADE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
1344&nbsp;&nbsp; 1&nbsp; 
(autoclean)<BR>ipt_state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
576&nbsp;&nbsp; 2&nbsp; 
(autoclean)<BR>ip_nat_ftp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
2912&nbsp;&nbsp; 0&nbsp; 
(unused)<BR>iptable_nat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
16592&nbsp;&nbsp; 2&nbsp; [ipt_MASQUERADE 
ip_nat_ftp]<BR>ip_conntrack_ftp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
3760&nbsp;&nbsp; 
1<BR>ip_conntrack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
18752&nbsp;&nbsp; 3&nbsp; [ipt_MASQUERADE ipt_state ip_nat_ftp iptable_nat 
ip_conntrack_ftp]<BR>iptable_filter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
1680&nbsp;&nbsp; 
1<BR>ip_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
12000&nbsp;&nbsp; 6&nbsp; [ipt_MASQUERADE ipt_state iptable_nat 
iptable_filter]<BR>3c509&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
8304&nbsp;&nbsp; 
2<BR>rtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
6112&nbsp;&nbsp; 0&nbsp; (autoclean)<BR></FONT></DIV></BODY></HTML>

--Boundary_(ID_TU9EA47i85IICc+blcsI2A)--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
