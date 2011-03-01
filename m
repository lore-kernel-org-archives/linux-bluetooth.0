Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6D4926.907@codeaurora.org>
Date: Tue, 01 Mar 2011 11:29:42 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
CC: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Bluetooth: Add counter for not acked HCI commands
References: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Again,

On 11-03-01 10:16 AM, Andrzej Kaczmarek wrote:
[...]

>   			atomic_dec(&hdev->cmd_cnt);
> +			atomic_inc(&hdev->cmd_not_ack);
[...]

Also, I am not sure this means what you may intend it to mean. I think 
that this is intended to do both of these operations "together 
atomically", but that as written, it is possible for an interruption to 
occur between the two operations.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
