Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150218080333.GA28722@aemeltch-MOBL1>
References: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20150218080333.GA28722@aemeltch-MOBL1>
Date: Thu, 19 Feb 2015 16:27:06 +0200
Message-ID: <CABBYNZJbsAnxg0-RzTDVPUOmrAwyHa0CkYj9HdFBqNZVmhohGw@mail.gmail.com>
Subject: Re: [PATCHv6 0/8] AVDTP deduplication
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 18, 2015 at 10:03 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> ping
>
> On Mon, Feb 16, 2015 at 03:02:22PM +0200, Andrei Emeltchenko wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> Changes:
>>       * v6: Fix uid_get/clear adding id checks
>>       * v5: Use POSIX ffs() for bitmap get uid, limiting maximum number of local SEPs to 32.
>>       * v4: Fix Android build and clear typos.
>>         * v3: Convert gslist to queue for lseps, refactor lseps handlings, remove extra DBGs.
>>         * v2: Fix fixup patch
>>         * v1: Add SEID fixes with unit tests
>>         * RFC: initial version
>>
>> Andrei Emeltchenko (8):
>>   unit/avdtp: Add SEP register/unregister tests
>>   unit/avdtp: Add duplicate SEID test
>>   shared/utils: Add helpers for bitfield id generation
>>   android/avdtp: Fix SEID generation
>>   unit/avdtp: Add check for too many SEP creation
>>   android/avdtp: Fix registering SEP with wrong SEID
>>   android/avdtp: Refactor local SEP list handling
>>   unit/avdtp: Refactor context destroy
>>
>>  android/Android.mk  |   2 +
>>  android/Makefile.am |   2 +
>>  android/a2dp.c      |  15 +++--
>>  android/avdtp.c     | 101 +++++++++++++++++++------------
>>  android/avdtp.h     |  10 ++-
>>  android/avdtptest.c |  10 ++-
>>  src/shared/util.c   |  29 +++++++++
>>  src/shared/util.h   |   3 +
>>  unit/test-avdtp.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++--------
>>  9 files changed, 273 insertions(+), 70 deletions(-)
>>
>> --
>> 2.1.0

1-6 are now applied, please change the last according to what we
discussed in the irc.


-- 
Luiz Augusto von Dentz
