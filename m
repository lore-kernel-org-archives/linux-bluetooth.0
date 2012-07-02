Return-Path: <cyrus@holtmann.org>
Date: Mon, 02 Jul 2012 13:26:20 -0300 (BRT)
Message-Id: <20120702.132620.433001249354725336.pcacjr@zytor.com>
To: johan.hedberg@gmail.com
Cc: paulo.alcantara@openbossa.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/12] storage: Store address type in "names" file
From: Paulo Alcantara <pcacjr@zytor.com>
In-Reply-To: <20120702112550.GB30370@x220.P-661HNU-F1>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
	<1339715044-13737-2-git-send-email-paulo.alcantara@openbossa.org>
	<20120702112550.GB30370@x220.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Mon, 2 Jul 2012 14:25:50 +0300

> Hi Paulo,
> 
> On Thu, Jun 14, 2012, Paulo Alcantara wrote:
> > +	uint8_t bdaddr_type;
> >  
> >  	idev = g_new0(struct input_device, 1);
> >  	adapter_get_address(adapter, &idev->src);
> > -	device_get_address(device, &idev->dst, NULL);
> > +	device_get_address(device, &idev->dst, &bdaddr_type);
> 
> I think it'd be clearer to call this dst_type (since it matches dst_addr
> and not src_addr). Could you also change this in all other places the
> variable naming occurs in your patches.

Yeah, indeed. I'll send a v2 of this patchset with the proposed changes.

Thanks!


		Paulo
