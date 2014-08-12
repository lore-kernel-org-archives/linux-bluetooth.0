Return-Path: <cyrus@holtmann.org>
From: "Gu, Chao Jie" <chao.jie.gu@intel.com>
To: Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC v2 1/1] doc/gatt-api: New API properties and methods for
 the GATT D-Bus API.
Date: Tue, 12 Aug 2014 05:16:09 +0000
Message-ID: <3D02B219753AD44CBDDDE484323B1774112F0DB2@SHSMSX104.ccr.corp.intel.com>
References: <1407789427-7118-1-git-send-email-armansito@chromium.org>
 <1407789427-7118-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1407789427-7118-2-git-send-email-armansito@chromium.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,
> +
> +		object Device [read-only, optional]
> +
> +			Object path of the Bluetooth device the service
> +			belongs to. Only present on services from remote
> +			devices.

Following your new proposal to implement, there is one details that I missed before which condition the services would set up under the local remote device. I think this "optional" maybe is not essential. Gatt Hiearchy should always set up when it connected to remote devices.

Thanks
Chaojie Gu 
