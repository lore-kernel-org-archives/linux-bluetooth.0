Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F32933.90808@evilgenius.de>
Date: Mon, 28 Aug 2006 19:34:43 +0200
From: Martin Karger <martin@evilgenius.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F22717.1080308@evilgenius.de>
	<1156772287.5613.31.camel@aeonflux.holtmann.net>
In-Reply-To: <1156772287.5613.31.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] flexible bt-dongle and bccmd
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

Marcel Holtmann wrote:
> Hi Martin,
> 
>> i am looking for a (csr-based) bt-dongle where you can at least change
>> the following things: bdaddr, features, remver and manufacturer.
>>
>> i am currently owning a bt-6030. i am able to change the key "version",
>> but not "remver". does anyone have an idea on this?
> 
> maybe this firmware doesn't have the key for remote version. You can use
> hcidump -X -V to check the actual return value of the command.

hi marcel,

i just realised that the problem is not changing the value of remver.
the output of hcidump looks good. i can store differnt values in psi or
psram.

the problem seems to be somewhere else:

PSKEY_LMP_REMOTE_VERSION has the value 0x0003 which is for LMP Version
2.0 i guess. but the output of hcitool info shows the wrong value (0x2)

# bccmd -i hci1 psget remver
The LMP version reported remotely: 0x0003 (3)
# hcitool info 00:0A:94:02:12:34
Requesting information ...
        BD Address:  00:0A:94:02:12:34
        Device Name: BlueZ (1)
        LMP Version: 1.2 (0x2) LMP Subversion: 0x5dc
        Manufacturer: Cambridge Silicon Radio (10)


and btw, what is PSKEY_HOST_INTERFACE for?

thanks,
martin

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
