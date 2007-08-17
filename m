Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C58673.70201@free.fr>
Date: Fri, 17 Aug 2007 13:28:51 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C088D7.9000108@silicom.fr>	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>	<46C1A52F.7050102@free.fr>
	<1187109044.6698.276.camel@violet>	<46C57BA5.5000400@free.fr>
	<1187348439.6698.369.camel@violet>
In-Reply-To: <1187348439.6698.369.camel@violet>
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel

> I got the SonyEricsson MBR-100 A2DP receiver dongle. That one is CSR
> based. Never seen a TI based before.

Me neither :-(

> Check again. There were a lot of changes.

Just did that. In fact it used to work a few days ago, when the acceptor 
side was paradoxally still broken. Not it has been fixed it doesn't work 
anymore : funny, isn't it ?

The issue seems to be that my headset doesn't seem to like very much the 
rejection of the start cmd that the daemon sends to him.
After a while when xmms starts the daemon sends a start cmd, to which 
the headset answers with a start rsp, which should indicate that 
everything is ok... however i hear no sound in the headset whatsoever :-(


Relevant hcidump log below:
 > ACL data: handle 6 flags 0x02 dlen 7
     L2CAP(d): cid 0x0041 len 3 [psm 25]
       AVDTP(s): Start cmd: transaction 4
         ACP SEID 1
< ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0054 len 4 [psm 25]
       AVDTP(s): Start rej: transaction 4
         ACP SEID 1
         Error code 25
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 06 00 01 00                                    .....
< ACL data: handle 6 flags 0x02 dlen 7
     L2CAP(d): cid 0x0054 len 3 [psm 25]
       AVDTP(s): Start cmd: transaction 0
         ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 06 00 01 00                                    .....
 > ACL data: handle 6 flags 0x02 dlen 6
     L2CAP(d): cid 0x0041 len 2 [psm 25]
       AVDTP(s): Start rsp: transaction 0
< ACL data: handle 6 flags 0x02 dlen 377
< ACL data: handle 6 flags 0x01 dlen 153
     L2CAP(d): cid 0x0056 len 526 [psm 25]
       AVDTP(m): ver 2 cc 0 pt 1 seqn 0 time 128 ssrc 1
       0000: 01 9c bf fa 20 00 00 00  00 00 00 00 00 00 7f ff  .... 
...........
       0010: 7f ff 7f ff 7f ff 7f ff  7f fe ff fd ff fb ff fb 
................
       0020: ff fb ff fb ff fb ff fb  ff f7 ff ef ff df ff df 
................
       0030: ff df ff df ff df ff df  ff bf ff 7f fe ff fe ff 
................
       0040: fe ff fe ff fe ff fe ff  fd ff fb ff f7 ff f7 ff 
................
:


Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
