Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Dec 2013 07:22:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: Fix crash due to agent callback freeing the agent
Message-ID: <20131210052212.GA18172@x220.p-661hnu-f1>
References: <1386616856-16140-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386616856-16140-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 09, 2013, Szymon Janc wrote:
> Similar fix was provided for simple_agent_reply in a2f5d438 but missed
> pincode_reply case.
> 
> Fix following:
> 
> src/agent.c:agent_disconnect() Agent :1.48 disconnected
> src/agent.c:set_default_agent() Default agent cleared
> src/agent.c:agent_destroy() agent :1.48
> src/agent.c:agent_unref() 0x4701c68: ref=1
> Agent /org/bluez/agent replied with an error:
>     org.freedesktop.DBus.Error.NoReply, Message did not receive a reply
>     (timeout by message bus)
> src/adapter.c:btd_adapter_pincode_reply() hci0 addr 6C:0E:0D:DB:D1:16
>     pinlen 0
> src/agent.c:agent_unref() 0x4701c68: ref=0
> src/adapter.c:btd_adapter_pincode_reply() hci0 addr 6C:0E:0D:DB:D1:16
>     pinlen 0
> src/agent.c:agent_unref() 0x4701c68: ref=-1
> src/adapter.c:btd_adapter_pincode_reply() hci0 addr 6C:0E:0D:DB:D1:16
>     pinlen 0
> src/agent.c:agent_unref() 0x4701c68: ref=-2
> ...
> ---
>  src/agent.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied. Thanks.

Johan
