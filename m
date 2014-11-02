Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 15:23:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 2/2] service-find command for new kernel method usage
Message-ID: <20141102132332.GB4544@t440s.P-661HNU-F1>
References: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
 <1414612349-2262-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414612349-2262-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Oct 29, 2014, Jakub Pawlowski wrote:
> +static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid);

Please just move up this function instead of creating a
forward-declaration for it.

> +static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
> +{
> +	struct mgmt_cp_start_service_discovery *cp;
> +	struct mgmt_uuid_filter *filter;
> +	uint8_t type;
> +	int opt;
> +	int total_size = sizeof(struct mgmt_cp_start_service_discovery) + sizeof(struct mgmt_uuid_filter);
> +	uuid_t uuid;
> +	uint128_t uint128;
> +	uuid_t uuid128;
> +
> +	if (index == MGMT_INDEX_NONE)
> +		index = 0;
> +
> +	type = 0;
> +	hci_set_bit(BDADDR_BREDR, &type);
> +	hci_set_bit(BDADDR_LE_PUBLIC, &type);
> +	hci_set_bit(BDADDR_LE_RANDOM, &type);
> +
> +	cp = malloc(total_size);
> +	if(cp == NULL) {

Missing space after 'if', however I wonder is there any point to do
dynamic allocation here since you always just have just one filter
entry. Having the send buffer on the stack might create simpler code
here.

> +		fprintf(stderr, "Unable to allocate memory for mgmt_cp_start_service_discovery structure.\n");
> +	}

Wouldn't you need to return from the function in this case?

> +	memset(cp, 0, total_size);
> +
> +	filter = cp->filter;
> +
> +	if(argc == 1) {

Missing space after 'if'.

> +	if (mgmt_send(mgmt, MGMT_OP_START_SERVICE_DISCOVERY, index, total_size, cp,
> +						find_service_rsp, cp, NULL) == 0) {
> +		free(cp);
> +		fprintf(stderr, "Unable to send start_service_discovery cmd\n");
> +		exit(EXIT_FAILURE);
> +	}
> +}

mgmt_send allocates its own buffer for the send parameters so there's no
need for you to keep your own buffer around until the command completion
callback (where all you do is free it). However, this whole issue would
go away if you'd just use a stack variable.

Johan
