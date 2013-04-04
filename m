Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 01:43:32 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alex Deymo <deymo@chromium.org>, linux-bluetooth@vger.kernel.org,
	keybuk@chromium.org
Subject: Re: [PATCH v3 1/2] input: Documentation for new Input1 interface
Message-ID: <20130404044332.GA30908@echo>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
 <1364863226-10566-1-git-send-email-deymo@chromium.org>
 <1364863226-10566-2-git-send-email-deymo@chromium.org>
 <51314AAB-DED8-49D6-ACF9-C5658B5948F1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51314AAB-DED8-49D6-ACF9-C5658B5948F1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


On 20:48 Wed 03 Apr, Marcel Holtmann wrote:
> Hi Alex,
> 
> > Adds new documentation for a new Input1 interface exposing two properties.
> > ---
> > doc/input-api.txt | 21 +++++++++++++++++++++
> > 1 file changed, 21 insertions(+)
> > create mode 100644 doc/input-api.txt
> > 
> > diff --git a/doc/input-api.txt b/doc/input-api.txt
> > new file mode 100644
> > index 0000000..44bbde6
> > --- /dev/null
> > +++ b/doc/input-api.txt
> > @@ -0,0 +1,21 @@
> > +BlueZ D-Bus Input API description
> > +*********************************
> > +
> > +Input hierarchy
> > +===============
> > +
> > +Service		org.bluez
> > +Interface	org.bluez.Input1
> > +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> > +
> > +Properties	boolean NormallyConnectable [readonly]
> > +
> > +			Exposes the value of HIDNormallyConnectable as defined
> > +			by the HID profile specification. If this optional value
> > +			is not specified by the HID device, the value is asumend
> > +			as FALSE.
> > +
> > +		boolean ConnectInitiate [readonly]
> > +
> > +			Exposes the value of ConnectInitiate as defined by the
> > +			HID profile specification.
> 
> I am not 100% comfortable with the property names yet. Especially the ConnectInitiate sounds badly to me. Does anybody have any ideas?

Just for fun, the only idea that I could come up with is: "ReconnectionMode"
or "Mode" with two values: "active" (the remote is not normally connectable,
but is able to initiate connections), "passive" (the remote is not able to
initiate connections but is normally connectable) and "dual".

Alex, does something like this cover the use cases that you have in mind?

> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
