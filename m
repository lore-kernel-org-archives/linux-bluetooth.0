Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix for android-tester: Gatt - Double Listen case
Date: Mon, 25 Aug 2014 11:11:08 +0200
Message-ID: <1889590.ENdnTkPaDa@uw000953>
In-Reply-To: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 22 of August 2014 14:40:45 Jakub Tyszkowski wrote:
> This patch set fixes the issue with Gatt: Double Listen test case, in which
> we were trying to reconnect the emulated remote while the ACL was still
> connected.
> 
> Jakub Tyszkowski (2):
>   android/tester: Wait for ACL disconnection before reconnect
>   android/tester: Make Gatt stop listening after ACL disconnects
> 
> Marcin Kraglak (2):
>   emulator/bthost: Add hci disconnect
>   android/tester: Force remotes ACL disconnection
> 
>  android/tester-gatt.c | 23 ++++++++++++++++++++---
>  android/tester-main.c | 15 ++++++++++++++-
>  emulator/bthost.c     | 11 +++++++++++
>  emulator/bthost.h     |  3 +++
>  4 files changed, 48 insertions(+), 4 deletions(-)
> 

Patches 1-3 applied. Thanks.

-- 
Best regards, 
Szymon Janc
