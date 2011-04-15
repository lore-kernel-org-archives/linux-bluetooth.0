Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110414170728.GC7152@jh-x301>
References: <1302544624-5216-1-git-send-email-sheldon.demario@openbossa.org>
	<20110414170728.GC7152@jh-x301>
Date: Fri, 15 Apr 2011 10:29:18 -0300
Message-ID: <BANLkTikUb_DJ98KCoTVwcmENPe1p7cm-9g@mail.gmail.com>
Subject: Re: [PATCH] Fix race condition on gatttool
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: Sheldon Demario <sheldon.demario@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

On Thu, Apr 14, 2011 at 2:07 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Sheldon,
>
> On Mon, Apr 11, 2011, Sheldon Demario wrote:
>> When the connect_cb() takes too long to be called the event_loop goes to idle
>> state and executes the callback too early
>> ---
>>  attrib/gatttool.c |  128 +++++++++++++++++++++++++---------------------------
>>  1 files changed, 62 insertions(+), 66 deletions(-)
>
> Thanks, the patch has been pushed upstream. Could you please fix your
> editor settings so that it doesn't produce lines longer than 74
> characters for git commit messages? I had to manually edit it this time.

For sure. I was using the 80 chars limit.

>
> Johan
>
