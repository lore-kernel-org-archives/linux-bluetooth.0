Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200903112358.05854.ybeagle@rehut.com>
References: <f9d2a5e10903111551h428ca9fekea7f6960c7666be9@mail.gmail.com>
	 <200903112358.05854.ybeagle@rehut.com>
Date: Thu, 12 Mar 2009 00:10:37 -0700
Message-ID: <f9d2a5e10903120010l4650c246h64f149cdf0d73ff3@mail.gmail.com>
Subject: Re: [beagleboard] btusb+slob
From: Russ Dill <russ.dill@gmail.com>
To: Hunyue Yau <ybeagle@rehut.com>
Cc: beagleboard@googlegroups.com, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, discussion@beagleboard.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

hcitool - HCI Tool ver 3.36

On Wed, Mar 11, 2009 at 11:58 PM, Hunyue Yau <ybeagle@rehut.com> wrote:
> Russ,
>
> What version of Bluez userland are you using?
>
> On Wednesday 11 March 2009 15:51, Russ Dill wrote:
>> After running into problems with btusb on my OMAP3 (arm) based Beagle
>> Board, I discovered that switching from SLOB to SLAB causes the
>> problems to go away. With SLOB:
>>
>> Scanning ...
>> =A0 =A0 =A0 =A0 05:16:CF:F7:04:20 =A0 =A0 =A0 n/a
>> =A0 =A0 =A0 =A0 00:11:F6:05:79:95 =A0 =A0 =A0 ....R#w
>> =A0 =A0 =A0 =A0 00:1A:8A:DB:E8:3D =A0 =A0 =A0 ....R$w9
>> =A0 =A0 =A0 =A0 00:16:CF:F7:04:20
>> =A0 =A0 =A0 =A0 05:1A:8A:DB:E8:3D =A0 =A0 =A0 n/a
>>
>> Devices:
>> =A0 =A0 =A0 =A0 hci0 =A0 =A000:00:00:00:A8:AE
>>
>> Connections:
>> =A0 =A0 =A0 =A0 < ACL 00:11:F6:05:79:95 handle 0 state 5 lm MASTER
>>
>>
>> With SLAB:
>>
>> Scanning ...
>> =A0 =A0 =A0 =A0 00:1A:8A:DB:E8:3D =A0 =A0 =A0 SGH-T629
>>
>> Devices:
>> =A0 =A0 =A0 hci0 =A0 =A000:1B:DC:0F:A8:AE
>>
>> Connections:
>> =A0 =A0 =A0 < ACL 00:11:F6:05:79:95 handle 42 state 1 lm SLAVE
>>
>> I have not been able to test on other architectures yet to determine
>> if it is another component in the chain (such as the usb OTG
>> controller) misbehaving with SLOB. This is with git latest (post
>> 2.6.29-rc7) and a number of OMAP branches.
>>
>> --~--~---------~--~----~------------~-------~--~----~
>> You received this message because you are subscribed to the Google Group=
s
>> "Beagle Board" group. To post to this group, send email to
>> discussion@beagleboard.org.
>> To unsubscribe from this group, send email to
>> beagleboard-unsubscribe@beagleboard.org For more options, visit this gro=
up
>> at http://groups.google.com/group/beagleboard?hl=3Den
>> -~----------~----~----~----~------~----~------~--~---
>
> --
> Hunyue Yau
> http://www.hy-research.com/
>
