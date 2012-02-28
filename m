Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Feb 2012 10:53:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Remove redundant read_host_features
 commands
Message-ID: <20120228085353.GA22809@x220.P-661HNU-F1>
References: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
 <1330386094-19501-2-git-send-email-johan.hedberg@gmail.com>
 <20120228080141.GB4381@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120228080141.GB4381@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 28, 2012, Andrei Emeltchenko wrote:
> > +	if (enable_le && test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
> > +		cp.le = 1;
> 
> Do you mean here "true"?

No, cp.le is a u8 and not a bool.

> > -	cp.page = 0x01;
> > -	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp), &cp);
> > +	if (!status) {
> > +		if (sent->le)
> > +			hdev->host_features[0] |= 0x02;
> > +		else
> > +			hdev->host_features[0] &= !0x02;
> 
> BTW: what is 0x02? I saw it also in the second patch.

It's LMP_HOST_LE (i.e. the host features bit indicating that LE support
is enabled for the host). I fixed this to use the proper define before
applying the patch.

Johan
