Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH] Expose HIDNormallyConnectable and HIDReconnectInitiate properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363655144-9705-1-git-send-email-deymo@chromium.org>
Date: Wed, 20 Mar 2013 08:47:16 -0700
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com,
	keybuk@chromium.org
Message-Id: <619604FF-BBA6-4FE5-8F48-A7B637272084@holtmann.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> The "Connectability" of a HID device, as defined by the HID spec,
> governs the way the host may and should connect to a HID device or
> expect a connection from it. In the comon case of mice and keyboards
> the HIDNormallyConnectable is FALSE and HIDReconnectInitiate is TRUE,
> since those devices only attempt a connection to the host when they
> have some data to transfer. A connection attempt initiated from the
> host after the device drops the connection (while still paired) will
> result in a Page timeout.
> 
> This patch exposes these two HID properties as Device properties, updates
> them every time new SDP records are available and persists them in the
> device's info file. This patch also shows this information in the
> bluetoothctl "info <dev>" command.
> For non-HID devices and when no information is available (i.e. a cached
> device after upgrade from a version without this patch) both properties
> are set to the comon case: HIDNormallyConnectable is FALSE and
> HIDReconnectInitiate is TRUE.
> ---
> 
> This patch is a rework of a previous patch named "Add GetCachedServices
> to device API". This new attempt exposes only these two properties 
> related to the "Connectability" of the device. 

I am not a huge fan of making these part of the Device1 interface. They should be part of an Input1 interface on the same object path. And it should be only present for HID devices. Making this available for everybody is a bit against the idea of keeping it simple.

We do not have an Input1 interface right now, but that does not stop the input plugin from creating this.

Regards

Marcel

