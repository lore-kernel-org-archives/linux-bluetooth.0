Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Nov 2014 08:39:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] service-find command for new kernel method usage
Message-ID: <20141104063918.GA31334@t440s.P-661HNU-F1>
References: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
 <1414612349-2262-2-git-send-email-jpawlowski@google.com>
 <20141102132332.GB4544@t440s.P-661HNU-F1>
 <CAD0=r8zh1GqVGQBG3dJJBmzbE8txAVtK6OkvzeB-zT218S5yRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8zh1GqVGQBG3dJJBmzbE8txAVtK6OkvzeB-zT218S5yRw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Nov 03, 2014, Jakub Pawlowski wrote:
> On Sun, Nov 2, 2014 at 5:23 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Jakub,
> >
> > On Wed, Oct 29, 2014, Jakub Pawlowski wrote:
> >> +static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid);
> >
> > Please just move up this function instead of creating a
> > forward-declaration for it.
> >
> >> +static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
> >> +{
> >> +     struct mgmt_cp_start_service_discovery *cp;
> >> +     struct mgmt_uuid_filter *filter;
> >> +     uint8_t type;
> >> +     int opt;
> >> +     int total_size = sizeof(struct mgmt_cp_start_service_discovery) + sizeof(struct mgmt_uuid_filter);
> >> +     uuid_t uuid;
> >> +     uint128_t uint128;
> >> +     uuid_t uuid128;
> >> +
> >> +     if (index == MGMT_INDEX_NONE)
> >> +             index = 0;
> >> +
> >> +     type = 0;
> >> +     hci_set_bit(BDADDR_BREDR, &type);
> >> +     hci_set_bit(BDADDR_LE_PUBLIC, &type);
> >> +     hci_set_bit(BDADDR_LE_RANDOM, &type);
> >> +
> >> +     cp = malloc(total_size);
> >> +     if(cp == NULL) {
> >
> > Missing space after 'if', however I wonder is there any point to do
> > dynamic allocation here since you always just have just one filter
> > entry. Having the send buffer on the stack might create simpler code
> > here.
> 
> mgmt_cp_start_service_discovery have array of mgmt_uuid_filter at the
> end, and mgmt_send internally just do one malloc and memcpy to copy
> the whole data.
> Right now I just reserve all needed space. If I use stack variable how
> would I make sure that mgmt_uuid_filter is exactly at end of
> mgmt_cp_start_service_discovery ?

Something like the following should work:

	struct mgmt_cp_start_service_discovery *cp;
	struct mgmt_uuid_filter *filter;
	uint8_t buf[sizeof(*cp) + sizeof(*filter)];

	cp = (void *) buf;
	filter = cp->filter;

	...

This kind of style has been used in a few other places, however in this
case a possibly better approach (resulting in a bit simpler code) would
be to use alloca().

Johan
