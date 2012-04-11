Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Apr 2012 10:30:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: vishal agarwal <vishal.bluez@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Temporary keys should be retained during
 connection
Message-ID: <20120411073007.GA10605@x220.P-661HNU-F1>
References: <1333624699-7922-1-git-send-email-vishal.agarwal@stericsson.com>
 <1333643105.16897.12.camel@aeonflux>
 <CA+_sZW_hNAMvxKzUXcvBYDEQTtzK=q0VSyKgWJkLiU5RpZTvuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+_sZW_hNAMvxKzUXcvBYDEQTtzK=q0VSyKgWJkLiU5RpZTvuw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Wed, Apr 11, 2012, vishal agarwal wrote:
> > So I would actually prefer a cleanup patch first that changes
> > hci_persistent_key() function into a bool return value.
> >
> > After that it could become just like this
> >
> >        conn->temp_link_key = !persistent;
> >
> 
> As this persistent variable is also used in function mgmt_new_link_key,
> which sends this value to bluez as store_hint and bluez stores the key
> on the basis of this value. So this will require 2 cleanup patches, one for
> bluez and one for kernel. thats what you want?

No, don't change the mgmt protocol or user space. Changing
mgmt_new_link_key to take bool instead of u8 as a parameter does make
sense though and you could have that in the same cleanup patch as the
hci_persistent_key change.

Johan
