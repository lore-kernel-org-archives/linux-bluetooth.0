Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46B1F5B9.6070107@gmail.com>
Date: Thu, 02 Aug 2007 12:18:17 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46AE7340.4010603@gmail.com>	<1185870706.27218.43.camel@ubuntu.mpl.access-company.com>	<1185871920.27218.44.camel@ubuntu.mpl.access-company.com>	<46AF1AD8.2020703@gmail.com>	<2d5a2c100707310929h1d8d48d3y5c26561c8d35cedd@mail.gmail.com>	<46AF7DF4.8010701@gmail.com>	<1185953899.21491.2.camel@ubuntu.mpl.access-company.com>	<46B0801C.6070809@gmail.com>	<2d5a2c100708012022kf3f53a0o7b227b9f51611f28@mail.gmail.com>	<46B1573A.3080003@gmail.com>	<1186059854.3574.2.camel@ubuntu.mpl.access-company.com>
	<1186059924.3574.4.camel@ubuntu.mpl.access-company.com>
In-Reply-To: <1186059924.3574.4.camel@ubuntu.mpl.access-company.com>
Subject: Re: [Bluez-devel] a2dp, sco and kernel version
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

With Frederic we have found the reason for the problem.
My config had:
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

According to the kernel desc this options are:
Tickless System (Dynamic Ticks) (NO_HZ)
This option enables a tickless system: timer interrupts will
only trigger on an as-needed basis both when the system is
busy and when the system is idle.

High Resolution Timer Support (HIGH_RES_TIMERS)
This option enables high resolution timer support. If your
hardware is not capable then this option only increases
the size of the kernel image.

I don't know yet if it's one or both options the one that makes anything 
fail (I think NO_HZ is the problem) but the thing is that I got a2dpd 
working on 2.6.22 again. I still couldn't get headsetd to work, maybe 
I'm missing a step, headsetd is telling me:
headsetd[9211]: unable to open SCO channel to headset: Function not 
implemented

And dmesg shows this lots of times:
hci_scodata_packet: hci0 SCO packet for unknown connection handle 65533
hci_scodata_packet: hci0 SCO packet for unknown connection handle 65023
hci_scodata_packet: hci0 SCO packet for unknown connection handle 65533
hci_scodata_packet: hci0 SCO packet for unknown connection handle 65023
hci_scodata_packet: hci0 SCO packet for unknown connection handle 65533
hci_scodata_packet: hci0 SCO packet for unknown connection handle 39795
hci_scodata_packet: hci0 SCO packet for unknown connection handle 27894
hci_scodata_packet: hci0 SCO packet for unknown connection handle 47

I had tried making a2dpd connect before trying to use headset but it 
keeps failing.

Anyway, my next step is trying to find out which of both kernel options 
is the one that makes a2dpd not work.

Thanks,
Manuel

>> Can you please send me your kernel config file?
>> And if anybody have (or not) the same problem, they can too saying what 
>> they have.
>>
>> Cheers,
>> Frederic
>>
>> On Thu, 2007-08-02 at 01:02 -0300, Manuel Naranjo wrote:
>>     
>>> I want to help, just tell me what you need and I get it to all for you.
>>> I work for the company that builds the USB dongle [1], and I'm using the 
>>> hifi headset we sell. So I have plenty access to almost every hardware 
>>> detail. So please let me know what you need, logs, etc, and I get it.
>>> Thanks,
>>> Manuel
>>>
>>> [1] http://www.aircable.net/host-xr.html
>>>
>>>       
>>>> Your bandwidth seems to be higher than expected,
>>>> thought we dont know how much is your bitpool.
>>>>
>>>> Here using 53 the bandwidth used is about 350 kbps,
>>>> using a value higher than 64 it starts to give me some
>>>> buffer problems.
>>>>
>>>> On 8/1/07, Manuel Naranjo <naranjo.manuel@gmail.com> wrote:
>>>>   
>>>>         
>>>>>> Make sure your stream is 44.1khz stereo
>>>>>>
>>>>>>       
>>>>>>             
>>>>> That's the first thing I had checked
>>>>>     
>>>>>           
>>>>>> Do you use the plug plugin?
>>>>>>
>>>>>> pcm.!default {
>>>>>>         type plug
>>>>>>         slave.pcm "a2dpdplug"
>>>>>> }
>>>>>>
>>>>>> pcm.a2dpdplug {
>>>>>>         type a2dpd
>>>>>> }
>>>>>>
>>>>>> Also this variant may help :
>>>>>>
>>>>>> pcm.a2dpdplug {
>>>>>>         type a2dpd
>>>>>>       rateconstraint 44100
>>>>>> }
>>>>>>
>>>>>>       
>>>>>>             
>>>>> Sorry but that didn't worked.
>>>>>
>>>>> Here's what mplayer is telling me:
>>>>> alsa-play: trying to reset soundcard
>>>>> alsa-play: write error: Broken pipe0)  2.3%
>>>>> alsa-play: trying to reset soundcard
>>>>> A:  80.9 (01:20.9) of 189.0 (03:09.0)  2.3%
>>>>>
>>>>> And this is what a2dpd says about it:
>>>>> A2DPD[09:42:05.562]: display_daemon_state: [16,16|16,16] playing
>>>>> connected clients=1 freq=1032 cnt=24833 (1032/0) poll=1048
>>>>> latency=1185972125 sec.
>>>>> A2DPD[09:42:05.616]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:05.767]: a2dp_transfer_raw: Bandwith: 79488 (621 kbps) 32,
>>>>> latency=1185972125 sec.
>>>>> A2DPD[09:42:05.826]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:05.030]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:06.234]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:06.479]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:06.631]: display_daemon_state: [16,16|16,16] playing
>>>>> connected clients=1 freq=1144 cnt=25977 (1144/0) poll=1162
>>>>> latency=1185972126 sec.
>>>>> A2DPD[09:42:06.672]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:06.836]: a2dp_transfer_raw: Bandwith: 85077 (664 kbps) 32,
>>>>> latency=1185972126 sec.
>>>>> A2DPD[09:42:06.895]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:06.103]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:07.307]: a2dp_transfer_raw: send (retry).
>>>>> A2DPD[09:42:07.508]: a2dp_transfer_raw: send (retry).
>>>>>
>>>>> Any ideas what can be wrong?
>>>>>
>>>>> Thanks,
>>>>> Manuel
>>>>>
>>>>> -------------------------------------------------------------------------
>>>>> This SF.net email is sponsored by: Splunk Inc.
>>>>> Still grepping through log files to find problems?  Stop.
>>>>> Now Search log events and configuration files using AJAX and a browser.
>>>>> Download your FREE copy of Splunk now >>  http://get.splunk.com/
>>>>> _______________________________________________
>>>>> Bluez-devel mailing list
>>>>> Bluez-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>>>
>>>>>     
>>>>>           
>>>>   
>>>>         
>>> -------------------------------------------------------------------------
>>> This SF.net email is sponsored by: Splunk Inc.
>>> Still grepping through log files to find problems?  Stop.
>>> Now Search log events and configuration files using AJAX and a browser.
>>> Download your FREE copy of Splunk now >>  http://get.splunk.com/
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>       
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Splunk Inc.
>> Still grepping through log files to find problems?  Stop.
>> Now Search log events and configuration files using AJAX and a browser.
>> Download your FREE copy of Splunk now >>  http://get.splunk.com/
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>     
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
