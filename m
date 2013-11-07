Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 17:10:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 2/2] android: Add set/get for discovery timeout
Message-ID: <20131107151001.GC23283@x220.p-661hnu-f1>
References: <1383815991-18523-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1383815991-18523-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383815991-18523-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Nov 07, 2013, Lukasz Rymanowski wrote:
> Android handles discoverable timeout in Settings app, however still
> expects BT stack to maintain this value so we should do it as well.
> Otherwise we will get some unexpected behaviour.
> For now we keep discovery_timeout only during runtime, but we need to move
> it to some local storage once we will have it.
> 
> Note: That since Android Settings up handles timer there is no reason to
> use discovery timer we have in kernel.
> ---
>  android/adapter.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)

You'll need to rebase this one due to the patches from Szymon that were
recently applied (right now it applies but doesn't compile).

Johan
