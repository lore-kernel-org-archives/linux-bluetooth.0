Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJN7b3aQAUPw=Lx0SSooW20Dkyan1OL-MZTw4xaSQpQgw@mail.gmail.com>
References: <CACA6DsU+5gp_diykBarJhmJ_WTLwVZc==CbPOVRKfkHdEtBY0w@mail.gmail.com>
 <CABBYNZJN7b3aQAUPw=Lx0SSooW20Dkyan1OL-MZTw4xaSQpQgw@mail.gmail.com>
From: Bruno Bruzzano <brunano21@gmail.com>
Date: Thu, 21 Nov 2013 09:07:15 -0500
Message-ID: <CACA6DsVt_Q38k6CGP5=9iUCRSPU9sP4hTogs97Po6_Mi-oUBfg@mail.gmail.com>
Subject: Re: BUG??
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I did as you suggested, disabling temporarily the SELinux.
Unfortunally the result is the same. Here I made a pastebin which
shows the last part of the connection and the fail.

Let me know. Thanks!.
Best Regards,
Bruno Bruzzano

On Thu, Nov 21, 2013 at 7:02 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bruno,
>
> On Thu, Nov 21, 2013 at 12:18 AM, Bruno Bruzzano <brunano21@gmail.com> wrote:
>> Hi all,
>>
>> Maybe I encountered a bug. I'm using git version of Bluez5 on Fedora
>> 20 beta and all crash when I try to connect to a generic profile. In
>> particular, the steps to reproduce it are the following:
>> - start bluetooth daemon (with -ndE args)
>> - using bluetoothctl (in client folder):
>> -- agent on
>> -- scan on
>> -- wait to discovery my android device
>> -- scan off
>> -- pair maddr -> pair complete!
>>
>> After that I try to connect using AVRCP profile. It works.
>> The problem appears when a tap on my smartphone's player. Bluetoothd crashes!!
>>
>> Here, you can find some pastebins.
>> bluetoothd -> http://pastebin.com/ZSER2Df6
>> bluetoothctl -> http://pastebin.com/rexVrruB
>>
>> I hope someone can give me a feedback or a
>> tip!
>
> Give the following message I believe there is something wrong with the
> D-Bus conf file:
>
> bluetoothd[2009]: src/agent.c:simple_agent_reply() agent error reply:
> org.freedesktop.DBus.Error.NoReply, Message did not receive a reply
> (timeout by message bus)
> bluetoothd[2009]: Access denied: Message did not receive a reply
> (timeout by message bus)
>
> Also it is quite possible that bluetoothd is being disconnected from
> D-Bus due to SELinux policy, you can try disabling it and see if that
> works, if it does then we need to let the fedora folks know so they
> add a proper rule for it.
>
>
> --
> Luiz Augusto von Dentz
