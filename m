Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Dec 2012 11:25:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] control: Add methods FastForward and Rewind
Message-ID: <20121201092514.GC2501@x220.P-661HNU-F1>
References: <1354279699-1245-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354279699-1245-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Nov 30, 2012, Luiz Augusto von Dentz wrote:
> These method can be used to fast-forward and rewind the playback, their
> action will keep active until another method is called.
> 
> The commands are reapeated every 2 seconds to conform with AVC spec.
> ---
>  doc/control-api.txt      |  10 ++++
>  profiles/audio/avctp.c   | 148 ++++++++++++++++++++++++++++++++++++++++++-----
>  profiles/audio/control.c |  14 +++++
>  3 files changed, 157 insertions(+), 15 deletions(-)


Applied. Thanks.

Johan
