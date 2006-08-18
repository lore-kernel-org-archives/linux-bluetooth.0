Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: John Morton <jwm@angrymonkey.net.nz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 18 Aug 2006 21:55:07 +1200
References: <200608180117.02770.jwm@angrymonkey.net.nz>
	<200608181617.59981.jwm@angrymonkey.net.nz>
	<1155899424.4075.179.camel@aeonflux.holtmann.net>
In-Reply-To: <1155899424.4075.179.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200608182155.07984.jwm@angrymonkey.net.nz>
Subject: Re: [Bluez-users] Keyboard woe
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Friday 18 August 2006 23:10, Marcel Holtmann wrote:
>  please redo it with "sdptool records --raw <bdaddr>".

> sdptool records --raw 00:0A:3A:30:D4:40
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1101 - SerialPort
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x01
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0100
                String SPP slave

>  You need to know what protocol are they using or I need a donation of
>  such a keyboard to actually hack the protocol.

Unfortunately, I bought it because I can't afford anything better at the 
moment, but they can be picked up for less than retail on Trademe (a local 
eBay-a-like trading site), so if my fortunes improve, I'll try and arrange 
it.

Might try contacting the manufacturers as they might prove to be helpful. 
Stranger things have happened...

Thanks,
John


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
