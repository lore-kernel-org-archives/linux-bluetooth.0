Return-Path: <cyrus@holtmann.org>
Message-ID: <512E15F5.4010909@kamens.us>
Date: Wed, 27 Feb 2013 09:19:33 -0500
From: Jonathan Kamens <jik@kamens.us>
MIME-Version: 1.0
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: HFP/HSP Telephony profile doesn't work with Bluetooth USB dongle
References: <51100E6E.8070804@kamens.us> <CAJdJm_MsOBOGTBoG+Nua49DbwuXx5Pu5KRm9zMp2ma3_nhF2CQ@mail.gmail.com> <512A82B3.405@kamens.us> <CABBYNZLRZkosRo95TDGMOwfD4-QB5NgP7erT1CoWzGbdq=o-ig@mail.gmail.com>
In-Reply-To: <CABBYNZLRZkosRo95TDGMOwfD4-QB5NgP7erT1CoWzGbdq=o-ig@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/25/2013 04:25 AM, Luiz Augusto von Dentz wrote
> The SCO connection seems to be established without problems:
>
>> HCI Event: Command Status (0x0f) plen 4
>      Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17
>      status 0x00 handle 6 bdaddr 00:12:3D:00:48:FD type eSCO
>      Air mode: CVSD
>
> But I cannot see any packets which might be the cause of your problem,
> so it might be a controller/driver related not PulseAudio problem. You
> can check what is the current voice settings of the controller by
> doing:
>
>> sudo hciconfig hci0 voice
I am an experienced software developer but have no experience whatsoever 
with Bluetooth software development or the Bluetooth protocol, so if you 
could try to limit the use of, or at least explain, the 
Bluetooth-related technical terms you are using, that would be helpful. 
I'm afraid most of the above is gobbledygook to me.

For example, I don't know what the "SCO connection" is. Just to be 
clear, remember that the behavior I'm experiencing is that my headset 
works just find in A2DP mode, but not int HSP/HFP mode. If the "SCO 
connection" is something that would be relevant to both modes, and I 
don't know whether it is because I don't know these terms, then it's 
understandable that the dump would show a successful SCO connection; as 
I mentioned before, in the dump, the headset starts out just fine in 
A2DP mode and only stops working when I try to switch to HSP/HFP.

I also mentioned before, or at least I think I did, that this same 
headset works fine with my ThinkPad with built-in (as opposed to USB 
dongle) Bluetooth hardware, running the same version of Linux as my 
desktop that isn't working with the dongle, so I had always assumed that 
it was likely to be a "controller/driver related not PulseAudio 
problem"; it seems to me that if it were a PulseAudio problem, it 
wouldn't work on the laptop either.

It is possible that you already know and understand everything I've 
clarified above, and I'm wasting your time and mine by restating things 
:-/, but I can't tell whether that's the case because there is so much 
here about Bluetooth that I don't understand, so I thought it important 
to make sure everything is clear. I'm sorry if I'm telling you things 
you already know.

Here is what "hciconfig hci0 voice" prints when I connect to the headset 
in A2DP mode:

hci0:    Type: BR/EDR  Bus: USB
     BD Address: 00:02:72:32:77:9C  ACL MTU: 1021:8  SCO MTU: 64:1
     Voice setting: 0x0060 (Default Condition)
     Input Coding: Linear
     Input Data Format: 2's complement
     Input Sample Size: 16 bit
     # of bits padding at MSB: 0
     Air Coding Format: CVSD

When I use the Sound Settings applet to switch to HSP/HFP mode and run 
"hciconfig hci0 voice" again, it says *exactly the same thing*; there is 
not a single character different in the output? Should it be different?

Here's another interesting (or so it seems to me) piece of 
information... While the headset was switched into HSP/HFP mode and not 
working, pidgin generated a sound, which of course I did not hear 
because the audio wasn't working. When I switched back to A2DP mode, 
that sound, delayed by several minutes, played through the headset 
immediately.

Please tell me what more I can do to help debug this further.

Thanks for your help.

Regards,

Jonathan Kamens

