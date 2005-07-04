Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42C8BD9E.7070904@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to use BT headset as microphone and the souncard
 as output
References: <42BB64FE.4070002@lesagepono.be> <42BF39A6.2020305@lesagepono.be>
In-Reply-To: <42BF39A6.2020305@lesagepono.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 03 Jul 2005 22:39:58 -0600

Laurent,

SCO is designed to be low-latency. Usually if you want that low latency, 
you use the pcm i/o from the bluetooth chip directly to your 
application. That's not really an option with a general purpose computer.

The latency you get is from putting sco onboard the hci bus and the 
computer pulling it through the hci stack, but mostly squeezing it 
through kernel space/audio drivers a couple of times. you might try dd 
with a small bs instead of cat to see if that helps.

Brad

Laurent Lesage wrote:
> Well, I have part of the answer. I just used " cat /dev/dsp1 > /dev/dsp" 
> to re-route from the BT headset to the sound card. It works but there is 
> a delay of around one second : this is annoying if it has to be used for 
> a conference or training.
> 
> What is this delay due to?
> 
> Any idea appreciated :-)
> 
> Laurent
> 
> Laurent Lesage a écrit :
> 
>> Well, this is not really a BT problem but I would like to use my BT 
>> headset as microphone and allow the sound to go out through the 
>> soundcard of the computer. So the BT headset would be like a wifi 
>> microphone. Cool for presentation, training or conference. But, as far 
>> as I tried, I cannot link the sound card and the BT headset, which 
>> uses USB via dongle.
>>
>> Any idea or link?? (Linux OS)
>>
>> Laurent
>>
>>
>> -------------------------------------------------------
>> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>> from IBM. Find simple to follow Roadmaps, straightforward articles,
>> informative Webcasts and more! Get everything you need to get up to
>> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-user
> s


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
