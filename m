Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOnmHE9wynBS2CG4nTbbLTpP8B7btzf8+sF_233Fb3WwrWtAjw@mail.gmail.com>
References: <CACj007=vVUEwvaqr7JhMqJ8VK95j2epK+1_Z+_cJ=1-+UwVnGw@mail.gmail.com>
	<CAKT1EBdLu5ZBhaXWE208q4ctotd8vF1DyTBOY9hQVwKkpewEGw@mail.gmail.com>
	<CAOnmHE9wynBS2CG4nTbbLTpP8B7btzf8+sF_233Fb3WwrWtAjw@mail.gmail.com>
Date: Wed, 28 Dec 2011 19:26:02 -0300
Message-ID: <CAKT1EBd-GNzQERzUcHg5w14c1AUbDfXV9ozE18DtjJPpZ5fQJw@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor Discussion
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Arun K. Singh" <arunkat@gmail.com>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Arun Kumar SINGH <arunkr.singh@stericsson.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Wed, Dec 28, 2011 at 4:27 PM, Arun K. Singh <arunkat@gmail.com> wrote:
> Hi Claudio,
>
>> If the remote supports both services, there is no way in the
>> client(Proximity plugin) to figure out which scenario is happening.
>> The upper layer(app external to BlueZ) implements the logic to control
>> the ImmediateAlertLevel. My suggestion are:
>> 1) add a new property ImmediateAlertTimeout
>
> The problem that I see with this new Timeout is that both Proximity
> and Findme app - above Bluez have to have the intelligence of knowing
> what services are supported on the remote side and then setting this
> level accordingly. This can further complicate such apps as these may
> not be standard profile applications and may be different from LE
> stacks where both the proximity and FindMe profiles are implemented
> pretty independently.
>
>> 2) or split ImmediateAlertLevel into: FindMeLevel and PathLossLevel
>> mapping into the same remote characteristic.
>
> This would need immediate Immediate alert to propogate to both such
> levels(FindMe/PAthLoss) from a remote side. May not be that bad except
> pushing extra logic into higher level apps. But still may be more
> appealing than the timeout complexities of approach (a).
>
>> Opinions?
> Would suggest (b) except that what happens to existing
> ImediateAlertLevel timeout. Who shall now decide to disconnect the ATT
> connection for FindMeLevel and retaining it for PathLoss. May be we
> need to export ATT disconnect too as a property in this case?

At the moment, there isn't a mechanism in the Proximity API to control
connections.

If the remote supports Link Loss or TX power, the link will NOT be
disconnected. If the remote supports Immediate Alert Service only, the
link can be disconnected after some seconds(after writing the level).
For Proximity, it seems enough. I don't think we need to expose ATT
disconnect property or method.

BR,
Claudio
