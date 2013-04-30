Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:16:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v4 2/8] plugins: Extend the pin code callback with the
 call number
Message-ID: <20130430081658.GB777@x220.ger.corp.intel.com>
References: <1367006741-28907-1-git-send-email-deymo@chromium.org>
 <1367006741-28907-3-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367006741-28907-3-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, Apr 26, 2013, Alex Deymo wrote:
>  static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
> -						char *pinbuf, gboolean *display)
> +			char *pinbuf, gboolean *display, uint32_t attempt)

You've still got uint32_t here.

Johan
