Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774113883BC@SHSMSX104.ccr.corp.intel.com>
References: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com>
	<CAHrH25T6BccZaza2SJvWLL70FQWoEXWkAmRcE=5cfE-WGkcUew@mail.gmail.com>
	<CABBYNZKqRwfbZUhE6E0Kv9fA9=XxWqZgcD7KjwabJ7yd+Zu7mw@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774113883BC@SHSMSX104.ccr.corp.intel.com>
Date: Thu, 19 Feb 2015 19:37:59 -0800
Message-ID: <CAHrH25RA8takpfqLMH_95cSUsA71PaqSPGCLstAKgCgv86raAQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] support signed write command
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

> On Thu, Feb 19, 2015 at 7:33 PM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:
> Hi Luiz,
>         This patch has been submitted for a long time. When I writing the signed write for GATT Client, the GATT Server is not ready yet. So this patch is just for GATT Client signed command. I am not sure Arman implemented Signed write command in GATT Server or not.
>
> Thanks
> Chaojie
>

Please don't top-post on your responses to the list.

I believe when we originally discussed the signed write support we
decided that bt_att needs to handle the signing and CSRK validation.
So as long as that support is not in place, bt_gatt_server can't
support signed writes either.

>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Tuesday, February 17, 2015 9:24 PM
>> To: Arman Uguray
>> Cc: Gu, Chao Jie; BlueZ development
>> Subject: Re: [PATCH v5 0/3] support signed write command
>>
>> Hi Gu,
>>
>> On Mon, Dec 15, 2014 at 6:41 PM, Arman Uguray <armansito@chromium.org> wrote:
>> > Hi all,
>> >
>> >> On Fri, Nov 7, 2014 at 1:04 AM, Gu Chaojie <chao.jie.gu@intel.com> wrote:
>> >> * This patch set give user dedicated command to set CSRK option and
>> >> seperate from signed write command implementation in the previous
>> >> patch
>> >> * Remove the valid_csrk flag, use struct signed_write_info make
>> >> implementation more clear and simple
>> >> * signed_counter will initialize when CSRK be set, remove signed_counter
>> initialization in bt_att_new procedure.
>> >>
>> >> Gu Chaojie (3):
>> >>   shared/att.c:Add signed command outgoing and CSRK function
>> >>   shared/gatt-client:Add CSRK part to support signed write
>> >>   tools/btgatt-client:Add signed write with CSRK option
>> >>
>> >>  src/shared/att-types.h   |   3 +
>> >>  src/shared/att.c         | 146
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>> >>  src/shared/att.h         |  12 ++++
>> >>  src/shared/gatt-client.c |  21 +++++--
>> >>  src/shared/gatt-client.h |   4 ++
>> >>  tools/btgatt-client.c    |  69 +++++++++++++++++++++-
>> >>  6 files changed, 245 insertions(+), 10 deletions(-)
>> >>
>> >> --
>> >> 1.9.1
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> >> linux-bluetooth" in the body of a message to
>> >> majordomo@vger.kernel.org More majordomo info at
>> >> http://vger.kernel.org/majordomo-info.html
>> >
>> > Sending a gentle ping on these patches, since they haven't received a
>> > lot of attention for a couple of months. What's the status of Signed
>> > Writes here? These will be more relevant for Android now than they
>> > will initially be for desktop.
>>
>> Do you have any new patches addressing the comments from Szymon?
>>
>>
>> --
>> Luiz Augusto von Dentz

Arman
