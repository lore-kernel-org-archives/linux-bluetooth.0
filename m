Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Feb 2014 20:37:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 10/15] Bluetooth: Add mechanism for updating the local RPA
Message-ID: <20140222183750.GA30214@x220.p-661hnu-f1>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
 <1393088805-28658-11-git-send-email-johan.hedberg@gmail.com>
 <30510655-D3CF-4168-A7E2-1DCB3496B606@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <30510655-D3CF-4168-A7E2-1DCB3496B606@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 22, 2014, Marcel Holtmann wrote:
> > @@ -2202,6 +2202,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> > 
> > 	cancel_delayed_work_sync(&hdev->le_scan_disable);
> > 
> > +	cancel_delayed_work_sync(&hdev->rpa_expired);
> > +	set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
> > +
> 
> why on power down. Why not just set this on power up.

No reason. I can move it to power up.

> > @@ -3276,6 +3279,26 @@ static void le_scan_disable_work(struct work_struct *work)
> > 		BT_ERR("Disable LE scanning request failed: err %d", err);
> > }
> > 
> > +void hci_update_rpa(struct hci_request *req)
> > +{
> > +	struct hci_dev *hdev = req->hdev;
> > +	bdaddr_t rpa;
> > +
> > +	if (smp_generate_rpa(hdev->tfm_aes, hdev->irk, &rpa) < 0) {
> > +		BT_ERR("%s failed to generate new RPA", hdev->name);
> > +		return;
> > +	}
> > +
> > +	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &rpa);
> > +
> > +	if (hdev->rpa_timeout) {
> > +		int to;
> > +
> > +		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
> 
> I thought our rpa_timeout is in minutes? Are we allowing second
> granularity? I have nothing against it, but it will be rather useless
> to have a device that changes its RPA every second.

Main reason is that we have other entries settable in seconds and it's
easier to verify that the timer is actually working if you don't have to
wait a full minute to change it. Not a big issue for me though, so I can
change it if you really want.

> > static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
> > {
> > 	if (test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
> > 		return;
> > 
> > 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
> > +	INIT_DELAYED_WORK(&hdev->rpa_expired, rpa_expired);
> > 
> > 	/* Non-mgmt controlled devices get this bit set
> > 	 * implicitly so that pairing works for them, however
> 
> We should set the RPA_EXPIRED bit here.

I don't think so. All the test_and_clear_bit(RPA_EXPIRED) places assume
that the flag will only be set if HCI_PRIVACY is also set. So I think
the right place to initialize it for the first time is when HCI_PRIVACY
is first set, i.e. in the set_privacy mgmt handler.

Johan
