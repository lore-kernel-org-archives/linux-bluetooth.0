Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2C6DE23@EXDCVYMBSTM005.EQ1STM.local>
References: <CAJdJm_OM4xExkBiy=oLpwFuPz5xx95i5ibh9bmWbAnokp7GC4w@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A2C6DE23@EXDCVYMBSTM005.EQ1STM.local>
Date: Fri, 8 Jul 2011 08:07:53 -0400
Message-ID: <CAJdJm_MTOHX1o+_RFJSfwXJDmrwx4nETugKAwnP5N8OhkK7u-w@mail.gmail.com>
Subject: Re: Connection parameters and multiple profiles (was: Re: [RFC BlueZ]
 Add Proximity API)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <ville.tervo@nokia.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Fri, Jul 8, 2011 at 3:19 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
>>* Exposing every single parameter to userspace will require one or
>>more mgmt commands which will just reflect the actual HCI commands.
>>This is usually not desirable (see Marcel's comments on this list
>>regarding the mgmt API being more "intelligent" than HCI)
> Agree with the philosophy in general but not sure what should be the granularity of mgmt command as compared to hci commands. For example in case of conn params I am not sure if you can stuff all conn params into one mgmt command for this?

I believe it will need to be evaluated on per case basis. I.e. we send
a draft patch to the list and see what other developers think about
it.

>>* Some parameters are just "hints" for the controller, so there is no
>>need (IMHO) to use the exact same values recommended by the profile.
>>Note that (in adopted profiles), the connection parameters are usually
>>recommendations ("should") not requirements ("shall").
>
> Yes but these recommendations are for optimal performance of each profile/usecase. Even though these are recommendations, ideally each profile programmer should try to stay close to these ...

Correct. What I meant is that in some cases we need to slightly modify
e.g. connection interval min/max depending on the currently loaded
profiles, and on characteristics of the local controller (e.g.
firmware limitations).

>
>>(I will use the word "mode" to avoid confusion below... better names
>>are welcome)
>>
>>With just a few "modes", we should be able to cover all currently
>>adopted profiles. And we could easily extend by adding more "modes",
>>or a mgmt API to allow registering temporary modes whose parameters
>>can be checked against those of currently running profiles, making
>>sure they will not be affected. What do you think?
>
> Why should these modes be "temp"? As long as the LE profiles which would need these modes run, these modes should be effective for same time. Unless we provide an option to disable LE profiles at run-time .. which in my opinion is still configurable only at start of bluetoothd?

So far there are no plans to disable LE after bluetoothd started. The
current approach is to enable/disable LE on kernel side, by using a
module parameter. (There is also "EnableLE" in bluez, but I believe it
will go away, as bluetoothd can query the controller for supported
features).

> Eitherways the idea of modes should be good and if we are able to check existing parameters before setting via new modes, that should alert the programmer/user as what he is playing with ...

Either that, or clearly document parameters. In any case, I believe
each vendor will tune these parameters anyway for their products
(depending on controller limitations, power consumption restrictions
etc.), we just need to come up with proper kernel API to add custom
"modes", and sane defaults.

BTW, we are not currently working on this feature, so feel free to
expand the idea or send RFC patches :).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
