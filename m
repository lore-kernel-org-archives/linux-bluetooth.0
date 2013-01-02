Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jan 2013 13:31:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix uuid output in debugfs
Message-ID: <20130102113122.GA22512@x220>
References: <1356130624-29234-1-git-send-email-gustavo@padovan.org>
 <87623g9chw.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87623g9chw.fsf@nemi.mork.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bjørn,

On Wed, Jan 02, 2013, Bjørn Mork wrote:
> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > index 55cceee..05b78c7 100644
> > --- a/net/bluetooth/hci_sysfs.c
> > +++ b/net/bluetooth/hci_sysfs.c
> > @@ -461,19 +461,18 @@ static const struct file_operations blacklist_fops = {
> >  
> >  static void print_bt_uuid(struct seq_file *f, u8 *uuid)
> >  {
> > -	__be32 data0, data4;
> > -	__be16 data1, data2, data3, data5;
> > -
> > -	memcpy(&data0, &uuid[0], 4);
> > -	memcpy(&data1, &uuid[4], 2);
> > -	memcpy(&data2, &uuid[6], 2);
> > -	memcpy(&data3, &uuid[8], 2);
> > -	memcpy(&data4, &uuid[10], 4);
> > -	memcpy(&data5, &uuid[14], 2);
> > -
> > -	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.8x%.4x\n",
> > -		   ntohl(data0), ntohs(data1), ntohs(data2), ntohs(data3),
> > -		   ntohl(data4), ntohs(data5));
> > +	u32 data0, data5;
> > +	u16 data1, data2, data3, data4;
> > +
> > +	data5 = le32_to_cpu(*(__le32 *)uuid);
> > +	data4 = le16_to_cpu(*(__le16 *)(uuid + 4));
> > +	data3 = le16_to_cpu(*(__le16 *)(uuid + 6));
> > +	data2 = le16_to_cpu(*(__le16 *)(uuid + 8));
> > +	data1 = le16_to_cpu(*(__le16 *)(uuid + 10));
> > +	data0 = le32_to_cpu(*(__le32 *)(uuid + 12));
> > +
> > +	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
> > +		   data0, data1, data2, data3, data4, data5);
> >  }
> >  
> >  static int uuids_show(struct seq_file *f, void *p)
> 
> 
> Why can't all this be replaced with
> 
> static void print_bt_uuid(struct seq_file *f, u8 *uuid)
> {
>         seq_printf(f, "%pUl\n", uuid);
> }
> 
> ?

I don't think there's any reason assuming that there are no unaligned
access considerations (which I pointed out in my other reply). I wasn't
aware of printk having such a nice extension to the usual format
specifiers (and neither was Gustavo as it seems). Thanks for making us
aware of it!

Johan
