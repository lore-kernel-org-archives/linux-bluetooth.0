Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:23:30 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attrib-server: Fix sending "not supported" for
 indications/notifications
Message-ID: <20120316152330.GD20650@x220>
References: <1331762860-6987-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331762860-6987-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Mar 14, 2012, Vinicius Costa Gomes wrote:
> Now that our Attribute Client is able to handle notifications and
> indications we don't need to respond that they are not supported.
> ---
>  src/attrib-server.c |    4 ++++
>  1 file changed, 4 insertions(+)

Applied. Thanks.

Johan
