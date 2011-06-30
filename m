Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC BlueZ] Add Proximity API
From: Bastien Nocera <hadess@hadess.net>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 30 Jun 2011 21:16:49 +0100
In-Reply-To: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1309465011.5023.85.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-30 at 15:24 -0300, Claudio Takahasi wrote:
> Covers the Proximity Reporter for Link Loss, Tx Power and Immediate
> Alert services. This first proposal considers that the connections
> will be managed by the bluetoothd core based on the registered
> connection callbacks.

Any examples of possible uses, or hardware implementing those? Is this
good enough to implement both sides of the profile, or just one side of
it?

Is this something that could require UI being written?

> Only one instance of Immediate Alert service is allowed, "Alert Level"
> characteristic of this service is used by Find Me and Path Loss. Note
> that "Alert Level" for Path Loss is a LOCAL property written in the
> Immediate Alert service when the threshold is reached. For Find Me
> the user/application needs to actively enable the alert in the Immediate
> Alert service. Link Loss has it's own instance of Alert Level

its.

> characteristic.

Cheers

