Return-Path: <cyrus@holtmann.org>
Message-Id: <13180AB6-3C0E-4BE5-B1A1-C1390DE43288@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <b014639a0901081044w3a0d6b44gc065bb1289ade64c@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Fix a bogus pointer crash that occurred when reconnecting A2DP.
Date: Thu, 8 Jan 2009 21:44:22 +0200
References: <b014639a0901081044w3a0d6b44gc065bb1289ade64c@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,
On Jan 8, 2009, at 20:44, Mike Lockwood wrote:
> commit af5d46b22852f4ec1ca0d7c43c7a7e71292fe334
> Author: Mike Lockwood <lockwood@android.com>
> Date:   Thu Jan 8 13:34:06 2009 -0500
>
>    Fix a bogus pointer crash that occurred when reconnecting A2DP.

The patch has now been applied and pushed upstream. Thanks!

In the future you might want to consider using an attachment for  
patches since now something (most likely your email client) messed up  
the tabs and converted them to spaces which made the patch not apply  
properly. Also, we don't use the Signed-off-by stuff on the userspace  
side of BlueZ so you can leave it out.

Johan
