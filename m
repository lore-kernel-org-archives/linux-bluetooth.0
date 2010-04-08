Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Report local services(UUIDs) through DBus
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100407012054.GC23956@vigoh>
References: <1270591520-2078-1-git-send-email-francisco.alecrim@openbossa.org>
	 <20100407012054.GC23956@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Apr 2010 05:57:55 +0200
Message-ID: <1270699076.6375.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > +/*
> > + * adapter_services_inc_rem - Insert or remove UUID from adapter
> > + */
> > +static void adapter_service_ins_rem(const bdaddr_t *bdaddr, void *rec,
> > +		gboolean insert)
> > +{
> > +	struct btd_adapter *adapter;
> > +	GSList *adapters;
> > +
> > +	adapters = NULL;
> > +
> > +	if (bacmp(bdaddr, BDADDR_ANY) != 0) {
> > +		/* Only one adapter */
> > +		adapter = manager_find_adapter(bdaddr);
> > +		if (!adapter)
> > +			return;
> > +
> > +		adapters = g_slist_append(adapters, adapter);
> > +	} else {
> > +		/* Emit D-Bus msg to all adapters */
> > +		adapters = manager_get_adapters();
> > +	}
> 
> No need for braces here. :)

because of the comment is is actually preferred to have braces in this
case. This is not for the sake of the compiler. It is purely for humans
to not disturb them with reading the code.

Regards

Marcel


