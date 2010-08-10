Return-Path: <cyrus@holtmann.org>
Message-ID: <4C616C59.9040401@codeaurora.org>
Date: Tue, 10 Aug 2010 10:12:25 -0500
From: David Scherba <dscherba@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: marcel@holtmann.org, rshaffer@codeaurora.org
Subject: Re: [PATCH 1/2] Remove non-functional hci_devinfo calls in init_device()
References: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org> <1281388059-15945-2-git-send-email-dscherba@codeaurora.org> <20100809215149.GA25488@jh-x301>
In-Reply-To: <20100809215149.GA25488@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 8/9/2010 4:51 PM, Johan Hedberg wrote:

> Nice catch, but that's not quite enough:
>
> plugins/hciops.c: In function ‘init_device’:
> plugins/hciops.c:178: error: label ‘done’ defined but not used
> plugins/hciops.c:125: error: unused variable ‘di’
>
> Always check that your patch compiles cleanly with ./bootstrap-configure
> before submitting upstream.

Johan--

Thanks for the tips--I had split-up a combined patch and neglected to 
ensure clean compilation and spacing after the split :-(.

New patch versions coming your way...

Cheers,
David

-- 
David Scherba
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
