Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Dec 2013 10:20:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android/tester: Enable bthost after device is enabled
Message-ID: <20131217082015.GC19701@x220.p-661hnu-f1>
References: <1387205568-14461-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1387205568-14461-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131217075057.GA19701@x220.p-661hnu-f1>
 <20131217080214.GA3209@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131217080214.GA3209@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Dec 17, 2013, Andrei Emeltchenko wrote:
> On Tue, Dec 17, 2013 at 09:50:57AM +0200, Johan Hedberg wrote:
> > Hi Andrei,
> > 
> > On Mon, Dec 16, 2013, Andrei Emeltchenko wrote:
> > > +static void client_connectable_complete(uint16_t opcode, uint8_t status,
> > > +					const void *param, uint8_t len,
> > > +					void *user_data)
> > > +{
> > > +	switch (opcode) {
> > > +	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
> > > +	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
> > > +		break;
> > > +	default:
> > > +		return;
> > > +	}
> > > +
> > > +	tester_print("Client set connectable status 0x%02x", status);
> > > +
> > > +	if (status)
> > > +		tester_setup_failed();
> > > +	else
> > > +		tester_setup_complete();
> > > +}
> > > +
> > > +static void setup_powered_client(void)
> > > +{
> > > +	struct test_data *data = tester_get_data();
> > > +	struct bthost *bthost;
> > > +
> > > +	tester_print("Controller powered on");
> > > +
> > > +	bthost = hciemu_client_get_host(data->hciemu);
> > > +	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
> > > +
> > > +	if (data->hciemu_type == HCIEMU_TYPE_LE)
> > > +		bthost_set_adv_enable(bthost, 0x01);
> > > +	else
> > > +		bthost_write_scan_enable(bthost, 0x03);
> > > +}
> > > +
> > >  static void adapter_state_changed_cb(bt_state_t state)
> > >  {
> > >  	enum hal_bluetooth_callbacks_id hal_cb;
> > > @@ -484,7 +525,7 @@ static void adapter_state_changed_cb(bt_state_t state)
> > >  		break;
> > >  	case adapter_test_setup_mode:
> > >  		if (state == BT_STATE_ON)
> > > -			tester_setup_complete();
> > > +			setup_powered_client();
> > >  		else
> > >  			tester_setup_failed();
> > >  		break;
> > 
> > You seem to have copied this from l2cap-tester without understanding why
> > the naming of these functions are as they are. The "client" in the names
> > are for testing client sockets (as opposed to server ones). However,
> > you're calling these for every test case, including the server tests
> > (the ones with _listen in them), which doesn't seem right. If you're the
> > server you don't need to make the bthost side connectable.
> 
> So what is appropriate way of setting emulated remote device connectible?
> This actually does not hurt in every case.

The you shouldn't at least have "client" in the naming since this is in
no way client-side specific.

Johan
