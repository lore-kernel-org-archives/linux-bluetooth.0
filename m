Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY104-F545C3886C1F9ECE32CF4DC1A60@phx.gbl>
From: "blookk -" <blookk@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
Subject: [Bluez-devel] Re: compiling hciconfig for ARM
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 24 Dec 2004 19:42:33 +0000

<html><div style='background-color:'><DIV class=RTE>Hi Marcel.</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>I use a kernel 2.4.20 and a Compactflash Bluetooth BT0100M.</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>Thanks.</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>Regards.</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>PD: Why I do not receive the messages of mailing list in my email?. I read the messages in the web.</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>-------------------------</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>&nbsp;</DIV>
<DIV class=RTE>Hi,<BR> <BR> &gt; I have compiled the Bluez Utils and Libs 2.11 for a ARM platform,<BR> &gt; concretly for the CPU ARM7TDMI.<BR> &gt; I have done the compilation with uClibc-0.9.19 and in "hciconfig" tool<BR> &gt; I have a problem when I make"hciconfig -a" or "hciconfig hci0 name" or<BR> &gt; "hciconfig hci0 class" and other.<BR> &gt; All this problems occurs in file "hci.c", in function "int<BR> &gt; hci_send_req(int dd, struct hci_request *r, int to)".<BR> &gt; In this function when the program execute "n = poll(&amp;p, 1, to)" I<BR> &gt; obtain a kernel panic like this (executing hciconfig -a):<BR> <BR> what kernel and what Bluetooth hardware do you use?<BR> <BR> Regards<BR> <BR> Marcel<BR>&nbsp;<BR></DIV></div></html>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
