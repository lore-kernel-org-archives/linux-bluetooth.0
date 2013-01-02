Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jan 2013 15:43:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix uuid output in debugfs
Message-ID: <20130102134340.GA25198@x220>
References: <1356130624-29234-1-git-send-email-gustavo@padovan.org>
 <87623g9chw.fsf@nemi.mork.no>
 <20130102113122.GA22512@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130102113122.GA22512@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 02, 2013, Johan Hedberg wrote:
> > > +	u32 data0, data5;
> > > +	u16 data1, data2, data3, data4;
> > > +
> > > +	data5 = le32_to_cpu(*(__le32 *)uuid);
> > > +	data4 = le16_to_cpu(*(__le16 *)(uuid + 4));
> > > +	data3 = le16_to_cpu(*(__le16 *)(uuid + 6));
> > > +	data2 = le16_to_cpu(*(__le16 *)(uuid + 8));
> > > +	data1 = le16_to_cpu(*(__le16 *)(uuid + 10));
> > > +	data0 = le32_to_cpu(*(__le32 *)(uuid + 12));
> > > +
> > > +	seq_printf(f, "%.8x-%.4x-%.4x-%.4x-%.4x%.8x\n",
> > > +		   data0, data1, data2, data3, data4, data5);
> > >  }
> > >  
> > >  static int uuids_show(struct seq_file *f, void *p)
> > 
> > 
> > Why can't all this be replaced with
> > 
> > static void print_bt_uuid(struct seq_file *f, u8 *uuid)
> > {
> >         seq_printf(f, "%pUl\n", uuid);
> > }
> > 
> > ?
> 
> I don't think there's any reason assuming that there are no unaligned
> access considerations (which I pointed out in my other reply). I wasn't
> aware of printk having such a nice extension to the usual format
> specifiers (and neither was Gustavo as it seems). Thanks for making us
> aware of it!

Actually I'm not getting the expected results with %pU. The following is
the output of seq_printf(f, "%pUl %pUb\n", uuid, uuid):

$ cat /sys/kernel/debug/bluetooth/hci0/uuids
5f9b34fb-0080-8000-0010-00000e110000 fb349b5f-8000-0080-0010-00000e110000
5f9b34fb-0080-8000-0010-00000c110000 fb349b5f-8000-0080-0010-00000c110000
5f9b34fb-0080-8000-0010-000004a00000 fb349b5f-8000-0080-0010-000004a00000
5f9b34fb-0080-8000-0010-000001180000 fb349b5f-8000-0080-0010-000001180000
5f9b34fb-0080-8000-0010-000000180000 fb349b5f-8000-0080-0010-000000180000
5f9b34fb-0080-8000-0010-000000120000 fb349b5f-8000-0080-0010-000000120000

None of those are of the correct format which I do get with Gustavo's
patch:

$ cat /sys/kernel/debug/bluetooth/hci0/uuids
0000110e-0000-1000-8000-00805f9b34fb
0000110c-0000-1000-8000-00805f9b34fb
0000a004-0000-1000-8000-00805f9b34fb
00001801-0000-1000-8000-00805f9b34fb
00001800-0000-1000-8000-00805f9b34fb
00001200-0000-1000-8000-00805f9b34fb

So it seems to me that the %pU specifier is expecting something quite
different from how we store the UUIDs. Looking at the difference of %pUb
and %pUl it seems it doesn't do a complete byte order swap for the whole
value but only for half of it, and even that half doesn't see a proper
64-bit byte order swap but just internal swaps for the one 32-bit and
two 16-bit parts.

So assuming that potential alignment issues get sorted out it seems that
Gustavos patch is the way to go forward.

Johan
