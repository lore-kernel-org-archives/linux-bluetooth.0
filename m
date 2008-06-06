Return-Path: <cyrus@holtmann.org>
Message-ID: <48496FF8.3050701@in.tum.de>
Date: Fri, 06 Jun 2008 19:12:24 +0200
From: Aleksandar Kanchev <kanchev@in.tum.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] D-Bus API for SDP_ServiceSearchAttributeRequest
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

Hello,

is there a BlueZ D-Bus API which uses the 
SDP_ServiceSearchAttributeRequest PDU, i.e. it should return all service 
records and not just the handles.
Under http://wiki.bluez.org/wiki/Adapter I could only find:

array{uint32} GetRemoteServiceHandles(string address, string match) - 
SDP_ServiceSearchRequest
array{byte} GetRemoteServiceRecord(string address, uint32 handle) - 
SDP_ServiceAttributeRequest
string GetRemoteServiceRecordAsXML(string address, uint32 handle) - 
SDP_ServiceAttributeRequest

best regards,
Aleksandar


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
