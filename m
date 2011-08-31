Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Aug 2011 15:27:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH BlueZ 1/8] Add link_type information to the mgmt "Device
 Connected" event
Message-ID: <20110831122752.GA16805@dell.ger.corp.intel.com>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798969-8772-2-git-send-email-vinicius.gomes@openbossa.org>
 <20110831075115.GA6348@dell.ger.corp.intel.com>
 <CABBYNZ++5EG+4w=VzBNKNPXQVJ_17aRyHdH6=X_LyYWxY7TZhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ++5EG+4w=VzBNKNPXQVJ_17aRyHdH6=X_LyYWxY7TZhw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Aug 31, 2011, Luiz Augusto von Dentz wrote:
> >> +/* Low Energy links do not have defined link type. Use invented one */
> >> +#define LE_LINK              0x80
> >
> > I remember Marcel being against any self-invented additions like this.
> > Have you discussed this with him?
> 
> Actually this follows what kernel has being doing:
> 
> include/net/bluetooth/hci.h:175:#define LE_LINK		0x80

Indeed it does. Also, the patch (from Ville) that introduced this to the
kernel has Marcel's Ack on it, so I guess it's fine then.

Johan
