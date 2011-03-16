Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110316055357.GG4369@null>
References: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
	<20110315075742.GD4369@null>
	<AANLkTikK4vjMgpuBHMLP4-6J2JMMnWqbaDo1-rwFsjEY@mail.gmail.com>
	<20110316055357.GG4369@null>
Date: Wed, 16 Mar 2011 08:21:49 -0400
Message-ID: <AANLkTinPviUvZ1NZnHQWp6Hkq53AosiSiAJTEZB2BiJb@mail.gmail.com>
Subject: Re: [RFC v2 0/6] LE advertising cache
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: ext Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Wed, Mar 16, 2011 at 1:53 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> On Tue, Mar 15, 2011 at 10:41:55AM -0400, ext Anderson Lizardo wrote:
>> IIRC the connection procedure defined on the spec requires this scan.
>> See for instance the general connection establishment procedure at
>> page 1715
>
> But it makes "Direct Connection Establishment" impossible.

I can only see on the spec "Direct Connection Establishment" allowed
to be used as sub-procedures for either General or Selective
connection establishment. Correct me if you find other references
outside these two procedures.

The problem is that, unlike BR/EDR where the address is enough, for LE
you need to know the address type as well before connecting and this
information can only be obtained by means of advertising reports (from
a scanning during discovery, or from previously bonded devices, for
which we need to have stored this information).

Also see this note regarding privacy-enabled peripherals (page 1704):
"A Central may connect to a Peripheral that supports the privacy
feature using only the general connection establishment procedure."
(I'm not sure I get this sentence right, as it uses the dubious "may
... only" sentence).

> Is it needed to pass PTS for example?

Note sure. Claudio may know more about PTS requirements on GAP part.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
