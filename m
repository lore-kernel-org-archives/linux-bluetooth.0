Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4550BC83.6070607@gmail.com>
Date: Tue, 07 Nov 2006 17:04:03 +0000
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4550A095.6060000@gmx.de> <20061107155257.GB22290@suse.de>
In-Reply-To: <20061107155257.GB22290@suse.de>
From: Simon Williams <systemparadox@googlemail.com>
Subject: Re: [Bluez-users] usb-device cannot be found by other
	bluetooth	devices
Reply-To: systemparadox@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Stefan Seyfried wrote:
> Hi Smobbl
> 
> (i would complain to your parents about that name :-)
> 
> On Tue, Nov 07, 2006 at 04:04:53PM +0100, Smobbl_Bobbl wrote:
>> hi!
>>
>> can someone help me to make my usb-stick "searchable" by other devices?
>>
>> i installed mandriva linux 2007, with all the bluetooth things.
>> i can send files to other devices (handy, pda...), but if i search in my 
>> handy for other near devices, i cannot find the usb-stick!
>> if i want the handy to pair with the pc (initiated by pc), the handy 
>> says i have to input my password. if i do so, my phone shows a 
>> progressbar, but in the end it fails.
> 
> do you have a passkey-agent registered?
>> can someone help me to make my usb-stick "searchable" by other devices?
> 
> use "apitest" to set the DiscoverableTimeout to 0:
> 
>     apitest SetDiscoverableTimeout 0
> 
> then set your device to discoverable:
> 
>     apitest SetMode discoverable
> 
> verify your settings with
> 
>     apitest IsDiscoverable
>     apitest GetMode
>     apitest GetDiscoverableTimeout
> 

Alternatively, make sure that hscan and pscan are enabled for that device.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
