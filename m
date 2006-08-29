Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F43AA3.3020600@evilgenius.de>
Date: Tue, 29 Aug 2006 15:01:23 +0200
From: Martin Karger <martin@evilgenius.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F22717.1080308@evilgenius.de>	<1156772287.5613.31.camel@aeonflux.holtmann.net>	<44F32933.90808@evilgenius.de>	<1156799873.5613.51.camel@aeonflux.holtmann.net>	<44F353E9.7080406@evilgenius.de>
	<1156809428.5613.59.camel@aeonflux.holtmann.net>
In-Reply-To: <1156809428.5613.59.camel@aeonflux.holtmann.net>
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
>>>> i just realised that the problem is not changing the value of remver.
>>>> the output of hcidump looks good. i can store differnt values in psi or
>>>> psram.
>>>>
>>>> the problem seems to be somewhere else:
>>>>
>>>> PSKEY_LMP_REMOTE_VERSION has the value 0x0003 which is for LMP Version
>>>> 2.0 i guess. but the output of hcitool info shows the wrong value (0x2)
>>>>
>>>> # bccmd -i hci1 psget remver
>>>> The LMP version reported remotely: 0x0003 (3)
>>>> # hcitool info 00:0A:94:02:12:34
>>>> Requesting information ...
>>>>         BD Address:  00:0A:94:02:12:34
>>>>         Device Name: BlueZ (1)
>>>>         LMP Version: 1.2 (0x2) LMP Subversion: 0x5dc
>>>>         Manufacturer: Cambridge Silicon Radio (10)
>>> the remote version is the version that the other side will see. However
>>> what is the reason for playing around with this. You better use psclr to
>>> remove this key and let the firmware set the default value.
>>>
>> first reason to play around with it: the remote version is wrong for
>> this bt-dongle. i think it should be 0x3 not 0x2.
>> second reason is, i want to find out, if its possible to "clone" a
>> bt-device. not only the address but also things like lmp-version or
>> features of a device.
> 
> you can change the LMP version and the features. In case of CSR the LMP
> subver is not changeable, because this is the build id of the firmware.
> 
>> when i am able to delete/clear a pskey, can also wonder if i can create
>> a new pskey entry.
> 
> Sure. You can do whatever you want the PS storage. Including rendering
> your device useless.
> 

as peter already pointed out bccmd is a very powerful program, i guess
reading the csr-documentation about the bccmd commands is a good idea.

right now i am having no idea how to add a new pskey. modifying and
delting works for me, but i did not yet found out how to create a new
one. it would be great if i could add a pskey with features to ps storage.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
