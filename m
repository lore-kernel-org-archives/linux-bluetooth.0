Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 14:36:40 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/6] att: add remote btd_device to ATT read/write
 callbacks
Message-ID: <20120320173640.GA16092@x220.amr.corp.intel.com>
References: <1332147523-9984-1-git-send-email-arik@wizery.com>
 <1332147523-9984-2-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332147523-9984-2-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Mon, Mar 19, 2012, Arik Nemtsov wrote:
> -	uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
> -	uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
> +	uint8_t (*read_cb)(struct attribute *a, gpointer user_data,
> +				gpointer device);
> +	uint8_t (*write_cb)(struct attribute *a, gpointer user_data,
> +				gpointer device);

Why is device a gpointer and not a struct btd_device *?

Also, user_data should be the last parameter as per GLib conventions.

Johan
