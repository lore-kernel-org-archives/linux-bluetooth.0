Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 11:26:44 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, dh.herrmann@googlemail.com,
	chen.ganir@ti.com
Subject: Re: [RFC 2/8] HoG: register ATTIO callbacks
Message-ID: <20120328082641.GA21905@aemeltch-MOBL1>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
 <1332887487-13601-3-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1332887487-13601-3-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

Minor comments:

On Tue, Mar 27, 2012 at 07:31:21PM -0300, João Paulo Rechi Vita wrote:
...
> +static struct hog_device *hog_device_new(struct btd_device *device,
> +							const char *path)
> +{
...
> +
> +	hogdev->attioid = btd_device_add_attio_callback(device,
> +							attio_connected_cb,
> +							attio_disconnected_cb,
> +							hogdev);

What is the coding style for the userspace? Shall it be at least the same?

Best regards 
Andrei Emeltchenko 


