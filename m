Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295984785.2656.98.camel@ubuntuLab1>
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
	<1295984785.2656.98.camel@ubuntuLab1>
Date: Wed, 26 Jan 2011 09:33:22 -0400
Message-ID: <AANLkTi=4HoUKdda-GCrTQEtLSScuxB4D+btoRy+QsMG_@mail.gmail.com>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 25, 2011 at 3:46 PM, Brian Gix <bgix@codeaurora.org> wrote:
> As far as test case coverage per the qualification test specification, I
> do not believe that there is a problem.  Any non long "Reads" can be
> tested by reading < 22 octet attributes, and long read tests by reading
>>= 22 octet attributes.

Now that you mentioned this topic, the issue that brought this thread
is that there is a specific qualification test where PTS sends a 22
bytes characteristic value, expecting a single Read Request to be
sent, and it refuses to answer to any further Read Blob Requests (i.e.
it does not send any response PDUs). This makes the client (e.g.
igatttool) wait forever for a answer or timeout.

Looks like more a PTS bug, but makes me wonder if it is not better for
BlueZ to have separate procedures instead of this "automatic" usage of
read blob request ?

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
