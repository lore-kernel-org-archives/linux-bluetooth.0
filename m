Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120717084417.GA1097@x220>
References: <1342038888-10102-1-git-send-email-anderson.lizardo@openbossa.org>
	<1342038888-10102-2-git-send-email-anderson.lizardo@openbossa.org>
	<20120717084417.GA1097@x220>
Date: Tue, 17 Jul 2012 13:58:45 -0400
Message-ID: <CAJdJm_Mu364Y_xKL-nnDDnsaj6n3pvxf4APFAgDNtP5Zfqyq2A@mail.gmail.com>
Subject: Re: [RFC BlueZ] mgmt-api: Broadcaster/Observer management API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jul 17, 2012 at 4:44 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Wed, Jul 11, 2012, Anderson Lizardo wrote:
>> +Set Controller Data Command
>> +===========================
>> +
>> +     Command Code:           0x002B
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Flags (1 Octet)
>> +                             Data_Type (1 Octet)
>> +                             Data_Length (1 Octet)
>> +                             Data (0-255 Octets)
>> +     Return Parameters:
>> +
>
> The return parameters should include the Flags and Data_Type so that
> user space can distinguish which Set Controller Data command completed
> or failed (in the case of multiple pending commands). Same goes for the
> Remove Controller Data command.

Ok, will add on next revision.

>
>> +     This command can be used to set AD for LE capable controllers or EIR
>> +     for BR/EDR controllers. Multiple AD/EIR types can be configured by
>> +     calling this command multiple times. If the data does not fit on a
>> +     single AD/EIR on the controller, it will be rotated based on the "High
>> +     priority" flag, so data with this flag set will stay longer over the
>> +     air than those with this flag cleared.
>
> I'm still struggling to see the usefulness or even the feasibility of a
> meaningful rotation of data. Is there actually some place in the core
> spec that implies or recommends that this be done? More importantly, is
> there some place that states that the content of multiple different AD
> packets from the same remote device should be considered in an
> aggregated manner instead of considering each of them as a
> unique/complete state of the remote device? If there's no such mention
> there's nothing stopping devices from using the latter interpretation
> and in such a case any kind of rotation could mess things up. Also the
> fact that there exists short/incomplete variants of many AD types
> (UUIDs, device name) seems to indicate that if any kind of compromising
> mechanism should be used when trying to fit data, this is it.

Rotation gives the ability to broadcast multiple sets of information
easily (when the information sets are known beforehand), without
requiring to have a timer on userspace and multiple mgmt API calls.
Given that LE advertising is inherently unreliable, it is up to the
application to add some sort of checksum or account for data that may
never arrive. In other words, it is a best effort communication
channel (IMHO).

Remember that this API is only useful for AD Types which are not
managed by BlueZ or kernel internally, i.e. service data and
manufaturer specific data currently (more may come on future Core
Specification Supplement document revisions). These information are
not necessarily device state, and applications have the freedom do
manage the information as they find necessary. E.g. some sort of
sequence numbering, CRC, or even Message Authentication (although
tricky to fit into <31 bytes adv. packets, it is still possible).

That said, I believe that even if the kernel does not rotate the
information as described above, it is still possible to broadcast the
same sets of information, but with performance penalty because of
multiple set/remove controller data commands.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
