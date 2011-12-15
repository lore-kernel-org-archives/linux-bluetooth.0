Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 16:18:31 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] Add support for getting the Encryption Key
 Size via btio
Message-ID: <20111215191831.GA19354@samus>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
 <20111215113720.GB6824@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215113720.GB6824@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 13:37 Thu 15 Dec, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Tue, Dec 13, 2011, Vinicius Costa Gomes wrote:
> > --- a/lib/bluetooth.h
> > +++ b/lib/bluetooth.h
> > @@ -63,6 +63,7 @@ extern "C" {
> >  #define BT_SECURITY	4
> >  struct bt_security {
> >  	uint8_t level;
> > +	uint8_t key_size;
> >  };
> >  #define BT_SECURITY_SDP		0
> >  #define BT_SECURITY_LOW		1
> 
> This libbluetooth change will need to be in a separate patch since it
> needs to be backported to hcidump (which now days has a copy of the lib).

Sure.

> 
> Johan

Cheers,
-- 
Vinicius
