Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44AEC88B.4090803@runbox.com>
Date: Fri, 07 Jul 2006 21:48:11 +0100
From: Tom K <tomk@runbox.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44A9923A.4050200@runbox.com>	<e1effdeb0607040642j3c3e0a34l67565401acb2f318@mail.gmail.com>	<44AADFBA.1030901@runbox.com>
	<e1effdeb0607071117q1a22bb24yfdefc69377c9acb8@mail.gmail.com>
In-Reply-To: <e1effdeb0607071117q1a22bb24yfdefc69377c9acb8@mail.gmail.com>
Subject: Re: [Bluez-devel] hcid fails to start after upgrade
 to	bluez-libs/bluez-utils 3.1 (Continued)
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

Claudio Takahasi wrote:
> Hi Tom,
>
> this dump doesn't contain the command status and the command complete events.
> Could you send it again with "hcidump -X -a -V"?
>
> BR,
> Claudio.
>   
OK - how's this:

$ hcidump -X -a -V -r bt20060704.dump
HCI sniffer - Bluetooth packet analyzer ver 1.29
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
 > HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 1
    status 0x00
    ACL MTU 128:8 SCO MTU 64:8
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:04:76:AD:12:E3
< HCI Command: Set Event Filter (0x03|0x0005) plen 2
    type 0 condition 0
    Clear all filters
 > HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
    timeout 32768
 > HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 1
    status 0x00
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
    timeout 32000
 > HCI Event: Command Complete (0x0e) plen 4
    Write Page Timeout (0x03|0x0018) ncmd 1
    status 0x00
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1
    status 0x00
 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 1.0b (0x0) HCI Revision: 0x61
    LMP Version: 1.1 (0x1) LMP Subversion: 0x61
    Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
    mode 0
< HCI Command: Reset (0x03|0x0003) plen 0

That's one Status and nine Complete - is that OK, or will I capture a 
new dump?

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
