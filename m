Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25TEAuyA-dwUJ_anEswEK5i_T0sZweZo-upqnAYfKkWQfQ@mail.gmail.com>
References: <1415823779-346-1-git-send-email-jamuraa@chromium.org>
	<1415823779-346-5-git-send-email-jamuraa@chromium.org>
	<2239100.FtFKDhk29O@leonov>
	<CAHrH25TEAuyA-dwUJ_anEswEK5i_T0sZweZo-upqnAYfKkWQfQ@mail.gmail.com>
Date: Thu, 13 Nov 2014 16:05:52 +0200
Message-ID: <CABBYNZ+y8Pq1KNtcoLCiyZqm1j70BAc3x+jjBSHfeO96utGLpQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] GATT shim to src/shared bt_att
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Nov 13, 2014 at 2:49 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Michael & Szymon,
>
>> On Wed, Nov 12, 2014 at 1:14 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> Hi Michael,
>>
>> On Wednesday 12 of November 2014 12:22:59 Michael Janssen wrote:
>>> This patch implements a version of GAttrib which is backed by
>>> bt_att, which enables the simultaneous use of GAttrib and bt_att.
>>>
>>> This should enable smooth transition of profiles from the GAttrib
>>> API to the src/shared bt_att API.
>>> ---
>>>  attrib/gattrib.c | 733
>>> ++++++++++++------------------------------------------- 1 file changed, 154
>>> insertions(+), 579 deletions(-)

I guess you forgot about the format flag this time so this changes
should show up as complete rewrite.


-- 
Luiz Augusto von Dentz
