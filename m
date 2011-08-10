Return-Path: <cyrus@holtmann.org>
Message-ID: <4E425061.6080206@nokia.com>
Date: Wed, 10 Aug 2011 12:33:21 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com
CC: ext Claudio Takahasi <claudio.takahasi@openbossa.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>	<1309309092.2208.25.camel@aeonflux>	<CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com> <CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com> <4E3A5BFB.1050201@nokia.com>
In-Reply-To: <4E3A5BFB.1050201@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hello Marcel and Johan,

On 08/04/2011 11:44 AM, Antti Julku wrote:
>
> This issue was discussed in the IRC. It seem that for LE, fast
> connection is needed only on the initiator side for outgoing connections
> (LE scan/connection establishment parameters), since 4.0 spec forbids LE
> connections between dual mode devices. So fast connectable mode on the
> LE acceptor side would be only used for testing purposes, or if spec is
> changed, or if single mode hw is supported in the future.
>
> For BR/EDR, as Dmitriy explained, the fast connectable use case is to
> make headset to be able to connect faster when there is an incoming call
> (user switches headset on when call is alerting). It's an enhancement
> for headset connection time and usability.
>
> It is currently implemented in hciops by changing page scan settings
> while incoming call is alerting. HCI commands Write Page Scan Activity
> and Write Page Scan Type are used to change page scan type from standard
> to interlaced and interval 1.28 s => 22.5 ms. This makes the incoming
> connection about 1 s faster. Settings are changed only for a short time
> to minimize impact on power consumption.
>
> In my opinion BR and LE cases are quite different, so I think it would
> make sense to keep these separate and not to put them in one mgmt
> command. Could we just add a generic mgmt command for setting BR page
> scan parameters, for example "Set Page Scan Parameters Command" which
> would take parameters type (standard or interlaced), interval, and window?
>
> Br,
> Antti

Any comments on this one? There has been lot of ideas about how the 
"fast connectable mode" for incoming connections should be implemented 
for management interface, and whether the same mgmt command should be 
used for both BR and LE. It's not totally clear yet what is needed for 
LE, but at least the Proximity profile requires changing the advertising 
parameters to make connecting faster.

Which option do you prefer?

1) Unified mgmt command for both BR and LE: fast connectable mode toggling.
  + simple interface for both BR and LE
  - scan/advertising parameters are hardcoded to kernel
  - BR page scan and LE advertising are two different things, why to mix 
them in same mgmt command?
  - not even needed currently by LE: only if single mode dongles will be 
supported, or spec is changed to allow dual mode device to accept LE 
connections

2) Command for BR and LE as in option 1, in addition we could define 3 
values. e.g. slow, normal, fast.
  + flexible to support LE advertising settings (when we support single 
mode dongles)

3) The patch I sent, fast connectable mode only for BR. If on/off 
toggling is enough for LE, it's easy to add LE support later.

4) Mgmt command for setting parameters for BR/LE/both to kernel, and 
another for toggling fast connectable on/off
  + more flexible than just toggling
  - two mgmt commands needed

5) Mgmt command for changing BR page scan parameters, e.g "Set Page Scan 
Parameters".
  + simplest solution for BR, since it's currently only needed for 
optimizing scan parameters for HFP connections
  + generic interface which can be used also for other purposes, no need 
to have concept of "fast connectable mode" in the kernel
  + more flexible for user space, if values need to be changed, or 
optimized for another purpose
  - too low level stuff for mgmt interface?
  - another solution needed for LE

6) Something else.

Br,
Antti
