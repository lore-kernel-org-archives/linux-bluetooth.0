Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ v3 06/16] attrib: Change g_attrib_set_destroy_function return type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130424140245.GB18679@x220>
Date: Thu, 2 May 2013 09:05:39 -0700
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <0D7D5332-E081-4F02-8117-91ED46BEF0C9@holtmann.org>
References: <1366207399-29536-1-git-send-email-jefferson.delfes@openbossa.org> <1366207399-29536-7-git-send-email-jefferson.delfes@openbossa.org> <20130424140245.GB18679@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> -gboolean g_attrib_set_destroy_function(GAttrib *attrib,
>> -		GDestroyNotify destroy, gpointer user_data)
>> +bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
>> +							gpointer user_data)
> 
> I've applied patches 1-5 but stopped there since I'm still not sure that
> we want to change this for an API which tries to follow GLib conventions
> (after all that's why the GAttrib API has G and g_ prefixes). Marcel, do
> you have any opinion about this one way or another?

the long term plan is to use standard types like bool, char, uint8_t and also void * here. However we might want to also see how to get rid of g_ prefix as well. Especially g_attrib seems to be a good candidate to get rid of.

I also like to see ATT and GATT being implemented as src/shared/ under LGPL so we can be easily share it in the future. I already have some (unpublished) code for src/shared/att.[ch] and src/shared/gatt.[ch] already, but I think what we first need to do is to figure out how we handle clients and servers from the kernel side. Especially with the background of the kernel auto-connecting LE channels in the future.

Regards

Marcel

