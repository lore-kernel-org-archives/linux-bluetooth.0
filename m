Return-Path: <cyrus@holtmann.org>
Message-ID: <4EBAD9DB.8060608@codeaurora.org>
Date: Wed, 09 Nov 2011 11:51:55 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Add support for LE Passkeys to MGMTOPS
References: <1320855666-8471-1-git-send-email-bgix@codeaurora.org> <20111109172411.GA2672@joana>
In-Reply-To: <20111109172411.GA2672@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 11/9/2011 9:24 AM, Gustavo Padovan wrote:
>[...]
>
> user_confirm_reply changes should be in a separate commit. Let's not mix
> things here.
>
>[...]
>
> Passkey reply should work for both BR/EDR and LE, so let's do this a way that
> it works for both with the same command.
>

Patches resubmitted as two patches, with the 2nd supporting both BR/EDR 
and LE.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
