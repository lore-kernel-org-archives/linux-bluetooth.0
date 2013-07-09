Return-Path: <cyrus@holtmann.org>
Message-ID: <51DBDE82.20007@linux.intel.com>
Date: Tue, 09 Jul 2013 11:57:22 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 7/8] Bluetooth: SCO connection fallback
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-8-git-send-email-frederic.dalleau@linux.intel.com> <EAB92B0C-1120-4EC7-A4C6-83D3C7F185CB@holtmann.org>
In-Reply-To: <EAB92B0C-1120-4EC7-A4C6-83D3C7F185CB@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

Le 08/07/2013 21:23, Marcel Holtmann a écrit :
> Hi Fred,
> before we do the fallback handling, lets get the basic CVSD vs transparent work done properly. The one thing that I am missing is the handling of SCO/eSCO setup error handling. Like say when using connect() and we try to establish transparent link where not available. Or accept() with defer setup and the transparent link does not work out.
>
> The fallback handling can be a separate patch once the others are all in a mergable state.

AFAIR if Accept Synchronous Connection does not specify a compatible
voice setting, Synchronous Connection Complete will return error
2.13 INVALID HCI COMMAND PARAMETERS (0x12).
Setup Synchronous Connection also returns error in Synchronous 
Connection Complete.

This is the reason why it is negociated before in profile.

Regards,
Fred
