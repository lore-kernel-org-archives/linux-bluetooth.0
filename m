Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKYSfpWCvK=3_VaKTz8nC-dWonkXesCibiuX1DPv+e3vA@mail.gmail.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
	<CABBYNZKQ-1s9p_18HOnKW3Sew+cMrW+6SnPJHwp-s5m5nYF3QQ@mail.gmail.com>
	<CAHrH25T_OGAuC2aS3FvV2ZNffv0Ep2PxxOk4+HDn7YXuvfJqbQ@mail.gmail.com>
	<2326994.RrINgRSL6X@athlon>
	<CABBYNZKYSfpWCvK=3_VaKTz8nC-dWonkXesCibiuX1DPv+e3vA@mail.gmail.com>
Date: Fri, 24 Oct 2014 12:32:50 -0700
Message-ID: <CAHrH25Qt=WkY+jvgJmyn7Mv2aAOOZG8qip40AnQ_OWXOv86qzA@mail.gmail.com>
Subject: Re: [PATCHv5 00/14] Included service discovery
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@gmail.com>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 23, 2014 at 12:55 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Szymon,
>
> On Wed, Oct 22, 2014 at 9:39 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
>> Hi,
>>
>> On Wednesday 22 October 2014 08:35:05 Arman Uguray wrote:
>>> Hi Luiz,
>>>
>>> On Wed, Oct 22, 2014 at 7:54 AM, Luiz Augusto von Dentz
>>>
>>> <luiz.dentz@gmail.com> wrote:
>>> > Hi Marcin,
>>> >
>>> > On Wed, Oct 22, 2014 at 9:25 AM, Marcin Kraglak
>>> >
>>> > <marcin.kraglak@tieto.com> wrote:
>>> >> On 16 October 2014 12:17, Marcin Kraglak <marcin.kraglak@tieto.com>
>> wrote:
>>> >>> v3:
>>> >>> In this version after primary service discovery,
>>> >>> secondary services are discovered. Next included
>>> >>> services are resolved. With this approach we
>>> >>> don't have recursively search for included service,
>>> >>> like it was TODO in previous proposal.
>>> >>> There is also small coding style fix suggested by Arman.
>>> >>>
>>> >>> v4:
>>> >>> If no secondary services found, continue include services search (fixed
>>> >>> in gatt-client.c).
>>> >>> Fixed wrong debug logs (primary->secondary).
>>> >>> Fixed searching descriptors
>>> >>>
>>> >>> v5:
>>> >>> Ignore Unsupported Group Type Error in response to secondary service
>>> >>> discovery and continue included services discovery.
>>> >>>
>>> >>> Marcin Kraglak (14):
>>> >>>   shared/gatt: Add discover_secondary_services()
>>> >>>   shared/gatt: Add initial implementation of discover_included_services
>>> >>>   shared/gatt: Discover included services 128 bit UUIDS
>>> >>>   shared/gatt: Add extra check in characteristic iterator
>>> >>>   shared/gatt: Add included service iterator
>>> >>>   shared/gatt: Remove not needed function parameter
>>> >>>   shared/gatt: Distinguish Primary from Secondary services
>>> >>>   tools/btgatt-client: Print type of service
>>> >>>   shared/gatt: Discover secondary services
>>> >>>   shared/gatt: Discover included services
>>> >>>   shared/gatt: Add gatt-client include service iterator
>>> >>>   tools/btgatt-client: Print found include services
>>> >>>   shared/gatt: Fix searching descriptors
>>> >>>   shared/gatt: Add function bt_gatt_result_included_count()
>>> >>>
>>> >>>  src/shared/gatt-client.c  | 263 +++++++++++++++++++++++++++--
>>> >>>  src/shared/gatt-client.h  |  18 ++
>>> >>>  src/shared/gatt-helpers.c | 418
>>> >>>  +++++++++++++++++++++++++++++++++++++++++++---
>>> >>>  src/shared/gatt-helpers.h |  10 +-
>>> >>>  tools/btgatt-client.c     |  17 +-
>>> >>>  5 files changed, 690 insertions(+), 36 deletions(-)
>>> >>>
>>> >>> --
>>> >>> 1.9.3
>>> >
>>> > Patches looks fine to me, but I would like Arman to ack before applying.
>>>
>>> I'm fine with the patches as they are, though I saw that Szymon has
>>> left comments on some of them (I'm guessing he's a doing a pass of the
>>> patch set now). I'm good with it as long as his comments are
>>> addressed.
>>
>> I really think we should have more comments and less magic numbers there.
>> Otherwise this code will be hard to maintain in long term.
>
> Yep, we could actually start creating packed structs for PDU as it was
> done for AVRCP so we could do sizeof etc, it makes the code much
> easier to understand and maintain.
>

I agree, though I'd be happier if we added unit tests first. We can
then introduce packed structs and convert all code, though the unit
tests would at least give us confidence that we didn't accidentally
break any of the PDU encoding.

Cheers,
Arman
