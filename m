Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4F35DE52-6E93-4668-95D5-8D5D1E5C9DFA@keyinitiative.com>
References: <4F35DE52-6E93-4668-95D5-8D5D1E5C9DFA@keyinitiative.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 11 Aug 2016 09:01:21 +0100
Message-ID: <CAAu3APY6aF9BckMfuH+2Ua7M=oHZuf7ghJVKT0t0_j0mSLyEBA@mail.gmail.com>
Subject: Re: Eddystone scanning - TLM packet
To: Jason Anderssen <j@keyinitiative.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Jason,


On 11 August 2016 at 02:53, Jason Anderssen <j@keyinitiative.com> wrote:
> Hi,
>
> I have successfully written code to scan for iBeacons using bluez, I was wondering if there is a link to some example or doc that explains how to detect the eddy stone different frames, for example, the main one I am after is the  Eddystone-TLM data which can be interleaved.
> Any help or direction I can search would be fantastic.

The different Eddystone frames are identified at the start of the
service data. TLM is 0x02 as detailed in the spec at:
https://github.com/google/eddystone/blob/master/protocol-specification.md

You may also find this beacon cheat-sheet useful that was posted on Twitter:
https://twitter.com/josryke/status/763006284052463617

Hope that helps.

Regards,
Barry

>
> Thanks in advance for any advice or help.
>
> Cheers
> Jason   --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
