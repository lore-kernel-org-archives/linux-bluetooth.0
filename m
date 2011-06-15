Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308175855.2196.7.camel@aeonflux>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
Date: Wed, 15 Jun 2011 19:47:58 -0400
Message-ID: <BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jun 15, 2011 at 6:10 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> so why are these two separate commands. Just reading them in one kernel
> call might be a lot better. Including everything else you need to know
> about the connection. Also TX power can be local and remote TX power if
> I remember this correctly.

The issue I see with your proposal is that for Proximity (currently
the only user of this information) we read TX power from server
(reporter) using GATT, while RSSI is read on client (monitor) side. By
reading both, we would need to issue two separate HCI commands (and
wait for both responses), but will always use only one value,
depending on local BlueZ role.

Also note that on latest Proximity profile drafts, it is mentioned
that the TX power on reporter will never change during a connection,
and thus it should be read only once when the connection is
established. RSSI (which is read "locally" on monitor side), on the
other hand, should be read periodically for path loss calculation.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
