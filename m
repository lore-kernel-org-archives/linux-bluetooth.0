Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] core: fix unbound watchdog-notify for timeouts <2s
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410614483-8462-1-git-send-email-dh.herrmann@gmail.com>
Date: Sat, 13 Sep 2014 09:54:36 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Michael Biebl <mbiebl@gmail.com>
Message-Id: <25587ECB-CBF8-4E5C-9E86-63CACCFD1A0D@holtmann.org>
References: <1410614483-8462-1-git-send-email-dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> If the watchdog timeout is below 2s, we end up with a timeout of 0s as
> glib event source. This causes unbound watchdog notifications. Avoid this
> by never using event-timeouts below 1s.
> 
> Reported by Michael Biebl.
> 
> ---
> src/main.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/main.c b/src/main.c
> index e6bac6e..da0bd12 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -596,9 +596,10 @@ int main(int argc, char *argv[])
> 
> 		seconds = atoi(watchdog_usec) / (1000 * 1000);
> 		info("Watchdog timeout is %d seconds", seconds);
> +		seconds = (seconds < 4) ? 1 : seconds / 2;
> 
> 		watchdog = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
> -							seconds / 2,
> +							seconds,
> 							watchdog_callback,
> 							NULL, NULL);

while setting WatchdogSec=1 is pretty insane interval anyway, this now also means that setting it that low will cause a race condition between systemd's watchdog killing us and we are able to be quickly enough to respond with a keep alive message.

I get the feeling that if > 2s, then we should use g_timeout_add_seconds to get the advantage of being woken up with all other timeouts in our daemon. And when it is <= 2s, then we better use a high precision g_timeout_add.

One alternative is to actually use timerfd natively here and use kernel based range timers.

Regards

Marcel

