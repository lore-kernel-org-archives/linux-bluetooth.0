Return-Path: <mka@chromium.org>
Date: Tue, 26 Jun 2018 13:49:09 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Replace open-coded msleep()
Message-ID: <20180626204909.GP129942@google.com>
References: <20180626170654.96831-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180626170654.96831-1-swboyd@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 26, 2018 at 10:06:54AM -0700, Stephen Boyd wrote:
> These three lines make up what msleep() already does, i.e. setting the
> task to uninterruptible, sleeping for so many jiffies, and then
> schedule() already puts the task state back to TASK_RUNNING when it
> returns. Make things clearer by just calling msleep() instead.
> 
> Cc: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-off-by: Matthias Kaehlcke <mka@chromium.org>
