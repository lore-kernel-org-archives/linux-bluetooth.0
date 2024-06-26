Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E7ACC18FDDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423987; cv=none; b=nFvFHkbBhBOgQgVDVtAeHe3RCoStYl2dtZv1Kfug72Sd0j9OwaQ+ZBs3uWgRggPLQyPVjLK9DpaE8ohfuDUHki/2x2h0bC3k8+GotIfMo+hN3CZ9TSdOZ7nowXc1Rg6EeRtvCQcVsx8IUZLIIR10XKqHj2rpEsnOeMK9awDMPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423987; c=relaxed/simple;
	bh=UDy2EAAAedZm8c+seUJoRJmo7fvPySwdZEOjQGes8Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc9Er/QGe6WIYCsKrdv54mV0eFMQYmMCdMgLD1iVkTdCQuJPUbuz6jIXHfvNfGrjbwDci+yTFlevs4Lt8ypaDnMXtfHvd7Rqyf252By0IU6nWp6cnndqooMsbGkbcT18galODT0N33vP9d94ZVnK/sIZ0w1jdVUkQsIOZ/fCBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 712417 invoked by uid 1000); 26 Jun 2024 13:46:24 -0400
Date: Wed, 26 Jun 2024 13:46:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in
 btusb_submit_intr_urb/usb_submit_urb
Message-ID: <6d1f6bcc-2918-48cd-bbb3-e8cca46622a1@rowland.harvard.edu>
References: <a6eb3c4e-411f-4fbf-a85c-f3435170341d@rowland.harvard.edu>
 <000000000000d6c39d061bcdb82c@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d6c39d061bcdb82c@google.com>

On Wed, Jun 26, 2024 at 09:44:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in btusb_submit_intr_urb/usb_submit_urb

As expected.  The interesting information is in the console log:

[  100.266326][   T25] btusb 1-1:0.0: Ep ffff8880234bee00 epaddr 9b epattr 67
[  100.280938][   T53] btusb 1-1:0.0: Pipe 404d8280 ep ffff8880234bee00
[  100.287918][   T53] usb 1-1: Error pipe 404d8280 ep ffff8880234beea0 epaddr 8b

Notice the difference in the "ep" values (the addresses of the endpoint 
descriptors).  The kernel thinks two different endpoints are the same.

The reason is that the two descriptors have the same direction and 
address, but the parsing code in config.c doesn't realize they are 
duplicates because they differ in the value of the reserved bits in 
bEndpointAddress.  You can see this in the epaddr values above: 0x9b 
versus 0x8b.

Let's see what happens if we reject endpoint descriptors in which any of 
the reserved bits in bEndpointAddress are set.

Alan Stern

#syz test: upstream 66cc544fd75c

Index: usb-devel/drivers/bluetooth/btusb.c
===================================================================
--- usb-devel.orig/drivers/bluetooth/btusb.c
+++ usb-devel/drivers/bluetooth/btusb.c
@@ -1398,6 +1398,7 @@ static int btusb_submit_intr_urb(struct
 	}
 
 	pipe = usb_rcvintpipe(data->udev, data->intr_ep->bEndpointAddress);
+	dev_info(&data->intf->dev, "Pipe %x ep %p\n", pipe, data->intr_ep);
 
 	usb_fill_int_urb(urb, data->udev, pipe, buf, size,
 			 btusb_intr_complete, hdev, data->intr_ep->bInterval);
@@ -4283,6 +4284,9 @@ static int btusb_probe(struct usb_interf
 
 		if (!data->intr_ep && usb_endpoint_is_int_in(ep_desc)) {
 			data->intr_ep = ep_desc;
+			dev_info(&intf->dev, "Ep %p epaddr %x epattr %x\n",
+					ep_desc, ep_desc->bEndpointAddress,
+					ep_desc->bmAttributes);
 			continue;
 		}
 
Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -208,8 +208,11 @@ int usb_pipe_type_check(struct usb_devic
 	ep = usb_pipe_endpoint(dev, pipe);
 	if (!ep)
 		return -EINVAL;
-	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)]) {
+		dev_info(&dev->dev, "Error pipe %x ep %p epaddr %x\n",
+				pipe, &ep->desc, ep->desc.bEndpointAddress);
 		return -EINVAL;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_pipe_type_check);
Index: usb-devel/drivers/usb/core/config.c
===================================================================
--- usb-devel.orig/drivers/usb/core/config.c
+++ usb-devel/drivers/usb/core/config.c
@@ -287,6 +287,13 @@ static int usb_parse_endpoint(struct dev
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
+	if (d->bEndpointAddress &
+			~(USB_ENDPOINT_DIR_MASK | USB_ENDPOINT_NUMBER_MASK)) {
+		dev_notice(ddev, "config %d interface %d altsetting %d has an invalid endpoint descriptor with address 0x%02x, skipping\n",
+		    cfgno, inum, asnum, d->bEndpointAddress);
+		goto skip_to_next_endpoint_or_interface_descriptor;
+	}
+
 	/* Only store as many endpoints as we have room for */
 	if (ifp->desc.bNumEndpoints >= num_ep)
 		goto skip_to_next_endpoint_or_interface_descriptor;

