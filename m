Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1080565272.3913901258382253455.JavaMail.root@sz0149a.westchester.pa.mail.comcast.net>
References: <dfb262380911160209v42da3134y8e645b33ac65ccdb@mail.gmail.com>
	 <1080565272.3913901258382253455.JavaMail.root@sz0149a.westchester.pa.mail.comcast.net>
Date: Mon, 16 Nov 2009 21:46:32 +0200
Message-ID: <dfb262380911161146j3b0b52a2o55b1b6f9c055534c@mail.gmail.com>
Subject: Re: bluetooth audio fails
From: Ramagudi Naziir <naziirr@gmail.com>
To: marjnkl@comcast.net
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Mon, Nov 16, 2009 at 4:37 PM,  <marjnkl@comcast.net> wrote:
> and daemon mode off.  That is, run /usr/sbin/bluetoothd -nd.  This will spit

thank you - good tip !

These are the logs I see when I try to run the aplay command:

bluetoothd[1260]: Accepted new client connection on unix socket (fd=23)
bluetoothd[1260]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1260]: sending error Input/output error(5)
bluetoothd[1260]: Audio API: BT_ERROR -> BT_GET_CAPABILITIES
bluetoothd[1260]: Unix client disconnected (fd=23)
bluetoothd[1260]: client_free(0x2a09f318)


> helpful.  Also, in your .asoundrc file you may want to try profile "auto" or
> just remove the line completely.

change applied (same results, though).

> you may want to try the bluez-gnome to assist in pairing and connecting the
> headset.

can't - I have no screen :)

I use the C agent for that:

# /test/agent 0000 00:14:13:00:25:93
Pincode request for device /org/bluez/1260/hci0/dev_00_14_13_00_25_93
Agent has been released

It seems successful, and indeed the device seems to be paired.
What strikes me as odd is that I can't see any link-key info in
/var/lib/bluetooth.
I only see there my laptop and no headset which I seem to pair with
successful (and I've tried already 3 different headsets, all yield the
same result).


Besides that, I see 2 errors in the logs.

1. while executing running bluetoothd, I see this line:
bluetoothd[1260]: Failed to open control socket: Protocol not supported (93)
Is this bad or can I ignore it ? what socket is it ? NETLINK ? what it
is used for ?

2. while adding (+up'ing) hci0, I see this line:
(bluetoothd:1260): GLib-CRITICAL **: g_key_file_get_boolean: assertion
`key_file != NULL' failed
...
bluetoothd[1260]: Adapter /org/bluez/1260/hci0 has been enabled
bluetoothd[1260]: Failed to access HAL

can you pls also tell me what are those errors and whether I should debug them ?

>  It provides a nice visual interface.  Anyway hope this helps a
> little and if you have any additional info please post it.

Thanks a lot for the help!!!!!

naziir.

>
>   - Mark
>
> ----- Original Message -----
> From: "Ramagudi Naziir" <naziirr@gmail.com>
> To: linux-bluetooth@vger.kernel.org
> Sent: Monday, November 16, 2009 5:09:23 AM GMT -05:00 US/Canada Eastern
> Subject: Re: bluetooth audio fails
>
> I have just tried that with bluez 3.36 and it works!
>
> So - should I downgrade to bluez 3.36 ?
>
> Can you just tell me how you would debug this ?
>
> On Sun, Nov 15, 2009 at 2:31 PM, Ramagudi Naziir <naziirr@gmail.com> wrote:
>> I have just tried that also with a Motorola H700 headset,
>> and got exact same error message.
>>
>> (I also tried bluez 4.56 and got same error)
>>
>> please help me to debug this.
>>
>> thank you,
>> naziirr
>>
>>
>> On Sat, Nov 14, 2009 at 8:26 PM, Ramagudi Naziir <naziirr@gmail.com>
>> wrote:
>>> Hi all,
>>>
>>> Can anyone pls help me debug this:
>>>
>>> # aplay -D bluetooth /startup.wav
>>> ALSA lib audio/pcm_bluetooth.c:1607:(audioservice_expect)
>>> BT_GET_CAPABILITIES failed : Input/output error(5)
>>> aplay: main:608: audio open error: Input/output error
>>>
>>> I'm running the latest bluez git sources with a 9xxPlantronics HFP
>>> headset.
>>> I tried both "auto" and "voice" in .asoundrc:
>>>
>>> pcm.bluetooth {
>>>        type bluetooth
>>>        device mybdaddr
>>>        profile “voice”
>>> }
>>>
>>>
>>> Any idea what this could be and how to debug/fix it ?
>>>
>>> thank you
>>> naziirr
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
