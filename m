Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:46:03 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/7] android/tester: Add RSSI set prop fail test case
Message-ID: <20131218084600.GA26311@aemeltch-MOBL1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <1387283874-29721-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <20131218080034.GD12649@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131218080034.GD12649@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 18, 2013 at 10:00:34AM +0200, Johan Hedberg wrote:
> Hi Grzegorz,
> 
> On Tue, Dec 17, 2013, Grzegorz Kolodziejczyk wrote:
> > +static int32_t setprop_remote_rssi = 0;
> > +
> > +static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
> > +	.expected_hal_callbacks = {ADAPTER_TEST_END},

btw: do we need to have space after "{" ?

Best regards 
Andrei Emeltchenko 

> > +	.expected_adapter_status = BT_STATUS_FAIL,
> > +	.expected_property.type = BT_PROPERTY_REMOTE_RSSI,
> > +	.expected_property.val = &setprop_remote_rssi,
> > +	.expected_property.len = sizeof(int32_t)
> 
> sizeof(setprop_remote_rssi);
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
