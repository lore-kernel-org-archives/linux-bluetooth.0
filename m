Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:01:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafael Fonseca <fonsecasantos.rafael@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update comment in the audio.conf file.
Message-ID: <20120629110140.GB17737@x220>
References: <1338951935-10388-1-git-send-email-fonsecasantos.rafael@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338951935-10388-1-git-send-email-fonsecasantos.rafael@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafael,

On Wed, Jun 06, 2012, Rafael Fonseca wrote:
> The config file erroneously said that all services were available by default.
> Actually Gateway, Source and Socket are disabled.
> ---
>  audio/audio.conf |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (after reformatting the commit message to follow the 72 char
rule). Thanks.

Johan
