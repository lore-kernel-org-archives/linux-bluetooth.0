Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 00/13] Connection and request handling improvements
Date: Tue, 10 Jun 2014 13:45:21 +0200
Message-ID: <2612948.surRFizXAZ@uw000953>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 06 of June 2014 15:46:13 Jakub Tyszkowski wrote:
> Patches from 1 to 9 adds subtle improvements to the existing functionality to
> prepare ground for patches 10 to 13, which adds proper handling of server app
> connections.
> 
> Server app connections should exist for all devices currently connected and for
> each server app registered so we properly propagate requests for reads and
> writes. Such connections are not owned by server apps so they cannot disconnect
> connections owned by other. But they should be notified of any connection state
> changes.
> 
> For this kind of functionality app_connection received owner flag to control
> disconnection permissions. Ownerless connections are created automatically for
> every device if server app registers. and for every server app on device
> connecting for proper event propagation purpose.
> 
> This fixes some issues spotted on the UPF.
> 
> Jakub Tyszkowski (13):
>   android/gatt: Rename app connection handling function
>   android/gatt: Always check for complete response queue
>   android/gatt: Dont process pending requests if queue is empty
>   android/gatt: Fix double processing of pending responses list
>   android/gatt: Improve response filling function
>   android/gatt: Move response filling functions up
>   android/gatt: Use fill_gatt_response in response processing
>   android/gatt: Use common code for server and client apps unregister
>   android/gatt: Rename app unregister function
>   android/gatt: Factor out device disconn. part from app disconn.
>   android/gatt: Create server connections on register
>   android/gatt: Verify client and server disconnect callers
>   android/gatt: Postpone disconnect notifications sent to server apps
> 
>  android/gatt.c | 399 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 217 insertions(+), 182 deletions(-)
> 

Patches 1-9 are now applied, thanks.

-- 
Best regards, 
Szymon Janc
