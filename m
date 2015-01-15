Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2015 22:11:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] core: device: Fix connect bearer selection
Message-ID: <20150115201134.GA22093@t440s.P-661HNU-F1>
References: <1421293935-24092-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421293935-24092-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Jan 14, 2015, Arman Uguray wrote:
> For dual-mode devices created from storage, trying to connect without
> a scan sometimes causes the incorrect bearer to be connected. This
> patch modifies device.c:select_conn_bearer so that it simply returns the
> stored bdaddr_type of a device if neither bredr nor le have been seen
> in a while.
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)

All three patches in this set have been applied. Thanks.

Johan
