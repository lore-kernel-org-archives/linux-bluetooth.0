Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 May 2013 19:28:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v0] avctp: Fix missing UUID registration
Message-ID: <20130510162809.GA24614@x220.P-661HNU-F1>
References: <1368186064-10960-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368186064-10960-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, May 10, 2013, Mikel Astiz wrote:
> When there is an incoming connection to AVCTP PSM, there is no way to
> know if the remote UUID corresponds to AVRCP_REMOTE_UUID or
> AVRCP_TARGET_UUID. Therefore both UUIDs should be reported to the core.
> 
> Without this patch, a crash has been observed with the iPhone 5
> immediately after pairing.
> ---
> I don't have the log traces right now but submitting the patch anyway due to the upcoming release.
> 
>  profiles/audio/avctp.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
