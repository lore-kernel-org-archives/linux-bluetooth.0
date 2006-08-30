Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F55AE5.40401@intec.ugent.be>
Date: Wed, 30 Aug 2006 11:31:17 +0200
From: Dieter Verslype <Dieter.Verslype@intec.ugent.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F54A39.6060704@intec.ugent.be>
In-Reply-To: <44F54A39.6060704@intec.ugent.be>
Subject: Re: [Bluez-devel] Registering service / Getting data
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

Hello list,

found it myself :) I was confusing the service ID with the Service Class 
UUID list.

I just added this in the register_service() method:

//SERVICE CLASS UUID
uint16_t class_uuid_int = 0x1101;
sdp_uuid16_create( &class_uuid, class_uuid_int );
class_list = sdp_list_append( class_list, &class_uuid);
sdp_set_service_classes( record, class_list );

This results in:

root@laptop:/home/dvrslype# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Health Monitor Service
Service Description: Captures Bluetooth packages and stores in SQL_DB
Service Provider: IBCN-Niko
Service RecHandle: 0x10000
Service Class ID List:
"Serial Port" (0x1101)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 11

Service Name: KBtSerialChat
Service Description: KDE Bluetooth Serial Chat Service
Service RecHandle: 0x10001
Service Class ID List:
"Serial Port" (0x1101)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 5

gr,

Dieter

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
