Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A43722784152@ORSMSX103.amr.corp.intel.com>
References: <1485282579-9172-1-git-send-email-brian.gix@intel.com>
 <1485282579-9172-3-git-send-email-brian.gix@intel.com> <6ea10c35-12e7-fbcc-8db8-cee61754e066@felipetonello.com>
 <DEBB0CAA2616974FAE35E4B560B9A437227840FB@ORSMSX103.amr.corp.intel.com>
 <CAAEJBhJpkpr7YAd_rRtiOnVkhf66tvcpZjAse7PA76MpFGZGeA@mail.gmail.com> <DEBB0CAA2616974FAE35E4B560B9A43722784152@ORSMSX103.amr.corp.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jan 2017 21:25:12 +0200
Message-ID: <CABBYNZKCVegN+x7y-jtwO5W+N064gLvEJZfZnoqHqVxVf7RKLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Require GLIB v2.46
To: "Gix, Brian" <brian.gix@intel.com>
Cc: Szymon Janc <szymon.janc@codecoup.pl>,
        Felipe Ferreri Tonello <eu@felipetonello.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian, Szymon,

On Tue, Jan 24, 2017 at 9:18 PM, Gix, Brian <brian.gix@intel.com> wrote:
> Hi Szymon,
>
>> -----Original Message-----
>> From: Szymon Janc [mailto:szymon.janc@codecoup.pl]
>>
>> Hi Brian,
>>
>> On 24 January 2017 at 20:04, Gix, Brian <brian.gix@intel.com> wrote:
>> > Done.
>> >
>> > -----Original Message-----
>> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Felipe Ferreri Tonello
>> > Sent: Tuesday, January 24, 2017 10:56 AM
>> > To: Gix, Brian <brian.gix@intel.com>; linux-bluetooth@vger.kernel.org
>> > Subject: Re: [PATCH v2 2/2] Require GLIB v2.46
>> >
>> > Hi Brian,
>> >
>> > Please, add the reason why this change is necessary in the commit
>> message.
>> >
>> > On 24/01/17 18:29, Brian Gix wrote:
>> >> ---
>> >>  configure.ac | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/configure.ac b/configure.ac index 91b4955..6d8bf9c 100644
>> >> --- a/configure.ac
>> >> +++ b/configure.ac
>> >> @@ -61,8 +61,8 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
>> >>
>> >>  AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
>> >>
>> >> -PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
>> >> -                             AC_MSG_ERROR(GLib >= 2.28 is required))
>> >> +PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.46, dummy=yes,
>> >> +                             AC_MSG_ERROR(GLib >= 2.46 is required))
>> >>  AC_SUBST(GLIB_CFLAGS)
>> >>  AC_SUBST(GLIB_LIBS)
>>
>> I'd rather change test instead of bumping glib dependency just for this...
>> But I'll let others to comment on this too.
>
>
> I am fine either way.  The latest (LTS) Ubuntu and Fedora both include >= GLIB v2.46 by default, so I have no strong preference any way, however it is only the unit test that uses it, and no Core BlueZ code.

In the past we tried to not bump the glib requirements since there are
some, probably many, embedded platforms using BlueZ that are stuck
with ancient glib. That said we might actually start removing glib
dependencies all together in favor of ell.


-- 
Luiz Augusto von Dentz
