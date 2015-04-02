Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 1/3] btattach: Add SetDevType ioctl call
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427985483-31580-2-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 2 Apr 2015 08:18:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F359CD19-C134-41E3-B5F8-2D68195C5E6B@holtmann.org>
References: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com> <1427985483-31580-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
> tools/btattach.c  | 22 +++++++++++++++++-----
> tools/hciattach.h |  1 +
> 2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/btattach.c b/tools/btattach.c
> index b7948a3..63620e4 100644
> --- a/tools/btattach.c
> +++ b/tools/btattach.c
> @@ -106,7 +106,7 @@ static void local_version_callback(const void *data, uint8_t size,
> }
> 
> static int attach_proto(const char *path, unsigned int proto,
> -						unsigned int flags)
> +					unsigned int flags, const char *type)
> {
> 	int fd, dev_id;
> 
> @@ -120,6 +120,14 @@ static int attach_proto(const char *path, unsigned int proto,
> 		return -1;
> 	}
> 
> +	if (type) {
> +		if (ioctl(fd, HCIUARTSETDEVTYPE, type) < 0) {
> +			perror("Failed to set device type");
> +			close(fd);
> +			return -1;
> +		}
> +	}
> +
> 	if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
> 		perror("Failed to set protocol");
> 		close(fd);
> @@ -193,6 +201,7 @@ static void usage(void)
> static const struct option main_options[] = {
> 	{ "bredr",   required_argument, NULL, 'B' },
> 	{ "amp",     required_argument, NULL, 'A' },
> +	{ "type",    required_argument, NULL, 't' },
> 	{ "version", no_argument,       NULL, 'v' },
> 	{ "help",    no_argument,       NULL, 'h' },
> 	{ }
> @@ -200,7 +209,7 @@ static const struct option main_options[] = {
> 
> int main(int argc, char *argv[])
> {
> -	const char *bredr_path = NULL, *amp_path = NULL;
> +	const char *bredr_path = NULL, *amp_path = NULL, *type = NULL;
> 	bool raw_device = false;
> 	sigset_t mask;
> 	int exit_status, count = 0;
> @@ -208,7 +217,7 @@ int main(int argc, char *argv[])
> 	for (;;) {
> 		int opt;
> 
> -		opt = getopt_long(argc, argv, "B:A:Rvh",
> +		opt = getopt_long(argc, argv, "B:A:t:Rvh",
> 						main_options, NULL);
> 		if (opt < 0)
> 			break;
> @@ -220,6 +229,9 @@ int main(int argc, char *argv[])
> 		case 'A':
> 			amp_path = optarg;
> 			break;
> +		case 't':
> +			type = optarg;
> +			break;
> 		case 'R':
> 			raw_device = true;
> 			break;
> @@ -258,7 +270,7 @@ int main(int argc, char *argv[])
> 		if (raw_device)
> 			flags = (1 << HCI_UART_RAW_DEVICE);
> 
> -		fd = attach_proto(bredr_path, HCI_UART_H4, flags);
> +		fd = attach_proto(bredr_path, HCI_UART_H4, flags, type);

I think the real feature you want to add here is the ability to choose different HCI_UART_* types. So lets define a list of types that we support. This should just be drivers/vendors and not all different chips like in hciattach.

However you need to do a lot of input verification checks here. For example AMP implies H:4 at the moment.

The kernel calls is PROTO at the moment and with that we most likely should just call it --protocol / -p here. If not specified it defaults to H:4.

Regards

Marcel

