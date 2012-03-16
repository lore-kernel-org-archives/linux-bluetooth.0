Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/7] Parse config DeviceID string on bluetoothd startup
Date: Fri, 16 Mar 2012 17:02:58 +0100
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>
References: <1331908913-10330-1-git-send-email-szymon.janc@tieto.com> <1331913063.14217.148.camel@aeonflux>
In-Reply-To: <1331913063.14217.148.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201203161702.58731.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> >  	uint8_t		mode;
> >  	uint8_t		discov_interval;
> > -	char		deviceid[15]; /* FIXME: */
> > +
> > +	gboolean	did;
> 
> store the uint16_t did_source here. 0x0000 means off like it does for
> the kernel.
> 

This is done in 3/7 'Add support for setting VID source (assigner ID) in DeviceID'
Just wanted to have adding support for setting source in main.conf in separate patch.

-- 
BR
Szymon Janc
