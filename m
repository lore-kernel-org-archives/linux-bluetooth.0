Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <44F5C4B8.7000407@arcor.de>
Date: Wed, 30 Aug 2006 19:02:48 +0200
From: Simon Siemens <Simon.Siemens@arcor.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44EC4CFC.4060400@arcor.de> <44F45E3F.7050507@csr.com>
In-Reply-To: <44F45E3F.7050507@csr.com>
Subject: Re: [Bluez-users] Inquiry in Bluetooth 1.2
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

Thanks a lot for the good explanation, Steven. I am currently doing some
empirical tests to see what this means with real devices. Maybe I can
post some results next week.

Interesting is also, that a Nokia N70 claims to be a Bluetooth v2.0
device, but does not advertise the enhanced inquiry feature, which is
mandatory.

$ sudo hcitool info 00:17:4B:14:F2:A8
Requesting information ...
BD Address: 00:17:4B:14:F2:A8
Device Name: Nokia N70
LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xbf 0xee 0x0f 0x46 0x98 0x19 0x00 0x00
<3-slot packets> <5-slot packets> <encryption> <slot offset>
<timing accuracy> <role switch> <sniff mode> <RSSI>
<channel quality> <SCO link> <HV3 packets> <u-law log>
<A-law log> <CVSD> <paging scheme> <power control>
<transparent SCO> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps>
<inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
<3-slot EDR ACL> <5-slot EDR ACL> <AFH cap. master>
<AFH class. master>

But I think (hope :-)) there will be more and more mobile phones with
enhanced and interlaced inquiry in the future.

Thanks again, Simon


Steven Singer schrieb:
> Simon Siemens wrote:
>   
>> So what is this enhanced inquiry scan? How is it compared to the old
>> v1.1 inquiry scan? How can I activate it?
>>     
>
> Here's an answer I wrote to someone else who asked me this question
> today.
>
> I've not checked all the details and I may have simplified in places, but
> it should be close enough for you to understand the difference.
>
> -------------------------------------------------------------------------
> Enhanced inquiry scan is a mandatory feature in 1.2 and is not a feature
> that can be turned on and off. All 1.2 devices do enhanced inquiry scan
> all the time.
>
> Enhanced inquiry scan is entirely backwards compatible with the inquiry
> procedure in 1.1 and earlier (in fact, the inquiry procedure was not
> changed between 1.1 and 1.2).
>
> The enhancement is just a minor change to the inquiry scan timing. In
> BT 1.1 the inquiry scan procedure is:
>
>     1) Go into scan for the time specified by the inquiry scan window.
>     2a) If you don't receive an ID packet before the end of the window:
>        + wait until the next inquiry scan interval
>        + go to stage 1
>     2b) if you receive an ID packet before the end of the window:
>        + back off for 0..1023 slots
>        + go into inquiry scan again for 128 slots.
>        + if you receive an ID packet before the end of the 128 slots:
>          * send an FHS packet
>          * go to stage 1
>        + If you don't receive an ID packet before the end of the 128
>          slots:
>          * go to stage 1
>
> In 1.2, the procedure is simplified to:
>
>     1) Go into scan for the time specified by the inquiry scan window.
>     2a) If you don't receive an ID packet before the end of the window:
>        + wait until the next inquiry scan interval
>        + go to stage 1
>     2b) if you receive an ID packet before the end of the window:
>        + send an FHS packet
>        + back off for 0..1023 slots
>        + go to stage 1
>
> The big difference is that in 1.1 you a device backs off before it
> responds and then must be hit in a window after the backoff, whereas,
> in 1.2 a device responds in its normal window before it backs off.
>
> This means that 1.2 devices respond sooner than 1.1 devices. This
> means that responses can be collected faster.
>
> Also, with the 1.1 procedure, there was a chance that even with perfect
> radio conditions, it was possible to have a timing such that not all
> devices could respond. In 1.2, that pathology has been removed so that
> all devices should be detected (assuming there are no collisions).
> -------------------------------------------------------------------------
>
> The timing pathology I refer to is when a 1.1 device receives the initial
> ID packet just before the inquirer changes trains (which someone's
> already explained in this thread). In that case, after the backoff, the
> scanner is listening while the inquirer is on the other train. By the
> time the inquirer has returned to this train, the 128 slot timeout has
> expired and the scanner needs to be hit twice to respond.
>
> I hope this helps.
>
> 	- Steven
>   

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
