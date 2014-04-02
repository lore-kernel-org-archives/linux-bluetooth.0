Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Apr 2014 14:51:34 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Poulain, Loic" <loic.poulain@intel.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4] tools: add bcm43xx specific init in hciattach
Message-ID: <20140402115134.GA5055@t440s.lan>
References: <50C3158CF44D924791C15F1437EF2EC65D7406@HASMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50C3158CF44D924791C15F1437EF2EC65D7406@HASMSX104.ger.corp.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Wed, Apr 02, 2014, Poulain, Loic wrote:
> Add a bcm43xx specific init sequence in hciattach
> in order to initialize bcm43xx controllers.
> ---
>  Makefile.tools            |   3 +-
>  tools/hciattach.c         |  11 +-
>  tools/hciattach.h         |   2 +
>  tools/hciattach_bcm43xx.c | 370 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 384 insertions(+), 2 deletions(-)
>  create mode 100644 tools/hciattach_bcm43xx.c

A few coding style related things that would still be good to be cleaned
up:

> +static int bcm43xx_read_local_name(int fd, char *name, size_t size)
> +{
> +	unsigned char cmd[] = {HCI_COMMAND_PKT, 0x14, 0x0C, 0x00};

Space after { and before } please.

> +	unsigned char *resp;
> +	unsigned int name_len;
> +
> +	resp = malloc(size + CC_MIN_SIZE);
> +	if (!resp) {
> +		return -1;
> +	}

No need for { } for one-line branches.

> +	name_len = (uint8_t)resp[2] - 1;

Space between the cast and variable name. That said, is the case even
necessary here? uint8_t and unsigned char should in practice be
interchangeable (however we do prefer the former whenever possible).

> +	strncpy(name, (char *)&resp[7], MIN(name_len, size));

Same here (regarding space after cast)

> +static int bcm43xx_reset(int fd)
> +{
> +	unsigned char cmd[] = {HCI_COMMAND_PKT, 0x03, 0x0C, 0x00};

Space after { and before }

> +static int bcm43xx_set_bdaddr(int fd, const char *bdaddr)
> +{
> +	unsigned char cmd[] =
> +		{HCI_COMMAND_PKT, 0x01, 0xfc, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

Same here.

> +	if (strlen(bdaddr) != 17) {
> +		fprintf(stderr, "Incorrect bdaddr\n");
> +		return -1;
> +	}
> +
> +	str2ba(bdaddr, (bdaddr_t *) (&cmd[4]));

The strlen check is redundant if you'd just check the return value of
str2ba. It will return < 0 in case of invalid string.

> +static int bcm43xx_set_speed(int fd, uint32_t speed)
> +{
> +	unsigned char cmd[] =
> +		{HCI_COMMAND_PKT, 0x18, 0xfc, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

Space after { and before }, and don't be afraid to split this into
multiple lines to avoid violating the less than 80 chars rule.

> +	unsigned char resp[CC_MIN_SIZE];
> +	int len, i;
> +
> +	printf("Set Controller UART speed to %d bit/s\n", speed);
> +
> +	cmd[6] = (uint8_t)(speed);
> +	cmd[7] = (uint8_t)(speed >> 8);
> +	cmd[8] = (uint8_t)(speed >> 16);
> +	cmd[9] = (uint8_t)(speed >> 24);

Space between cast and variable name.

> +	if ((len = read_hci_event(fd, resp, sizeof(resp))) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to update baudrate, invalid HCI event\n");
> +		return -1;
> +	}

You don't seem to use the len variable anywhere in this function after
assigning something to it. Just remove it.

> +
> +static int bcm43xx_set_clock(int fd, uint8_t clock)
> +{
> +	unsigned char cmd[] = {HCI_COMMAND_PKT, 0x45, 0xfc, 0x01, 0x00};

Space after { and before }

> +	unsigned char resp[CC_MIN_SIZE];
> +
> +	printf("Set Controller clock (%d)\n", clock);
> +
> +	cmd[4] = (unsigned char)clock;

Again, this cast seems unnecessary to me due to to uint8_t and unsigned
char being interchangeable. Just change all places you can to use
uint8_t to avoid even this cosmetic inconsistency.

> +static int bcm43xx_load_firmware(int fd, const char *fw)
> +{
> +	unsigned char cmd[] = {HCI_COMMAND_PKT, 0x2e, 0xfc, 0x00 };
> +	struct timespec tm_mode = {0, 50000};
> +	struct timespec tm_ready = {0, 2000000};

Space after { and before }

> +	unsigned char resp[CC_MIN_SIZE];
> +	unsigned char tx_buf[1024];
> +	int len;
> +
> +	printf("Flash firmware %s\n", fw);
> +
> +	int fd_fw = open(fw, O_RDONLY);

Declare the variable in the beginning of the code block (I know newer C
standards allow this but it's not consistent with BlueZ coding style).

> +	while (read(fd_fw, &tx_buf[1], 3)) {

I suppose you should be checking for failure here to avoid entering the
loop when read failed?

> +static int
> +bcm43xx_locate_patch(const char *dir_name, const char *chip_name, char *location)

We usually do the line splitting somewhere in the middle of the function
parameters instead of putting the return type on its own line.

> +	DIR *dir;
> +	struct dirent *entry;
> +	int ret = -1;
> +	char fw_ext[] = ".hcd";
> +
> +	dir = opendir (dir_name);
> +	if (!dir) {
> +		fprintf (stderr, "Cannot open directory '%s': %s\n",
> +				dir_name, strerror (errno));
> +		return -1;
> +	}

No space between the function name and the opening parenthesis please.

> +
> +	/* Recursively look for a BCM43XX*.hcd */
> +	while(1) {

Space after while

> +		entry = readdir(dir);
> +		if (!entry)
> +			break;
> +
> +		if (entry->d_type & DT_DIR) {
> +			char path[PATH_MAX];
> +
> +			if (!strcmp(entry->d_name, "..") || !strcmp(entry->d_name, "."))
> +				continue;
> +
> +			snprintf(path, PATH_MAX, "%s/%s", dir_name, entry->d_name);
> +
> +			ret = bcm43xx_locate_patch(path, chip_name, location);
> +			if (!ret)
> +				break;
> +		} else if (!strncmp(chip_name, entry->d_name, strlen(chip_name))) {
> +			unsigned int name_len = strlen(entry->d_name);
> +			unsigned int curs_ext = name_len - sizeof(fw_ext) + 1;

Shouldn't these be size_t instead of unsigned int?

> +	if (bdaddr) {
> +		bcm43xx_set_bdaddr(fd, bdaddr);
> +	}
> +
> +	if (speed > 3000000 && bcm43xx_set_clock(fd, BCM43XX_CLOCK_48)) {
> +		return -1;
> +	}

No need for { } for one-line branches.

Johan
