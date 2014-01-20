Return-Path: <cyrus@holtmann.org>
Message-ID: <cfdf976e52d86b180ee5e750c23fed8f.squirrel@mungewell.org>
In-Reply-To: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
References: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 20 Jan 2014 13:28:57 -0500
Subject: Re: [PATCH v2 1/5] lib: Add flag to force large MTU size used for
 SDP connection
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Szymon Janc" <szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> From: Szymon Janc <szymon.janc@gmail.com>
>
> This will allow to workaround Dualshock4 not respecting L2CAP MTU
> size while sending SDP response. Use same L2CAP MTU value base on
> RFCOMM.

I can confirm that the V2 series of patches work with my DS4 and crappy
laptop. Still require particular 'connect' sequence...

I note that I do not need the original '[PATCH 3/3] input: Add DualShock 4
detection' patch. I am using just this sequence of 5 patches on top of
5.13.
Simon


