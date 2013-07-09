Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 7/8] Bluetooth: SCO connection fallback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51DBDE82.20007@linux.intel.com>
Date: Tue, 9 Jul 2013 07:25:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CDC72D06-91B6-49BA-AD67-1A0A2C6E55E5@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-8-git-send-email-frederic.dalleau@linux.intel.com> <EAB92B0C-1120-4EC7-A4C6-83D3C7F185CB@holtmann.org> <51DBDE82.20007@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>> before we do the fallback handling, lets get the basic CVSD vs transparent work done properly. The one thing that I am missing is the handling of SCO/eSCO setup error handling. Like say when using connect() and we try to establish transparent link where not available. Or accept() with defer setup and the transparent link does not work out.
>> 
>> The fallback handling can be a separate patch once the others are all in a mergable state.
> 
> AFAIR if Accept Synchronous Connection does not specify a compatible
> voice setting, Synchronous Connection Complete will return error
> 2.13 INVALID HCI COMMAND PARAMETERS (0x12).
> Setup Synchronous Connection also returns error in Synchronous Connection Complete.
> 
> This is the reason why it is negociated before in profile.

I am not sure I like that. What we want is to return proper error codes when a connect() or accept() + read() fails due to an invalid combination.

Regards

Marcel

