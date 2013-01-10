Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2013 14:31:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] unit: Avoid D-Bus calling _exit() during SDP
 tests
Message-ID: <20130110123117.GA30528@x220>
References: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
 <1357821030-11412-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357821030-11412-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 10, 2013, Anderson Lizardo wrote:
> While running tests, the D-Bus library was set to call _exit() when the
> client leaves the bus. This caused the second test to be interrupted
> without providing a PASS/FAIL result. This was confirmed by running
> test-sdp with DBUS_VERBOSE=1.
> 
> This commit disables this behavior, which does not exist on BlueZ
> because g_dbus_set_disconnect_function() implicitly does this.
> ---
>  unit/test-gdbus-client.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
