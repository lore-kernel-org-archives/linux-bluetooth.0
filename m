Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 13:37:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Urja Rannikko <urjaman@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciattach_tialt: Implement texas_change_speed function.
Message-ID: <20120330103709.GA12656@x220>
References: <CAPCnQJnPC3Abgg7r_HL_27V-0DZ8EZ7ufopySFiZ4nL1wREzYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPCnQJnPC3Abgg7r_HL_27V-0DZ8EZ7ufopySFiZ4nL1wREzYw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Urja,

On Thu, Mar 29, 2012, Urja Rannikko wrote:
> I'm working on bluetooth on the pandora handheld console, and this
> functionality was missing.
> This is my first mail on this list, and I'm not 100% sure on all the
> customs here, but I think this is sufficient:

If possible please use git send-email instead of sending patches as
attachments.

> Signed-off-by: Urja Rannikko <urjaman@gmail.com>

This convention is only used for kernel-side patches.
> +static int poll_wait_reply(int fd, int ms) {

The { goes on its own line.

> +	struct pollfd pfd;
> +	pfd.fd = fd;

Empty line after the initial variable declarations.

> +	pfd.events = POLLIN;
> +	pfd.revents = 0;
> +	return poll(&pfd, 1, ms);
> +}

Empty line before return. ...


> +static int texas_change_speed(int fd, uint32_t speed) {

Same thing here with the {
> +	int i;
> +	texas_speed_change_cmd_t cmd;
> +	fprintf(stdout,"Sending speed change command..\n");

And again empty line after the variable declarations. Also missing space
after the comma (I'd have requested you to use printf instead of fprintf
since you're using stdout but I noticed that the rest of the file does
this too; feel free to send a separate cleanup patch for that if you
wish though).

> +	for (i=0;i<3;i++) {

This should be:
	for (i = 0; i < 3; i++) {

> +		int n = write(fd,&cmd,sizeof(cmd));

The return value of write is ssize_t and not int (not that it makes much
difference but it doesn't hurt to be consistent here). Also, missing
space after each comma.

> +		if (n < 0) {
> +			perror("Failed to write speed change command");
> +			return -1;
> +		}
> +		if (n < sizeof(cmd)) {

Add an empty line before the second if

> +			fprintf(stderr, "Wanted to write %lu bytes, could only write %d. Stop\n", sizeof(cmd), n);

Keep your lines under 80 characters please.

> +			return -1;
> +		}
> +		if (poll_wait_reply(fd,100)!=1) continue;

Empty line before the if and put the continue on its own line. Also,
missing space before and after !=

> +		return read_command_complete(fd,cmd.hci_hdr.opcode,cmd.hci_hdr.plen);

Missing spaces after each comma.

> +	}
> +	fprintf(stderr,"Speed change command timeout.\n");

Add an empty line before the fprintf. Also, missing space after the
comma.

> +		if (texas_change_speed(fd, speed)) return -1;

Put the return statement on its own line.

Johan
