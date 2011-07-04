Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 4 Jul 2011 10:57:10 -0400
Message-ID: <CAJdJm_OM4xExkBiy=oLpwFuPz5xx95i5ibh9bmWbAnokp7GC4w@mail.gmail.com>
Subject: Connection parameters and multiple profiles (was: Re: [RFC BlueZ] Add
 Proximity API)
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

On Mon, Jul 4, 2011 at 9:23 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
> Also how about setting profile specific LSTO? Proximity specs recommends this value to be 6X connection interval but I guess we may give the user/application some flexibility to play around on this? Same may be the case for connection interval, scan interval, latency values etc...I believe these values can be pretty much user/platform specific and user should have control over these ...

I still think we should try to come up with a "connection parameter
profile" (e.g. "low latency/fast connection", "low power",
"reconnection" etc.), instead of allowing applications to tune
specific values by hand. A couple of reasons:

* Exposing every single parameter to userspace will require one or
more mgmt commands which will just reflect the actual HCI commands.
This is usually not desirable (see Marcel's comments on this list
regarding the mgmt API being more "intelligent" than HCI)
* It will be too easy for custom/proprietary profiles to interfere
with core profiles (or with other custom/proprietary profiles).
* Some parameters are just "hints" for the controller, so there is no
need (IMHO) to use the exact same values recommended by the profile.
Note that (in adopted profiles), the connection parameters are usually
recommendations ("should") not requirements ("shall").

(I will use the word "mode" to avoid confusion below... better names
are welcome)

With just a few "modes", we should be able to cover all currently
adopted profiles. And we could easily extend by adding more "modes",
or a mgmt API to allow registering temporary modes whose parameters
can be checked against those of currently running profiles, making
sure they will not be affected. What do you think?

IIRC Ville had some comments/ideas regarding this. Ville?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
