Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 13:00:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v4 0/6] client: agent implementation on bluetoothctl
Message-ID: <20130325110005.GA17227@x220.ger.corp.intel.com>
References: <1363903497-4517-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363903497-4517-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Mar 21, 2013, Alex Deymo wrote:
> Fixed Vinicius comments for agent prompt. I kind of hate readline =)
> Thanks for reporting.
> I'll leave the agent disabled at startup since you can choose the
> capability you want to support for your agent, and also you may want
> to test your environment without an agent.
> 
> Alex Deymo (6):
>   client: Add color modifiers to NEW, CHG and DEL events.
>   client: Right prompt management on agent input
>   client: "agent" command capability argument and autocompletion
>   client: Agent's DisplayPincode implementation
>   client: Agent's DisplayPasskey implementation
>   client: Agent's RequestPasskey implementation
> 
>  client/agent.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  client/display.h |   7 ++-
>  client/main.c    | 106 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 232 insertions(+), 27 deletions(-)

Thanks. All patches in this set have been applied.

I did have to do some manual fixing with coding style issues such as
"char* foo" vs "char *foo", so please pay attention to that in the
future.

Johan
