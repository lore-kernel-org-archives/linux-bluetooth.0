Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 15:57:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ 3/3] device: add a btd_device_set_trusted() call
Message-ID: <20120416125748.GB30242@x220.P-661HNU-F1>
References: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
 <1329144168-19263-4-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329144168-19263-4-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Mon, Feb 13, 2012, Antonio Ospite wrote:
> +int btd_device_set_trusted(const char *adapter_address,
> +			   const char *device_address,
> +			   char *name,
> +			   uint16_t vendor_id_source,
> +			   uint16_t vendor_id,
> +			   uint16_t product_id,
> +			   uint16_t version_id,
> +			   const char *uuid)
> +{

If you have a function called set_trusted then that's *all* it should
do. You have six other parameters there that have *nothing* to do with
the function name. Also, as I mentioned in my previous email the full
use case for all of these should be understood (which also implies the
code that uses them being available) before anything gets added to the
bluetoothd exported API.

Johan
