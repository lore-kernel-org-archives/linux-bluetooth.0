Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54BBE71F.7050509@cschramm.eu>
References: <54A956DC.2050100@cschramm.eu>
	<87k30kgyxg.fsf@frog.home>
	<54BBE71F.7050509@cschramm.eu>
Date: Mon, 19 Jan 2015 17:13:18 +0200
Message-ID: <CABBYNZ+7SybGD1hMo5R+WOGzqiEp+1FRPSJDmXwWu_tgL5kKNg@mail.gmail.com>
Subject: Re: Services connected in BlueZ 5
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christopher Schramm <blueman@cschramm.eu>
Cc: Jakub Sitnicki <jsitnicki@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	blueman@ml.mate-desktop.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christopher,

On Sun, Jan 18, 2015 at 7:02 PM, Christopher Schramm
<blueman@cschramm.eu> wrote:
> Hi Jakub,
>
>> Also, in case you haven't already seen it, I think you might find
>> interesting a part of the discussion of this patchset from some time ago
>> (regarding the need to show in UI which services are connected):
>>
>> http://thread.gmane.org/gmane.linux.bluez.kernel/36507
>
> thanks for pointing me at this. Unfortunately to me Marcel confirms that
> ConnectProfile / DisconnectProfile isn't of any use for management UIs
> and even says that this is by design. That leaves me with
> Device1.Connect as the only option to connect services and no way to
> check which services have actually been connected.

You don't know what service have been registered and match with remote
device services to use them properly anyway, I do however agree that
ConnectProfile/DisconnectProfile are useless as they are right now and
having objects for each service would be better, however I wouldn't
expose them in any UI but use them for testing/debug and external
connection policies if non-standard profiles are used.

> It also seems to mean that connecting a device with a network service
> and something else, e.g. and audio service, (say a common Android device
> with tethering) results in total confusion for the user. If I'm not
> totaling seeing or doing things wrong, we e.g. have the following case:

Network and Audio are normally integrated directly into their
subsystems, if you want to connect a network use NetworkManager or
connman both will give all the information needed, this model is
actually quite similar to other buses such as USB, the only different
is that for Bluetooth you need an UI to pair and connect, but don't
except the user to know what is A2DP, HFP, etc, they have no clue.

> * Provide user with ways to connect to a) the NAP (Network1) and b) the
> "other" services (Device1).
>
> * User requests to connect to NAP -> Call Network1.Connect.

Network1.Connect is what NM and connman use to connect, the user can
use the Network UI instead so I don't see any problem with NAP in
specific.

> * Device1 changes Connected property to 1 -> Do not provide the way to
> connect to the "other" services anymore, since at least some are connected.

Device1.Connect can still be called, internally BlueZ will figure out
if there is any other service to connect to, you call it once and it
acts as you are plugging in a device and service will show in their
respective domain e.g. PulseAudio will show a new card has been added,
etc.

> This leaves the user with no way to connect to the other services if the
> NAP is already connected. Pretty unsatisfactory situation... :/

You can still connect, what you cannot do, reliably at least, is to
connect services individually from the Bluetooth UI since you have no
idea what services are enabled, most modern Bluetooth UIs work like
that nowadays except if you go into the advanced view which
traditionally have the Media and Voice settings to blacklist services
and the reason for that to exist is that apparently it was a
requirement for cars vendors, probably still is, otherwise I bet it
would be gone by now.


-- 
Luiz Augusto von Dentz
