Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140509115045.GA3536@t440s.lan>
References: <20140509014001.0A027100DB2@puck.mtv.corp.google.com>
	<20140509115045.GA3536@t440s.lan>
Date: Fri, 9 May 2014 09:44:22 -0700
Message-ID: <CAGXr9JH9F+HdZj9PzeTZwnb9MCctHJkgW9BTL8SD-2bPXG8j0A@mail.gmail.com>
Subject: Re: [PATCH] hog: Fix report_value_cb()
From: Petri Gynther <pgynther@google.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, May 9, 2014 at 4:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Thu, May 08, 2014, Petri Gynther wrote:
>> 1. Fix potential buffer overflow. It would happen in the case:
>>    hogdev->has_report_id == TRUE && report_size == UHID_DATA_MAX
>>
>> 2. Adjust function signature to match GAttribNotifyFunc.
>>
>> 3. Adjust uHID error handling to mimic uhid_send_input_report() in
>>    profiles/input/device.c
>> ---
>>  profiles/input/hog.c | 44 +++++++++++++++++++++++++++++---------------
>>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> Whenever I see a commit message like this it begs the question:
> shouldn't these separate fixes be in separate patches? If at all
> possible please split the patch into smaller ones so that each one
> contains a single independent fix. That makes it much easier to track
> exactly which code change maps to which described fix as well the
> possibility to do some bisecting later in case one of the fixes
> introduces a bug.
>
> Johan

Fair enough. I'll break this down to three commits and send a new
patch out shortly.

-- Petri
