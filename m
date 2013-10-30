Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 09:39:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/AVRCP: Always assign a player to TG role
Message-ID: <20131030073957.GB1710@x220.p-661hnu-f1>
References: <1383055634-11953-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383055634-11953-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 29, 2013, Luiz Augusto von Dentz wrote:
> Currently the code does not assign a player if version is bellow 1.3,
> but sometimes the version may not be initialized correctly e.g: record
> could not be fetch.
> 
> Futhermore by assigning a player for 1.0 CT it won't break backward
> compatibility as no commands will be sent but adds the possibility to
> respond properly in case the CT is sending commands above its own
> version which is a violation of the spec but unfortunately there exists
> such stacks on the market.
> ---
>  profiles/audio/avrcp.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied. Thanks.

Johan
