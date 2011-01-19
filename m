Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Jan 2011 23:11:04 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: =?utf-8?B?THVrw6HFoQ==?= Turek <8an@praha12.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Never deallocate a session when some DLC
 points to it
Message-ID: <20110119011104.GA7762@joana>
References: <201101050243.59801.8an@praha12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <201101050243.59801.8an@praha12.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukáš,

* Lukáš Turek <8an@praha12.net> [2011-01-05 02:43:59 +0100]:

> Fix a bug introduced in commit 9cf5b0ea3a7f1432c61029f7aaf4b8b338628884:
> function rfcomm_recv_ua calls rfcomm_session_put without checking that
> the session is not referenced by some DLC. If the session is freed, that
> DLC would refer to deallocated memory, causing an oops later, as shown
> in this bug report: https://bugzilla.kernel.org/show_bug.cgi?id=15994
> 
> Signed-off-by: Lukas Turek <8an@praha12.net>
> ---
>  net/bluetooth/rfcomm/core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
