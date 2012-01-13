Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120112131607.GA13175@x220.ger.corp.intel.com>
References: <1326373161-4618-1-git-send-email-divya.yadav@samsung.com>
	<20120112131607.GA13175@x220.ger.corp.intel.com>
Date: Fri, 13 Jan 2012 08:18:52 +0100
Message-ID: <CA+i+Aw2xrfTAttdYkwHFNpnQuQLih9rXBVsEXjA7959Mw2MEAQ@mail.gmail.com>
Subject: Re: [PATCH obexd] MAP: Add application parameter parsing support
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Divya Yadav <divya.yadav@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

On Thu, Jan 12, 2012 at 2:16 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Thu, Jan 12, 2012, Divya Yadav wrote:
>> Add application parameter parsing and check for
>> mandatory parameters.
>> ---
>>  plugins/mas.c      |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  plugins/messages.h |   19 +++++
>>  2 files changed, 199 insertions(+), 7 deletions(-)
>
> Are you aware of src/map_ap.h that we have in the obexd tree?

And let me add to this, that I'm working in this area (MAP in
general). I was on a longer vacation recently, but I was planning to
send further patches at the end of this week.

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Slawomir Bochenski
