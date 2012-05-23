Return-Path: <cyrus@holtmann.org>
Message-ID: <1337742978.15105.34.camel@aeonflux>
Subject: Re: [PATCH 1/3] hciattach: add common debug print functions and
 toggle option
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 23 May 2012 05:16:18 +0200
In-Reply-To: <148659297.eyne5QQyzV@tedd-ubuntu>
References: <148659297.eyne5QQyzV@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This adds common debug print functions that print the debug messages
> to stderr and it can be toggled with'-d' option in the parameter.
> 
> It provides two functions: one for message and the other for data contents.
> 
> ---
>  tools/hciattach.8 |    4 ++++
>  tools/hciattach.c |   36 ++++++++++++++++++++++++++++++++++--
>  tools/hciattach.h |    3 +++
>  3 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/hciattach.8 b/tools/hciattach.8
> index cc97cad..eccbc61 100644
> --- a/tools/hciattach.8
> +++ b/tools/hciattach.8
> @@ -6,6 +6,7 @@ hciattach \- attach serial devices via UART HCI to BlueZ stack
>  .RB [\| \-b \|]
>  .RB [\| \-n \|]
>  .RB [\| \-p \|]
> +.RB [\| \-d \|]
>  .RB [\| \-t
>  .IR timeout \|]
>  .RB [\| \-s
> @@ -32,6 +33,9 @@ Don't detach from controlling terminal.
>  .B \-p
>  Print the PID when detaching.
>  .TP
> +.B \-d
> +Print debug messages to stderr.
> +.TP
>  .BI \-t " timeout"
>  Specify an initialization timeout.  (Default is 5 seconds.)
>  .TP
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index 3e73956..06ae9d6 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -42,6 +42,7 @@
>  #include <sys/poll.h>
>  #include <sys/param.h>
>  #include <sys/ioctl.h>
> +#include <stdarg.h>
>  
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/hci.h>
> @@ -73,6 +74,8 @@ struct uart_t {
>  
>  static volatile sig_atomic_t __io_canceled = 0;
>  
> +static int g_debug;
> +
>  static void sig_hup(int sig)
>  {
>  }
> @@ -144,6 +147,30 @@ static int uart_speed(int s)
>  	}
>  }
>  
> +void dbg_print(const char *fmt, ...)
> +{
> +	va_list args;

extra empty line between variables and code please.

> +	if(g_debug) {

Extra space after if and before (.

> +		fprintf(stderr, "dbg: ");
> +		va_start(args, fmt);
> +		vfprintf(stderr, fmt, args);
> +		va_end(args);
> +		fprintf(stderr, "\n");
> +	}
> +}
> +
> +void dbg_print_pkt(const char *str, unsigned char *data, int len)
> +{
> +	int i;

Same here.

> +	if(g_debug) {

And here.

> +		fprintf(stderr, "dbg: %s", str);
> +		for (i = 0; i < len; i++) {
> +			fprintf(stderr, "%02x ", data[i]);
> +		}

No { } needed for single statements.

> +		fprintf(stderr, "\n");
> +	}
> +}
> +
>  int set_speed(int fd, struct termios *ti, int speed)
>  {
>  	if (cfsetospeed(ti, uart_speed(speed)) < 0)
> @@ -1260,7 +1287,7 @@ static void usage(void)
>  {
>  	printf("hciattach - HCI UART driver initialization utility\n");
>  	printf("Usage:\n");
> -	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
> +	printf("\thciattach [-n] [-p] [-b] [-r] [-d] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
>  	printf("\thciattach -l\n");
>  }
>  
> @@ -1280,8 +1307,9 @@ int main(int argc, char *argv[])
>  	detach = 1;
>  	printpid = 0;
>  	raw = 0;
> +	g_debug = 0;

I rather have you not start with g_ for global semantic. We have not
been using it, so starting it now is making it confusing.

>  
> -	while ((opt=getopt(argc, argv, "bnpt:s:lr")) != EOF) {
> +	while ((opt=getopt(argc, argv, "bnpdt:s:lr")) != EOF) {
>  		switch(opt) {
>  		case 'b':
>  			send_break = 1;
> @@ -1314,6 +1342,10 @@ int main(int argc, char *argv[])
>  			raw = 1;
>  			break;
>  
> +		case 'd':
> +			g_debug = 1;
> +			break;
> +
>  		default:
>  			usage();
>  			exit(1);
> diff --git a/tools/hciattach.h b/tools/hciattach.h
> index a24dbc4..c528f2b 100644
> --- a/tools/hciattach.h
> +++ b/tools/hciattach.h
> @@ -44,6 +44,9 @@
>  #define HCI_UART_RESET_ON_INIT	1
>  #define HCI_UART_CREATE_AMP	2
>  
> +void dbg_print(const char *fmt, ...);
> +void dbg_print_pkt(const char * str, unsigned char * data, int len);

it is char *str here. No extra space.

> +
>  int read_hci_event(int fd, unsigned char* buf, int size);

And clearly not your fault, this one is wrong as well. The hciattach is
a poster child of bad coding style. Time to clean that up a little
bit ;)

>  int set_speed(int fd, struct termios *ti, int speed);
>  

Regards

Marcel


