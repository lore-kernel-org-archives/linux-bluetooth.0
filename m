Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4561DDBE.6040508@idlum.be>
Date: Mon, 20 Nov 2006 17:54:22 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: Bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Extracting full SDP database from device at once
	using DBus API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

At the moment, to perform a full extraction of the SDP database of a 
device, I first perform a call to

array{uint32} GetRemoteServiceHandles(string address, string match)

with an empty "match" string. It does connect to Public Browse Group, 
and returns handles for all the ServiceRecords. I then perform a call

array{byte} GetRemoteServiceRecord(string address, uint32 handle)

for each of these handles, and I get all the data in binary form ti 
interpret myself.


1) Is it the right way to do this, or is there a way to get that all at 
once?

2) As ServiceRecords are extracted "one at a time", is Bluez connecting 
and disconnecting to the device each time? Is there a performance 
penalty in doing so? If I understand the output of hcidump well, it does 
not close he ACL link each time, but there is a L2CAP 
connection/disconnection for each ServiceRecord.

Thanks a lot,
Best Regards

Pierre-Yves

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
