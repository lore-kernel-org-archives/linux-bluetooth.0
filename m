Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2012 17:33:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Authentication issue during connection if remote deletes link key
Message-ID: <20121220153321.GA13208@x220.Elisa>
References: <20121128122318.GA30710@x220.ger.corp.intel.com>
 <1355918497-21944-1-git-send-email-tomasz.bursztyka@linux.intel.com>
 <CAMOw1v40+w62ToR4SKnNLnKfLzBSz_MKK1fXwoW66z7cXbTw4A@mail.gmail.com>
 <50D2C258.4000908@linux.intel.com>
 <442B171E16C14289B5160678267146C3@sisodomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <442B171E16C14289B5160678267146C3@sisodomain.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Dec 20, 2012, Jaganath Kanakkassery wrote:
> I am facing one issue with authentication during profile connection.
> Two devices are there A and B which are paired.
> From B I deleted the pairing of A.
> Now from A I initiated a file transfer to B which failed during
> authentication
> since remote link key is not there.
> Please see the hcidump logs.
> < HCI Command: Authentication Requested (0x01|0x0011) plen 2
>    handle 12
> < ACL data: handle 12 flags 0x00 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0046 scid 0x0040
> >HCI Event: Command Status (0x0f) plen 4
>    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> >HCI Event: Link Key Request (0x17) plen 6
>    bdaddr BC:85:1F:74:7F:29
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>    bdaddr BC:85:1F:74:7F:29 key 0E7B8C5C01CBF6CA7FF08050591C21BB
> >HCI Event: Command Complete (0x0e) plen 10
>    Link Key Request Reply (0x01|0x000b) ncmd 1
>    status 0x00 bdaddr BC:85:1F:74:7F:29
> >ACL data: handle 12 flags 0x02 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0040
> >HCI Event: Auth Complete (0x06) plen 3
>    status 0x06 handle 12
>    Error: PIN or Key Missing
> 
> Is it controller issue or BlueZ has to take care this?
> Please let me know your opinion.

This is normal behavior. The core spec gives us two options, either fail
or ask the user if he wants to try to repair. Right now the former is
implemented and you'll need to explicitly remove the local pairing
before attempting to repair.

We could (and maybe should) implement the latter option, but we need to
be very careful since it's important that we do not drop the old link
key until the new pairing is successful and we should also refuse to
accept the new pairing if it results in a less secure link key
(unauthenticated vs authenticated) than the original one. This is to
avoid attacks from devices spoofing the address of the other (paired)
device and therefore not having the link key available.

The way this should be implemented is that upon getting the "PIN or Key
Missing" error after having responded with a positive link key reply on
our side the kernel should fire off a mgmt event to user space to
request repairing (on the D-Bus agent level I think we could probably
reuse the RequestAuthorization callback for this). If a positive
response is received from user space the kernel would proceed with a new
pairing attempt, holding on to the old link key but still giving a
negative link key reply, and then follow the procedure which I described
in the previous paragraph.

If you're interested to implement this I'd be happy to provide more
feedback and guidance. The implementation should also be extended to LE
SMP where I believe we have a similar improvement opportunity.

Johan
