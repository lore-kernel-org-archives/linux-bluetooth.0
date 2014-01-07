Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 13:55:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 1/4] android/pan: Register Network Access Point
Message-ID: <20140107115539.GA2107@x220.p-661hnu-f1>
References: <1389093533-13210-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1389093533-13210-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389093533-13210-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Jan 07, 2014, Ravi kumar Veeramally wrote:
> +static int set_forward_delay(void)
> +{
> +	FILE *f;
> +	char *path;
> +
> +	path = g_strdup_printf("/sys/class/net/%s/bridge/forward_delay",
> +								BNEP_BRIDGE);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	f = fopen(path, "r+");
> +	g_free(path);
> +	if (!f)
> +		return -errno;

The above is not safe since g_free() might modify the value of errno.

In general, we're not really in the habit of using the f* variants of
file access functions. Could you convert the above to use a stack
variable for path (there's a PATH_MAX variable you can use for its
size) together with sprintf and use open + write instead of fopen +
fprintf?

> +static int nap_create_bridge(void)
> +{
> +	int sk, err;
> +
> +	DBG(" %s", BNEP_BRIDGE);

Why the extra space before %s?


> +	if (ioctl(sk, SIOCBRADDBR, BNEP_BRIDGE) == -1) {

We usually check for this kind of errors with < 0 instead of == -1.

> +	DBG(" %s", BNEP_BRIDGE);

Same thing here with the seemingly unnecessary space.

Johan
