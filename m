Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C1A54A.9080103@free.fr>
Date: Tue, 14 Aug 2007 14:51:22 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46BD85F4.1090400@free.fr>
	<1186855275.6698.10.camel@violet>	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>	<1186999538.6698.141.camel@violet>
	<46C07EAC.8060407@free.fr> <1187024669.6698.214.camel@violet>
In-Reply-To: <1187024669.6698.214.camel@violet>
Subject: Re: [Bluez-devel] An explanation of a2dpd	weird	behaviour	on	high
 resolution timers enabled kernels
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

Hi Marcel, please find some comments bellow

>>> Otherwise the audio sounds too fast or frames are skipped. If you have
>>> any ideas on how we can improve pcm_bluetooth.c (yes, that handling is
>>> inside the ALSA plugin), I would like to know.
>> The issue you plotted here is a well known issue. Basically a2dp/avdtp 
>> profile does not specify how flow control is supposed to be handled, 
>> which leaves it open to implementation-specific behaviours (play faster, 
>> drop samples, use l2cap flow control...). :-(
>> The way handset makers have solved the issue is to throttle the data 
>> sending, to avoid triggering moonlight specific headset behaviours.
>> What i would suggest is to do the same thing using usleep() calls inside 
>> the alsa plugin.
> 
> we have to calculate the actual time of an SBC frame and then transmit
> it and then sleep the rest of the time before sending the next frame.
> However to have at least a little bit buffer, we should encode something
> around 3 L2CAP packets ahead. Should be something like 9-12 SBC frames.

The "something around 3 l2CAP packets" is what is called the buffer size 
in ALSA terminology. ;-)

> 
>> That will trigger another issue which is clock drifting, because the 
>> headset will supposedly consume data at master clock speed, while we 
>> will send data at host clock speed. I think for this one the best is to 
>> calculate and compensate for the drift using OCF_READ_CLOCK_OFFSET hci 
>> command: however it's just my wild guess ... ;-)
> 
> I can't see how the clock offset will help us here. It is only important
> for paging devices. All the other time, the device will re-sync their
> clocks as needed.

Ok, i will try to be more explicit then. I think you haven't catched the 
issue... yet ;-)
If you remember some of the electronics courses you certainly had, all 
electronics systems clocks are generated using quartz oscillator. Issue 
is those quartz, even if clocked officially at the same frequency, all 
beat at their own frequency.
Bluetooth spec choose to solve this issue by having the master send it's 
clock as a field of each packet sent to a slave. This way the slave is 
able to update in real time a register that stores the delta between the 
slave clock and the master clock. So each slave has an estimate of the 
master clock.
Now to come back to our streaming issues : the target is as follows.
* The A2DP headset has a unique quartz that powers both the bluetooth 
baseband and the sbc decoder/DAC part. (this is a guess, but i don't see
headset manufacturers put two quartz, as that would cost them more ;-))
* We have a usb or rs232 attached bluetooth dongle that is clocked by 
its own quartz.
* We have a main CPU whose time tracking functions are implemented using 
a timer interrupt that is based on its own quartz.

To prevent underrun audio cuts (data sent too slowly) or overrun audio 
cuts (data sent two fast), we must sent them at the *right* speed, which 
means the master clock's speed.
As the main CPU clock and the bluetooth master clock will inevitably 
drift (up to 250 ppm for the bluetooth master clock), we will have to 
compensate in software (which means in the alsa plugin). I suggest using 
the above given HCI command to retrieve the master clock.

I hope this is more clear :-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
