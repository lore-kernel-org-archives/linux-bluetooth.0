Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <ville.tervo@nokia.com>
Date: Fri, 8 Jul 2011 09:19:25 +0200
Subject: RE: Connection parameters and multiple profiles (was: Re: [RFC
 BlueZ] Add Proximity API)
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2C6DE23@EXDCVYMBSTM005.EQ1STM.local>
References: <CAJdJm_OM4xExkBiy=oLpwFuPz5xx95i5ibh9bmWbAnokp7GC4w@mail.gmail.com>
In-Reply-To: <CAJdJm_OM4xExkBiy=oLpwFuPz5xx95i5ibh9bmWbAnokp7GC4w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> Also how about setting profile specific LSTO? Proximity specs recommends this
>value to be 6X connection interval but I guess we may give the user/application some
>flexibility to play around on this? Same may be the case for connection interval, scan
>interval, latency values etc...I believe these values can be pretty much user/platform
>specific and user should have control over these ...
>
>I still think we should try to come up with a "connection parameter
>profile" (e.g. "low latency/fast connection", "low power",
>"reconnection" etc.), instead of allowing applications to tune
>specific values by hand. A couple of reasons:

Agree. This should be the most valid proposition for connection parameters as long as identify a common "set" of these that is agreeable to all LE profiles. I guess Proximity and Phone Alert Service seem to have GAP conn parm recommendation. So arriving at a common union shouldn't be hard.
>
>* Exposing every single parameter to userspace will require one or
>more mgmt commands which will just reflect the actual HCI commands.
>This is usually not desirable (see Marcel's comments on this list
>regarding the mgmt API being more "intelligent" than HCI)
Agree with the philosophy in general but not sure what should be the granularity of mgmt command as compared to hci commands. For example in case of conn params I am not sure if you can stuff all conn params into one mgmt command for this?


>* It will be too easy for custom/proprietary profiles to interfere
>with core profiles (or with other custom/proprietary profiles).
Agree.

>* Some parameters are just "hints" for the controller, so there is no
>need (IMHO) to use the exact same values recommended by the profile.
>Note that (in adopted profiles), the connection parameters are usually
>recommendations ("should") not requirements ("shall").

Yes but these recommendations are for optimal performance of each profile/usecase. Even though these are recommendations, ideally each profile programmer should try to stay close to these ...

>(I will use the word "mode" to avoid confusion below... better names
>are welcome)
>
>With just a few "modes", we should be able to cover all currently
>adopted profiles. And we could easily extend by adding more "modes",
>or a mgmt API to allow registering temporary modes whose parameters
>can be checked against those of currently running profiles, making
>sure they will not be affected. What do you think?

Why should these modes be "temp"? As long as the LE profiles which would need these modes run, these modes should be effective for same time. Unless we provide an option to disable LE profiles at run-time .. which in my opinion is still configurable only at start of bluetoothd? 
Eitherways the idea of modes should be good and if we are able to check existing parameters before setting via new modes, that should alert the programmer/user as what he is playing with ...
 
Thanks,
Arun
