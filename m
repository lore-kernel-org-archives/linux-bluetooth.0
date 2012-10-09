Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 10:53:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix registering HoG service for non-HoG profiles
Message-ID: <20121009085337.GB32191@x220.ger.corp.intel.com>
References: <1349741074-16665-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349741074-16665-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Oct 08, 2012, Vinicius Costa Gomes wrote:
> We need to handle the case that the device has multiple HoG services,
> but before registering we must check the service UUID.
> ---
>  profiles/input/hog_manager.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
