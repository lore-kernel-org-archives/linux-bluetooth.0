Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141125093256.GB15104@t440s.ger.corp.intel.com>
References: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
	<1416728993-4189-2-git-send-email-jpawlowski@google.com>
	<20141125093256.GB15104@t440s.ger.corp.intel.com>
Date: Tue, 25 Nov 2014 12:31:56 -0800
Message-ID: <CAD0=r8z=L9gv5oNGc6nzouSL=yibjtwsQ1kyOBmw=JJ2qhS2+w@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] Bluetooth: Extract generic start and stop discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 25, 2014 at 1:32 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Sat, Nov 22, 2014, Jakub Pawlowski wrote:
>> This commit extract generic_start_discovery and generic_stop_discovery
>> in preparation for start and stop service discovery. The reason behind
>> that is that both functions will share big part of code, and it would
>> be much easier to maintain just one generic method.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>>  net/bluetooth/mgmt.c | 89 +++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 56 insertions(+), 33 deletions(-)
>
> People's dislike of these generic* functions was previously pointed out
> but no good options were proposed, so let me give a try:
>
> Considering that we don't allow multiple concurrent stop or start
> discovery operations (the mgmt commands will return "busy" errors),
> couldn't we simply look up whatever pending start/discovery command
> there is and then use that to derive our response? I.e. instead of a
> single mgmt_pending_find (which we anyway need to do) there'd
> potentially be two such calls.
>
> Regarding Stop Service Discovery, I'm starting to doubt whether the
> whole thing is needed at all. It's exactly the same as Stop Discovery
> and you don't even attempt to check that the Stop Discovery/Stop Service
> Discovery matches the actual ongoing discovery type (i.e. your code
> would allow stopping a normal discovery with Stop Service Discovery and
> vice versa). So I'd propose to just drop the new method and reuse the
> existing Stop Discovery to stop either one of these two types.

Removing stop discovery is ok, I'll do that.

When it comes to starting discovery, the flow now is like that:

1. The start_discovery or start_service_discovery is called
2. generic_start_discovery is called
    - insde it there is some processing, then mgmt_pending_add is called
3. call to start_discovery_complete or
start_serivce_discovery_complete is made when all requests to hci
success
4. generic_start_discovery_complete is called, somewhere internally it
use mgmt_pending_find

So you mean change that would remove generic_start_discovery_complete,
and have only start_discovery_complete that gets proper opcode from
call to mgmt_pending_find ? I'll do that.

When it comes to generic_start_discovery, I don't think I can get rid
of that, I need two different methods to know opcode that was passed,
otherwise  I would need to somehow have opcode passed from
mgmt_control, I don't want to touch that.

The concern that Arman have is:
"I'm not that big on calling these generic functions "generic_*".
Let's try to come up with something better."
but I couldn't come up with better  name.


To sum up:
I'll get rid of all generic functions except generic_start_discovery,
but I'm willing to also get rid of it if there's easy way to somehow
get opcode. Is that ok ?


>
> Johan
