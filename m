Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Mar 2013 15:22:59 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH v3 2/6] client: Right prompt management on agent input
Message-ID: <20130320182259.GC6190@samus>
References: <1363726505-15171-1-git-send-email-deymo@chromium.org>
 <1363726505-15171-3-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363726505-15171-3-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On 13:55 Tue 19 Mar, Alex Deymo wrote:
> Registering an agent shares the user input interface with the normal console
> command interface. The way it is implemented (using rl_message, rl_save_prompt
> and rl_restore_prompt) conflicts with the rl_printf calls that may appear
> while waiting for user input, loosing the [bluetooth]# prompt.
> This patch fixes this and makes clear if the expected input is a command or an
> agent reply changing the color and text of the prompt.

Seems that there are some minor issues with formatting:

[bluetooth]# pair 40:98:4E:XX:XX:XX
Attempting to pair with 40:98:4E:XX:XX:XX
[CHG] Device 40:98:4E:XX:XX:XX Connected: yes
Request confirmation
[blue1m[agent] Confirm passkey 368383 (yes/no): yes


And I would suggest adding a patch to make bluetoothctl register itself as a
default agent by default. I needed to enable it manually before it could
handle incomming pairing requests.


Cheers,
-- 
Vinicius
