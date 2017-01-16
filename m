Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 16 Jan 2017 09:32:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tomasz Gorochowik <tgorochowik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] lib/sdp: Remove deprecated VIDEO_CONF profile id
Message-ID: <20170116073201.GA5201@x1c>
References: <20161210225926.10179-1-tgorochowik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161210225926.10179-1-tgorochowik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Tomasz,

On Sat, Dec 10, 2016, Tomasz Gorochowik wrote:
> Commit 75e0c32af6bf ("lib/sdp: Replace VIDEO_CONF_SVCLASS_ID with
> AV_REMOTE_CONTROLLER_SVCLASS_ID") removed the deprecated
> VIDEO_CONF_SVCLASS_ID definition, but left the corresponding profile
> definition..
> 
> According to the specification linked below A/V_RemoteControlController
> UUID can only be used as a service class so its profile definition
> should be removed.
> 
> https://www.bluetooth.org/en-us/specification/assigned-numbers/service-discovery
> ---
>  lib/sdp.h | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

Johan
