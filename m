Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110419215807.GA26778@jh-x301>
References: <4dae0084.a905ec0a.709a.12f6@mx.google.com> <20110419215807.GA26778@jh-x301>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 20 Apr 2011 08:33:54 -0400
Message-ID: <BANLkTik5UF9hPgHG1hwzWV2hG5ZLS8GXnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add basic discovery commands to the
 management interface
To: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 19, 2011 at 5:58 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Briglia,
>
> On Tue, Apr 19, 2011, anderson.briglia@openbossa.org wrote:
>> From: Johan Hedberg <johan.hedberg@nokia.com>
>>
>> This patch adds start_discovery and stop_discovery commands to the
>> management interface. Right now their implementation is fairly
>> simplistic and the parameters are fixed to what user space has
>> defaulted to so far.
>> This is the very initial phase for discovery implementation into
>> the kernel. Next steps include name resolution, LE scanning and
>> bdaddr type handling.
>>
>> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
>> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
>> ---
>>  include/net/bluetooth/mgmt.h |    4 ++
>>  net/bluetooth/mgmt.c         |   77 +++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 80 insertions(+), 1 deletions(-)
>
> I'd appreciate it if you'd check with me first before going about
> sending patches in my name that I haven't 100% authored. There are e.g.
> some coding style things I'd have cleaned up before making this public.
> Depending on the amount of code changed (maybe not enough for this case
> though) you could have even put yourself as author and simply mentioned
> "Based on original code by Johan..." somewhere in the commit message.

Yes, you're right. Actually I thought just the "Signed-off-by" adding
myself would be enough since the code is pretty much the same and you
had already sent this few weeks ago. Anyway I should contact you first
before send to the mailing list, sorry.
What do you prefer? I modify the commit message and the patch
authoring (and send it again)? Which coding style issues did you
notice?

Regards,

Anderson Briglia

>
> Johan
>



-- 
INdT - Instituto Nokia de tecnologia
+55 2126 1122
http://techblog.briglia.net
