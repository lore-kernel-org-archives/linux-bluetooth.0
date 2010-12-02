Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101202101031.GB18808@jh-x301>
References: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
	<1291219986-29913-2-git-send-email-anderson.lizardo@openbossa.org>
	<20101202101031.GB18808@jh-x301>
Date: Thu, 2 Dec 2010 09:33:55 -0400
Message-ID: <AANLkTinbiQyXTKKPc+jfpEtfuJAFCZphzR6Dcwm3Qaj+@mail.gmail.com>
Subject: Re: [PATCH 1/3] Initial attribute permission implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 2, 2010 at 6:10 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Dec 01, 2010, Anderson Lizardo wrote:
>> +     attrib_db_add(0x0685, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
>> +                                                                     len);
> <snip>
>> +/* Access permissions */
>> +#define ATT_READ     1
>> +#define ATT_WRITE    2
>> +/* Authentication/Authorization permissions */
>> +#define ATT_NONE             0
>> +#define ATT_AUTHENTICATION   2
>> +#define ATT_AUTHORIZATION    4
>> +/* Build bit mask for permission checks */
>> +#define ATT_ACCESS(x, y)     (((x) << y) | (x))
>
> The last macro doesn't make any sense to me. Based the core spec it
> seems that the values for the different permission types are
> implementation specific and not exposed publicly (vol 2, part G, 2.5.1:
> "Attribute Permissions is part of the Attribute that cannot be read from
> or written to using the Attribute Protocol").

Correct. The permission implementation is internal.

> Why not make sure that
> they are all orthogonal from the start instead of ssigning the same
> value for authentication and writability like you do now. I.e. instead
> you could have:
>
> none            0
> read            1
> write           2
> authentication  4
> authorization   8

This was the first attempt (as it seemed obvious). But see vol 3, part
F, section 4:

"For example, an attribute value may be allowed to be read by any device, but
only written by an authenticated device. An implementation should take this
into account, and not assume that just because it can read an attribute’s value,
it will also be able to write the value. [...]"

This makes it clear that the authentication/authorization permissions
are not orthogonal. Further on it is confirmed by the attribute
permissions of "Client Characteristic Configuration" (vol 3, part G,
3.3.3.4):

* Readable with no authentication or authorization.
* Writable with authentication and authorization defined by a higher
layer specification or is implementation specific.

The scheme implemented in this patch set is just a compacted version
of unix permissions using a 2-bit grouping (not sure if it will look
nice to read):

5 4 3 2 1 0  bit
| | | | | \_ Read
| | | | \___ Write
| | | \_____ Authenticated read
| | \_______ Authenticated write
| \_________ Authorized read
\___________ Authorized write

With an addition that, if the authenticated/authorized read/write bits
are set, the "none" read/write bits are set as well (I think the
reason is obvious).

> Then you can just or together whatever you want without having any
> complex macros for producing the final permissions value. Alternatively
> you could also have a simple enum and use set_bit/test_bit marcos (see
> lib/hci_lib.h).

If you have ideas to reuse the hci_lib.h macros and keep the semantics
defined in the spec at the same time, let us know.

>
> Johan
>

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
