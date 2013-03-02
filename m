Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Date: Fri, 1 Mar 2013 19:09:20 -0800
Cc: <linux-bluetooth@vger.kernel.org>
Message-Id: <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
To: Waldemar Rymarkiewicz <Waldemar.Rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> Change-Id: I7165ecee0186dfdb51cd01838f28768d94ff12b9
> ---
> doc/bloodpressure-api.txt | 138 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 138 insertions(+)
> create mode 100644 doc/bloodpressure-api.txt
> 
> diff --git a/doc/bloodpressure-api.txt b/doc/bloodpressure-api.txt
> new file mode 100644
> index 0000000..2acc660
> --- /dev/null
> +++ b/doc/bloodpressure-api.txt
> @@ -0,0 +1,138 @@
> +Blood Pressure API description
> +******************************
> +
> +
> +Blood Pressure Manager hierarchy
> +================================
> +
> +Serviceorg.bluez
> +Interface	org.bluez.BloodPressureManager1
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +Methods		RegisterWatcher(object agent)

I do not really this manager business anymore. Splitting the interface over adapter and device object seems pointless. What I like to see is that we make one interface on the device object. We should have no proper lifetime rules for these.

Basically a client using a specialised interface should have to deal with one entry point and not with multiple. Low Energy clients need to pick a device they want to operate with. So this should focus on device objects and nothing else.

Regards

Marcel

