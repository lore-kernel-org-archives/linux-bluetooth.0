Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v3 1/2] input: Documentation for new Input1 interface
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364863226-10566-2-git-send-email-deymo@chromium.org>
Date: Wed, 3 Apr 2013 20:48:20 -0700
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Message-Id: <51314AAB-DED8-49D6-ACF9-C5658B5948F1@holtmann.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org> <1364863226-10566-1-git-send-email-deymo@chromium.org> <1364863226-10566-2-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> Adds new documentation for a new Input1 interface exposing two properties.
> ---
> doc/input-api.txt | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
> create mode 100644 doc/input-api.txt
> 
> diff --git a/doc/input-api.txt b/doc/input-api.txt
> new file mode 100644
> index 0000000..44bbde6
> --- /dev/null
> +++ b/doc/input-api.txt
> @@ -0,0 +1,21 @@
> +BlueZ D-Bus Input API description
> +*********************************
> +
> +Input hierarchy
> +===============
> +
> +Service		org.bluez
> +Interface	org.bluez.Input1
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +Properties	boolean NormallyConnectable [readonly]
> +
> +			Exposes the value of HIDNormallyConnectable as defined
> +			by the HID profile specification. If this optional value
> +			is not specified by the HID device, the value is asumend
> +			as FALSE.
> +
> +		boolean ConnectInitiate [readonly]
> +
> +			Exposes the value of ConnectInitiate as defined by the
> +			HID profile specification.

I am not 100% comfortable with the property names yet. Especially the ConnectInitiate sounds badly to me. Does anybody have any ideas?

Regards

Marcel


