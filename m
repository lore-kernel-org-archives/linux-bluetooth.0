Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 14:34:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add support for parsing the remote name during LE
 Scan
Message-ID: <20111014113407.GA15909@fusion.localdomain>
References: <1318524096-2412-1-git-send-email-vinicius.gomes@openbossa.org>
 <1318541947-13947-1-git-send-email-vinicius.gomes@openbossa.org>
 <20111014080144.GA2125@fusion.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111014080144.GA2125@fusion.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Oct 14, 2011, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Thu, Oct 13, 2011, Vinicius Costa Gomes wrote:
> > +	while (len < HCI_MAX_EIR_LENGTH - 1) {
> > +		uint8_t field_len = eir_data[0];
> > +
> > +		/* Check for the end of EIR */
> > +		if (field_len == 0)
> > +			break;
> 
> I suppose there should also be a check for:
> 
> 	if (len + field_len > HCI_MAX_EIR_LENGTH)
> 		goto failed;
> 
> Otherwise you're gonna access past the end of the eir_data buffer when
> you do the memcpy later.
> 
> > +
> > +		switch (eir_data[1]) {
> > +		case EIR_NAME_SHORT:
> > +		case EIR_NAME_COMPLETE:
> > +			if (field_len > HCI_MAX_NAME_LENGTH)
> > +				goto failed;
> 
> If you add the if-statement I suggested earlier you can remove this one
> (since it becomes redundant).
> 
> > +
> > +			memcpy(name, &eir_data[2], field_len - 1);
> > +			return;
> > +		}
> > +
> > +		len += field_len + 1;
> > +		eir_data += field_len + 1;
> > +	}
> > +
> > +failed:
> > +	sprintf(name, "(unknown)");
> > +	return;
> > +}
> 
> Please remove the unnecessary return statement here.

I had a slight confusion with my local patch handling and your patch
went upstream by mistake. So, I ended up fixing these issues by myself.
There were actually several more issues which I spotted and fixed in the
same go:

- read_flags() had missing checks too
- The LE EIR data length is variable and max 0x1f (31) bytes, i.e. not
  HCI_MAX_EIR_LENGTH
- Because of the above limit the name is max 29 bytes

Please check upstream (github) and verify that I didn't make any mistake
(since I was only able to do only limited testing here).

Johan
