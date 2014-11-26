Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141126080427.GA16861@t440s>
References: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
	<20141126080427.GA16861@t440s>
Date: Wed, 26 Nov 2014 09:14:53 +0100
Message-ID: <CANq1E4S1xOQpz_JfSkPgmXq1wCZ4RkyaO7gN=qf55FUdnswa_A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add GET/SET_REPORT support to HoG
From: David Herrmann <dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Wed, Nov 26, 2014 at 9:04 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi David,
>
> On Fri, Nov 21, 2014, David Herrmann wrote:
>> Benjamin Tissoires (4):
>>   hog: import latest uhid.h definition
>>   hog: break out the report retrieval in its own function
>>   hog: implement get_report functionality
>>   hog: implement set_report functionality
>>
>>  profiles/input/hog.c       | 204 +++++++++++++++++++++++++++++++++++++++++----
>>  profiles/input/uhid_copy.h | 117 +++++++++++++++++++++++---
>>  2 files changed, 292 insertions(+), 29 deletions(-)
>
> All these patches have been applied upstream. There was just a minor
> thing I fixed myself with a follow-up patch where the code was doing an
> unnecessary < 0 comparison of an unsigned value.

Thanks, Johan!

David
