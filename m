Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 12:20:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Only page device once per connect attempt
Message-ID: <20130613092010.GA17400@x220>
References: <1371039216-15944-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371039216-15944-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jun 12, 2013, Luiz Augusto von Dentz wrote:
> In case of EHOSTDOWN/page timeout the code should not proceed with the
> next profile as it is very likely it will fail again, moreover the page
> timeout is configurable and should be enough for getting a response from
> the remote device in a reasonable time.
> ---
>  src/device.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied. Thanks.

Johan
