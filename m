Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3FE530.4090508@start.ca>
Date: Mon, 08 Aug 2011 09:31:28 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Permission denied (13) on Samsung WEP475 headset?
References: <4E3A7E09.6040503@start.ca>  <20110804121703.GA23534@dell>  <1312469666.2158.8.camel@THOR> <1312641412.2202.12.camel@THOR>  <4E3D5EC9.9040400@start.ca> <1312649428.2202.26.camel@THOR>  <4E3D7866.2020804@start.ca> <1312807101.2202.48.camel@THOR>
In-Reply-To: <1312807101.2202.48.camel@THOR>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 08/08/2011 08:38 AM, Peter Hurley wrote:
> On Sat, 2011-08-06 at 13:22 -0400, Colin Beckingham wrote:
>> On 08/06/2011 12:50 PM, Peter Hurley wrote:
>>> On Sat, 2011-08-06 at 11:33 -0400, Colin Beckingham wrote:
>>>> Hi Peter:
>>>>
>>> ...<snip>...
>>>> I ran # hciconfig hci0 sspmode 1 to force the adapter into a secure attempt.
>>>>
>>>> I downloaded and installed the latest hcidump which identifies itself
>>>> (hcidump -v) as 2.0 even though it is marked as 2.1 version on the webpage.
>>>>
>>>> Made another attempt to connect, here is the syslog
>>>>
>>>> # tail -n 100 /var/log/messages | grep bluetoothd
>>>> Aug  6 05:15:39 linux-c96h bluetoothd[1246]: Audio connection got
>>>> disconnected
>>>> Aug  6 11:23:29 linux-c96h bluetoothd[1246]: Rejecting request: remote
>>>> device can't provide MITM
>>>> Aug  6 11:23:56 linux-c96h bluetoothd[1246]: Discovery session
>>>> 0x7f801d0a6ca0 with :1.4178 activated
>>>> Aug  6 11:24:01 linux-c96h bluetoothd[1246]: Stopping discovery
>>>> Aug  6 11:24:13 linux-c96h bluetoothd[1246]: Permission denied (13)
>>>>
>>>> and a binary hcidump is attached.
>>>
>>> Hi Colin,
>>>
>>> That makes a lot more sense!
>>>
>>> Would you please repeat the experiment with bluetoothd in debug mode,
>>> though? That would give me a lot more information to work with about how
>>> bluetoothd got to that point.
>>>
>>> As before, please capture hcidump binary at the same time. Also please
>>> include every bluetoothd syslog message starting from the start of the
>>> experiment.
>>>
>>> I appreciate your patience helping me to track down this bug.
>>>
>>> Regards,
>>> Peter Hurley
>>
>> Sorry, forgot to set bluetoothd in debug mode.
>>
>> Attached are my latest logs, 2 files, wep475a.*. Note in the syslog that
>> the first entry is timestamped way before the experiment was launched,
>> so the log should have everything that bluetoothd wrote for the current
>> experiment.
>
> Hi Colin,
>
> Well, the new logs did not recreate the "Rejecting request: remote
> device can't provide MITM". However, they did show 2 things:
>
> 1. The host controller has a race condition bug which has been seen
> before (see this thread
> http://comments.gmane.org/gmane.linux.bluez.kernel/14286 for the really
> technical discussion)
>
> That's why the initial attempt by the device at connecting an RFCOMM
> channel is rejected (@ 13:13:02.533713).
>
> Nevertheless, the headset is found anyway and Bluez connects to the
> headset. After establishing an insecure SDP link, Bluez attempts to open
> an RFCOMM channel to the device, and
>
> 2. the kernel attempts to connect the RFCOMM channel prior to the link
> being encrypted, so the device rejects the connection.
>
> There were some last minute changes to 3.0 final that directly impacts
> how this is supposed to work. However, even with those changes it's
> unclear to me how #2 is happening.
>
> Would you be willing to run the same experiment as before but with the
> kernel bluetooth module enabled for debug output?  If your kernel is
> configured for dynamic debug (Kernel hacking/Enable dynamic printk()
> support =>  Y), doing this is trivial:
> # sudo su
> # echo -n "module bluetooth +p"
>                      >  /sys/kernel/debug/dynamic_debug/control
> <  perform experiment>
> # echo -n "module bluetooth -p"
>                      >  /sys/kernel/debug/dynamic_debug/control
>
> Regards,
> Peter Hurley

Peter, before I do this, let me just verify that my kernel is set up 
right. I checked for dynamic printk and I am not clear that I have the 
setting needed. Here is what my .config tells me for dynamic and printk 
separately.

 > cat .config | grep DYNAMIC
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_SND_DYNAMIC_MINORS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_DEBUG=y

 > cat .config | grep PRINTK
CONFIG_PRINTK=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_PRINTK_TIME=y
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y

Could you confirm that I am ok to go?
-- 
---
Colin Beckingham
