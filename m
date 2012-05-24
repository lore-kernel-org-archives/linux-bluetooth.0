Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 11:10:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/12] Redundant D-Bus error init, remove unwanted
 code, g_free missmatch etc
Message-ID: <20120524081040.GA18388@x220>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Wed, May 23, 2012, Syam Sidhardhan wrote:
> This series of patches resolves:
> Memory leak, free - g_free mismatch, redundant D-Bus error initilization
> and remove unwanted code.
> 
> Syam Sidhardhan (12):
>   monitor: Fix memory leak
>   storage: Use g_free() instead of free()
>   media: Remove redundant D-Bus error initilization
>   telephony-maemo5: Remove redundant D-Bus error initilizations
>   telephony-maemo6: Remove redundant D-Bus error initilization
>   telephony-ofono: Remove redundant D-Bus error initilization
>   agent: Remove redundant D-Bus error initilizations
>   Remove redundant D-Bus error initilization in maemo6 plugin
>   avctp: Fix NULL check after dereference
>   adapter: Remove unwanted if check and code
>   audio: Remove unwanted code from manager
>   input: Remove unwanted codes from device
> 
>  audio/avctp.c            |    3 ++-
>  audio/manager.c          |    2 --
>  audio/media.c            |    1 -
>  audio/telephony-maemo5.c |    5 -----
>  audio/telephony-maemo6.c |    1 -
>  audio/telephony-ofono.c  |    1 -
>  input/device.c           |    5 -----
>  monitor/hcidump.c        |    3 ++-
>  plugins/maemo6.c         |    1 -
>  src/adapter.c            |    3 ---
>  src/agent.c              |    5 -----
>  src/storage.c            |    6 +++---
>  12 files changed, 7 insertions(+), 29 deletions(-)

I've applied all patches except the telephony ones. Those do not buy us
very much but come with the expense of conflicting with the pending
telephony driver removal patches (destined for 5.0). I also applied one
extra patch from myself to do the agent variable removal suggested by
Vinicius.

Johan
