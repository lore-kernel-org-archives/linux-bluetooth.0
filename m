Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACA6DsU+5gp_diykBarJhmJ_WTLwVZc==CbPOVRKfkHdEtBY0w@mail.gmail.com>
References: <CACA6DsU+5gp_diykBarJhmJ_WTLwVZc==CbPOVRKfkHdEtBY0w@mail.gmail.com>
Date: Thu, 21 Nov 2013 14:02:59 +0200
Message-ID: <CABBYNZJN7b3aQAUPw=Lx0SSooW20Dkyan1OL-MZTw4xaSQpQgw@mail.gmail.com>
Subject: Re: BUG??
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bruno Bruzzano <brunano21@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruno,

On Thu, Nov 21, 2013 at 12:18 AM, Bruno Bruzzano <brunano21@gmail.com> wrote:
> Hi all,
>
> Maybe I encountered a bug. I'm using git version of Bluez5 on Fedora
> 20 beta and all crash when I try to connect to a generic profile. In
> particular, the steps to reproduce it are the following:
> - start bluetooth daemon (with -ndE args)
> - using bluetoothctl (in client folder):
> -- agent on
> -- scan on
> -- wait to discovery my android device
> -- scan off
> -- pair maddr -> pair complete!
>
> After that I try to connect using AVRCP profile. It works.
> The problem appears when a tap on my smartphone's player. Bluetoothd crashes!!
>
> Here, you can find some pastebins.
> bluetoothd -> http://pastebin.com/ZSER2Df6
> bluetoothctl -> http://pastebin.com/rexVrruB
>
> I hope someone can give me a feedback or a
> tip!

Give the following message I believe there is something wrong with the
D-Bus conf file:

bluetoothd[2009]: src/agent.c:simple_agent_reply() agent error reply:
org.freedesktop.DBus.Error.NoReply, Message did not receive a reply
(timeout by message bus)
bluetoothd[2009]: Access denied: Message did not receive a reply
(timeout by message bus)

Also it is quite possible that bluetoothd is being disconnected from
D-Bus due to SELinux policy, you can try disabling it and see if that
works, if it does then we need to let the fedora folks know so they
add a proper rule for it.


-- 
Luiz Augusto von Dentz
