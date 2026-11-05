Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909063;
	b=UtjGQ5vkzDNRk4wB+FOIFj4VELjZ/tG0il3Yy3bRAN69sLR01fVVs9AHgct87Nc8o0oa
	 u3D0hYbd1R61xzAzvFJ3AAAzurEULBZ+th3NX3T3fu3YjEF2p4xHwju5htMfwsg5Puq94
	 eXMSJ+K6BaP4iVtBVVX1dvAtZtj5ErZxIAwOJz9zIk/iR1lIyJOM/kzqh8ve+TvS1ov0Z
	 miWYMSarKbkXEICW4jEDJrozlafke9E3IJBCBunaMlpyOIDkekVerRNk2ZxS9bMY0e2wW
	 fbH1eu3LVDUEeKAi9AjqI1PXJAGUgoEwaFk55C9OyJTlVa+NHBATnBmkd/S2g2fZOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Aw5degZrQHo3V3rpws5+g22RRHe/seP3Fa1C54u6MN0=;
	b=yNFq10ICE7DcJkAwClJ0criL6bh9kiSZziebTdb9Zs+XedefMphQBrDDKbSpV9Ci6UEH
	 Rsqc/0ddXkEBFzPCH2Ie1JrbsSwH/C9rdX2Lkvpp0dog5usfFsLvDe0e34FQ39RSNVQBw
	 4aoI7Mgw7DWXA8F+Frjv5GXNpXpS+aiE3E9354wuB/uKxCppuYaeHlNHoJsvK75Fy4iqJ
	 daIllOZXOXop63AbbUxrcemxBQO4xThyPy1iJOy7fYmkuzhLX0aST2eACcCML2Bkv8EGB
	 qsmR0kEgnOMTLvd8rp0dg9MGo0g7YE+hSn9GuVGLyQgG7JXZm2XZwGHRKmKvdpo8/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b="l7XvB/r0";
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23316606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 20:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23316606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=l7XvB/r0
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53669f7b518so24654181cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793909062; x=1794513862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aw5degZrQHo3V3rpws5+g22RRHe/seP3Fa1C54u6MN0=;
        b=l7XvB/r0EAsfmkvKwLXi9U+FCv4znlZ1uWBgyBwXXZBCaUNdokUJy53RUHWJ+2kEWT
         BpwprXNHONWGHOvIsaDTpZHtcB6XsAeWhewDJaNhuiB2euiyoU1AbjQlFtg5R3UAb8Zl
         j9ild+5nUdzM5UZbj7mYag8Dctagcxk6YhEm1Nh61f0Vznb26vlUpjb7sFwe3CVlNOPl
         SyOS6Mi1UVvjAAp7m7mMB3CBgWNbht54CQ+BOwi4rfm1nRGeYFie5joT1aagUt7j+5ki
         VjKs1rKf0ER8mcU7zk1mritepu2DeojMvspSrsP6rAbky9P1uX094nTddzM3XtqlzsCQ
         csmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909062; x=1794513862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aw5degZrQHo3V3rpws5+g22RRHe/seP3Fa1C54u6MN0=;
        b=J8sUhGZIDpm2qwOz2kOuxx/ruP2muX/59FDihavfFyT6zueOCP06JJJc/UXbHD8p9i
         Ih+XvtB4VFhIQLMtuhebGwoWxuLDOeErTf1fkyjeh/8+O1CXcQLElcJYKf8lEzek8cfP
         84o56eBULh5sKfPSwOVKghzbi3Q2G9fm93UFZ6bV0477nbcD4YPuXNN7Qp5Kic97v2pC
         wfAOyvTVyzFkMqbdg+9GCaI95+qdmbX3NlWaU1Kjk0sqDuDjKXlJ6oYW16uqgQmMwIoC
         xatbzTE6EvoS4Jagmecosf3sSwLMMXKOMEM40a5P0Z8BF8i411bAhlOw4hMO4wv46HE+
         ietQ==
X-Forwarded-Encrypted: i=1; AKwUvByGGUuYInNYzZDAnuYDUkissxQlmj+3M4r7x8Y6ZYtknPd8izWkSA/FYRFugrjfFTanbPO7EXRYfoytenI+fj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1fWX2Yd3g1Cx6m1QfnwnN3cmwYJ77ihAAOVtTIu9orw2NbuM6
	OPFq/Wn+FAR1r6U19x/xNX8kupzhdUq9GwGMCDaY/AwuGYWSYJKcAbOrXHCTixTf0A==
X-Gm-Gg: AYBFou1jllwzvQy3NZUnk6+M913pVWWJ4zpfM3iq/cdLsqATojHs9gzuBSNJV2hs8IG
	djxNmz65eks17IwDOMgrEzNkjCbDkc176WdNFJUUypRCwzJ5brV2AL1e8TpgbauYwL0SIA9nvPr
	X147qLUnz8mpxpSza1ZwqEcjf8drerdnCl0tVzkZI8Krvg/1FbFQv8NKY9vbJgwkzuTOVd6z4mm
	eejUtUyat5CJKlKDW1zA1lMUBJbvxo0FPKfm9sG8KBMZ3e06uKksSQUilOrEix2/OJUvc4yqsem
	sFSz2+dC8OsiWE5ZBbQGZd40h3fjQw6wQ91vEZzeG60VYhgUDbCbTpE9eEHdMoahbNiSRHGLawY
	IFQVTimF3fH6aAC4ngqat/3bsW9u1Gjq8HAWDoouX7oSBaXtYl5dxiMAzvlOLAhIRnKWKs0eFoK
	4B6+H8LsN4oUb/ATZue/sYg2gC1rKICgfAFBK4uBWsgU8aLM5Jaexh7CzR4FuFAwjayr+KLKB7q
	piks0Rn/OUX/SVu+Z0Pnen/FIXIYterSPERVz8E7Fi+9mTwV0WS8A63K7rYuKDheaQB2GLxrdpi
	HjdWQfGAHG2laf2IgL0d/pANojOq
X-Received: by 2002:a05:622a:418d:b0:536:60e1:c87d with SMTP id d75a77b69052e-54e14266a2dmr6509601cf.35.1793909061778;
        Thu, 05 Nov 2026 12:04:21 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e270167afsm1403061cf.25.2026.11.05.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:04:21 -0800 (PST)
Date: Thu, 5 Nov 2026 15:04:18 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105184442.GF8298@unreal>

On Thu, Nov 05, 2026 at 08:44:42PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 12:24:33PM -0500, Alan Stern wrote:
> > On Thu, Nov 05, 2026 at 01:42:18PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Interface claims hold the USB device lock, but device_bind_driver()
> > > requires the target interface lock. Without it, trust-policy writes can
> > > race admission.
> > 
> > This says nothing about usb_driver_release_refused_claim() and the code 
> > related to it.  It is an incomplete description of the patch.
> > 
> > Note that nothing prevents drivers from using an interface they claim 
> > before that interface is registered.  For your scheme to work properly, 
> > you should make sure the claim is authorized when 
> > usb_driver_claim_interface() is called, not when the interface is 
> > registered.
> 
> This patch is unrelated to authorization;

I meant "authorization" in its generic sense.  When you don't trust 
something, you don't authorize it to do anything.  Pretend I had written 
"the interface being claimed is trusted" in place of "the claim is 
authorized" above.

>  it ensures that the lock is
> acquired when the driver is bound.

That may have been your intention when the patch was created, but if you 
read the patch you'll see that it includes a whole bunch of material 
not related to locking during binding.  Namely, this part:

> > > +/*
> > > + * The driver core refused to bind an interface that a sibling claimed before
> > > + * it was registered, and dropped the claim. Let the claimant release the
> > > + * interface instead of operating it with a bound interface but no driver.
> > > + */
> > > +void usb_driver_release_refused_claim(struct usb_interface *iface,
> > > +				      struct device_driver *claimant)
> > > +{
> > > +	struct device *dev = &iface->dev;
> > > +
> > > +	device_lock(dev);
> > > +	if (!dev->driver && iface->condition == USB_INTERFACE_BOUND) {
> > > +		dev->driver = claimant;
> > > +		usb_unbind_interface(dev);
> > > +		dev_set_drvdata(dev, NULL);
> > > +		dev->driver = NULL;
> > > +	}
> > > +	device_unlock(dev);
> > > +}
> > > +
> > >  /* returns 0 if no match, 1 if match */
> > >  int usb_match_device(struct usb_device *dev, const struct usb_device_id *id)
> > >  {
> > > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > > index a738d03c23eac..d35a7710c8ef4 100644
> > > --- a/drivers/usb/core/message.c
> > > +++ b/drivers/usb/core/message.c
> > > @@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> > >  	 */
> > >  	for (i = 0; i < nintf; ++i) {
> > >  		struct usb_interface *intf = cp->interface[i];
> > > +		struct device_driver *claimant;
> > >  
> > >  		if (intf->dev.of_node &&
> > >  		    !of_device_is_available(intf->dev.of_node)) {
> > > @@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> > >  			dev_name(&intf->dev), configuration,
> > >  			intf->cur_altsetting->desc.bInterfaceNumber);
> > >  		device_enable_async_suspend(&intf->dev);
> > > +		claimant = intf->dev.driver;
> > > +		if (claimant && !try_module_get(claimant->owner))
> > > +			claimant = NULL;
> > >  		ret = device_add(&intf->dev);
> > > +		if (!ret && claimant && !intf->dev.driver)
> > > +			usb_driver_release_refused_claim(intf, claimant);
> > > +		if (claimant)
> > > +			module_put(claimant->owner);
> > >  		if (ret != 0) {
> > >  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
> > >  				dev_name(&intf->dev), ret);
> > > diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> > > index a9b37aeb515be..293340a48b6c5 100644
> > > --- a/drivers/usb/core/usb.h
> > > +++ b/drivers/usb/core/usb.h
> > > @@ -49,6 +49,8 @@ extern int usb_set_isoch_delay(struct usb_device *dev);
> > >  extern int usb_get_bos_descriptor(struct usb_device *dev);
> > >  extern void usb_release_bos_descriptor(struct usb_device *dev);
> > >  extern int usb_set_configuration(struct usb_device *dev, int configuration);
> > > +void usb_driver_release_refused_claim(struct usb_interface *iface,
> > > +				      struct device_driver *claimant);
> > >  extern int usb_choose_configuration(struct usb_device *udev);
> > >  extern int usb_generic_driver_probe(struct usb_device *udev);
> > >  extern void usb_generic_driver_disconnect(struct usb_device *udev);

Was this meant to be two separate patches that somehow got combined into 
one?

Alan Stern
