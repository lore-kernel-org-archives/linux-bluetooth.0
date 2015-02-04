Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix minimum size for variable length events
Date: Wed, 04 Feb 2015 23:11:28 +0100
Message-ID: <1858164.g9f32Se7Qq@leonov>
In-Reply-To: <AEA5CFDB-68FD-41C0-9960-6EA1433DD4A5@holtmann.org>
References: <1423080848-7611-1-git-send-email-szymon.janc@tieto.com> <AEA5CFDB-68FD-41C0-9960-6EA1433DD4A5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wednesday 04 of February 2015 14:03:25 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > Those could lead to reading invalid memory if frames were corrupted.
> > ---
> > monitor/packet.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/monitor/packet.c b/monitor/packet.c
> > index ba58d84..56a315b 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -8204,7 +8204,7 @@ static const struct event_data event_table[] = {
> > 
> > 	{ 0x01, "Inquiry Complete",
> > 	
> > 				inquiry_complete_evt, 1, true },
> > 	
> > 	{ 0x02, "Inquiry Result",
> > 
> > -				inquiry_result_evt, 1, false },
> > +				inquiry_result_evt, 8, false },
> 
> these are wrong. That is why fixed size is set to false here. It means that
> the callback function needs to ensure we do the right checks. If we don't,
> please with the callback functions.

If fixed==false then passed size is minimum required size and all callbacks 
are expecting those.

>From packet_hci_event()

	if (event_data->fixed) {
		if (hdr->plen != event_data->size) {
			print_text(COLOR_ERROR, "invalid packet size");
			packet_hexdump(data, size);
			return;
		}
	} else {
		if (hdr->plen < event_data->size) {
			print_text(COLOR_ERROR, "too short packet");
			packet_hexdump(data, size);
			return;
		}
	}

	event_data->func(data, hdr->plen);


-- 
BR
Szymon Janc
