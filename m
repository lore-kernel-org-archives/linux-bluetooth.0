Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] android: Add native support for Android logger
Date: Mon, 15 Dec 2014 17:05:59 +0100
Message-ID: <3508130.3dy2inJSYm@uw000953>
In-Reply-To: <1418652475-19842-1-git-send-email-szymon.janc@tieto.com>
References: <1418652475-19842-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 15 of December 2014 15:07:53 Szymon Janc wrote:
> Lollipop enabled SELinux in enforcing mode but doesn't provide
> proper policy for logwrapper. All AOSP native services were converted
> to not use logwrapper at all so we should follow the same.
> 
> On Android Lollipop we handle logging by sending data to Android
> logd over socket. On Android KitKat logs are written directly to
> /dev/log/system.
> 
> Nice addition over logwrapper is that now we have proper tags for
> messages levels like debug, info, error etc.
> ---
> V2: - don't depend on glib on Android
>     - use structure for logd header (make code easier to read)
>     - reduce getpid calls
> 
>  android/Android.mk |   2 +-
>  android/log.c      | 213 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+), 1 deletion(-)
>  create mode 100644 android/log.c
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index c1505c8..17349bf 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -58,7 +58,7 @@ LOCAL_SRC_FILES := \
>  	bluez/android/sco.c \
>  	bluez/profiles/health/mcap.c \
>  	bluez/android/map-client.c \
> -	bluez/src/log.c \
> +	bluez/android/log.c \
>  	bluez/src/shared/mgmt.c \
>  	bluez/src/shared/util.c \
>  	bluez/src/shared/queue.c \
> diff --git a/android/log.c b/android/log.c
> new file mode 100644
> index 0000000..09d226a
> --- /dev/null
> +++ b/android/log.c
> @@ -0,0 +1,213 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdbool.h>
> +#include <time.h>
> +#include <sys/uio.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#include "src/log.h"
> +
> +#define LOG_TAG "bluetoothd"
> +
> +#define LOG_DEBUG 3
> +#define LOG_INFO 4
> +#define LOG_WARN 5
> +#define LOG_ERR 6
> +
> +#define LOG_ID_SYSTEM 3
> +
> +struct logd_header {
> +	uint8_t id;
> +	uint16_t pid; /* Android logd expects only 2 bytes for PID */
> +	uint32_t sec;
> +	uint32_t nsec;
> +} __attribute__ ((packed));
> +
> +static int log_fd = -1;
> +static bool legacy_log = false;
> +
> +static void android_log(unsigned char level, const char *fmt, va_list ap)
> +{
> +	struct logd_header header;
> +	struct iovec vec[4];
> +	int cnt = 0;
> +	char *msg;
> +	static pid_t pid = 0;
> +
> +	if (log_fd < 0)
> +		return;
> +
> +	/* no need to call getpid all the time since we don't fork */
> +	if (!pid)
> +		pid = getpid();
> +
> +	if (vasprintf(&msg, fmt, ap) < 0)
> +		return;
> +
> +	if (!legacy_log) {
> +		struct timespec ts;
> +
> +		clock_gettime(CLOCK_REALTIME, &ts);
> +
> +		header.id = LOG_ID_SYSTEM;
> +		header.pid = pid;
> +		header.sec = ts.tv_sec;
> +		header.nsec = ts.tv_nsec;
> +
> +		vec[0].iov_base = &header;
> +		vec[0].iov_len = sizeof(header);
> +
> +		cnt += 1;
> +	}
> +
> +	vec[cnt + 0].iov_base = &level;
> +	vec[cnt + 0].iov_len = sizeof(level);
> +	vec[cnt + 1].iov_base = LOG_TAG;
> +	vec[cnt + 1].iov_len = sizeof(LOG_TAG);
> +	vec[cnt + 2].iov_base  = msg;
> +	vec[cnt + 2].iov_len  = strlen(msg) + 1;
> +
> +	cnt += 3;
> +
> +	writev(log_fd, vec, cnt);
> +
> +	free(msg);
> +}
> +
> +void info(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, format);
> +
> +	android_log(LOG_INFO, format, ap);
> +
> +	va_end(ap);
> +}
> +
> +void warn(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, format);
> +
> +	android_log(LOG_WARN, format, ap);
> +
> +	va_end(ap);
> +}
> +
> +void error(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, format);
> +
> +	android_log(LOG_ERR, format, ap);
> +
> +	va_end(ap);
> +}
> +
> +void btd_debug(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, format);
> +
> +	android_log(LOG_DEBUG, format, ap);
> +
> +	va_end(ap);
> +}
> +
> +static bool init_legacy_log(void)
> +{
> +	log_fd = open("/dev/log/system", O_WRONLY);
> +	if (log_fd < 0)
> +		return false;
> +
> +	legacy_log = true;
> +
> +	return true;
> +}
> +
> +static bool init_logd(void)
> +{
> +	struct sockaddr_un addr;
> +
> +	log_fd = socket(PF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> +	if (log_fd < 0)
> +		return false;
> +
> +	if (fcntl(log_fd, F_SETFL, O_NONBLOCK) < 0)
> +		goto failed;
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	strcpy(addr.sun_path, "/dev/socket/logdw");
> +
> +	if (connect(log_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
> +		goto failed;
> +
> +	return true;
> +
> +failed:
> +	close(log_fd);
> +	log_fd = -1;
> +
> +	return false;
> +}
> +
> +extern struct btd_debug_desc __start___debug[];
> +extern struct btd_debug_desc __stop___debug[];
> +
> +void __btd_log_init(const char *debug, int detach)
> +{
> +	if (!init_logd() && !init_legacy_log())
> +		return;
> +
> +	if (debug) {
> +		struct btd_debug_desc *desc;
> +
> +		for (desc = __start___debug; desc < __stop___debug; desc++)
> +			desc->flags |= BTD_DEBUG_FLAG_PRINT;
> +	}
> +
> +	info("Bluetooth daemon %s", VERSION);
> +}
> +
> +void __btd_log_cleanup(void)
> +{
> +	if (log_fd < 0)
> +		return;
> +
> +	close(log_fd);
> +	log_fd = -1;
> +}
> 

Applied.

-- 
Best regards, 
Szymon Janc
