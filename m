Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBdLu5ZBhaXWE208q4ctotd8vF1DyTBOY9hQVwKkpewEGw@mail.gmail.com>
References: <CACj007=vVUEwvaqr7JhMqJ8VK95j2epK+1_Z+_cJ=1-+UwVnGw@mail.gmail.com>
 <CAKT1EBdLu5ZBhaXWE208q4ctotd8vF1DyTBOY9hQVwKkpewEGw@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Thu, 29 Dec 2011 00:57:41 +0530
Message-ID: <CAOnmHE9wynBS2CG4nTbbLTpP8B7btzf8+sF_233Fb3WwrWtAjw@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor Discussion
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Arun Kumar SINGH <arunkr.singh@stericsson.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> If the remote supports both services, there is no way in the
> client(Proximity plugin) to figure out which scenario is happening.
> The upper layer(app external to BlueZ) implements the logic to control
> the ImmediateAlertLevel. My suggestion are:
> 1) add a new property ImmediateAlertTimeout

The problem that I see with this new Timeout is that both Proximity
and Findme app - above Bluez have to have the intelligence of knowing
what services are supported on the remote side and then setting this
level accordingly. This can further complicate such apps as these may
not be standard profile applications and may be different from LE
stacks where both the proximity and FindMe profiles are implemented
pretty independently.

> 2) or split ImmediateAlertLevel into: FindMeLevel and PathLossLevel
> mapping into the same remote characteristic.

This would need immediate Immediate alert to propogate to both such
levels(FindMe/PAthLoss) from a remote side. May not be that bad except
pushing extra logic into higher level apps. But still may be more
appealing than the timeout complexities of approach (a).

> Opinions?
Would suggest (b) except that what happens to existing
ImediateAlertLevel timeout. Who shall now decide to disconnect the ATT
connection for FindMeLevel and retaining it for PathLoss. May be we
need to export ATT disconnect too as a property in this case?

Thanks,
Arun
