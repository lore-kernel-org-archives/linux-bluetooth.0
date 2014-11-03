Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141102132332.GB4544@t440s.P-661HNU-F1>
References: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
	<1414612349-2262-2-git-send-email-jpawlowski@google.com>
	<20141102132332.GB4544@t440s.P-661HNU-F1>
Date: Mon, 3 Nov 2014 12:50:58 -0800
Message-ID: <CAD0=r8zh1GqVGQBG3dJJBmzbE8txAVtK6OkvzeB-zT218S5yRw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] service-find command for new kernel method usage
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Nov 2, 2014 at 5:23 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Oct 29, 2014, Jakub Pawlowski wrote:
>> +static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid);
>
> Please just move up this function instead of creating a
> forward-declaration for it.
>
>> +static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
>> +{
>> +     struct mgmt_cp_start_service_discovery *cp;
>> +     struct mgmt_uuid_filter *filter;
>> +     uint8_t type;
>> +     int opt;
>> +     int total_size = sizeof(struct mgmt_cp_start_service_discovery) + sizeof(struct mgmt_uuid_filter);
>> +     uuid_t uuid;
>> +     uint128_t uint128;
>> +     uuid_t uuid128;
>> +
>> +     if (index == MGMT_INDEX_NONE)
>> +             index = 0;
>> +
>> +     type = 0;
>> +     hci_set_bit(BDADDR_BREDR, &type);
>> +     hci_set_bit(BDADDR_LE_PUBLIC, &type);
>> +     hci_set_bit(BDADDR_LE_RANDOM, &type);
>> +
>> +     cp = malloc(total_size);
>> +     if(cp == NULL) {
>
> Missing space after 'if', however I wonder is there any point to do
> dynamic allocation here since you always just have just one filter
> entry. Having the send buffer on the stack might create simpler code
> here.

mgmt_cp_start_service_discovery have array of mgmt_uuid_filter at the
end, and mgmt_send internally just do one malloc and memcpy to copy
the whole data.
Right now I just reserve all needed space. If I use stack variable how
would I make sure that mgmt_uuid_filter is exactly at end of
mgmt_cp_start_service_discovery ?

I've fixed all other issues, and would re-send my patch after making
sure that Marcel is fine with mgmt API as I defined it.

>
>> +             fprintf(stderr, "Unable to allocate memory for mgmt_cp_start_service_discovery structure.\n");
>> +     }
>
> Wouldn't you need to return from the function in this case?
>
>> +     memset(cp, 0, total_size);
>> +
>> +     filter = cp->filter;
>> +
>> +     if(argc == 1) {
>
> Missing space after 'if'.
>
>> +     if (mgmt_send(mgmt, MGMT_OP_START_SERVICE_DISCOVERY, index, total_size, cp,
>> +                                             find_service_rsp, cp, NULL) == 0) {
>> +             free(cp);
>> +             fprintf(stderr, "Unable to send start_service_discovery cmd\n");
>> +             exit(EXIT_FAILURE);
>> +     }
>> +}
>
> mgmt_send allocates its own buffer for the send parameters so there's no
> need for you to keep your own buffer around until the command completion
> callback (where all you do is free it). However, this whole issue would
> go away if you'd just use a stack variable.
>
> Johan
