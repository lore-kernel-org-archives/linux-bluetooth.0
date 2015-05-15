Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>,
	'Bharat Bhusan Panda' <bharat.panda@samsung.com>
References: <1429011468-13667-1-git-send-email-gowtham.ab@samsung.com>
 <000301d0784c$be534440$3af9ccc0$@samsung.com>
 <003101d07c2e$0b3d2200$21b76600$@samsung.com>
In-reply-to: <003101d07c2e$0b3d2200$21b76600$@samsung.com>
Subject: RE: [PATCH] tools: Handle the common profile & service ecode
Date: Fri, 15 May 2015 10:45:09 +0530
Message-id: <000001d08ece$23413eb0$69c3bc10$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Tuesday, April 21, 2015 5:54 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: RE: [PATCH] tools: Handle the common profile & service ecode
> 
> Ping.
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> > Sent: Thursday, April 16, 2015 7:23 PM
> > To: linux-bluetooth@vger.kernel.org
> > Subject: RE: [PATCH] tools: Handle the common profile & service ecode
> >
> > Ping.
> >
> > > -----Original Message-----
> > > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > > owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> > > Sent: Tuesday, April 14, 2015 5:08 PM
> > > To: linux-bluetooth@vger.kernel.org
> > > Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham
> Anandha
> > Babu
> > > Subject: [PATCH] tools: Handle the common profile & service ecode
> > >
> > > Handles the common profile and service error codes sent over the
> > > Attribute Protocol in btgatt-client and monitor.
> > > ---
> > >  monitor/l2cap.c       | 9 +++++++++
> > >  tools/btgatt-client.c | 6 ++++++
> > >  2 files changed, 15 insertions(+)
> > >
> > > diff --git a/monitor/l2cap.c b/monitor/l2cap.c index
> > > fc565b1..55efa54
> > 100644
> > > --- a/monitor/l2cap.c
> > > +++ b/monitor/l2cap.c
> > > @@ -2046,6 +2046,15 @@ static void att_error_response(const struct
> > > l2cap_frame *frame)
> > >  	case 0x11:
> > >  		str = "Insufficient Resources";
> > >  		break;
> > > +	case 0xfd:
> > > +		str = "CCC Improperly Configured";
> > > +		break;
> > > +	case 0xfe:
> > > +		str = "Procedure Already in Progress";
> > > +		break;
> > > +	case 0xff:
> > > +		str = "Out of Range";
> > > +		break;
> > >  	default:
> > >  		str = "Reserved";
> > >  		break;
> > > diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c index
> > > ee5315d..3935a7e 100644
> > > --- a/tools/btgatt-client.c
> > > +++ b/tools/btgatt-client.c
> > > @@ -114,6 +114,12 @@ static const char *ecode_to_string(uint8_t
> ecode)
> > >  		return "Group type Not Supported";
> > >  	case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
> > >  		return "Insufficient Resources";
> > > +	case BT_ERROR_CCC_IMPROPERLY_CONFIGURED:
> > > +		return "CCC Improperly Configured";
> > > +	case BT_ERROR_ALREADY_IN_PROGRESS:
> > > +		return "Procedure Already in Progress";
> > > +	case BT_ERROR_OUT_OF_RANGE:
> > > +		return "Out of Range";
> > >  	default:
> > >  		return "Unknown error type";
> > >  	}
> > > --
> > > 1.9.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth"
> > in
> > > the body of a message to majordomo@vger.kernel.org More majordomo
> > info
> > > at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth"
> in
> > the body of a message to majordomo@vger.kernel.org More majordomo
> info
> > at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

