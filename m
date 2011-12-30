Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Dec 2011 13:06:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix wiimote device_get_address to use new API
Message-ID: <20111230110638.GA32368@x220>
References: <1325177984-26383-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325177984-26383-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Dec 29, 2011, David Herrmann wrote:
> Commit b06899eace1f484b387aae0e568fb1da988b468c introduced a new API
> for device_get_name but apparently missed fixing the call in
> plugins/wiimote.c. This patch converts the plugin to use the new API.
> ---
>  plugins/wiimote.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied after the obvious s/get_name/get_address/ in the commit message.
Thanks.

Johan
